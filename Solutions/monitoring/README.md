# Anomaly Detection

## Overview

Axibase Time Series Database allows IT operations teams to monitor Linux containers in concert with existing management systems.

ATSD continuously collects availability status, performance metrics and detailed configurations from containers in a single repository and exposes the data to upstream tools (CMDB, monitoring, alerting, event management) via the API, notifications, and scheduled reporting. It provides operations teams the necessary visibility, control, and automation into Linux containers while delivering a unified view of container performance to development and QA teams.

## Integration Overview

The data is collected by [Axibase Collector](https://github.com/axibase/axibase-collector/blob/master/jobs/docker.md) instances installed locally on each Docker host.

![docker-local](images/docker-local.png)

## Integration Benefits

-   Seamlessly collect detailed configurations and statistics at the host, container, volume, and network level from multiple Docker hosts.
-   Analyze incoming data with the built-in rule engine and escalate actionable data to upstream alerting and monitoring systems.
-   Automatically compose application and service dashboards using image and container-labels for filtering and roll-ups.
-   Provide development and operations teams a search interface to quickly locate resources as the environment grows in size and scope.
-   Distribute scheduled reports on historical and estimated host and container utilization to prevent performance bottlenecks.

## Use Cases

### Linux Container Monitoring

-   Collect cpu, memory, I/O, volume, and network statistics from Docker hosts and containers.
-   Correlate container utilization with OS-level usage for triage and diagnostics.
-   Instantly visualize data with built-in, real-time host and container dashboards.
-   Automatically build service dashboards using image and container labels.

### Change Management

-   Perform detailed inventory scans of the Docker environment including hosts, images, containers, volumes, and networks.
-   Notify applications and operations teams in case of container misplacement.
-   Enforce labeling standards to ensure CMDB accuracy.

### Compliance and Security

-   Intercept and react to life-cycle events such as new image pulls, container starts, container command executions.
-   Identify images and containers that violate pre-approved black-lists and white-lists.
-   Perform enterprise-wide inventory queries to identify configuration abnormalities.
-   Scan launch parameters and variables to ensure secrets and credentials are protected.

## Getting Started

### Launch ATSD

Start ATSD container on one of the Docker hosts.

Replace `cuser` and `cpassword` variables with custom credentials. These credentials will be used by collectors to insert data into ATSD.

Minimum password length is 6 characters.

```sh
$ docker run -d --name=atsd -p 8443:8443 -p 8081:8081 \
  --env COLLECTOR_USER_NAME=cuser \
  --env COLLECTOR_USER_PASSWORD=cpassword \
  --env COLLECTOR_USER_TYPE=api-rw \
  axibase/atsd:latest
```

Wait for the database to initialize.

```sh
$ docker logs -f atsd
```

```
[ATSD] ATSD user interface:
[ATSD] http://172.17.0.2:8088
[ATSD] https://172.17.0.2:8443
[ATSD] ATSD start completed. Time: 2017-09-26 15-12-10.
[ATSD] Collector account 'cuser' created. Type: 'writer'.
```

### Launch Axibase Collectors

Launch an [Axibase Collector](https://github.com/axibase/axibase-collector/blob/master/jobs/docker.md) instance on each Docker host.

Replace **cuser** and **cpassword** variables with collector credentials specified above.

Replace **atsd_host** variable with the hostname of the Docker host where ATSD container is running.

The hostname must be resolvable from the Docker host where collector is installed.

```sh
$ docker run -d --name axibase-collector \
   --volume /var/run/docker.sock:/var/run/docker.sock \
   --env=DOCKER_HOSTNAME=`hostname -f` \
  axibase/collector \
   -atsd-url=https://cuser:cpassword@atsd_host:8443 \
   -job-enable=docker-socket
```

Wait for the collector to initialize.

```sh
$ docker logs -f axibase-collector
```

```
...
[Collector] Waiting for Collector to bind to port 9443 ...( 6 of 30 )
[Collector] Collector web interface:
[Collector] https://172.17.0.3:9443
[Collector] https://127.0.0.1:9443
[Collector] Collector start completed.
```

### Verify Installation

Log in to the ATSD web interface at `https://atsd_host:8443`.

Create a built-in administrator account.

Open **Entities > Docker Hosts** and **Entities > Docker Containers** tabs and verify that records are available as displayed on the below screenshots.

Open **Configuration > Rules** and import alerting rules into the rule engine.

## Reference Information

* [Axibase Collector](https://github.com/axibase/axibase-collector/blob/master/jobs/docker.md)

## Discovery

### Containers:

![docker-view-container](images/docker-view-container.png)

### Images:

![docker-images](images/docker-images.png)

### Filtered containers:

![docker-view-container-filter](images/docker-view-container-filter.png)

### Filtered views:

![docker-image-filter](images/docker-image-filter.png)

### Volume views:

![docker-containers](images/docker-containers.png)


## Search

### Full-text Series Metadata Search:

![docker-search](images/docker-search.png)

### Metadata Fields:

![docker-container-summary](images/docker-container-summary.png)


## Configuration Detail

### Docker host:

![docker-host-properties](images/docker-host-properties.png)

### Docker container:

![docker-container-properties](images/docker-container-properties.png)

### Docker inspect files:

![docker-inspect](images/docker-inspect.png)

## Compliance Reports

### Environment Settings and Versions

![docker-lang](images/docker-lang.png)

### Secret Leaks

![docker-secret-leak](images/docker-secret-leak.png)

## Statistics

### Host Metrics

![docker-host-metrics](images/docker-host-metrics.png)

### Container Metrics

![docker-container-metrics](images/docker-container-metrics.png)

### Volume Metrics

![docker-volume-metrics](images/docker-volume-metrics.png)

## Dashboards

### Host Summary

![docker-portal-summary](images/docker-portal-summary.png)

### Host Breakdown

![docker-portal-breakdown](images/docker-portal-breakdown.png)

### Container Summary

![docker-portal-container](images/docker-portal-container.png)

### Custom Composite Summary

![docker-portal-breakdown-custom](images/docker-portal-breakdown-custom.png)

### Service Summary

![docker-service](images/docker-service.png)

## Rule Engine

### Performance, availability and configuration rules

![docker-rules](images/docker-rules.png)

### Alerts

![docker-alerts](images/docker-alerts-1.png)

## Messages and Events

### Host Events

![docker-messages](images/docker-messages-1.png)

### Container Actions

![docker-messages-container](images/docker-messages-container-1.png)
