# Importing Entity Groups

![](images/entity-group1.png)

Entity Groups provide a way to organize similar entities into logical collections that can be operated on as aggregates when managing user permissions, filtering data, calculating statistics, etc.

For more information on entity groups, see the [documentation](https://axibase.com/docs/atsd/configuration/entity_groups.html).

Follow this procedure to import an Entity Group definition to your local ATSD instance.

1. Expand the **Settings** menu from the left toolbar and select **Entity Groups**

    ![](images/entity-group2.png)

2. Expand the split button at the bottom of the page and click **Import**.

    ![](images/entity-group3.png)

3. Select the appropriate XML file from your local machine by clicking **Choose File**. Click **Import**.

    ![](images/import-entity.png)

Your entity group has been uploaded to ATSD. Expand the **Settings** menu in the left tool bar and select **Entity Groups**, where you new entry will be visible.

## Uploading Multiple Configuration Files

Note that multiple files may be uploaded together or as an archive by opening the **Settings** menu, expanding the **Diagnostics** section, selecting the **Backup Import** page, and completing the form to which you will be directed.

![](images/backup-import.png)
