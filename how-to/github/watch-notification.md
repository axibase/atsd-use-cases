# Configure Notifications for Repository Subscriptions

### Overview

This guide shows how to configure GitHub to alert you when someone begins to watch your reposity. This feature allows you to monitor your repository's followers. Follow the instructions to configure the notifications to be sent to you directly through a third-party messenger service with [Axibase Time Series Database](https://axibase.com/products/axibase-time-series-database/).

![](images/title-workflow.png)

### Purpose

Many repositories encapsulate a broad range of code and documentation to which end-users respond by subscribing. Turn your public repositories into market research and product experimentation with **Subscription Notifications**. New releases which generate a large number of subscriptions may be tracked without manually monitoring your watchlists, and obsolete repositiories which no longer garner much attention may be simplified and integrated to streamline your company's GitHub optics.

### Launch ATSD Sandbox

Launch a local ATSD instance using the following sandbox image:

```
docker run -d -p 8443:8443 -p 9443:9443 -p 8081:8081 \
  --name=atsd-sandbox \
  --env SERVER_URL=https://example.com \
  --env WEBHOOK=github \
  --env ATSD_IMPORT_PATH='https://raw.githubusercontent.com/axibase/atsd-use-cases/repo-notifications/how-to/github/resources/github-watch-rule.xml' \
  axibase/atsd-sandbox:latest
```

The `SERVER_URL` parameter in the template above should be replaced with the the externally-addressable DNS name of the machine on which `atsd-sandbox` is running.

For detailed launch information, or advanced launch configuration settings use the following [guide](https://github.com/axibase/dockers/tree/atsd-sandbox).

Monitor launch by consulting Docker logs:

```
docker logs -f atsd-sandbox
```

Wait for the sandbox to launch, indicated by the `All applications started` line, and copy the newly-created webhook from the logs.

```
[ATSD] Administrator account 'axibase' created.
github webhook created:
https://github:password@atsd-hostname0/api/v1/messages/webhook/github?type=webhook&entity=github&exclude=organization.*%3Brepository.*%3B*.signature%3B*.payload%3B*.sha%3B*.ref%3B*_at%3B*.id&include=repository.name&header.tag.event=X-GitHub-Event&excludeValues=http*&debug=true

```

* Replace `atsd-host` and `password` in payload URL template with valid information from Docker logs. Default username and password will be `axibase`.

### Create a GitHub Webhook

Log in to GitHub and open the **Settings** menu for the repository for which you would like to create notifications.

![](images/repo-settings.png)

Select the **Webhooks** tab from the left-side menu and click **Add Webhook**.

On the **Add Webhook** page, configure the following settings:

* **Payload URL**: Follow the [Launch ATSD Sandbox](#launch-atsd-sandbox) instructions below to launch a local ATSD instance and create a valid webhook. Copy / paste that webhook into this field. 
* **Content Type**: application/json
* Click **Disable SSL Verification** and confirm the setting.
* Select **Send me everything**, under **Which events would you like to trigger this webhook?** and select **Watches**. 

![](images/webhook-config.png)

Be sure that your server is exposed to receiving webhooks from GitHub, for more information about configuring your server use this [guide](https://developer.github.com/webhooks/configuring/). Once your server and webhook have been properly configured, confirm connectivity at the bottom of the **Manage Webhook** page.

![](images/deliv-confirm.png)

### Configure ATSD

> The sandbox command above contains a line which automatically imports the needed rule into ATSD. If you would like to import the following [rule configuration](resources/github-watch-rule.xml) manually, use this [guide](/../master/how-to/shared/import-rule.md).

Configure your messenger of choice according to one of the following guides:

* [Slack](https://github.com/axibase/atsd/blob/master/rule-engine/notifications/slack.md)
* [Telegram](https://github.com/axibase/atsd/blob/master/rule-engine/notifications/telegram.md)

After you have configured ATSD, GitHub, and the desired messenger service, new watch notifications will be delivered to any device where you can access the messenger service.

![](images/message.png)

### Confirm Connectivity

In the ATSD environment, open the left-side **Settings** menu, navigate to **Diagnostics** and click **Webhook Requests**.

![](images/webhook-diag.png)

On the **Webhook Requests** page, you will see your newly-configured webhook. Under the **Details** column, click the **View** link to see detailed information about the webhook request.

![](images/webhook-confirm.png)
