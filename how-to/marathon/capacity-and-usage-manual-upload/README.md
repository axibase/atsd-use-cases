# How to Monitor Marathon Applications as Services (Manual Walkthrough)

To perform this process using a single command, see the following [abbreviated walkthrough](/how-to/marathon//capacity-and-usage/README.md).

## Overview

[Marathon](https://mesosphere.github.io/marathon/) is a framework for automating the deployment of Linux containers on top of clusters managed by [Apache Mesos](http://mesos.apache.org/). The framework supports auto-scaling and failover based on built-in health checks. 

The primary concept implemented in Marathon is the [**Application**](https://mesosphere.github.io/marathon/docs/application-basics.html), which is a resizeable collection of identical containers launched as a long-running service or a short-term batch processing job.

The framework consists of the following components:

* Marathon server to translate Application definitions into stateful services consisting of Mesos tasks.
* [REST API](http://mesosphere.github.io/marathon/api-console/index.html) for programmatic access and integration.
* User Interface to create and manage Applications.

_Marathon v1.5.6 user interface:_

![Marathon v1.5.6 User Interface](images/marathon_ui.png)

## Capacity

Each container (or **task** in Marathon terms) is allocated a pre-defined amount of CPU, memory, and disk resources. The containers are launched on the underlying Mesos [nodes](http://mesos.apache.org/documentation/latest/architecture/) based on available system capacity.

### Allocated Capacity

Both the API and the user interface provide a way to view allocated capacity alongside the number of launched, healthy, and unhealthy tasks aggregated for each application. The health statuses of these applications are reported for tasks with enabled health checks.

![](images/monitor-marathon.png)

### Capacity Usage

Integration with [Axibase Time Series Database](http://axibase.com/products/axibase-time-series-database/) adds an additional level of visibility by collecting and aggregating CPU, memory, and disk usage at the **Application** level. This allows the user to achieve higher capacity utilization by correlating resource allocations with actual usage.

![](images/marathon-applications-label.png)

## Configuration

### Prerequisites

* Access to Marathon server via REST API v2.
* 4GB RAM for the ATSD Sandbox container.

### Launch Axibase Sandbox

Use the following command to launch ATSD and Axibase Collector instances. The default username and password will be `axibase`.
```
$ docker run -d -p 8443:8443 -p 9443:9443 -p 8081:8081 \
  --name=atsd-sandbox \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  axibase/atsd-sandbox:latest
```

### Launch Axibase Collectors containers

Launch Collector instances on the other Docker hosts in the environment. The remote Collector instances will send Docker statistics into the centralized ATSD database running in the sandbox container that we previously launched. 

![](images/marathon.png)

Replace `atsd_hostname` in the command below with the hostname or IP address where ATSD is running. 

```
$ docker run -d -p 9443:9443 --restart=always \
   --name=axibase-collector \
   --volume /var/run/docker.sock:/var/run/docker.sock \
   --env=DOCKER_HOSTNAME=`hostname -f` \
  axibase/collector \
   -atsd-url=https://collector:collector@atsd_hostname:8443 \
   -job-enable=docker-socket
```

### Import Marathon Job into Axibase Collector

Log in to Axibase Collector instance at `https://atsd_hostname:9443` using `axibase` username and `axibase` password.

Import the attached [job configuration](resources/marathon_jobs.xml) XML file.

The **marathon_apps** JSON job will query the Marathon `/v2/apps` API endpoint for Application definitions and health status, then offload this data into ATSD.

![](images/import_job.png)

### Configure Marathon API Connection

In the **Jobs** drop-down menu, select **JSON** jobs.

> By default, the **marathon_apps** job is not enabled and therefore not visible. Be sure that the **Status** drop-down menu is displaying all jobs to proceed.

Open the **JSON Job** page, then open the **JSON Configuration** page by clicking the **apps** link. On the **JSON Configuration** page, open **HTTP Pool** settings.

![](images/http_pool.png)

Specify 'Server', 'Username' and 'Password' for a Marathon user with API query permissions.

![](images/http_pool_config_.png)

Confirm connectivity by clicking the **Test** button. Click **Save**. 

From the **JSON Job** page, enable the **marathon_apps** job. Click **Save**.

![](images/enable_job.png)

### Import Marathon Models into ATSD

Open ATSD user interface at `https://atsd_hostname:8443`.

Open **Settings > Diagnostics > Backup Import** and upload the [atsd-marathon-xml.zip](resources/atsd-marathon-xml.zip) archive that contains entity views, portals, queries and rules designed specifically for Marathon.

## Results

### Marathon Applications Entity View

Click **Marathon Applications** on the menu to access the Entity View. This view displays all Marathon applications, the number of healthy tasks for each application, as well as aggregate resource utilization with breakdown by CPU, memory, and disk.

![](images/marathon-applications.png)

### Resource Utilization Portal

The built-in portal displays daily statistics on resource allocation and usage for all applications at once.

![](images/marathon_portal.png)