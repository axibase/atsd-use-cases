# How to Monitor Marathon Applications as Services

## Overview

[Marathon](https://mesosphere.github.io/marathon/) is a framework for automating deployment of Linux containers on top of clusters managed by [Apache Mesos](http://mesos.apache.org/). The framework supports auto-scaling and failover based on built-in http/tcp health checks. 

The primary concept implemented in Marathon is an **Application** which is a resizeable collection of containers of similar type launched as a long-running service or a short-term batch processing job. Each container (or **task** in Marathon terms) is entitled to a pre-defined amount of CPU, memory, and disk resources. The containers are launched on the underlying Mesos nodes based on available capacity.

## Marathon Components

The framework consists of the following components:

* User Interface for creating and managing Applications.
* Marathon server to translate Application models and actions into Mesos tasks.
* [REST API](http://mesosphere.github.io/marathon/api-console/index.html) for programmatic access and integration.

![Marathon v1.5.6 User Interface](images/marathon_ui.png)

## Allocated Capacity

Both the API and the user interface provide a way to view allocated capacity, as well as the number of launched, healthy, and unhealthy tasks aggregated for each application. Health status is reported for tasks with enabled health checks.

![marathon_capacity](images/marathon_capacity.png)

## Capacity Usage

The integration with [Axibase Time Series Database](http://axibase.com/products/axibase-time-series-database/) adds an additional level of visibility by collecting and aggregating CPU, memory, and disk usage at the Application level. This allows correlating resource allocations with actual resource usage and to monitor Marathon Applications as services and to achieve higher capacity utilization.

## Configuration

### Prerequisites

* Marathon: v1.5.6 was used for this article.

### Launch ATSD and Axibase Collector 

Launch [ATSD sandbox](https://github.com/axibase/dockers/tree/atsd-sandbox) container on one of the Docker hosts:

```
$ docker run -d -p 8443:8443 -p 9443:9443 -p 8081:8081 \
  --name=atsd-sandbox \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  axibase/atsd-sandbox:latest
```

The sandbox container includes both the ATSD and [Axibase Collector](https://github.com/axibase/axibase-collector/blob/master/jobs/docker.md) instances. The Axibase Collector is a companion data collection tool in the ATSD toolbox and the Collecter instance installed in the sandbox container will automatically start historizing statistics from the local Docker engine.

Login into ATSD user interface using 'axibase' username and 'axibase' password:

```
https://atsd_hostname:8443/
```

Launch Collector instances on the other Docker hosts in the environment. Those instances will send Docker statistics into the central ATSD database running in the sandbox container that we launched previously. Replace `atsd_hostname` in the command below with the hostname or IP address where ATSD is running. 

-- diagram

```
docker run -d -p 9443:9443 --restart=always \
   --name=axibase-collector \
   --volume /var/run/docker.sock:/var/run/docker.sock \
   --env=DOCKER_HOSTNAME=`hostname -f` \
  axibase/collector \
   -atsd-url=https://axibase:axibase@atsd_hostname:8443 \
   -job-enable=docker-socket
```

### Import Marathon Job into Axibase Collector

Login into Axibase Collector instance in the sandbox container at `https://atsd_hostname:9443` using 'axibase' username and 'axibase' password.

Import the attached [job configuration](resources/marathon_jobs.xml) XML file. 

The JSON job will query the Marathon REST API for Application definitions and health status and offload this data into ATSD database.

![](images/import_job.png)

### Configure Marathon API Connection

In the **Jobs** drop-down menu, select **JSON** jobs.

> If the **marathon_apps** job is not visible, be sure that the **Status** drop-down menu is showing all jobs.

Open the **JSON Job** page, then open the **JSON Configuration** page by clicking the **apps** link. On the **JSON Configuration** page, open **HTTP Pool** settings.

![](images/http_pool.png)

Specify Server, Username and Password.

![](images/http_pool_config_.png)

Confirm connectivity by clicking the **Test** button. Click **Save**. 

From the **JSON Job** page, enable the **marathon_apps** job. Click **Save**.

![](images/enable_job.png)

### Import Marathon Models into ATSD

Open ATSD user interface at `https://atsd_hostname:8443`.

Open the **Settings > Diagnostics > Backup Import** and upload the [atsd-marathon-xml.zip](resources/atsd-marathon-xml.zip) archive that contains entity views, portals, queries and rules designed specifically for Marathon.

## Results

### Entity View

The view displays all Marathon applications, the number of healthy tasks for each application, as well as aggregate resource utilization with breakdown by CPU, memory, and disk.

-- add

### Resource Utilization Portal

The built-in portal displays daily statistics on resource allocation and usage for all applications at once.

![](images/marathon_portal.png)
