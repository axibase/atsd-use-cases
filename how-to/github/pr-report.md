# Daily Pull Request Report for GitHub Repositories

## Overview

This guide shows how to configure [ATSD](https://axibase.com/products/axibase-time-series-database/) to produce a daily report with all open Pull Requests across an organization's entire collection of repositories and email it to subscribed users. GitHub [webhook services](pr-notification.md) may be used to notify repository owners and administrators when a Pull Request is opened, but for larger organizations with a large collection of repositories, individual Pull Requests may be missed and left open leading to potential conflicts or inaccurate code / documentation. This feature allows repository owners and administrators to monitor their work and receive a daily report with the status of all open Pull Requests across an entire repository library. Follow the instructions to configure the notifications to be sent directly to any group of subscribers via email with [Axibase Time Series Database](https://axibase.com/products/axibase-time-series-database/) and the [GitHub v4 API](https://developer.github.com/v4/).

![](images/pr-report-workflow.png)

## Purpose

Large organizations maintain large GitHub libraries with many repositories. Keeping track of many incoming Pull Requests is important to maintain accurate documentation and up-to-date code accessible to end users, but even attentive repository administrators may miss the occasional Pull Request. Stay on top of open Pull Requests with daily reports delivered to a list of subscribers.

GitHub features email notifications for individual repositories, but the task of tracking Pull Requests across many repositories may be better accomplished using programmatic integration leveraging the [GraphQL](https://graphql.org/) API query language, featured in the GitHub API.

In contrast to the [GitHub v3 REST API](https://developer.github.com/v3/), the latest API offers more flexibility by replacing multiple REST requests with a single call to fetch all relevant data.

## Launch ATSD Sandbox

Execute the `docker run` command to launch a local ATSD [sandbox](https://github.com/axibase/dockers/tree/atsd-sandbox) instance.

Replace the `SERVER_URL` parameter with the public DNS name of the Docker host where the sandbox container will be running.

```sh
docker run -d -p 8443:8443 \
  --name=atsd-sandbox \
  --env START_COLLECTOR=off \
  --env SERVER_URL=https://atsd.company_name.com:8443 \
  --env EMAIL_CONFIG=mail.properties \
  --env ATSD_IMPORT_PATH='https://raw.githubusercontent.com/axibase/atsd-use-cases/master/how-to/github/resources/github-daily-pr-status.xml' \
  --env ATSD_IMPORT_PATH='https://raw.githubusercontent.com/axibase/atsd-use-cases/master/how-to/github/resources/github-graphql-table.xml' \
  --env ATSD_IMPORT_PATH='https://raw.githubusercontent.com/axibase/atsd-use-cases/master/how-to/github/resources/graphql-queries.xml' \
  --volume /home/user/mail.properties:/mail.properties \
  axibase/atsd-sandbox:latest
```

The bound volume should point to the **absolute path** where a plaintext file is stored containing the following parameters:

```txt
server_name=ATSD-sandbox
server=smtp.example.org
port=587
sender=notify@axibase.com
user=myuser@example.org
password=secret
auth=true
ssl=true
upgrade_ssl=true
```

This file defines the mail server which will host outgoing reports. The Simple Mail Transfer Protocol (SMTP) documentation for any mail server will contain information on the correct `port` to expose, typically `587`, and the name of the server. Replace `server`, `user`, and `password` fields with legitimate credentials.

> For advanced launch settings refer to this [guide](https://github.com/axibase/dockers/tree/atsd-sandbox).

Watch the sandbox container logs for `All applications started`.

```sh
docker logs -f atsd-sandbox
```

The ATSD host will be present in the logs as a clickable link:

```txt
[ATSD] https://atsd_hostname:8443
```

## Adding Subscribers

Log in to ATSD using the [default credentials](https://github.com/axibase/dockers/tree/atsd-sandbox#default-credentials). Open the **Alerts** menu and select **Rules**.

![](images/alerts-rules.png)

Open the `github-daily-pr-status` rule and navigate to the **Email Notifications** tab. Add a list of subscriber email addresses separated by commas.

![](images/email-notifications.png)

> The system will prevent malformed email addresses from being saved and return a warning.

## Configuring Report Delivery

By default, the `github-daily-pr-status` rule is configured to deliver a report every morning at 5 AM UTC time, which may differ from local time.

Open the **Settings** menu and select **System Information** to view system time.

![](images/settings-system-information.png)

Modify delivery time by opening the `github-daily-pr-status` rule. The `Condition` field contains:

```java
now.getHourOfDay == 5
```

Change the value of this expression to the integer UTC 24-hour time when the report should be delivered.

Minute granularity may be applied by extending the expression:

```java
now.getHourOfDay == 18 && now.getMinuteOfHour == 30
```

Report delivery will be scheduled for 6:30 PM UTC time.

## Configure GraphQL Query

Open the **Data** menu and select **Replacement Tables**.

![](images/data-replacement-tables.png)

In the `value` field, the GraphQL query will be present. The `organization` clause contains the placeholder value `your-organization-name` surrounded by quotation marks. Within the quotation marks, replace the placeholder information with the case-sensitive name of the GitHub organization whose repositories will be monitored. For information about creating a new organization, see the [GitHub Help Documentation](https://help.github.com/articles/creating-a-new-organization-from-scratch/).

## Notification Payload

The `github-daily-pr-status` rule contains this payload, found in the **Text** field of the **Email Notifications** tab:

```json
${addTable(
  jsonToLists(
    jsonPathFilter(
      queryConfig('github-graphql-table',
        ['GQL_query': lookup('graphql-queries', 'issue-list')]
      ).content,
      "$..pullRequests.nodes[*]"
    )
  )
, 'html', true)}
```

The `queryConfig` clause calls the `github-graphql-table` web notification setting which queries the [GraphQL API v4](https://developer.github.com/v4/guides/forming-calls/#the-graphql-endpoint) via POST method and returns open Pull Request information in JSON format. Inspect this configuration by opening the **Alerts** menu and selecting **Web Notifications**.

![](images/alerts-web-notifications.png)

The `'GQL_query'` variable is delivered as the outgoing query and returns the `pullRequests` [node](https://developer.github.com/v4/guides/intro-to-graphql/#node), which is a JSON list of open Pull Requests.

## Report Delivery

Before report delivery, ensure all parameters have been correctly configured:

* ATSD web client is able to resolve outgoing email server (See **Settings** > **Mail Client** to send test messages);

* [Email subscriber](#adding-subscribers) list defined.

* [GraphQL query](#configure-graphql-query) targets the appropriate organization. Any organization's public repositories may be queried by GraphQL.

A sample report from [**Siemens**](https://github.com/siemens) repositories:

![](images/pr-report-delivery.png)

Clickable URLs redirect to the Pull Request page.

For additional setup information, raise an [issue](https://github.com/axibase/atsd/issues) on the ATSD GitHub repository. For other GitHub tools developed by Axibase, see our [Use Cases Repository](https://github.com/axibase/atsd-use-cases#github).