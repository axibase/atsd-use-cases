# Kafka Integration

This integration guide describes how to monitor availability and performance of [Apache Kafka](https://kafka.apache.org/) with ATSD.

## Step 1: Configure Collector

1. Log in to the Collector web interface at `https://collector_hostname:9443`
2. From the **Jobs** page select **Import** by expanding the split-button below the table.
3. Import the [`kafka-jmx`](./resources/job_jmx_kafka-jmx.xml) job.
4. On the **JMX Job** page, enable the job status with the **Enabled** checkbox.
5. Adjust the `cron` expression if required. For more information on `cron` expressions, see [Scheduling](https://axibase.com/docs/axibase-collector/scheduling.html).
6. Select a target ATSD database to store data.
7. Click **Save**.

![JMX_JOB](./images/jmx_job_to_configuration.png)

### Configure series collection

1. Select `kafka-series` configuration.
2. On the **JMX Configuration** page, enter the JMX connection parameters or use an [Item List](https://axibase.com/docs/axibase-collector/jobs/jmx.html#connection-parameters) with predefined kafka parameters:

    * **Host**: Kafka hostname.
    * **Port**: JMX port.
    * **User Name**: JMX user name.
    * **Password**: Password for JMX user.
    * **Entity**: Optionally, specify the output of the hostname command on the Kafka server if it is different from `kafka_hostname` (for example if `kafka_hostname` represents a fully qualified name).
    * Other parameters are optional. For more information on JMX configuration, see [JMX Job Documentation](https://axibase.com/docs/axibase-collector/jobs/jmx.html).

3. Click **Test** to validate the configuration.
4. Click **Save**.

    ![](./images/series_config.png)

### Configure properties collection

1. Select `kafka-properties` configuration.
2. Set **Host**, **Port**, **User Name**, **Password**, and **Entity** fields as described in the previous section.
3. Click **Test** to validate the configuration.
4. Click **Save**.

    ![](./images/properties_config.png)

## Step 2: Configure Kafka in ATSD

1. Log in to the target ATSD instance at `https://atsd_hostname:8443`.
2. Navigate to the **Metrics** page and verify that `jmx.kafka.*` metrics are available.
3. Navigate to the **Entities** page and verify that `jmx.kafka.*` properties are available for entities from `kafka-properties` configuration.
4. Open the **Settings > Entity Groups** page and import [Kafka](./resources/groups.xml) entity group.
5. Expand the **Portals** menu, select **Configure** and import [Kafka](./resources/portal-configs.xml) portals (Enable **Auto-enable New Portals**).
6. Open the ![](./images/alerts.png) **Alerts** menu, select **Rules** and import [Kafka](./resources/rules.xml) rules (Enable **Auto-enable New Rules**).
7. Open the ![](./images/entity_views.png) **Entity Views** menu, select **Configure** and import [Kafka](./resources/entity-views.xml) Entity View configuration.

## Step 3: Verification

1. Select an open `Kafka` on the **Entity Views** menu:

    ![](./images/entity_view.png)

2. Verify that the portal in the table header is available and refers to the Kafka portal:

    ![](./images/kafka_cluster.png)

3. Verify that the portal for each entity refers to the Broker portal:

    ![](./images/kafka_broker.png)

## Consumer Lag

Consumer lag calculation requires information about producer offset and consumer offset.

Producer offset is collected from Kafka brokers by the JMX Job above.

Consumer offset is collected using a Kafka console consumer reading events from  the `__consumer_offset` topic on one of the Kafka servers in the cluster.

Log in to the Kafka server.

Download the [shell script](./resources/send_offset.sh) to the Kafka `bin` directory.

```sh
# assign execute permission
chmod +x /opt/kafka_2.12-1.0.0/bin/send_offset.sh
```

For Kafka versions before `0.10.2.0` use `--zookeeper` option instead `bootstrap-server` in the script.

Replace `ATSD_HOST` and `TCP_PORT` with actual values and launch the script.

> The default ATSD TCP command port is `8081`.

The script reads and sends topic offsets to ATSD under the hostname entity.

Launch the script:

```sh
nohup /opt/kafka_2.12-1.0.0/bin/send_offset.sh ATSD_HOST TCP_PORT &
```

If the hostname is different from the entity name used in the JMX job, specify the entity manually.

```sh
nohup /opt/kafka_2.12-1.0.0/bin/send_offset.sh ATSD_HOST TCP_PORT ENTITY &
```

The script continuously reads consumer offsets from Kafka and sends the offsets to ATSD as `series` commands. Kafka also copies the commands `stdout` for debugging.

```ls
series e:nurswgvml702 m:kafka.consumer_offset=455 t:groupid="console-consumer-72620" t:topic="test" t:partition=0 ms:1519893731570
series e:nurswgvml702 m:kafka.consumer_offset=492 t:groupid="console-consumer-72620" t:topic="test" t:partition=0 ms:1519893736569
series e:nurswgvml702 m:kafka.consumer_offset=492 t:groupid="console-consumer-72620" t:topic="test" t:partition=0 ms:1519893741570
series e:nurswgvml702 m:kafka.consumer_offset=550 t:groupid="console-consumer-72620" t:topic="test" t:partition=0 ms:1519893746570
```

1. Check that metric `kafka.consumer_offset` is available on the **Metrics** tab in ATSD.
1. Import [Consumer Lag Portal](./resources/consumer-lag.xml) into ATSD and change the topic name to view the consumer lag.

![](./images/consumer_lag.png)

For additional Kafka integration, see [Brokers Monitoring](brokers-monitoring/README.md) and [Consumers Monitoring](consumers-monitoring/README.md).
