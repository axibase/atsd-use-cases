# Importing Entities

![](images/entity-group.png)

An Entity Group represents a collection of entities, typically grouped by a common feature or an attribute. The groups typically consist of entities of similar type, such as 'Docker Containers', or entities collecting the same metrics, such as 'collectd' agents.

Follow this process to upload a new entity to your local ATSD instance.

1. Click the **Entities** link in the toolbar on the left. 

![](images/entities.png)

2. From the **Entities** page, expand the split button at the bottom of the page and click **Import**.

![](images/entity-import.png)

3. Select the appropriate XML file from your local machine. Click **Import**.

![](images/entity-import1.png)

Your Entity Group has been uploaded to ATSD. Return to the **Entities** page where the newly imported Entity Group will be visible.

### Uploading Multiple Configuration Files

Note that multiple files may be uploaded together or as an archive by opening the **Settings** menu, expanding the **Diagnostics** section, selecting the **Backup Import** page, and completing the form to which you will be directed.

![](images/backup-import.png)
