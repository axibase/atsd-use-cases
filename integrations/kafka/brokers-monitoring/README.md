# How to Monitor Kafka Brokers

## Overview

This guide describes how to monitor availability and performance of [Apache Kafka](https://kafka.apache.org/) brokers using Axibase Time Series Database.

## Configuration

### Prerequisites

* Kafka brokers with enabled JMX.
* 4 GB RAM for the [ATSD sandbox](https://github.com/axibase/dockers/blob/atsd-sandbox/README.md#atsd-sandbox-docker-image) container.

### Launch ATSD Sandbox

Launch [ATSD sandbox](https://github.com/axibase/dockers/blob/atsd-sandbox/README.md#atsd-sandbox-docker-image) container on one of the Docker hosts:

```sh
docker run -d -p 8443:8443 -p 9443:9443 -p 8081:8081 \
    --name=atsd-sandbox \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    --env ATSD_IMPORT_PATH='https://raw.githubusercontent.com/axibase/atsd-use-cases/master/integrations/kafka/broker-monitoring/resources/kafka-xml.zip' \
    --env COLLECTOR_IMPORT_PATH='https://raw.githubusercontent.com/axibase/atsd-use-cases/master/integrations/kafka/broker-monitoring/resources/job_jmx_kafka-jmx.xml' \
axibase/atsd-sandbox:latest
```

The sandbox container includes both ATSD and [Axibase Collector](https://axibase.com/docs/axibase-collector/jobs/docker.html) instances.

Use the Collector instance installed in the sandbox container to retrieve Kafka statistics using JMX and store the statistics in ATSD.

Monitor the logs for `All applications started`.

```sh
docker logs -f atsd-sandbox
```

### Configure Collector

Log in to Axibase Collector instance at `https://atsd_hostname:9443` using `axibase` username and `axibase` password.

Open the **Jobs** drop-down list and select **JMX**. Ensure you see the enabled `kafka-jmx` job.

![](./images/check-kafka-job.png)

This job uses `kafka-cluster-jmx` [Item List](https://axibase.com/docs/axibase-collector/jobs/jmx.html#connection-parameters) with Kafka JMX connection settings.
Replace default parameters in this list with actual broker JMX address. Open the **Collections** menu and select **Item Lists**.

![](./images/kafka-item-list-1.png)

Open `kafka-cluster-jmx`:

![](./images/kafka-item-list-2.png)

Edit CSV-formatted items. Replace default parameters with actual JMX parameters. Set username and password if required. Click **Save**.

![](./images/kafka-item-list-3.png)

Ensure that connection settings are correct. Open the **Jobs** menu, select **JMX** and find the `kafka-jmx` job.
Click `kafka-series` configuration

![](./images/kafka-job-check-1.png)

At the bottom of the page click **Test**.

![](./images/kafka-job-check-2.png)

If connection parameters are correct, you see series commands. Select other brokers and repeat test.

![](./images/kafka-job-check-3.png)

Return to the **Job** page and run the job.

![](./images/kafka-job-run-1.png)

![](./images/kafka-job-run-2.png)

### Configure ATSD

Log in to ATSD instance at `https://atsd_hostname:8443` using `axibase` username and `axibase` password.

Open the **Entities** tab and ensure Collector displays the Kafka nodes with hostnames

![](./images/atsd-entities-check.png)

Open the **Portals** menu and select **Configure**.

![](./images/portals-enable-1.png)

Select **Kafka Broker** and **Kafka Cluster** portals via checkbox and enable these portals using the split-button at the bottom of the page.

![](./images/portals-enable-2.png)

Check **Kafka Broker** portal. Return to the **Entities** page, find any kafka broker and click the **Portal** icon.

![](./images/kafka-broker-portal-check-1.png)

![](./images/kafka-broker-portal-check-2.png)

Check Kafka cluster entity view and portal. Open the **Entity Views** menu and select **Kafka**.

![](./images/kafka-cluster-check-1.png)

Click the **Portal** icon to check the **Kafka Cluster** portal

![](./images/kafka-cluster-check-2.png)

![](./images/kafka-cluster-check-3.png)
