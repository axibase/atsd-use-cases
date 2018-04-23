# Configure Launch Notifications for AWS Resources

## Overview

This guide shows how to configure automatic email notifications upon resource launch from an Amazon Web Services account. This feature enables real-time notifications that alert you to resource status change and prevent unauthorized use of your AWS account which, if left unchecked, can result in expensive fees from AWS and potentially harmful operations.

![](images/new-flow.png)

You may follow these instructions to set up default AWS email notifications or follow the advanced procedure to integrate Axibase Time Series Database and AWS CloudWatch Events for enhanced notifications delivered via email, or through your preferred messenger service such as Slack or Telegram.

### Configure a New CloudWatch Event

From the AWS console homepage, open the **Services** menu and in the **Management Tools** section, select **CloudWatch**.

![](images/cw-menu.png)

On the left toolbar, click **Rules**. On the **Rules** page, click **Create New Rule**.

![](images/cw1.png)

On the following page, configure the rule to respond to an **Event Pattern** and in the **Build Event Pattern to Match...** drop-down menu, select **All Events**. You can customize the filter later on.

![](images/cw-2.png)

### Configure SNS Topic

In a new tab or window, open the **Services** menu and under the **Application Integration** section, select **Simple Notification Services** (SNS).

![](images/app-integration-sns.png)

From the **SNS Dashboard**, navigate to the **Topics** page from the menu on the left. Click **Create New Topic**. Complete the information on the **Create Topic** form and save it.

![](images/sns-1.png)

Click the **ARN Link** of the newly created topic to configure its details.

![](images/sns-2.png)

### Define Subscribers

On the **Topic Details** page, click **Create Subscription**.

![](images/sns-3.png)

Define the email address to which you would like AWS status change notifications to be sent. Be sure to select **Email** from the **Protocol** drop-down menu.

![](images/email-subscription.png)

Once you have completed creating a new subscription, click **Confirm Subscription** and AWS will send the new subscriber an email similar to the one shown here. 

![](images/confirm-email.png)

After confirming, you will be shown the following notification indicating that the email address was successfully confirmed.

![](images/email-confirm.png)

Refresh the page with the **Refresh** button on the bottom right portion of the screen. A confirmed email subscriber entry is shown here.

![](images/confirmed-email.png)

You are ready to start receiving native AWS status change notifications. A sample email notification is shown here.

![](images/aws-default.png)

## ATSD Integration

### Launch ATSD Sandbox

Follow the procedure below to send AWS CloudWatch events into ATSD to enrich standard SNS notifications with additional resource details and AWS console links.

