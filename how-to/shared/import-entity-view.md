# Importing Entity Views

![](images/entity-views.png)

Entity Views display a custom set of attributes and statistics for the members of the selected Entity Group. The information displayed by an entity view is presented in a tabular format and is updated when the page is refreshed. Entity Views can be added to the top menu. For more information on entity views, see the following [documentation](https://github.com/axibase/atsd/blob/master/configuration/entity_views.md).

Follow this process to upload an Entity View configuration to your local ATSD instance.

1. Expand the **Entity Views** menu from the left toolbar and select **Configure**.

![](images/portal-config-path.png)

2. Expand the split button at the bottom of the page, click **Import**.

![](images/import-evs.png)

3. Select the appropriate XML file from your local machine by clicking **Choose File**. Click **Import**.

![](images/import-page.png)

Your Entity View has been uploaded to ATSD. Expand the **Entity Views** menu from the left toolbar to navigate to this new page.

### Uploading Multiple Configuration Files

Note that multiple files may be uploaded together or as an archive by opening the **Settings** menu, expanding the **Diagnostics** section, selecting the **Backup Import** page, and completing the form to which you will be directed.

![](images/backup-import.png)
