# Configuring Slack/Telegram Notifications for New GitHub Issues

## Overview

This guide shows how to configure GitHub to alert you when someone raises an issue in your repository. This feature allows you to monitor your repository and receive notifications the moment an issue is raised. Follow the instructions to configure ATSD to send you the notifications directly through a third-party messenger service.

![](./images/workflow_issue.png)

## Purpose

The GitHub Team has recently developed the issue functionality to resemble a lightweight support system. Many GitHub repositories contain thousands of lines of code and need to handle an increasing number of issues raised both by repository collaborators as well as community members.

While the default email notifications delivered by GitHub provide a convenient way to stay on track, the flexibility of being able to match new issues to specific collaborators can be better accomplished by programmatic integration leveraging GitHub webhook functionality.

GitHub webhook functionality is prominently featured on the [Platform Roadmap](https://developer.github.com/early-access/platform-roadmap/), explore the latest developments from the GitHub Team and gain an insight into coming features.

## Launch ATSD Sandbox

Execute the `docker run` command to launch a local ATSD [sandbox](https://github.com/axibase/dockers/tree/atsd-sandbox) instance.

Replace the `SERVER_URL` parameter with the public DNS name of the Docker host where the sandbox container is running. The Docker host must be externally accessible to receive webhook notifications from GitHub servers.

To acquire the **Bot User Token**, open the [Slack API](https://api.slack.com/apps), select the application to use for integration, and navigate to the **Install App** tab. The **Bot User OAuth Access Token** field contains the needed information. Note that you must be a collaborator for the application which you want to integrate.

```sh
docker run -d -p 8443:8443 \
  --name=atsd-sandbox \
  --env START_COLLECTOR=off \
  --env SERVER_URL=https://atsd.company_name.com:8443 \
  --env WEBHOOK=github \
  --env SLACK_TOKEN=xoxb-************-************************ \
  --env SLACK_CHANNELS=general \
  --env ATSD_IMPORT_PATH='https://raw.githubusercontent.com/axibase/atsd-use-cases/master/integrations/github/resources/github-issue-open.xml' \
  axibase/atsd-sandbox:latest
```

> For advanced launch settings refer to the [ATSD Sandbox Documentation](https://github.com/axibase/dockers/tree/atsd-sandbox).

Watch the sandbox container logs for `All applications started`.

```sh
docker logs -f atsd-sandbox
```

Copy the newly-created GitHub webhook URL from the log output once all applications successfully start.

```txt
All applications started
Webhooks created:
Webhook user: github
Webhook URL: https://github:password@atsd.example.org:8443/api/v1/messages/webhook/github?exclude=organization.*;repository.*;*.signature;*.payload;*.sha;*.ref;*_at;*.id&include=repository.name;repository.full_name&header.tag.event=X-GitHub-Event&excludeValues=http*&debug=true
```

Refer to [GitHub Developer Guide](https://developer.github.com/webhooks/) for additional information on outgoing webhooks.

Open the **Settings** menu of the GitHub repository to monitor.

![](./images/repo-settings.png)

Open the **Webhooks** tab from the left-side menu and click **Add Webhook**.

On the **Add Webhook** page, configure the following settings:

* **Payload URL**: Copy the GitHub webhook URL from the Docker log.
* **Content Type**: Select **application/json**.
* Click **Disable SSL Verification** and confirm the setting.
* Select **Send me everything**, under **Which events would you like to trigger this webhook?** The rule engine filters other events.

![](./images/webhook-config.png)

Be sure that your server is reachable by GitHub servers. For more information about configuring GitHub webhooks use the [GitHub Developer Guide](https://developer.github.com/webhooks/configuring/).

Once you configure your server and webhook, confirm connectivity at the bottom of the **Manage Webhook** page.

![](./images/recent-delivery.png)

See [Troubleshooting](troubleshooting.md) for connectivity issues.

---

You begin receiving messenger notifications the next time someone raises an issue in your GitHub repository.

![](./images/slack_issue.png)

**Repository**, **User**, and **Issue** links redirect you to the repository where the issue is raised, the user who raised the issue, and the issue page itself, respectively.

## Explore ATSD

Access the ATSD web interface at [`https://docker_host:8443/`](https://github.com/axibase/dockers/tree/atsd-sandbox#exposed-ports).

Log in to ATSD using the [default credentials](https://github.com/axibase/dockers/tree/atsd-sandbox#default-credentials) and explore the database.