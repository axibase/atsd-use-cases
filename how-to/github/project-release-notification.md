# Configure Slack/Telegram Notifications for New GitHub Project Releases

## Overview

This guide shows how to configure GitHub to alert you when someone creates a new project in your repository. This feature allows you to monitor your repository and receive notifications the moment a project is created. Follow the instructions to configure the notifications to be sent directly to your repository collaborators through a third-party messenger service with [Axibase Time Series Database](https://axibase.com/docs/atsd/).

![](./images/workflow-four.png)

## Purpose

Project management functionality in GitHub has evolved to enable users to design, execute, and complete the projects associated with their code stored on GitHub without the need for an external plug-in. Many GitHub repositories contain thousands of lines of code and need to handle an increasing number of projects, especially those associated with larger organizations with employees across the globe.

While the default email notifications delivered by GitHub provide a convenient way to stay on track, the flexibility of watching new projects as they are created can be better accomplished using programmatic integration leveraging GitHub webhook functionality.

GitHub webhook functionality is prominently featured on the [Platform Roadmap](https://developer.github.com/early-access/platform-roadmap/), explore the GitHub team's latest developments and gain an insight into coming features.

## Launch ATSD Sandbox

Execute the `docker run` command to launch a local ATSD [sandbox](https://github.com/axibase/dockers/tree/atsd-sandbox) instance.

Replace the `SERVER_URL` parameter with the public DNS name of the Docker host where the sandbox container will be running. The Docker host should be externally accessible to receive webhook notifications from GitHub servers.

To acquire the Bot User Token, open the [Slack API](https://api.slack.com/apps), select the application which you would like to use for integration, and navigate to the **Install App** tab. The `Bot User OAuth Access Token` field contains the needed information. Note that you must be a collaborator for the application which you would like to integrate.

```sh
docker run -d -p 8443:8443 \
  --name=atsd-sandbox \
  --env START_COLLECTOR=off \
  --env SERVER_URL=https://atsd.company_name.com:8443 \
  --env WEBHOOK=github \
  --env SLACK_TOKEN=xoxb-************-************************ \
  --env SLACK_CHANNELS=general \
  --env ATSD_IMPORT_PATH='https://raw.githubusercontent.com/axibase/atsd-use-cases/master/how-to/github/resources/github-project-create.xml' \
  axibase/atsd-sandbox:latest
```

> For advanced launch settings refer to this [guide](https://github.com/axibase/dockers/tree/atsd-sandbox).

Watch the sandbox container logs for `All applications started`.

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

![](./images/repo-settings.png)

Select the **Webhooks** tab from the left-side menu and click **Add Webhook**.

On the **Add Webhook** page, configure the following settings:

* **Payload URL**: Copy the GitHub webhook URL from the Docker log.
* **Content Type**: Select `application/json`.
* Click **Disable SSL Verification** and confirm the setting.
* Select **Send me everything**, under **Which events would you like to trigger this webhook?** The rule engine will filter other events.

![](./images/webhook-config.png)

Be sure that your server is reachable by GitHub servers. For more information about configuring GitHub webhooks use the [developer guide](https://developer.github.com/webhooks/configuring/).

Once your ATSD server and webhook have been configured, confirm connectivity at the bottom of the **Manage Webhook** page.

![](./images/recent-delivery.png)

See the [Troubleshooting](troubleshooting.md) for connectivity issues.

---

You'll begin receiving messenger notifications the next time a project is created in your GitHub repository.

![](./images/slack_project.png)

**Repository**, **User**, and **Project** links will redirect you to the repository where the Project was created, the GitHub profile of the user who opened the PR, and the Project page itself, respectively.

## Explore ATSD

ATSD web interface is accessible at [`https://docker_host:8443/`](https://github.com/axibase/dockers/tree/atsd-sandbox#exposed-ports).

Log in to ATSD using the [default credentials](https://github.com/axibase/dockers/tree/atsd-sandbox#default-credentials) to explore the database.