# How to Monitor SSL Certificates Expiry Dates for subdomains

## Overview

[Axibase Collector](https://github.com/axibase/axibase-collector/#overview) contains tools to collect information about SSL certificates. Monitor SSL certificates for the subdomains of some top domain and receive notifications via [Slack](https://slack.com/) triggered by the [Rule Engine](https://axibase.com/docs/atsd/rule-engine/). ATSD notifies when a certificate expiry date is approaching or modified. Query a list of domains using SQL in the [CRT Certificate Search](https://crt.sh) portal created by [Comodo Group](https://www.comodo.com).

### Tools and Resources

Certificate search engine [`crt.sh`](https://crt.sh) stores information about SSL certificates issued by Comodo Group. The portal provides open access to the database. [ATSD Sandbox](https://github.com/axibase/dockers/tree/atsd-sandbox#overview) is the Docker image which runs ATSD and Axibase Collector instances used in this integration.

## Procedure

1. [Prepare job and rules for domain](#prepare-files-for-domain).
2. [Configure and launch ATSD Sandbox](#configure-and-launch-atsd-sandbox).
3. [Receive notifications](#notifications).

### Prepare Files for Domain

Create a directory to store tutorial files and navigate to the newly created directory from the console.

```bash
mkdir tutorial && cd ./tutorial
```

### Configure Slack Notifications

ATSD Sandbox can pass the `SLACK_TOKEN` for notifications as environment variable.

> See [Web Notifications Documentation](https://github.com/axibase/dockers/tree/atsd-sandbox#outgoing-webhooks) for more information.

### Configure and Launch ATSD Sandbox

Job file contains placeholder `${ENV.TOP_DOMAIN}` instead of a real domain name. Set `TOP_DOMAIN` environment variable to an actual domain name. Collector replaces the placeholder with variable name during the import process. In the launch command shown below, `TOP.DOMAIN` is set to [axibase.com](https://axibase.com).

Start ATSD Sandbox with the required [environment variables](https://github.com/axibase/dockers/tree/atsd-sandbox#container-parameters):

Place your Slack token instead of `SLACK_TOKEN` placeholder.

```bash
docker run -d -p 8443:8443 -p 9443:9443 -p 8081:8081 \
  --name=atsd-sandbox \
  --volume $(pwd):/import \
  --env TOP_DOMAIN=axibase.com \
  --env ATSD_IMPORT_PATH='https://raw.githubusercontent.com/axibase/atsd-use-cases/dev-howto-monitor-ssl-for-domains/how-to/atsd-sandbox/monitor-ssl-expiry-dates/resources/ssl-certificates-files.tar.gz' \
  --env COLLECTOR_IMPORT_PATH='https://raw.githubusercontent.com/axibase/atsd-use-cases/dev-howto-monitor-ssl-for-domains/integrations/atsd-sandbox/monitor-ssl-expiry-dates/resources/job_http_subdomains-ssl-certificates.xml' \
  --env SLACK_TOKEN={SLACK_TOKEN} \
  axibase/atsd-sandbox:latest
```

### Notifications

ATSD sends a test notification to Slack upon successful launch.

![Test ATSD Notification](./images/test-notification.png)

Collector starts the imported monitoring job and imports the data into ATSD. The database sends a message with the certificate expiry date of the monitored domain.

 ![Certificate's expiry date set](./images/expiry-date-set.png)

Upon modification of SSL certificate expiry date, the database sends the following message:

![Certificate's expiry date set](./images/expiry-date-changed.png)

If less than 30 days remain before SSL certificate expiry date, the database sends the following message:

![Expiration rule](./images/expiration-approaching.png)

## Troubleshooting

In the case of unsuccessful launch, review ATSD Sandbox `start.log` file.

```bash
docker logs atsd-sandbox
```
