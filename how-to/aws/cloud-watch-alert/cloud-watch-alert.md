# Configure Launch Notifications for AWS Resources

## Overview

This guide shows how to configure automatic notifications from ATSD upon resource launch from an Amazon Web Services account. This feature enables real-time notifications that alert you to instance launch and prevent unauthorized use of your AWS console which, if left unchecked, can result in expensive fees from Amazon and potentionally harmful operations carried out from your console.

![](images/new-flow.png)

You may follow these instructions to set up native AWS email notifications or follow the advanced procedure to integrate ATSD and AWS for enhanced notifications delivered via email, or through your preferred messegner service such as Telegram or Slack.

### Infrastructure Prerequisites

Integrate your local ATSD instance to communicate with AWS by following the **Configuration** set-up described in this [guide](/../../tree/master/how-to/aws/route53-health-checks/README.md#configuration).

### Configure CloudWatch Event

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

### Define Subscribers / Input Webhook

On the **Topic Details** page, click **Create Subscription**.

![](images/sns-3.png)

In a new window, use the [**Webhook User Wizard**](https://github.com/axibase/atsd/blob/master/api/data/messages/webhook.md#webhook-user-wizard) to create a Webhook User with your AWS account.

A Webhook User template is shown here:

```
https://aws-cw:aws-cw@atsd.hostname:443/api/v1/messages/webhook/aws-cw?type=webhook&entity=aws-cw&command.date=Timestamp&json.parse=Message&exclude=Signature;SignatureVersion;SigningCertURL;SignatureVersion;UnsubscribeURL;MessageId;Message.detail.instance-id;Message.time;Message.id;Message.version
```

Return to the **Create Subscription** form, and paste Webhook User information in the **Endpoint** field. If you used the above Webhook User template be sure to replace the `aws-cw` and `atsd.hostname` placeholders with legitimate information.

![](images/sns-4.png)

Once you have completed creating a new subscription, click **Confirm Subscription**. After confirming, refresh the page with the **Refresh** button on the bottom right portion of the screen. 

![](images/sns-5.png)

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

### Finalize CloudWatch Event

Return to the **Create Rule** page. On the right of the screen in the **Targets** section, click **Add Target**. Select the **SNS Topic** event target and select your newly created SNS topic.

![](images/cw-3.png)

You should see an account number in the **Event Pattern Preview** text box.

![](images/cw-4.png)

Click **Configure Details** at the bottom of the screen to move on. On the following page, name the rule and click **Create Rule**.

![](images/cw-5.png)

On the **Rules** page, be sure that your new rule has **Running** status, indicated by a green circle in the **Status** column.

![](images/cw-7.png)

![](images/cw-8.png)

### ATSD Interface Configuration

Begin by integrating your local ATSD instance to communicate with AWS by following the **Configuration** set-up described in this [guide](/../../tree/master/how-to/aws/route53-health-checks/README.md#configuration).

In the ATSD interface, navigate to the **Rules** page, and import this [XML file](resources/rule_aws-cloudwatch-events.xml) to configure ATSD to notify you via [**Slack Team Messeging**](https://slack.com/). For more information about importing a configured rule to ATSD see this brief [guide](/../../blob/master/how-to/shared/import-rule.md).

After the rule has been created and is enabled, it is active. Follow [this procedure](https://github.com/axibase/atsd/blob/master/rule-engine/notifications/slack.md) to configure ATSD to use your new rule to send messaeges directly to a Slack channel.

A sample status change Slack message is shown here. 

![](images/slack-notification.png)
