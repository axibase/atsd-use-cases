# Configure Launch Notifications for AWS Resources

## Overview

This guide shows how to configure automatic email notifications upon resource launch from an Amazon Web Services account. This feature enables real-time notifications that alert you to resource status change and prevent unauthorized use of your AWS account which, if left unchecked, can result in expensive fees from Amazon and potentionally harmful operations.

![](images/new-flow.png)

You may follow these instructions to set up native AWS email notifications or follow the advanced procedure to integrate ATSD and AWS for enhanced notifications delivered via email, or through your preferred messegner service such as Telegram or Slack.

### Configure a New CloudWatch Event

From the AWS console homepage, open the **Services** menu and in the **Management Tools** section, select **CloudWatch**.

![](images/cw-menu.png)

On the left toolbar, click **Rules**. On the **Rules** page, click **Create New Rule**.

![](images/cw1.png)

On the following page, configure the rule to respond to an **Event Pattern** and in the **Build Event Pattern to Match...** drop-down menu, select **All Events**.

![](images/cw-2.png)

### Configure SNS Topic

In a new tab or window, open the **Services** menu and under the **Application Integration** section, select **Simple Notification Services**.

![](images/app-integration-sns.png)

From the **SNS Dashboard**, navigate to the **Topics** page from the menu on the left. Click **Create New Topic**. Complete the information on the **Create Topic** form and store it in the system.

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

## ATSD Interface Configuration

### Infrastructure Prerequisites

* Launch a local ATSD instance with the needed rule already imported with the following command:

```
docker run -d -p 8443:8443 \
  --name=atsd-sandbox \
  --env ATSD_IMPORT_PATH='https://raw.githubusercontent.com/axibase/atsd-use-cases/cloud-watch-alert/how-to/aws/cloud-watch-alert/resources/rule_aws-cloudwatch-events.xml' \
  axibase/atsd-sandbox:latest
```

### Create Webhook User

On the same **Topic Details** page that you used to create the AWS email subscription, click **Create Subscription**.

Confirm that your new subscription is active by checking that the **Subscriber** column contains actual subcriber information and is not showing **Pending Confirmation** as seen here.

![](images/sns-6.png)

Set the flag in the checkbox next to your new subscriber and click **Publish to Topic**. Title the publication and paste the following in the **Message** body.

```
{
  "detail-type": "Test Notification",
  "source": "aws.ec2",
  "region": "us-east-1",
  "resources": ["test-1"],
  "detail": {
    "instance-id": "test-1",
    "state": "starting"
  }
}
```

![](images/cw-6.png)

Click **Publish Message**.

![](images/sns-3.png)

In a new window, use the [**Webhook User Wizard**](https://github.com/axibase/atsd/blob/master/api/data/messages/webhook.md#webhook-user-wizard) to create a Webhook User with your AWS account.

A Webhook User template is shown here:

```
https://aws-cw:aws-cw@atsd.hostname:443/api/v1/messages/webhook/aws-cw?type=webhook&entity=aws-cw&command.date=Timestamp&json.parse=Message&exclude=Signature;SignatureVersion;SigningCertURL;SignatureVersion;UnsubscribeURL;MessageId;Message.detail.instance-id;Message.time;Message.id;Message.version
```

Return to the **Create Subscription** form, and paste Webhook User information in the **Endpoint** field. If you used the above Webhook User template be sure to replace the `aws-cw` and `atsd.hostname` placeholders with legitimate information.

![](images/sns-4.png)

ATSD is ready to be configured to notify you via [**Slack Team Messeging**](https://slack.com/), [**Telegram Messenger**](https://telegram.org/), or email upon resource launch. For more information about manually importing a configured rule to ATSD see this brief [guide](/../../blob/master/how-to/shared/import-rule.md). The raw Rule XML file may be downloaded [here](https://raw.githubusercontent.com/axibase/atsd-use-cases/cloud-watch-alert/how-to/aws/cloud-watch-alert/resources/rule_aws-cloudwatch-events.xml).

### Detailed Email Notifications from ATSD

Configure the [mail client](https://github.com/axibase/atsd/blob/master/administration/setting-up-email-client.md) by following the instructions here. Now, detailed status change notifications will be sent via email. It is possible to remove CloudWatch notifications in order to eliminate duplicate emails from being received.

![](images/atsd-event-alert.png)

ATSD email notifications contain literal links to the newly launched AWS resource for quick response time in the event of unauthorized. Links redirect to the AWS console, as seen here.

![](images/atsd-advanced-alert.png)

### Detailed Telegram Notifications from ATSD 

Configure your local ATSD instance to send messages to **Telegram Messenger** by following [this procedure](https://github.com/axibase/atsd/blob/master/rule-engine/notifications/telegram.md). Now, your status change notifications will be sent via Telegram messages as well as email.

A sample Telegram message is shown here. Telegram notifications will contain links to newly launched resources, as seen here.

![](images/telegram-alerts.png)

### Detailed Slack Notifications from ATSD

Configure your local ATSD instance to send messages to **Slack Messenger** by following [this procedure](https://github.com/axibase/atsd/blob/master/rule-engine/notifications/slack.md). Now, your status change notifications will be sent via Slack messages as well as email.

A sample status change Slack message is shown here. 

![](images/slack-notification.png)
