# Configuring Slack Notifications for New GitHub Repository Forks

## Overview

This guide shows how to configure GitHub to alert you when someone forks your repository. This feature allows you to monitor activity related to your repository. Follow the instructions to configure ATSD to send you the notifications directly through a third-party messenger service with.

![](./images/workflow_fork.png)

## Purpose

Github is a great place for open-source projects. Companies and individuals around the world are collaborating to improve code. Keep an eye on what others are doing with your repositories with **Fork Notifications**.

While the default email notifications delivered by GitHub provide a convenient way to stay on track, the flexibility of tracking new repository forks can be better accomplished by programmatic integration leveraging GitHub webhook functionality.

GitHub webhook functionality is prominently featured on the [Platform Roadmap](https://developer.github.com/early-access/platform-roadmap/), explore the latest developments from the GitHub Team and gain an insight into coming features.

## Launch ATSD Sandbox

Execute the `docker run` command below to launch a local ATSD [sandbox](https://github.com/axibase/dockers/tree/atsd-sandbox) instance.

Replace the `SERVER_URL` parameter with the public DNS name of the Docker host where the sandbox container is running. The URL must be externally accessible to receive webhook notifications from GitHub.

To acquire the **Bot User Token**, open the [Slack API](https://api.slack.com/apps), select the application to use for integration, and navigate to the **Install App** tab. The **Bot User OAuth Access Token** field contains the needed information. Note that you must be a collaborator for the application which you want to integrate.

```sh
docker run -d -p 8443:8443 \
  --name=atsd-sandbox \
  --env START_COLLECTOR=off \
  --env SERVER_URL=https://atsd.company_name.com:8443 \
  --env WEBHOOK=github \
  --env SLACK_TOKEN=xoxb-************-************************ \
  --env SLACK_CHANNELS=general \
  --env ATSD_IMPORT_PATH='https://raw.githubusercontent.com/axibase/atsd-use-cases/master/integrations/github/resources/github-fork.xml' \
  axibase/atsd-sandbox:latest
```

> For advanced launch settings refer to the [ATSD Sandbox Documentation](https://github.com/axibase/dockers/tree/atsd-sandbox).

Watch the container logs for `All applications started`.

```sh
docker logs -f atsd-sandbox
```

Copy the newly-created GitHub webhook URL from the log output once all applications successfully start.

```txt
All applications started
Webhooks created:
Webhook user: github
Webhook URL: https://github:password@atsd_hostname:8443/api/v1/messages/webhook/github?exclude=organization.*;repository.*;*.signature;*.payload;*.sha;*.ref;*_at;*.id&include=repository.name;repository.full_name&header.tag.event=X-GitHub-Event&excludeValues=http*&debug=true
```

Refer to [GitHub Developer Guide](https://developer.github.com/webhooks/) for additional information on outgoing webhooks.

Open the **Settings** menu of the GitHub repository for which you would like to create notifications.

![](./images/repo-settings.png)

Select the **Webhooks** tab from the left-side menu and click **Add Webhook**.

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

You begin receiving messenger notifications the next time someone creates a new fork from your GitHub repository.

![](./images/fork-message.png)

**Repository**, **User**, and **New Repository** links redirect you to the original repository, the user who forked it, and the newly-created repository, respectively.

## Explore ATSD

Access the ATSD web interface at [`https://docker_host:8443/`](https://github.com/axibase/dockers/tree/atsd-sandbox#exposed-ports).

Log in to ATSD using the [default credentials](https://github.com/axibase/dockers/tree/atsd-sandbox#default-credentials) and explore the database.