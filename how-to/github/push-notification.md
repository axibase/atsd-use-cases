# Configure Slack/Telegram Notifications for a New GitHub Push

### Overview

This guide shows how to configure GitHub to alert you when someone pushes to your repository. This feature allows you to monitor the dataflow in your repository. Follow the instructions to configure the notifications to be sent to you directly through a third-party messenger service with [Axibase Time Series Database](https://axibase.com/products/axibase-time-series-database/).

![](images/workflow-5.png)

### Purpose

Repositories with collaborators working across the globe are difficult to monitor. Before it's time to squash a PR and merge two branches, the input of several team members is usually needed and when these operators are working from a third-party GUI client, most of their commits are appended in the form of a repository push.

While the default email notifications delivered by GitHub provide a convenient way to stay on track, the flexibility of being able to track new pushes can be better accomplished using programmatic integration leveraging GitHub webhook functionality.

### Launch ATSD Sandbox

Launch a local ATSD instance using the following sandbox image:

```
docker run -d -p 8443:8443 -p 9443:9443 \
  --name=atsd-sandbox \
  --env SERVER_URL=https://example.com \
  --env WEBHOOK=github \
  --env ATSD_IMPORT_PATH='https://raw.githubusercontent.com/axibase/atsd-use-cases/repo-notifications/how-to/github/resources/github-push.xml' \
  axibase/atsd-sandbox:latest
```

Replace the `SERVER_URL` parameter in the command above with the public DNS name of the Docker host where the sandbox container will be running. The Docker host should be externally accessible to receive webhook notifications from GitHub servers.

If you would like to automatically configure Slack Messaging Service at runtime, use the following ATSD Sandbox launch command:

```
docker run -d -p 8443:8443 -p 9443:9443 \
  --name=atsd-sandbox \
  --env SERVER_URL=https://atsd.company_name.com:8443 \
  --env WEBHOOK=github \
  --env SLACK_CONFIG="slack.properties \  
  --volume /home/user/slack.properties.xml:/slack.properties.xml \
  --env ATSD_IMPORT_PATH='https://raw.githubusercontent.com/axibase/atsd-use-cases/master/how-to/github/resources/github-issue-open.xml' \
  axibase/atsd-sandbox:latest
```

The bound volume should at least contain at least the required parameters seen below and be stored as a plaintext file at the defined location on your local machine or URL.

```
token=xoxb-************-************************
channels=general
```

For advanced launch settings refer to the following [guide](https://github.com/axibase/dockers/tree/atsd-sandbox).

Watch the sandbox container logs for `All applications started` line.

```
docker logs -f atsd-sandbox
```

Copy the newly-created GitHub webhook URL from the log output once all applications have successfully started.

```
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
* Select 'Send me everything', under **Which events would you like to trigger this webhook?** and select **Watches**. 

![](images/webhook-config.png)

Be sure that your server is reachable by GitHub servers. For more information about configuring GitHub webhooks use the [developer guide](https://developer.github.com/webhooks/configuring/). 

Once your server and webhook have been properly configured, confirm connectivity at the bottom of the **Manage Webhook** page.

![](images/recent-delivery.png)

### Confirm Connectivity

In the ATSD environment, open the left-side **Settings** menu, navigate to **Diagnostics** and click **Webhook Requests**.

![](images/webhook-diag.png)

On the **Webhook Requests** page, you will see your newly-configured webhook. Under the **Details** column, click the **View** link to see detailed information about the webhook request.

![](images/webhook-confirm.png)

### Configure Web Notification

Configure your [messenger of choice](https://github.com/axibase/atsd/blob/master/rule-engine/web-notifications.md#collaboration-services), for example:

* [Slack](https://github.com/axibase/atsd/blob/master/rule-engine/notifications/slack.md)
* [Telegram](https://github.com/axibase/atsd/blob/master/rule-engine/notifications/telegram.md)

In the ATSD environment, open the left-side **Alerts** menu and select **Web Notifications**.

![](images/alerts-wn.png)

Select the messenger which you've configured from the list on the **Web Notifications** page.

![](images/wn-page.png)

On the messenger-specific page, be sure that the **Web Notification** is enabled. In the `Auth Token` field, insert the authentication token you received from your messenger of choice. Configure additional parameters as needed such as **Bot Username** and click **Save**

![](images/web-notifications.png)

### Configure Alert Rule to Process GitHub Webhook Requests

Navigate to the **Rules** page as shown here.

![](images/alerts-rules.png)

Open the rule configuration by clicking the link in the **Name** column.

![](images/open-watch-rule.png)

On the **Web Notifications** tab, enable the rule. Click **Save**.

![](images/wn-watch.png)

You'll begin receiving messenger notifications the next time someone pushes to your GitHub repository.

![](images/slack_push.png)

**Repository** and **User** links will redirect you to the repository where the push occurred and user by whom the push was made, respectively.
