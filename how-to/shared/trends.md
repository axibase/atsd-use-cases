# Using Trends

![](images/portal.png)

## Overview

[**Trends**](https://trends.axibase.com/) is a data visualization sandbox based on the [Axibase Charts](https://axibase.com/products/axibase-time-series-database/visualization/) library and the [Axibase Time Series Database](https://axibase.com/products/axibase-time-series-database/) which provides essential data storage and processing tasks.

The **Trends** service enables users to interact with the data that they are reading about by creating their own visualizations as well as by modifying examples shared by other users.

**Trends** doesn't require readers to be proficient in any programming language however a certain familiarity with key concepts and general schema is recommended.

## Syntax

**Trends** uses a convenient [syntax](https://axibase.com/products/axibase-time-series-database/visualization/widgets/) for creating graphs that will be briefly discussed in this guide. Feel free to ask questions or suggest datasets or topics by raising an issues on our [GitHub](https://github.com/axibase/atsd-use-cases/issues) page.

In the **Editor** window you will see the configuration for the current portal. All portals have several levels of settings:

* **[configuration]**: Overall settings for the entire portal. Even the most complex visualizations will have one set of **[configuration]** settings. Define base parameters for the portal such as layout, offset, formatting, as well as the default parameters that will be inherited by all widgets contained in the portal.

* **[group]**: Each row of widgets is defined as a group. **[group]** level settings are applied to an entire row.

* **[widget]**: Widget represents a chart. Define the [type](https://axibase.com/products/axibase-time-series-database/visualization/widgets/) of chart and its parameters such as title, timespan, formatting.

For detailed information about **[widget]** level settings, see this [guide](https://axibase.com/products/axibase-time-series-database/visualization/widgets/configuring-the-widgets/#series).

* **[series]**: Each widget must have at least one series. A series is a ordered and timestamped array of observations loaded from the database and visualized by the widget. **[series]** settings include the metric name, entity name, optional tags as well as any series-specific transformations.

More information about selecting series can be found [here](https://axibase.com/products/axibase-time-series-database/visualization/widgets/selecting-series/).

> Some settings may be defined at multiple levels. Settings defined at the **[configuration]** level are inherited by nested levels: **[group]** > **[widget]** > **[series]**. Settings defined at the lower level override settings set at the upper level. For example, if you define an entity `x` at the **[configuration]** level for several widgets, and at the **[series]** level for one chart you define a different entity `y`, entity `x` will be used for all widgets **EXCEPT** for the one where you defined `entity = y`.  This is a useful setting when including an additional set of data from a unique entity.

## Metrics Reference Page

For a [listing](https://trends.axibase.com/public/reference.html) of available metrics stored in ATSD and accessible to **Trends** users, click the **Reference** button in the top toolbar as seen here.

![](images/ref-button.png)

On the **Reference** page, you'll see a list of all metrics that are usable in **Trends**.

Search available metrics in the **Search Bar**. The entire metric list is indexed and may be searched there.

![](images/ref-search.png)

Dictionary columns may be filtered by value. Click the **Filter** icon to open the menu of available values.

![](images/ref-filter.png)

Each metric may be previewed using the **Portal** button. Click the icon to open a preview of the data associated with the particular metric.

![](images/ref-portal.png)

## Modifying Portals

Open the **Editor** window in the **Trends** interface by clicking the button in the top menu.

![](images/editor-window.png)
[![](images/button-new.png)](https://trends.axibase.com/e91b896e#fullscreen)

Using the chart above as a configuration example:

```sql
[configuration]
  height-units = 2
  width-units = 1
  offset-right = 20
  entity = fred.stlouisfed.org

  [group]
    [widget]
      title = Crude Birth Rates vs. Over 65 Population
      timespan = all
      markers = false
      type = chart
      starttime = 1980
      endtime = 2016

      [series]
        metric = SPDYNCBRTINUSA
        label = Live Births per 1000 Individuals
        style = stroke-width: 2

      [series]
        metric = SPPOP65UPTOZSUSA
        label = Over 65 Population (Percent of Total)
        replace-value = value/100
        format = %
        axis = right
        style = stroke-width: 2
```

Each of these settings may be modified and new settings may be added based on Charts syntax. Additionally, complex transformations may be performed according to this [guide](../../Solutions/calculated-values), which details common transformations. For more information about advanced portal configuration, use this [guide](https://axibase.com/products/axibase-time-series-database/visualization/widgets/portal-settings/).

Likewise, series may be derived from existing data according to this [guide](../../Support/Add-Calculated-Value), which shows each step from one series to another.

For baselines and thresholds, data may be manually input using the `value = x` setting at the **[series]** level, where `x` is the constant value.

Once you have modified a configuration, click the **Run** button to apply the new settings.

![](images/run-button.png)

If you would like to create a new version of the current portal by adding a version suffix to the current URL, click **Save**.

To save the portal under an entirely new URL click **Clone**.

![](images/save-clone-button.png)

**Trends** is a sandbox for everyone, we encourage users to create their own charts and share it with others.

## Pre-Defined Widgets

Click the **Widgets** button in the upper toolbar to copy pre-defined widget sections that may be used as a template for developing your custom widgets.

![](images/pre-def-func.png)

The two pre-defined widgets are described here:

* **Inflation Index**: Experimental Consumer Price Index (CPIE) is the measure of a particular basket of consumer goods. It is often used to track inflation across a given period of time or compare "today's" dollars to historic dollar values.

* **Annual Inflation**: Percentile inflation for the United States. Inflation is calculated by comparing CPI, money supply, gross domestic product (GDP), and average wages. This widget relies on calculated metrics to created a derived measurement.

## User-Defined Functions

The Charts API supports user-defined functions, enabling users to store and re-use statistical functions which they apply on a regular basis.

![](images/fred-lib-demo.png)
[![](images/button-new.png)](https://trends.axibase.com/3a3b1c01#fullscreen)

The above visualization applies user-defined functions for each of the series. An abbreviated version of the configuration is shown here:

```sql
### On the [configuration] level, the 'import' command is used to load functions from the `fred.js` file
### The library is assigned the name 'fred'.
### Multiple function libraries may be imported into the same portal.

[configuration]
  import fred = fred.js

  offset-right = 50
  height-units = 2
  width-units = 1
  start-time = 1980

  entity = fred.stlouisfed.org
  metric = unrate

[series]
  alias = base
  display = false

[series]
  value = fred.MonthlyChange('base')
```

Using two series, the monthly change is calculated as a new series with a `value` expression which applies `MonthlyChange` function from the `fred` library to the series identified with alias `base`.

### `fred` Library

The `fred.js` library is available to any **Trends** user and contains the following functions:

| Function Name                      | Arguments       | Description |
|------------------------------------|-----------------|-------------|
| [`MonthlyChange`](https://trends.axibase.com/c5e043b5)                      | alias           | Month-on-month change |
| [`ChangeFromYearAgo`](https://trends.axibase.com/34165ff1)                  | alias           | Year-on-year change |
| [`ChangeByOffset`](https://trends.axibase.com/90cfadae)                     | alias, [interval](https://axibase.com/products/axibase-time-series-database/visualization/end-time/) | Customizable interval-on-interval change |
| [`MonthlyPercentChange`](https://trends.axibase.com/7bca24b2)               | alias           | Month-on-month percent change |
| [`PercentChangeFromYearAgo`](https://trends.axibase.com/44627e1d)           | alias           | Year-on-year percent change |
| [`PercentChangeByOffset`](https://trends.axibase.com/b0deb565)              | alias, [interval](https://axibase.com/products/axibase-time-series-database/visualization/end-time/) | Customizable interval-on-interval change |
| [`CompoundedAnnualRateOfChange`](https://trends.axibase.com/f04b65fc)       | alias           | Geometric-progression ratio which compounds change annually
| [`ContinuouslyCompoundedRateOfChange`](https://trends.axibase.com/16ea90bf) | alias           | Geometric-progression ratio which continuously compounds change over an infinitesimally small interval
| [`NaturalLog`](https://trends.axibase.com/897f53e1)                         | alias           | Natural Logarithm (`LOG` base constant `e`)
| [`IndexMax`](https://trends.axibase.com/3db3bfa7)                           | alias           | Maximum series value is used as index value
| [`Index`](https://trends.axibase.com/964a4b97)                              | alias, [time](https://axibase.com/products/axibase-time-series-database/visualization/end-time/)     | User-selected value is used as index value

Open any of the visualizations above to see syntax and visual demonstrations of each function.

## Further Reading

For more detailed information about ATSD, the underlying mechanics, or download instructions see the [ATSD Documentation](https://axibase.com/docs/atsd/).

Reach out to us with questions, comments, or suggestions [here](mailto:hello@axibase.com) via email or [here](https://github.com/axibase/atsd-use-cases/issues) on our GitHub page.

For a complete list of metrics stored in **Trends**, see the [Index](https://trends.axibase.com/public/reference.html). Good luck and happy data hunting!
