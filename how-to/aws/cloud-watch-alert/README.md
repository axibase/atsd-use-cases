# Configuring Launch Notifications for AWS Resources

## Overview

This guide shows how to configure automatic email notifications upon resource launch from an Amazon Web Services account. This feature enables real-time notifications that alert you of resource status change and prevent unauthorized use of your AWS account which can result in expensive fees from AWS and potentially harmful operations carried out by your account.

![](./images/cloudwatch-workflow.png)

Follow these instructions to set up default AWS email notifications or follow the advanced procedure to integrate [Axibase Time Series Database](https://axibase.com/docs/atsd/) and AWS CloudWatch Events for enhanced notifications delivered via email, or through your preferred messenger service such as Slack or Telegram.

### Configure a New CloudWatch Event

From the **Console Home** page, open the **Services** menu and in the **Management Tools** section, select **CloudWatch**.

![](./images/cw-menu.png)

On the left toolbar, click **Rules**. On the **Rules** page, click **Create New Rule**.

![](./images/cw1.png)

On the following page, configure the rule to respond to an **Event Pattern** and in the **Build Event Pattern to Match...** drop-down list, select **All Events**. You can customize the filter later on.

![](./images/cw-2.png)

### Configure SNS Topic

In a new tab or window, open the **Services** menu and under the **Application Integration** section, select **Simple Notification Services** (SNS).

![](./images/app-integration-sns.png)

From the **SNS Dashboard**, navigate to the **Topics** page from the menu on the left. Click **Create New Topic**. Complete the information on the **Create Topic** form and save it.

![](./images/sns-1.png)

Click the **ARN** link of the newly-created topic to configure additional details.

![](./images/sns-2.png)

### Define Subscribers

On the **Topic Details** page, click **Create Subscription**.

![](./images/sns-3.png)

Define the email address to which you would like AWS to send status change notifications. Be sure to select **Email** from the **Protocol** drop-down list.

![](./images/email-subscription.png)

Once you have completed creating a new subscription, click **Confirm Subscription**. AWS sends the new subscriber an email similar to the one shown here:

![](./images/confirm-email.png)

After confirming, AWS notifies that the subscription is active.

![](./images/email-confirm.png)

Refresh the page. A confirmed email subscriber entry is shown here:

![](./images/confirmed-email.png)

You are ready to receive native AWS status change notifications. See the sample email notification here:

![](./images/aws-default.png)

## ATSD Integration

Follow the quick [launch procedure](#launch-sandbox-with-automated-slack-and-email-configuration) below to integrate AWS with Slack, email, and ATSD or use the custom [set-up](#launch-atsd-sandbox) to configure a custom launch.

### Launch ATSD Sandbox

Follow this procedure to send AWS CloudWatch events into ATSD to enrich standard SNS notifications with additional resource details and AWS console links.

* Launch an [ATSD sandbox](https://github.com/axibase/dockers/tree/atsd-sandbox):

```sh
docker run -d -p 8443:8443 \
  --name=atsd-sandbox \
  --env ATSD_IMPORT_PATH='https://raw.githubusercontent.com/axibase/atsd-use-cases/master/how-to/aws/cloud-watch-alert/resources/rule_aws-cloudwatch-events.xml' \
  --env WEBHOOK=aws-cw \
  axibase/atsd-sandbox:latest
```

This command starts the sandbox applications, import the integration [rule](https://axibase.com/docs/atsd/rule-engine/), and generate an incoming webhook for AWS SNS subscriptions.

Watch the start log for progress:

```sh
docker logs -f atsd-sandbox
```

Wait for `All applications started`.

### Launch Sandbox with Automated Slack and Email Configuration

To configure an email client in the ATSD sandbox container:

* Create a directory to mount onto the container, for example `/home/user/import`.
* Specify email account settings in a `mail.properties` file in the aforementioned directory:

  ```txt
  server=mail.example.org
  user=myuser@example.org
  password=secret
  ```

  * If your outgoing mail server uses a different port than `587` for SMTP queries, define it as an additional parameter in the `mail.properties` file.

  ```ls
  port=465
  ```

* Specify **Slack Bot** token in a `slack.properties` file in same directory:

  ```txt
  token=xoxb-************-************************
  channels=general,devops
  ```

* Add the `EMAIL_CONFIG` and `SLACK_CONFIG` variables, as well as the `volume` bind setting to the run command:

```sh
docker run -d -p 8443:8443 \
  --name=atsd-sandbox \
  --env ATSD_IMPORT_PATH='https://raw.githubusercontent.com/axibase/atsd-use-cases/master/how-to/aws/cloud-watch-alert/resources/rule_aws-cloudwatch-events.xml' \
  --env START_COLLECTOR=off \
  --env WEBHOOK=aws-cw \
  --env SLACK_CONFIG=slack.properties \
  --env EMAIL_CONFIG=mail.properties \
  --volume /home/user/import:/import \
  axibase/atsd-sandbox:latest
```

### Create SNS Subscription

**NOTE**: If you are using the custom launch procedure, be sure you have added the appropriate information to the generic launch command before configuring the SNS Subscription, see [Custom Launch Preferences](#custom-launch-preferences). If you are using the quick launch procedure, move on.

Copy the incoming `aws-cw` webhook URL from the start log.

```txt
[ATSD] Importing '/tmp/import/rule_aws-cloudwatch-events.xml' configuration
[ATSD] Successfully imported '/tmp/import/rule_aws-cloudwatch-events.xml'
aws-cw webhook created:
https://aws-cw:PASSWORD@atsd_hostname:8443/api/v1/messages/webhook/aws-cw?command.date=Timestamp&json.parse=Message&exclude=Signature;SignatureVersion;SigningCertURL;SignatureVersion;UnsubscribeURL;MessageId;Message.detail.instance-id;Message.time;Message.id;Message.version
```

Navigate to the **Topics** section of the **Simple Notification Service** page once again. On the same **Topic Details** page that establishes the AWS email subscription, click **Create Subscription** to add a second subscription to the topic.

Return to the **Create Subscription** form, and paste the Webhook URL in the **Endpoint** field. Be sure that the **Protocol** drop-down list is showing **HTTPS**.

AWS SNS notifications over HTTPS protocol do not support destination endpoints with self-signed SSL certificates. If your ATSD instance runs on a self-signed certificate, switch to the HTTP protocol or install a [CA-signed SSL certificate](https://axibase.com/docs/atsd/administration/ssl-self-signed.html) into ATSD.

![](./images/sns-4.png)

Confirm that your new subscription is active by checking that the **Subscriber** column contains actual subscriber information and is not showing **Pending Confirmation** as seen here.

![](./images/sns-6.png)

ATSD is ready to notify you via [**Slack Team Messaging**](https://slack.com/) and email.

## Custom Launch Preferences

Customize the generic ATSD launch command with your preferences from these options. After customizing the launch command and executing, return to the [Create SNS Subscription](#create-sns-subscription) section to complete the setup procedure.

### Email Notifications from ATSD

Configure the [Mail Client](https://axibase.com/docs/atsd/administration/mail-client.html) by following the instructions here or by following the alternative launch instructions above.

Open the **Alerts** menu from the toolbar on the left and select **Rules**. By default the imported rule is named `aws-cloudwatch-events`. Open the rule editor by clicking the link in the **Name** column. Select the **Email Notifications** tab from the toolbar along the top of the screen and update the **Recipients** field to include those addresses to whom you would like ATSD to deliver email notifications.

![](./images/my-email.png)

Now, ATSD sends detailed status notifications via email.

![](./images/atsd-event-alert.png)

ATSD email notifications contain context-aware links to the newly-launched AWS resource for quick drilldown. Links redirect to the AWS Console, as seen here.

![](./images/atsd-advanced-alert.png)

### Detailed Slack Notifications from ATSD

Configure your local ATSD instance to send messages to Slack Messenger by following the [Slack Notifications](https://axibase.com/docs/atsd/rule-engine/notifications/slack.html) procedure or adding the following environment variable to the atsd-sandbox container above:

```sh
   --env SLACK_CONFIG="slack.properties"
```

Bind the `slack.properties` file to the sandbox container:

```sh
   --volume /home/user/slack.properties:/slack.properties
```

The bound volume should contain these required parameters in plaintext:

```txt
token=xoxb-************-************************
channels=general
```

Now, ATSD sends status change notifications via email and Slack messenger.

A sample status change Slack message is shown here:

![](./images/-slack-notification.png)

### Detailed Telegram Notifications from ATSD

Configure your local ATSD instance to send messages to Telegram Messenger by following the [Telegram Notifications](https://axibase.com/docs/atsd/rule-engine/notifications/telegram.html) procedure or adding the following environment variable to the atsd-sandbox container above:

```sh
   --env TELEGRAM_CONFIG="telegram.properties"
```

Bind the `telegram.properties` file to the sandbox container:

```sh
   --volume /home/user/telegram.properties:/telegram.properties
```

The bound volume should at least contain the required parameters in plaintext:

```txt
bot_id=*********:***********************************
chat_id=-NNNNNNNNN
```

Now, ATSD sends status change notifications via email and Telegram.

A sample Telegram message is shown below. Telegram notifications contain links to newly-launched resources, as seen here:

![](./images/telegram-alerts.png)