* Launch an [ATSD sandbox](https://github.com/axibase/dockers/tree/atsd-sandbox) using the following command:

```
docker run -d -p 8443:8443 \
  --name=atsd-sandbox \
  --env ATSD_IMPORT_PATH='https://raw.githubusercontent.com/axibase/atsd-use-cases/master/how-to/aws/cloud-watch-alert/resources/rule_aws-cloudwatch-events.xml' \
  --env WEBHOOK=aws-cw \
  axibase/atsd-sandbox:latest
```

This command will start the sandbox applications, import the [rule](https://github.com/axibase/atsd/tree/master/rule-engine#rule-engine) needed for integration and generate an incoming webhook for AWS SNS subscriptions.

Watch the start log for progress:

```
docker logs -f atsd-sandbox
```

Wait for the `All applications started` line.

### Launch Sandbox with Automated Slack and Email Configuration

To automatically configure an email client in the ATSD sandbox container:

* Create a directory that will be mounted into the container, for example `/home/user/import`.
* Specify email account settings in the `mail.properties` file in this directory:

  ```
  server=mail.example.org
  port=587
  user=myuser@example.org
  password=secret
  ```
* Specify Slack Bot token in the `slack.properties` file in this directory:

  ```
  token=xoxb-************-************************
  channels=general,devops
  ```  

* Add the `EMAIL_CONFIG` and `SLACK_CONFIG` variables, as well as the `volume` setting to the run command:

```
docker run -d -p 8443:8443 \
  --name=atsd-sandbox \
  --env ATSD_IMPORT_PATH='https://raw.githubusercontent.com/axibase/atsd-use-cases/master/how-to/aws/cloud-watch-alert/resources/rule_aws-cloudwatch-events.xml' \
  --env WEBHOOK=aws-cw \
  --env SLACK_CONFIG=slack.properties \
  --env EMAIL_CONFIG=mail.properties \
  --volume /home/user/import:/import \
  axibase/atsd-sandbox:latest
```

### Create SNS Subscription

Copy the incoming 'aws-cw' webhook URL from the start log.

```
...
[ATSD] Importing '/tmp/import/rule_aws-cloudwatch-events.xml' configuration
[ATSD] Successfully imported '/tmp/import/rule_aws-cloudwatch-events.xml'
aws-cw webhook created:
https://aws-cw:PASSWORD@atsd_hostname:8443/api/v1/messages/webhook/aws-cw?command.date=Timestamp&json.parse=Message&exclude=Signature;SignatureVersion;SigningCertURL;SignatureVersion;UnsubscribeURL;MessageId;Message.detail.instance-id;Message.time;Message.id;Message.version
```

Navigate to the **Topics** section of the **Simple Notification Service** page once again. On the same **Topic Details** page that you used to create the AWS email subscription, click **Create Subscription** to add a second subscription to the topic.

Return to the **Create Subscription** form, and paste the Webhook URL in the **Endpoint** field. Be sure that the **Protocol** drop-down menu is showing **HTTPS**. 

AWS SNS notifications over HTTPS protocol do not support destination endpoints with self-signed SSL certificates. If your ATSD instance is running on a self-signed certificate, switch to the HTTP protocol or install a [CA-signed SSL certificate](https://github.com/axibase/atsd/blob/master/administration/ssl-ca-signed.md) into ATSD.

![](images/sns-4.png)

Confirm that your new subscription is active by checking that the **Subscriber** column contains actual subscriber information and is not showing **Pending Confirmation** as seen here.

![](images/sns-6.png)

ATSD is ready to be configured to notify you via [**Slack Team Messaging**](https://slack.com/), [**Telegram Messenger**](https://telegram.org/). 

### Email Notifications from ATSD

Configure the [mail client](https://github.com/axibase/atsd/blob/master/administration/mail-client.md) by following the instructions here or by following the alternative launch instructions above.

Open the **Alerts** menu from the toolbar on the left and select **Rules**. By default the imported rule will be named `aws-cloudwatch-events`. Open the rule editor by clicking the rule name link. Select the **Email Notifications** tab from the toolbar along the top of the screen and update the **Recipients** field to include those addresses to whom you would like email notification to be delivered.

![](images/my-email.png)

Now, detailed status change notifications will be sent via email.

![](images/atsd-event-alert.png)

ATSD email notifications contain context-aware links to the newly launched AWS resource for quick drill-down. Links redirect to the AWS console, as seen here.

![](images/atsd-advanced-alert.png)

### Detailed Slack Notifications from ATSD

Configure your local ATSD instance to send messages to **Slack Messenger** by following [this procedure](https://github.com/axibase/atsd/blob/master/rule-engine/notifications/slack.md) or adding the following environment variable to the atsd-sandbox image above:

```
   --env SLACK_CONFIG="slack.properties.xml"
```

Bind the `slack.properties.xml` file to the sandbox image with the following:

```
   --volume /home/user/slack.properties.xml:/slack.properties.xml
```

The bound volume should at least contain the following required parameters:

```
token=xoxb-************-************************
channels=general
```

Now, your status change notifications will be sent via Slack messages as well as email.

A sample status change Slack message is shown here. 

![](images/-slack-notification.png)

### Detailed Telegram Notifications from ATSD 

Configure your local ATSD instance to send messages to **Telegram Messenger** by following [this procedure](https://github.com/axibase/atsd/blob/master/rule-engine/notifications/telegram.md) or adding the following environment variable to the atsd-sandbox image above:

```
   --env TELEGRAM_CONFIG="telegram.properties.xml"
```

Bind the `telegram.properties` file to the sandbox image with the following:

```
   --volume /home/user/telegram.properties.xml:/telegram.properties.xml
```

The bound volume should at least contain the following required parameters:

```
token=xoxb-************-************************
channels=general
```

Now, your status change notifications will be sent via Telegram messages as well as email.

A sample Telegram message is shown here. Telegram notifications will contain links to newly launched resources, as seen here.

![](images/telegram-alerts.png)
