# The Time Series Database is about Reducing Complexity

Axibase set out to build a time series database with two primary design objectives:

1. Simplify the data collection process.
2. Simplify dashboarding, reporting, and analytics.

The Axibase Time Series Database is able to deliver on both counts, and here is an example:

Take a data source that is passive and non-standard. A data source that is passive cannot be instrumented to stream data into ATSD on its own. A data source that is non-standard provides data in neither CSV nor JSON format.

An HMTL file hosted by a SharePoint reporting server returning HTML text in XLS format works well for this example, [`energinet.dk`](https://energinet.dk) market data reporting service fits the bill well.

Energinet is an all-in-one energy regulator and operator in Denmark. Energinet performs research and development into sustainable energy, collects industry data, and participates in policy action. Download publicly available datasets from the Danish energy industry from the official [Energinet](https://energinet.dk/EN/El/Engrosmarked/Udtraek-af-markedsdata/Sider/default.aspx) website.

The recurring effort involved in analyzing this data and preparing a report is substantial.

Enter the Axibase Time Series Database.

With ATSD you do not have to stage a database, design table schema, provision an application server, and write programs to parse and upload this type of file. Instead, simply configure a scheduled job to fetch the file from a specified endpoint and have ATSD parse it according to pre-defined rules. Once you have raw data in ATSD, creating and sharing reports with built-in widgets is trivial. The reports are continuously updated as new data comes in.

[Sample Raw Data](https://apps.axibase.com/chartlab/fcce7fb8)

![](./images/energinet_detailed.png)

The built-in visualization also allows you to combine wildcards, aggregators, and simple control functions to build a fairly complex report in less than 50 lines:

* [`for/endfor` loop](https://axibase.com/products/axibase-time-series-database/visualization/widgets/control-structures): create a set of similar widgets for different metrics
* [inheritance](https://axibase.com/products/axibase-time-series-database/visualization/widgets/inheritance): apply similar settings to all widgets
* [group-statistics](https://axibase.com/products/axibase-time-series-database/visualization/widgets/configuring-the-widgets/): merge multiple series
* [group-period](https://axibase.com/products/axibase-time-series-database/visualization/widgets/configuring-the-widgets/): aggregate data by month
* [`endtime`](https://axibase.com/products/axibase-time-series-database/visualization/end-time/): syntax to align start/end times to calendar units
* [offset](https://axibase.com/products/axibase-time-series-database/visualization/widgets/time-chart/): setting to overlay data from previous comparable intervals onto one chart
* [layout settings](https://github.com/axibase/atsd/blob/master/portals/portal-settings.md#layout): arrange, style, and format graphs

Imagine the time and effort required using traditional reporting tools.

[Consolidated Report](https://apps.axibase.com/chartlab/8c11fc48/2/)

![](./images/energinet_report.png)