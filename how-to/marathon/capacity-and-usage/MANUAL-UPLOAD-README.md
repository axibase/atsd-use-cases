# Marathon Integration: Manual File Import

To perform this process using a single command, see the following [abbreviated walkthrough](/how-to/marathon/capacity-and-usage/README.md).

### Launch Axibase Sandbox

Use the following command to launch ATSD and Axibase Collector instances. The default username and password will be `axibase`.
```
$ docker run -d -p 8443:8443 -p 9443:9443 -p 8081:8081 \
  --name=atsd-sandbox \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  axibase/atsd-sandbox:latest
```

### Import Marathon Job into Axibase Collector

Log in to Axibase Collector instance at `https://atsd_hostname:9443` using `axibase` username and `axibase` password.

Import the attached [job configuration](resources/marathon-jobs.xml) XML file.

The **marathon_apps** JSON job will query the Marathon `/v2/apps` API endpoint for Application definitions and health status, then offload this data into ATSD.

![](images/import_job.png)

### Configure Marathon API Connection

In the **Jobs** drop-down menu, select **JSON** jobs.

> By default, the **marathon_apps** job is not enabled and therefore not visible. Be sure that the **Status** drop-down menu is displaying all jobs to proceed.

Open the **JSON Job** page, then open the **JSON Configuration** page by clicking the **apps** link. On the **JSON Configuration** page, open **HTTP Pool** settings.

![](images/http_pool.png)

Specify 'Server', 'Username' and 'Password' for a Marathon user with API query permissions.

![](images/http_pool_config_.png)

Confirm connectivity by clicking the **Test** button. Click **Save**. 

From the **JSON Job** page, enable the **marathon_apps** job. Click **Save**.

![](images/enable_job.png)

### Import Marathon Models into ATSD

Open ATSD user interface at `https://atsd_hostname:8443`.

Open **Settings > Diagnostics > Backup Import** and upload the [atsd-marathon-xml.zip](resources/atsd-marathon-xml.zip) archive that contains entity views, portals, queries and rules designed specifically for Marathon.
