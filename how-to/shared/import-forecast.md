# Importing Forecast Settings

![](images/forecast-title.png)

[Forecast Settings](https://github.com/axibase/atsd/tree/master/forecasting) is a set of rules to predict future data by applying a statistical algorithm to histroical records.  The choice of the algorithm and its parameters may be manually specified by an expert user or automatically selected by ATSD based on the built-in scoring system.

Follow this process to upload a forecast configuration to your local ATSD instance.

1. Expand the **Data** menu and select **Forecasts**.

![](images/forecast-1.png)

2. From the **Forecasts** page, expand the split button and click **Import**.

![](images/forecast-2.png)

3. Select the appropriate XML file from you local machine and click **Import**.

![](images/forecast-3.png)

4. Your forecast configuration has been uploaded to ATSD.

Return to the **Forecasts** page where the newly configured forecast settings will be visible.

### Uploading Multiple Configuration Files

Note that multiple files may be uploaded together or as an archive by opening the **Settings** menu, expanding the **Diagnostics** section, selecting the **Backup Import** page, and completing the form to which you will be directed.

![](images/backup-import.png)
