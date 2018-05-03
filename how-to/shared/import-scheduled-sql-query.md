# Importing Scheduled SQL Queries

![](images/sched-sql.png)

A scheduled SQL query is executed by the database on schedule. When the query is executed, it can be configured to generate files on the local file system, to send a report via email, or to produce calculated metrics and store them in the database.

Follow this process to add a new schedule SQL query to your local ATSD instance.

1. Expand the **SQL** menu and select **Scheduled Queries**.

    ![](images/sql-schd.png)

2. From the **Scheduled Queries** page, expand the split button at the bottom of the page and click **Import**.

    ![](images/sql-split-import.png)

3. Select the appropriate XML file from your local machine and click **Import**.

    ![](images/import-sql.png)

Your scheduled SQL query has been added to ATSD.

Return to the **Scheduled Queries** page, where the newly configured scheduled SQL query will be visible.

## Uploading Multiple Configuration Files

Note that multiple files may be uploaded together or as an archive by opening the **Settings** menu, expanding the **Diagnostics** section, selecting the **Backup Import** page, and completing the form to which you will be directed.

![](images/backup-import.png)
