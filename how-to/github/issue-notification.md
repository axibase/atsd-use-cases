# Configure Slack/Telegram Notifications for New Github Issues

## Overview

This guide shows how to configure Github to alert you when someone raises an issue in your repository. This feature allows you to monitor your repository and receive notifications the moment an issue is raised. Follow the instructions to configure the notifications to be sent directly to your repository collaborators through a third-party messenger service with [Axibase Time Series Database](https://axibase.com/products/axibase-time-series-database/).

![](images/workflow-1.png)

## Purpose

The issue functionality in Github has evolved recently to resemble a lightweight support system. Many Github repositories contain thousands of lines of code and need to handle an increasing number of issues raised both by repository collaborators as well as community members.

While the default email notifications delivered by Github provide a convenient way to stay on track, the flexibility of being able to match new issues to specific collaborators can be better accomplished using programmatic integration leveraging Github webhook functionality.

## Launch ATSD Sandbox

Execute the `docker run` command to launch a local ATSD [sandbox](https://github.com/axibase/dockers/tree/atsd-sandbox) instance.

Replace the `SERVER_URL` parameter in the command above with the public DNS name of the Docker host where the sandbox container will be running. The Docker host should be externally accessible to receive webhook notifications from Github servers.

```sh
docker run -d -p 8443:8443 \
  --name=atsd-sandbox \
  --env START_COLLECTOR=off \
  --env SERVER_URL=https://atsd.company_name.com:8443 \
  --env WEBHOOK=github \
  --env SLACK_TOKEN=xoxb-************-************************ \
  --env SLACK_CHANNELS=general,devops \
  --env ATSD_IMPORT_PATH='https://raw.githubusercontent.com/axibase/atsd-use-cases/master/how-to/github/resources/github-issue-open.xml' \
  axibase/atsd-sandbox:latest
```

> For advanced launch settings refer to this [guide](https://github.com/axibase/dockers/tree/atsd-sandbox).

Watch the sandbox container logs for `All applications started` line.

```sh
docker logs -f atsd-sandbox
```

Copy the newly-created Github webhook URL from the log output once all applications have successfully started.

```txt
All applications started
Webhooks created:
Webhook user: github
Webhook URL: https://github:PdWnC1jF@atsd.company.com:8443/api/v1/messages/webhook/github?exclude=organization.*;repository.*;*.signature;*.payload;*.sha;*.ref;*_at;*.id&include=repository.name;repository.full_name&header.tag.event=X-Github-Event&excludeValues=http*&debug=true
```

Refer to [Github Developer Guide](https://developer.github.com/webhooks/) for additional information on outgoing webhooks.

Open the **Settings** menu for the Github repository for which you would like to create notifications.

![](images/repo-settings.png)

Select the **Webhooks** tab from the left-side menu and click **Add Webhook**.

On the **Add Webhook** page, configure the following settings:

* **Payload URL**: Copy the Github webhook URL from the Docker log.
* **Content Type**: Select `application/json`.
* Click **Disable SSL Verification** and confirm the setting.
* Select **Send me everything**, under **Which events would you like to trigger this webhook?** The rule engine will filter other events.

![](images/webhook-config.png)

Be sure that your server is reachable by Github servers. For more information about configuring Github webhooks use the [developer guide](https://developer.github.com/webhooks/configuring/).

Once your ATSD server and webhook have been configured, confirm connectivity at the bottom of the **Manage Webhook** page.

![](images/recent-delivery.png)

## Confirm Connectivity

In the ATSD environment, open the left-side **Settings** menu, navigate to **Diagnostics** and click **Webhook Requests**.

![](images/webhook-diag.png)

On the **Webhook Requests** page, you will see your newly-configured webhook. Under the **Details** column, click the **View** link to see detailed information about the webhook request.

![](images/webhook-confirm.png)

You'll receive a test message from ATSD:

![](images/ping-message.png)

---

You'll begin receiving messenger notifications the next time an issue is raised on your Github repository.

![](images/slack_issue.png)

**Repository**, **User**, and **Issue** links will redirect you to the repository where the issue was raised, the user who raised the issue, and the issue page itself, respectively.