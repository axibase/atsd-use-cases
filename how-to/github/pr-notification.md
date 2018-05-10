# Configure Slack/Telegram Notifications for New GitHub Pull Requests

## Overview

This guide shows how to configure GitHub to alert you when anyone opens a new pull request in your repository. This feature allows you to monitor your repository and receive notifications the moment a new PR is opened. Follow the instructions to configure the notifications to be sent directly to repository collaborators through a third-party messenger service with [Axibase Time Series Database](https://axibase.com/products/axibase-time-series-database/).

![](images/workflow-three.png)

## Purpose

Pull Request functionality in GitHub is used for repository quality control. Only repository owners or other credentialed users may commit visible changes to their repositories. Manage pull requests from repository collaborators from anywhere with an internet connection without needing to log in to GitHub.

While the default email notifications delivered by GitHub provide a convenient way to stay on track, the flexibility of being able to quickly handle new pull requests or make them known to specific collaborators can be better accomplished using programmatic integration leveraging GitHub webhook functionality.

Webhook functionality is constantly evolving to include new options , explore the GitHub development team's latest pursuits on the [Platform Roadmap](https://developer.github.com/early-access/platform-roadmap/) for an insight into coming features.

## Launch ATSD Sandbox

Execute the `docker run` command to launch a local ATSD [sandbox](https://github.com/axibase/dockers/tree/atsd-sandbox) instance.

Replace the `SERVER_URL` parameter in the command above with the public DNS name of the Docker host where the sandbox container will be running. The Docker host should be externally accessible to receive webhook notifications from GitHub servers.

```sh
docker run -d -p 8443:8443 \
  --name=atsd-sandbox \
  --env START_COLLECTOR=off \
  --env SERVER_URL=https://atsd.company_name.com:8443 \
  --env WEBHOOK=github \
  --env SLACK_TOKEN=xoxb-************-************************ \
  --env SLACK_CHANNELS=general,devops \
  --env ATSD_IMPORT_PATH='https://raw.githubusercontent.com/axibase/atsd-use-cases/master/how-to/github/resources/github-pr.xml' \
  axibase/atsd-sandbox:latest
```

> For advanced launch settings refer to this [guide](https://github.com/axibase/dockers/tree/atsd-sandbox).

Replace the `SERVER_URL` parameter in the command above with the public DNS name of the Docker host where the sandbox container will be running. The Docker host should be externally accessible to receive webhook notifications from GitHub servers.

For advanced launch settings refer to this [guide](https://github.com/axibase/dockers/tree/atsd-sandbox).

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
* **Content Type**: Select `application/json`.
* Click **Disable SSL Verification** and confirm the setting.
* Select **Send me everything**, under **Which events would you like to trigger this webhook?** The rule engine will filter other events.

![](images/webhook-config.png)

Be sure that your server is reachable by GitHub servers. For more information about configuring GitHub webhooks use the [developer guide](https://developer.github.com/webhooks/configuring/).

Once your ATSD server and webhook have been configured, confirm connectivity at the bottom of the **Manage Webhook** page.

![](images/recent-delivery.png)

See the [Troubleshooting](troubleshooting.md) for connectivity issues.

---

You'll begin receiving messenger notifications the next time an PR is raised on your GitHub repository.

![](images/slack-pr.png)

**Repository**, **User**, and **PR** links will redirect you to the repository where the PR was opened, the GitHub profile of the user who opened the PR, and the PR page itself, respectively.
