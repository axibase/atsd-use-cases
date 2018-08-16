# How to Monitor Kafka Brokers

## Overview

This integration guide describes how to monitor availability and performance of [Apache Kafka](https://kafka.apache.org/) brokers using ATSD.

## Configuration

### Prerequisites

* Kafka brokers with enabled JMX.
* `4` GB RAM for the [ATSD Sandbox](https://github.com/axibase/dockers/blob/atsd-sandbox/README.md#atsd-sandbox-docker-image) container.

### Launch ATSD Sandbox

Launch [ATSD Sandbox](https://github.com/axibase/dockers/blob/atsd-sandbox/README.md#launch-instructions) container on one of the Docker hosts:

```sh
docker run -d -p 8443:8443 -p 9443:9443 -p 8081:8081 \
    --name=atsd-sandbox \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    --env ATSD_IMPORT_PATH='https://raw.githubusercontent.com/axibase/atsd-use-cases/master/integrations/kafka/broker-monitoring/resources/kafka-xml.zip' \
    --env COLLECTOR_IMPORT_PATH='https://raw.githubusercontent.com/axibase/atsd-use-cases/master/integrations/kafka/broker-monitoring/resources/job_jmx_kafka-jmx.xml' \
axibase/atsd-sandbox:latest
```

Sandbox container includes ATSD and [Axibase Collector](https://axibase.com/docs/axibase-collector/jobs/docker.html) instances.

Use the Collector instance installed in the Sandbox container to retrieve Kafka statistics with JMX and store the statistics in ATSD.

Monitor the logs for `All applications started`.

```sh
docker logs -f atsd-sandbox
```

### Configure Collector

Log in to the Collector instance at `https://atsd_hostname:9443` with `axibase` username and `axibase` password.

Expand the **Jobs** drop-down list and select **JMX**.

![](./images/jobs-jmx.png)

Ensure you see the enabled `kafka-jmx` job.

![](./images/kafka-jmx-job.png)

This job uses `kafka-cluster-jmx` [Item List](https://axibase.com/docs/axibase-collector/jobs/jmx.html#connection-parameters) with Kafka JMX connection settings.
Replace default parameters in this list with actual broker JMX address. Expand the **Collections** drop-down list and select **Item Lists**.

![](./images/collections-item-list.png)

Open `kafka-cluster-jmx`.

![](./images/kafka-item-list-2.png)

Edit CSV-formatted items. Replace default parameters with actual JMX parameters. Set username and password if required and confirm that connection settings are correct. Click **Save**.

![](./images/kafka-item-list-3.png)

Expand the **Jobs** drop-down list and select **JMX**. Navigate to the `kafka-jmx` job. Click `kafka-series` in the configuration list

![](./images/kafka-job-check-1.png)

At the bottom of the page click **Test**.

![](./images/kafka-job-check-2.png)

If connection parameters are correct, you see series commands. Select other brokers and repeat test.

![](./images/brokers-test.png)

Return to the **Job** page and run the job.

![](./images/kafka-job-run-1.png)

![](./images/kafka-job-run-2.png)

### Configure ATSD

Log in to ATSD instance at `https://atsd_hostname:8443` using `axibase` username and `axibase` password.

Open the **Entities** tab and ensure Collector displays the Kafka nodes with hostnames

![](./images/nodes-hosts1.png)

Open the **Portals** menu and select **Configure**.

![](./images/portals-enable-1.png)

Select **Kafka Broker** and **Kafka Cluster** portals via checkbox and enable these portals using the split-button at the bottom of the page.

![](./images/portal-creation.png)

Check **Kafka Broker** portal. Return to the **Entities** page, find any kafka broker and click the **Portal** icon.

![](./images/open-portal.png)

![](./images/kafka-broker-portal-check-2.png)

Check Kafka cluster entity view and portal. Open the **Entity Views** menu and select **Kafka**.

![](./images/kafka-cluster-check-1.png)

Click **View Portal** to check the **Kafka Cluster** portal

![](./images/cluster-check-2.png)

![](./images/kafka-cluster-check-3.png)