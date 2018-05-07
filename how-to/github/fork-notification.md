# Configure Slack Notifications for New GitHub Repository Subscriptions

## Overview

This guide shows how to configure GitHub to alert you when someone forks your repository. This feature allows you to monitor activity related to your repository. Follow the instructions to configure the notifications to be sent to you directly through a third-party messenger service with [Axibase Time Series Database](https://axibase.com/products/axibase-time-series-database/).

![](images/fork-workflow.png)

## Purpose

Github runs on open-source code. Companies and individuals around the world collaborate to improve their programs. Keep an eye on what others are doing with your repositories with **Fork Notifications**.

While the default email notifications delivered by GitHub provide a convenient way to stay on track, the flexibility of being able to track new repository forks can be better accomplished using programmatic integration leveraging GitHub webhook functionality.

## Launch ATSD Sandbox

Execute the `docker run` command below to launch a local ATSD [sandbox](https://github.com/axibase/dockers/tree/atsd-sandbox) instance.

Create a `slack.properties` file to pass Slack [notification settings](https://github.com/axibase/atsd/blob/master/rule-engine/notifications/slack.md) into the container.

```txt
token=xoxb-************-************************
channels=general
```

Specify the correct path to the `slack.properties` file in the `--volume` parameter.

Replace the `SERVER_URL` parameter with the public DNS name of the Docker host where the sandbox container will be running. The URL should be externally accessible to receive webhook notifications from GitHub.

```sh
docker run -d -p 8443:8443 \
  --name=atsd-sandbox \
  --env START_COLLECTOR=off \
  --env SERVER_URL=https://atsd.company_name.com:8443 \
  --env WEBHOOK=github \
  --env SLACK_CONFIG=slack.properties \
  --volume /path/to/slack.properties:/slack.properties \
  --env ATSD_IMPORT_PATH='https://raw.githubusercontent.com/axibase/atsd-use-cases/master/how-to/github/resources/github-fork.xml' \
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
* **Content Type**: Make sure you select `application/json`.
* Click **Disable SSL Verification** and confirm the setting.
* Under **Which events would you like to trigger this webhook?** select **Send me everything.**

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

You're ready to begin receiving notifications to your Slack Workspace.

## Configure Alert Rule to Process GitHub Webhook Requests

Navigate to the **Rules** page as shown here.

![](images/alerts-rules.png)

Open the rule configuration by clicking the link in the **Name** column.

![](images/open-watch-rule.png)

On the **Web Notifications** tab, enable the rule. Click **Save**.

![](images/wn-watch.png)

You'll begin receiving messenger notifications the next time someone creates a new fork from your GitHub repository.

![](images/fork-message.png)

**Repository** and **User** links will redirect you to the original repository, the user who forked it, and the newly-created repository, respectively.