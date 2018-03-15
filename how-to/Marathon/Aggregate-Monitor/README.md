# How to Monitor Aggregate CPU and Memory Usage in Marathon Application

![](Images/Axibase%20Logo.png)

### Overview

[Marathon](https://mesosphere.github.io/marathon/) is a production-grade container orchestration platform for 
Mesosphere’s Datacenter Operating System (DC/OS) and Apache Mesos. Using [Axibase Time Series Database](http://axibase.com/products/axibase-time-series-database/) and the supported messaging service of your choice, reliable system monitoring can be expanded to support real time alerts and notifications sent directly to your mobile device, email, or desktop.

* ATSD is configured to work with utilities such as Marathon and Docker, and supports additional capabilities to integrate and deploy custom bots in a variety of messaging platforms and internet connected devices.

* You may launch [ATSD](https://github.com/axibase/atsd-use-cases/tree/master/Solutions/docker#launch-atsd) and an [Axibase Collector](https://github.com/axibase/atsd-use-cases/tree/master/Solutions/docker#launch-axibase-collectors) using a single command.

**Preparing your instance of ATSD, starting the Axibase Collector, and uploading the needed files should take less than 10 minutes.**

### Prerequisites

* Marathon v1.5.6

![](Images/Marathon%20Home.png)

### Launch ATSD and Axibase Collector 

From the Linux terminal execute the following [sandbox command](https://github.com/axibase/dockers/tree/atsd-sandbox):

```
$ docker run -d -p 8443:8443 -p 9443:9443 -p 8081:8081 \
--name=MYSANDBOX \
--volume /var/run/docker.sock:/var/run/docker.sock \
MYDOCKERUSERNAME/atsd-sandbox:latest
```
Replace the template information above with the credentials you'd like to use. Here, we'll use `atsd-sandbox` as our sandbox
name and `axibase` as our Docker username.

> To launch the applications individually or for troubleshooting, see the [ATSD](https://github.com/axibase/atsd-use-cases/tree/master/Solutions/docker#launch-atsd) and [Axibase Collectors](https://github.com/axibase/atsd-use-cases/tree/master/Solutions/docker#launch-axibase-collectors) documentation.

### Import Marathon Jobs to Axibase Collector

Once you have confirmed the launch of ATSD and the creation of a new Axibase Collector follow the link to the Collector URL. 
```
https://docker_host:9443
```
Create and confirm your password on the login page to access the Collector UI. Import the [attached XML file](Resources/marathon_jobs.xml) to connect Marathon and Axibase Collector. In the **Jobs** tab, click **Import** and select the appropriate file from the local machine.

![](Images/Job%20Import.png)

### Configure Marathon Properties to Ensure Connectivity

In the **Jobs** drop-down menu, select **JSON** jobs.

> If the **marathon_apps** job is not visible, be sure that the **Status** drop-down menu is showing all jobs, not only those which have been enabled.

Click the job link to open the **JSON Job** page, then open the **JSON Configuration** page by clicking the **apps** link from the **JSON Job** page. On the **JSON Configuration** page, open **HTTP Pool** settings. 

![](Images/HTTP%20Pool.png)

Replace the template information with your server address, login information and password.

![](Images/HTTP%20Pool%20Config.png)

Confirm connectivity by clicking the **Test** button. Click **Save**. 

From the **JSON Job** page, enable the **marathon_apps** job. Click **Save**.

![](Images/Enable%20Job.png)

### Import XML Archive to ATSD

ATSD uses a different port than Axibase Collector. Change the Collector URL to the port defined in the original sandbox
command. The ATSD Port should appear similar to the one here:
```
https://atsd_host:8443
```
Log in to ATSD using the username which you defined in the **Launch ATSD and Axibase Collector** portion of the process.

> By default, the password will be the same as the username you entered upon application launch but it may be changed by clicking the **My Account** logo in the upper right corner of the UI. 

From the ATSD homepage, follow the path **Settings > Diagnostics > Back-up Import**

Click **Choose Files** and upload it the [attached archive](Resources/atsd-marathon-xml.zip). ATSD is able to unpack and import the archive automatically. Click **Import**.

You've successfully prepared the application to interact with Marathon. In the **Marathon Applications** tab of the ATSD UI, monitor the jobs you've integrated by clicking **View Portal** at the top of the screen.

![](Images/Marathon%20Portal.png)
