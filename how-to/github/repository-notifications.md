# Configure Notifications for Repository Subscriptions

### Overview

This guide shows how to configure GitHub to alert you when someone begins to watch your reposity. This feature allows you to monitor your repository's followers. Follow the instructions to configure the notifications to be sent to you directly through a third-party messenger service with [Axibase Time Series Database](https://axibase.com/products/axibase-time-series-database/).

![](images/title-chart.png)

### Create a GitHub Webhook

Log in to GitHub and open the **Settings** menu for the repository for which you would like to create notifications.

![](images/repo-settings.png)

Select the **Webhooks** tab from the left-side menu and click **Add Webhook**.

On the **Add Webhook** page, configure the following settings:

* **Payload URL**: 
```
https://user:PWD@atsd_host/api/v1/messages/webhook/github?type=webhook&entity=github&exclude=organization.*%3Brepository.*%3B*.signature%3B*.payload%3B*.sha%3B*.ref%3B*_at%3B*.id&include=repository.name&header.tag.event=X-GitHub-Event&excludeValues=http*&debug=true
```
> The above payload URL template should be modified to include a valid ATSD hostname and password. Follow the [Launch ATSD Sandbox](#launch-atsd-sandbox) instructions below to launch a local ATSD instance.

* **Content Type**: application/json
* Click **Disbale SSL Verification** and confirm the setting.
* Select **Let me individual events** under **Which events would you like to trigger this webhook?** and select **Watches**. 

![](images/webhook-config.png)

### Launch ATSD Sandbox

Launch a local ATSD instance using the following sandbox image:

```
docker run -d -p 8443:8443 -p 9443:9443 -p 8081:8081 \
  --name=atsd-sandbox \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  axibase/atsd-sandbox:latest
```

For detailed launch information, or advanced launch configuration settings use the following [guide](https://github.com/axibase/dockers/tree/atsd-sandbox).

Confirm successful launch and acquire hostname information by consulting Docker logs:

```
docker logs -f atsd-sandbox
```

Wait for `All applications started` notification:

```
[Collector] Account 'axibase' created.
All applications started

```

* Replace `atsd-host`, `user` and `password` in payload URL template above using valid information from Docker logs. Default username and password with be `axibase`.

### Import Rule Configuration
