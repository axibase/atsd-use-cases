# Importing Entity Views

![](images/entity-views.png)

Entity Views are a set of special queries which retrieve specific information automtically on a recurring basis. Follow this process to upload an Entity View configuration to your local ATSD instance.

1. From any tab in the ATSD interface, expand the **Entity Views** menu from the left toolbar and select **Configure**.

![](images/portal-config-path.png)

2. Expand the split button at the bottom of the page, click **Import**.

![](images/import-evs.png)

3. Select the appropriate XML file from your local machine by clicking **Choose File**. By default ATSD will add a number to the file name if such an entity view already exists. Set the flag in the **Replace Existing Entity Views** box to modify this behavior. Click **Import**.

![](images/import-page.png)

Your Entity View has been uploaded to ATSD. Expand the **Entity Views** menu from the left toolbar to navigate to this new page.
