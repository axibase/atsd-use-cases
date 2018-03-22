# Enhancing Route53 Health Status Alarms with ATSD

## Overview

Route53 may be configured to send email notifications based on customizable [rules](https://github.com/axibase/atsd/tree/master/rule-engine#rule-engine) whereby the system monitors incoming data from endpoint health checks and notifies specified users via email with reports upon endpoint failure or continual timeout. Follow this process to enable email notifications from Route53.

## Initial Configuration

1. In the Amazon Web Services interface, navigate to Route53 by opening the **Services** drop-down menu in the upper toolbar and clicking **Route53** under the **Networking and Content Delivery** section.

![](images/route53-locate.png)

2. Select **Health Checks** from the toolbar on the left and click **Create Health Check**. Note that if you have not yet set up Route53 services with your AWS account, you will need to click through an introductory screen before completing this step.

![](images/route53-menu.png)

3. Configure a new end point health check on the form shown below. Specify the **Domain Name** to monitor the status of a specific website and define the path you would like to monitor. Click **Next**.

![](images/route53-config.png)

4. On the following page, configure an alarm based on the newly created health check.

![](images/route53-alert.png)

5. Once you have configured the new health check and alarm, the email address you indicated will be sent a confirmation email. The health check will not be executed until you confirm the new alert. Once the health check begins to execute, be sure that the monitored site is showing 100% health under the **Monitoring** tab.

![](images/route53-githup-api.png)

6. Under the **Health Checkers** tab, review information in the **Status** column for each of the **Health Checker Regions** and resolve any issues.

![](images/route53-region-error.png)

7. If you haven't already done so, configure the new alarm's notification target by navigating to the **Alarms** tab and clicking the **Edit** button in the **Actions** column. Select the appropriate **Notification Target** from the drop-down menu and existing targets.

![](images/route53-alarm.png)

8. Should the endpoint become unhealthy and the alarm be triggered, the specified email address will recieve an email notification from AWS similar to the one shown below.

![](images/route53-alarm-github.png)

Your health checks and alarms are now fully functioning. Complete the process below to enhance Route53 alarms with your local ATSD instance.

## ATSD Configuration

ATSD may be configured to monitor AWS Route53 health checks and send detailed downtime reports featuring data visualization portal and comprehensive outage information. 

1. Open the **Services** drop-down menu and navigate to the **Simple Notification Service** page in the **Application Integration** section of the menu.

![](images/app-integration-sns.png)

2. Open the **Topics** page from toolbar on the left, and click the Amazon Resource Name (ARN) link of the alert which you would like to integrate with ATSD. 

![](images/route53-slack-subscription.png)

3. In the **Subscriptions** section of the **Topic Details** page, click **Create Subscription** to enable enriched emails with contextual information. Click **Create Subscription** and use the following webhook in the **endpoint** field:

```
https://atsd_hostname/api/v1/messages/webhook/aws-cw?type=webhook&entity=aws-cw&command.date=Timestamp&json.parse=Message&exclude=Signature;SignatureVersion;SigningCertURL;SignatureVersion;UnsubscribeURL;MessageId;Message.detail.instance-id;Message.time;Message.id;Message.version
```

> Replace **atsd_hostname** with a valid hostname in the webhook above. 

![](images/route53-slack.png)

> Replace **atsd_hostname** and **my**

4. In ATSD, import the following [rule](). For instructions on importing a new rule see the following [walkthrough]().

