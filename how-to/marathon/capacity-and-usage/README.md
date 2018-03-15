# How to Monitor Marathon Applications as Services

## Overview

[Marathon](https://mesosphere.github.io/marathon/) is a framework for automating the deployment of Linux containers on top of clusters managed by [Apache Mesos](http://mesos.apache.org/). The framework supports auto-scaling and failover based on built-in HTTP/TCP health checks. 

The primary unit tracked in Marathon is the **Application**, which is a resizeable collection of similar containers launched as a long-running service or a short-term batch processing job. 

Each container (or **task** in Marathon terms) is allocated a pre-defined amount of CPU, memory, and disk resources. The containers are launched on the underlying [Mesos nodes](http://mesos.apache.org/documentation/latest/architecture/) based on available system capacity.

## Marathon Components

The framework consists of the following components:

* User Interface to create and manage Applications.
* Marathon server to translate Application models and actions into Mesos tasks.
* [REST API](http://mesosphere.github.io/marathon/api-console/index.html) for programmatic access and integration.

![Marathon v1.5.6 User Interface](images/marathon_ui.png)

## Allocated Capacity

Both the API and the user interface provide a way to view allocated capacity alongside the number of launched, healthy, and unhealthy tasks aggregated for each application. The health statuses of these applications are reported for tasks with enabled health checks.

![](images/marathon_monitoring.png)

## Capacity Usage

Integration with [Axibase Time Series Database](http://axibase.com/products/axibase-time-series-database/) adds an additional level of visibility by collecting and aggregating CPU, memory, and disk usage at the Application level. This allows the correlation of resource allocation with actual usage in order to achieve higher capacity utilization.

## Configuration

### Prerequisites

* Marathon: v1.5.6 is used for this walkthrough.

### Launch ATSD and Axibase Collector 

Launch [ATSD sandbox](https://github.com/axibase/dockers/tree/atsd-sandbox) container on one of the Docker hosts:

```
$ docker run -d -p 8443:8443 -p 9443:9443 -p 8081:8081 \
  --name=atsd-sandbox \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  axibase/atsd-sandbox:latest
```

The sandbox container includes both ATSD and [Axibase Collector](https://github.com/axibase/axibase-collector/blob/master/jobs/docker.md) instances. 

The Collector instance installed in the sandbox container will automatically start historizing statistics from the local Docker engine.

Log in to ATSD user interface using `axibase` username and `axibase` password.

```
https://atsd_hostname:8443/
```

Launch Collector instances on the other Docker hosts in the environment. Those instances will send Docker statistics into the central ATSD database running in the sandbox container that we previously launched. Replace `atsd_hostname` in the command below with the hostname or IP address where ATSD is running. 

```
docker run -d -p 9443:9443 --restart=always \
   --name=axibase-collector \
   --volume /var/run/docker.sock:/var/run/docker.sock \
   --env=DOCKER_HOSTNAME=`hostname -f` \
  axibase/collector \
   -atsd-url=https://collector:collector@atsd_hostname:8443 \
   -job-enable=docker-socket
```

![](images/marathon.png)

### Import Marathon Job into Axibase Collector

Log in to Axibase Collector instance at `https://atsd_hostname:9443` using `axibase` username and `axibase` password.

Import the attached [job configuration](resources/marathon_jobs.xml) XML file.

The **marathon_apps** JSON job will query the Marathon `/v2/apps` API endpoint for Application definitions and health status, then offload this data into ATSD.

![](images/import_job.png)

### Configure Marathon Connection

In the **Jobs** drop-down menu, select **JSON** jobs.

> If the **marathon_apps** job is not visible, be sure that the **Status** drop-down menu is displaying all jobs.

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

### Entity View

The view displays all Marathon applications, the number of healthy tasks for each application, as well as aggregate resource utilization with breakdown by CPU, memory, and disk.

![](images/entities_view.png)

### Resource Utilization Portal

The built-in portal displays daily statistics on resource allocation and usage for all applications at once.

![](images/marathon_portal.png)
