# SQL Console: Data Analysis in ATSD

## Overview

Structured query languages are used by all kinds of information professionals across the broad spectrum of data industries. [ATSD](https://axibase.com/docs/atsd/) includes an inline [SQL Console](https://axibase.com/docs/atsd/sql/) which may query samples already stored in the database and export the results to a `CSV`, `JSON`, or `XLSX` file for external use, [reinsert a newly created series](#store) for immediate use within the ATSD environment, run specific queries [on a schedule](#scheduled-queries), as well as [track usage statistics](#query-statistics) and historical queries for reference. This article explains the SQL interface from top to bottom.

## SQL Console

![](images/sql-console.png)

The SQL Console has three components:

1. [Data Toolbar](#data-toolbar)
2. [Action Toolbar](#action-toolbar)
3. SQL Menu

> Access SQL Console from anywhere in the ATSD interface by opening the **SQL** menu and clicking **Console**.

### Data Toolbar

The **Data Toolbar** has five drop-down menus which may modify return set data formatting or alter the appearance of the text entered into the **Query Window**.

#### Date Format

**Date Format** drop-down menu may be used to modify result set data to one of the supported [date formats](https://axibase.com/docs/atsd/api/data/date-format.html) without the use of inline [`date_format`](https://axibase.com/docs/atsd/sql/examples/datetime-format.html) function.

![](images/date-format.gif)

#### Time Zone

Select UTC or server local time for `datetime` output.

#### Decimal Precision

Modify included significant figures in the result set. Values represent decimal places beyond `0` which will be included. Value `-1` includes complete set of logged decimal values.

![](images/decimal_precision.gif)

#### Theme

SQL Console supports color customization for query text based on user preferences. [Reserved words](https://axibase.com/docs/atsd/sql/#reserved-words), [literals](https://axibase.com/docs/atsd/sql/#literals), and [syntactical expressions](https://axibase.com/docs/atsd/sql/#syntax) will be affected.

![](images/theme.gif)

#### Null Format

Customize the way SQL Console returns [`NULL`](https://axibase.com/docs/atsd/sql/#null) values. Setting will affect both displayed and exported result sets.

Selectable options are:

* `null`
* `NULL`
* `N/A`
* `-`
* Empty space

### Action Toolbar

The action toolbar is a row of buttons that initiate various event in SQL Console.

#### Execute

Perform the query shown in the **Query Window**, results will be returned in a `CSV` table below the toolbar.

#### Cancel

Interrupt long-running queries.

#### Export

Download the results of the current query in `CSV`, `JSON (objects)`, `JSON (row)`, or `XLSX` formats. Clicking **Export** will open the **Export Window** tool where the query may be modified (for example applying [aliases](https://axibase.com/docs/atsd/sql/#aliases) for more human-readable results), the download format may be selected, and the option to include [metadata](https://axibase.com/docs/atsd/sql/scheduled-sql-metadata.html#sql-report-metadata) information is given.

![](images/export-results.png)

#### Store

Query results may be immediately re-inserted into [ATSD](https://axibase.com/docs/atsd/) and stored as a new derived series. After the desired query is performed, click **Store** to open the **Store Query Results as Series** tool.

![](images/store.png)

Result set will be shown as it will be inserted into the database. [**Check Last Time**](https://axibase.com/docs/atsd/sql/scheduled-sql-store.html#duplicates) switch will verify that newly-inserted results' timestamps exceed existing samples, as a means of controlling how duplicate results are handled.

[**Test**](https://axibase.com/docs/atsd/sql/scheduled-sql-store.html#validation) button validates results before inserting them into ATSD.

The query may be [run on a schedule](https://axibase.com/docs/atsd/sql/scheduled-sql.html), clicking **Schedule** will open a new [**Scheduled Queries**](#scheduled-queries) page for the current query.

#### Query Plan

Opens the **SQL Query Statistics** page for the specific SQL query shown in the **Query Window**. General query information is shown, such as **Elapsed Time** (to perform query), **Returned Records**, and **User** who performed the query, as well as more detailed information like **Results Bytes**, **RPC Calls** (between remote servers), and **Millis Between Next** (time between two samples in milliseconds).

![](images/query-plan.png)

The bottom row of buttons may be used to return to the SQL Console or navigate to the general **Query Statistics** page.

### Query Statistics

**Query Statistics** page tracks all queries performed since database start (up to 1000). The records are cleared each time the database is stopped, including restarts. This page is useful for analyzing scheduled queries on the fly, or returning to an earlier query. It may accessed directly from the **SQL** menu, from the [**Action Toolbar**](#action-toolbar) of the **SQL Console** page, or from the [**SQL Query Statistics**](#query-plan) page.

![](images/query-statistics.png)

Historical query statistics may be filtered by many fields, such as the user who completed the query, its status, or by the query text itself.

### Scheduled Queries

Useful queries may be automated and performed [on a schedule](https://axibase.com/docs/atsd/sql/scheduled-sql.html) by ATSD. The **Scheduled Queries** page may be accessed from the **SQL** menu or the [**Store Query Results**](#store) page. For more information about **SQL Scheduler** see the complete [Documentation](https://axibase.com/docs/atsd/sql/scheduled-sql.html).