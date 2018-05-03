# Configure Slack/Telegram Notifications for New GitHub Pull Requests

## Overview

This guide shows how to configure GitHub to alert you when anyone opens a new pull request in your repository. This feature allows you to monitor your repository and receive notifications the moment a new PR is opened. Follow the instructions to configure the notifications to be sent directly to repository collaborators through a third-party messenger service with [Axibase Time Series Database](https://axibase.com/products/axibase-time-series-database/).

![](images/workflow-three.png)

## Purpose

Pull Request functionality in GitHub is used for repository quality control. Only repository owners or other credentialed users may commit visible changes to their repositories. Manage pull requests from repository collaborators from anywhere with an internet connection without needing to log in to GitHub.

While the default email notifications delivered by GitHub provide a convenient way to stay on track, the flexibility of being able to quickly handle new pull requests or make them known to specific collaborators can be better accomplished using programmatic integration leveraging GitHub webhook functionality.

## Launch ATSD Sandbox

Launch an [ATSD Sandbox](https://github.com/axibase/dockers/tree/atsd-sandbox) container on Docker:

```sh
docker run -d -p 8443:8443 -p 9443:9443 \
  --name=atsd-sandbox \
  --env SERVER_URL=https://atsd.company_name.com:8443 \
  --env WEBHOOK=github \
  --env ATSD_IMPORT_PATH='https://raw.githubusercontent.com/axibase/atsd-use-cases/master/how-to/github/resources/github-pr.xml' \
  axibase/atsd-sandbox:latest
```

If you would like to automatically configure Slack Messaging Service at runtime, use the following ATSD Sandbox launch command:

```sh
docker run -d -p 8443:8443 -p 9443:9443 \
  --name=atsd-sandbox \
  --env SERVER_URL=https://atsd.company_name.com:8443 \
  --env WEBHOOK=github \
  --env SLACK_CONFIG="slack.properties" \
  --volume /home/user/slack.properties:/slack.properties \
  --env ATSD_IMPORT_PATH='https://raw.githubusercontent.com/axibase/atsd-use-cases/master/how-to/github/resources/github-pr.xml' \
  axibase/atsd-sandbox:latest
```

The bound volume should at least contain at least the required parameters seen below and be stored as a plaintext file at the defined location on your local machine or URL.

```txt
token=xoxb-************-************************
channels=general
```

Replace the `SERVER_URL` parameter in the command above with the public DNS name of the Docker host where the sandbox container will be running. The Docker host should be externally accessible to receive webhook notifications from GitHub servers.

For advanced launch settings refer to the following [guide](https://github.com/axibase/dockers/tree/atsd-sandbox).

Watch the sandbox container logs for `All applications started` line.

```sh
docker logs -f atsd-sandbox
```

Copy the newly-created GitHub webhook URL from the log output once all applications have successfully started.

```txt
All applications started
Webhooks created:
Webhook user: github
Webhook URL: https://github:PdWnC1jF@atsd.company.com:8443/api/v1/messages/webhook/github?exclude=organization.*;repository.*;*.signature;*.payload;*.sha;*.ref;*_at;*.id&include=repository.name;repository.full_name&header.tag.event=X-GitHub-Event&excludeValues=http*&debug=true
```

Refer to [GitHub Developer Guide](https://developer.github.com/webhooks/) for additional information on outgoing webhooks.

Open the **Settings** menu for the GitHub repository for which you would like to create notifications.

![](images/repo-settings.png)

Select the **Webhooks** tab from the left-side menu and click **Add Webhook**.

On the **Add Webhook** page, configure the following settings:

* **Payload URL**: Copy the GitHub webhook URL from the Docker log.
* **Content Type**: Make sure you select `application/json`.
* Click **Disable SSL Verification** and confirm the setting.
* Select 'Send me everything', under **Which events would you like to trigger this webhook?**.

![](images/webhook-config.png)

Be sure that your server is reachable by GitHub servers. For more information about configuring GitHub webhooks use the [developer guide](https://developer.github.com/webhooks/configuring/).

Once your ATSD server and webhook have been properly configured, confirm connectivity at the bottom of the **Manage Webhook** page.

![](images/recent-delivery.png)

## Confirm Connectivity

In the ATSD environment, open the left-side **Settings** menu, navigate to **Diagnostics** and click **Webhook Requests**.

![](images/webhook-diag.png)

On the **Webhook Requests** page, you will see your newly-configured webhook. Under the **Details** column, click the **View** link to see detailed information about the webhook request.

![](images/webhook-confirm.png)

If you launched ATSD with the pre-configured `SLACK_CONFIG` variable, the setup process is complete. You're ready to begin receiving notifications to the defined Slack Workspace.

## Configure Web Notification

### Detailed Slack Notifications from ATSD

Configure your local ATSD instance to send messages to **Slack Messenger** by following [this procedure](https://github.com/axibase/atsd/blob/master/rule-engine/notifications/slack.md) or adding the following environment variable to the atsd-sandbox container above:

```sh
   --env SLACK_CONFIG="slack.properties"
```

Bind the `slack.properties` file to the sandbox container with the following:

```sh
   --volume /home/user/slack.properties:/slack.properties
```

The bound volume should at least contain the following required parameters:

```txt
token=xoxb-************-************************
channels=general
```

Now, your status change notifications will be sent via Slack messages as well as email.

### Detailed Telegram Notifications from ATSD

Configure your local ATSD instance to send messages to **Telegram Messenger** by following [this procedure](https://github.com/axibase/atsd/blob/master/rule-engine/notifications/telegram.md) or adding the following environment variable to the atsd-sandbox container above:

```sh
   --env TELEGRAM_CONFIG="telegram.properties"
```

Bind the `telegram.properties` file to the sandbox container with the following:

```sh
   --volume /home/user/telegram.properties:/telegram.properties
```

The bound volume should at least contain the following required parameters:

```txt
bot_id=*********:***********************************
chat_id=-NNNNNNNNN
```

## Configure Alert Rule to Process GitHub Webhook Requests

Navigate to the **Rules** page as shown here.

![](images/alerts-rules.png)

Open the rule configuration by clicking the link in the **Name** column.

![](images/open-issue-rule.png)

On the **Web Notifications** tab, enable the rule. Click **Save**.

![](images/wn-issue-1.png)

You'll begin receiving messenger notifications the next time an issue is raised on your GitHub repository.

![](images/slack-pr.png)

**Repository**, **User**, and **PR** links will redirect you to the repository where the PR was opened, the GitHub profile of the user who opened the PR, and the PR page itself, respectively.
