# Configure Slack Notifications for New GitHub Repository Subscriptions

## Overview

This guide shows how to configure GitHub to alert you when someone begins to watch your repository. This feature allows you to monitor your repository's followers. Follow the instructions to configure the notifications to be sent to you directly through a third-party messenger service with [Axibase Time Series Database](https://axibase.com/products/axibase-time-series-database/).

![](images/workflow-two.png)

## Purpose

Many repositories contain a broad range of code and documentation to which end-users may positively respond by subscribing. Turn your public repositories into product-to-market validation tools with **Subscription Notifications**.

While the default email notifications delivered by GitHub provide a convenient way to stay on track, the flexibility of being able to track new subscribers can be better accomplished using programmatic integration leveraging GitHub webhook functionality.

## Launch ATSD Sandbox

Execute the `docker run` command to launch a local ATSD [sandbox](https://github.com/axibase/dockers/tree/atsd-sandbox) instance.

Replace the `SERVER_URL` parameter with the public DNS name of the Docker host where the sandbox container will be running. The URL should be externally accessible to receive webhook notifications from GitHub.

```sh
docker run -d -p 8443:8443 \
  --name=atsd-sandbox \
  --env START_COLLECTOR=off \
  --env SERVER_URL=https://atsd.company_name.com:8443 \
  --env WEBHOOK=github \
  --env SLACK_TOKEN=xoxb-************-************************ \
  --env SLACK_CHANNELS=general,devops \
  --env ATSD_IMPORT_PATH='https://raw.githubusercontent.com/axibase/atsd-use-cases/master/how-to/github/resources/github-watch.xml' \
  axibase/atsd-sandbox:latest
```

Watch the container logs for `All applications started` line.

```sg
docker logs -f atsd-sandbox
```

Copy the newly-created GitHub webhook URL from the log output once all applications have successfully started.

```txt
All applications started
Webhooks created:
Webhook user: github
Webhook URL: https://github:PdWnC1jF@atsd.company.com:8443/api/v1/messages/webhook/github?exclude=organization.*;repository.*;*.signature;*.payload;*.sha;*.ref;*_at;*.id&include=repository.name;repository.full_name&header.tag.event=X-GitHub-Event&excludeValues=http*&debug=true
```

Open the **Settings** menu for the GitHub repository for which you would like to create notifications.

![](images/repo-settings.png)

Select the **Webhooks** tab from the left-side menu and click **Add Webhook**.

On the **Add Webhook** page, configure the following settings:

* **Payload URL**: Copy the GitHub webhook URL from the Docker log.
* **Content Type**: Select `application/json`.
* Click **Disable SSL Verification** and confirm the setting.
* Select **Send me everything**, under **Which events would you like to trigger this webhook?**.

![](images/webhook-config.png)

Refer to [GitHub Developer Guide](https://developer.github.com/webhooks/) for additional information on outgoing webhooks.

Be sure that your server is reachable by GitHub servers. For more information about configuring GitHub webhooks use the [developer guide](https://developer.github.com/webhooks/configuring/).

Once your server and webhook have been properly configured, confirm connectivity at the bottom of the **Manage Webhook** page.

![](images/recent-delivery.png)

## Confirm Connectivity

In the ATSD environment, open the left-side **Settings** menu, navigate to **Diagnostics** and click **Webhook Requests**.

![](images/webhook-diag.png)

On the **Webhook Requests** page, you will see your newly-configured webhook. Under the **Details** column, click the **View** link to see detailed information about the webhook request.

![](images/webhook-confirm.png)

If you launched ATSD with the pre-configured `SLACK_CONFIG` variable, the setup process is complete. You'll receive a test message from ATSD:

![](images/ping-message.png)

You're ready to begin receiving notifications to the defined Slack Workspace.

## Alternative Launch Options

### Detailed Slack Notifications from ATSD

Configure your local ATSD instance to send messages to **Slack Messenger** by following [this procedure](https://github.com/axibase/atsd/blob/master/rule-engine/notifications/slack.md) or adding an environment variable to the atsd-sandbox container above:

```sh
  --env SLACK_TOKEN=xoxb-************-************************ \
  --env SLACK_CHANNELS=channel_name \
```

### Detailed Telegram Notifications from ATSD

Configure your local ATSD instance to send messages to **Telegram Messenger** by following [this procedure](https://github.com/axibase/atsd/blob/master/rule-engine/notifications/telegram.md) or adding an environment variable to the atsd-sandbox container command:

```sh
  --env TELEGRAM_BOT_TOKEN=*********:*********************************** \
  --env TELEGRAM_CHAT_ID=@channel_name \
```

---

You'll begin receiving messenger notifications the next time a new subscriber begins to watch your GitHub repository.

![](images/-slack-watch.png)

**Repository** and **User** links will redirect you to the newly-watched repository and the newly-subscribed user, respectively.