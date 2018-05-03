# How to Monitor Kafka Brokers

## Overview

This guide describes how to monitor availability and performance of [Apache Kafka](https://kafka.apache.org/) brokers using Axibase Time Series Database.

## Configuration

### Prerequisites

* Kafka brokers with enabled JMX
* 4GB RAM for the [ATSD sandbox](https://github.com/axibase/dockers/tree/atsd-sandbox) container.

### Launch ATSD Sandbox

Launch [ATSD sandbox](https://github.com/axibase/dockers/tree/atsd-sandbox) container on one of the Docker hosts:

```sh
docker run -d -p 8443:8443 -p 9443:9443 -p 8081:8081 \
    --name=atsd-sandbox \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    --env ATSD_IMPORT_PATH='https://raw.githubusercontent.com/axibase/atsd-use-cases/master/how-to/kafka/broker-monitoring/resources/kafka-xml.zip' \
    --env COLLECTOR_IMPORT_PATH='https://raw.githubusercontent.com/axibase/atsd-use-cases/master/how-to/kafka/broker-monitoring/resources/job_jmx_kafka-jmx.xml' \
axibase/atsd-sandbox:latest
```

The sandbox container includes both ATSD and [Axibase Collector](https://github.com/axibase/axibase-collector/blob/master/jobs/docker.md) instances.

The Collector instance installed in the sandbox container is used to retrieve Kafka statistics using JMX and store them in ATSD.

Wait until the sandbox is initialized and 'All applications started.' message is displayed.

```sh
docker logs -f atsd-sandbox
```

### Configure Collector

Log in to Axibase Collector instance at `https://atsd_hostname:9443` using `axibase` username and `axibase` password.

Click `Jobs` and set job type `JMX`. Make sure that `kafka-jmx` job is visible on the page and enabled.

![](images/check-kafka-job.png)

This job uses `kafka-cluster-jmx` [Item List](https://github.com/axibase/axibase-collector/blob/master/jobs/jmx.md#connection-parameters) with Kafka JMX connection settings.
Replace default parameters in this list with actual broker JMX address. Click `Collections` -> `Item Lists`

![](images/kafka-item-list-1.png)

Open `kafka-cluster-jmx`

![](images/kafka-item-list-2.png)

Edit CSV-formatted items. Replace default parameters with actual JMX parameters. Set username and password if required. Click `Save`.

![](images/kafka-item-list-3.png)

Make sure that connection settings are correct. Click `Jobs` -> `JMX` and find `kafka-jmx` job.
Click `kafka-series` configuration

![](images/kafka-job-check-1.png)

At the bottom of the page click the `Test` button.

![](images/kafka-job-check-2.png)

If connection parameters are correct, series commands will be shown. Select other brokers and repeat test.

![](images/kafka-job-check-3.png)

Return to the Job page and run job.

![](images/kafka-job-run-1.png)

![](images/kafka-job-run-2.png)

### Configure ATSD

Log in to ATSD instance at `https://atsd_hostname:8443` using `axibase` username and `axibase` password.

Click `Entities` and make sure that Kafka nodes are created by collector with their hostnames

![](images/atsd-entities-check.png)

Click `Portals` -> `Configure`

![](images/portals-enable-1.png)

Select `Kafka Broker` and `Kafka Cluster` portals and enable them using button at the bottom of the page.

![](images/portals-enable-2.png)

Check Kafka broker portal. Return to the entities page, find any kafka broker and click `Open portals`

![](images/kafka-broker-portal-check-1.png)

![](images/kafka-broker-portal-check-2.png)

Check Kafka cluster entity view and portal. Click `Entity Views` -> `Kafka`

![](images/kafka-cluster-check-1.png)

Entity View should be shown. Click `View Portal` to check Kafka Cluster portal

![](images/kafka-cluster-check-2.png)

![](images/kafka-cluster-check-3.png)
