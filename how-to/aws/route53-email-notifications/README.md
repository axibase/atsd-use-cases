# Route53 Health Status Alarms

## Overview

This guide described how to configure email alerts when a url monitored with Route53 health checks becomes inaccessible. It also provides information on how to enhance the alerts with availability portals and outage details using Axibase Time Series Database [rule engine](https://github.com/axibase/atsd/tree/master/rule-engine#rule-engine).

## Initial Configuration

1. In the Amazon Web Services interface, navigate to Route53 by opening the **Services** drop-down menu in the upper toolbar and clicking **Route53** under the **Networking and Content Delivery** section.

![](images/route53-locate.png)

2. Select **Health Checks** from the toolbar on the left and click **Create Health Check**. Note that if you have not yet set up Route53 services with your AWS account, you will need to click through an introductory screen before completing this step.

![](images/route53-menu.png)

3. Configure a new endpoint health check on the form shown below. Specify the **Domain Name** to monitor the status of a specific website and define the path you would like to monitor. Click **Next**.

![](images/route53-config.png)

4. On the following page, configure an alarm based on the newly created health check.

![](images/route53-alert.png)

5. Once you have configured the new health check and alarm, the email address you indicated will be sent a confirmation email. The health check will not be executed until you confirm the new alert. Once the health check begins to execute, be sure that the monitored site is showing 100% health under the **Monitoring** tab.

![](images/route53-githup-api.png)

6. Under the **Health Checkers** tab, review information in the **Status** column for each of the **Health Checker Regions** and resolve any issues.

![](images/route53-region-error.png)

7. If you haven't already done so, configure the new alarm's notification target by navigating to the **Alarms** tab and clicking the **Edit** button in the **Actions** column. Select the appropriate **Notification Target** from the drop-down menu and existing targets.

![](images/route53-alarm.png)

8. Should the endpoint become unhealthy and the alarm be triggered, the specified email address will receive an email notification from AWS similar to the one shown below.

![](images/route53-alarm-github.png)

Your health checks and alarms are now fully functioning. 

Complete the process below to enhance Route53 alarms with your local ATSD instance.

## Enhancing Alerts with Axibase Time Series Database

1. Install [ATSD sandbox](README.md) with AWS integration.

2. Configure ATSD to accept HTTPS requests from AWS infrastructure servers with a [**CA-signed**](https://github.com/axibase/atsd/blob/master/administration/ssl-ca-signed.md) SSL certificate. Alternatively, use the HTTP protocol when configuring the SNS subscription URL below.

3. Open the **Services** drop-down menu and navigate to the **Simple Notification Service** page in the **Application Integration** section of the menu.

![](images/app-integration-sns.png)

4. Open the **Topics** page from toolbar on the left, and click the Amazon Resource Name (ARN) link of the alert which you would like to integrate with ATSD. 

![](images/route53-slack-subscription.png)

5. Create a [webhook](https://github.com/axibase/atsd/blob/master/api/data/messages/webhook.md#messages-webhook) user with `aws-cw` username in your ATSD instance.

6. In the **Subscriptions** section of the **Topic Details** page, click **Create Subscription** to enable enriched emails with contextual information. Click **Create Subscription** and use the following webhook URL in the **endpoint** field:

```
https://aws-cw:1234568@atsd_hostname:8443/api/v1/messages/webhook/aws-cw?type=webhook&entity=aws-cw&command.date=Timestamp&json.parse=Message&exclude=Signature;SignatureVersion;SigningCertURL;SignatureVersion;UnsubscribeURL;MessageId;Message.detail.instance-id;Message.time;Message.id;Message.version
```

  Replace **atsd_hostname** with a valid hostname and update user password in the webhook URL above. 

  Switch to HTTP protocol and modify the port number of your ATSD is not yet configured with a [**CA-signed**](https://github.com/axibase/atsd/blob/master/administration/ssl-ca-signed.md) SSL certificate.

![](images/route53-slack.png)

7. Import the [aws-cloudwatch-alarm](rule-aws-cloudwatch-alarm.xml) rule into ATSD. For instructions on importing a new rule see the following [walkthrough](walkthrough.url).

8. Configure the [mail client](https://github.com/axibase/atsd/blob/master/administration/setting-up-email-client.md).

9. Configure the [web driver](https://github.com/axibase/atsd/blob/master/rule-engine/notifications/web-driver.md) in order to send availability portals as screenshots.

You're ready to start receiving detailed email notifications about endpoint health status alerts.

Follow the optional steps below to further enhance this functionality to send context-rich messages to a [collaboration service](https://github.com/axibase/atsd/blob/master/rule-engine/web-notifications.md#web-notifications) such as Slack or Telegram.

### Alarm Notifications in Slack

* Configure your local ATSD instance to output messages to **Slack Messenger** by following [this procedure](https://github.com/axibase/atsd/blob/master/rule-engine/notifications/slack.md). Now, your alarm notifications will be sent via Slack messages as well as email.

![](images/route53-alert-slack.png)

### Alarm Notifications in Telegram

* Configure your local ATSD instance to output messages to **Telegram Messenger** by following [this procedure](https://github.com/axibase/atsd/blob/master/rule-engine/notifications/telegram.md). Now, your alarm notifications will be sent via Telegram messages as well as email.

![](images/route53-tg-alert.png)

### Advanced Configuration

* To configure advanced settings, expand the **Alerts** menu and select **Rules**. Follow the procedure described [here](https://github.com/axibase/atsd/blob/master/rule-engine/web-notifications.md#attachments) to include detailed reports and portals in your alert emails.

* Enable the **Attach Details** option to include detailed email reports upon alarm notification:

![](images/route53-alarm-email-detail.png)

* Enable the **Attach Portals** option to include complete health check portals upon alarm notification (not only unhealthy endpoints):

![](images/route53-alarm-email-portal.png)
