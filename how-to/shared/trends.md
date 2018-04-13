# Using TRENDS

![](images/portal.png)

### Overview

[**TRENDS**](https://trends.axibase.com/) is a data visualization sandbox based on the [Axibase Charts](https://axibase.com/products/axibase-time-series-database/visualization/) library and the [Axibase Time Series Database](https://axibase.com/products/axibase-time-series-database/) which provides essential data storage and processing tasks. 

The **TRENDS** service enables users to interact with the data that they are reading about by creating their own visualizations as well as by modifying examples shared by other users.

**TRENDS** doesn't require readers to be proficient in any programming language however a certain familiarity with key concepts and general schema is recommended.

### Syntax

**TRENDS** uses a convenient [syntax](https://axibase.com/products/axibase-time-series-database/visualization/widgets/) for creating graphs that will be briefly discussed in this guide. Feel free to ask questions or suggest datasets or topics by raising an issues on our [GitHub](https://github.com/axibase/atsd-use-cases/issues) page.

In the **Editor** window you will see the configuration for the current portal. All portals have several levels of settings:

* **[configuration]**: Overall settings for the entire portal. Even the most complex visualizations will have one set of **[configuration]** settings. Define base parameters for the portal such as layout, offset, formatting, as well as the default parameters that will be inhereted by all widgets contained in the portal.

* **[group]**: Each row of widgets is defined as a group. **[group]** level settings are applied to an entire row.

* **[widget]**: Widget represents a chart. Define the [type](https://axibase.com/products/axibase-time-series-database/visualization/widgets/) of chart and its parameters such as title, timespan, formatting.

For detailed information about **[widget]** level settings, see the following [guide](https://axibase.com/products/axibase-time-series-database/visualization/widgets/configuring-the-widgets/#series).

* **[series]**: Each widget must have at least one series. A series is a ordered and timestamped array of observations loaded from the database and visualized by the widget. **[series]** settings include the metric name, entity name, optional tags as well as any series-specific transformations.

More information about selecting series can be found [here](https://axibase.com/products/axibase-time-series-database/visualization/widgets/selecting-series/).

> Some settings may be defined at multiple levels. Settings defined at the **[configuration]** level are inhereted by nested levels: **[group]** > **[widget]** > **[series]**. Settings defined at the lower level override settings set at the upper level. For example, if you define an entity `x` at the **[configuration]** level for several widgets, and at the **[series]** level for one chart you define a different entity `y`, entity `x` will be used for all widgets **EXCEPT** for the one where you defined `entity = y`.  This is a useful setting when including an additional set of data from a unique entity.

For a complete [index](https://trends.axibase.com/public/reference.html) of all metrics stored in ATSD and accessible to **TRENDS** users, click the **Reference** button in the upper-right corner as seen here.

![](images/metric-index.png)

### Modifying Portals

Open the **Editor** window in the **TRENDS** interface by clicking the button in the top menu.

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

Each of these settings may be modified and new settings may be added based on Charts syntax. Additionally, complex transformations may be performed according to this [guide](https://github.com/axibase/atsd-use-cases/tree/master/Solutions/calculated-values), which details common transformations. For more information about advanced portal configuration, use this [guide](https://axibase.com/products/axibase-time-series-database/visualization/widgets/portal-settings/).

Likewise, series may be derived from existing data according to this [guide](https://github.com/axibase/atsd-use-cases/tree/master/Support/Add-Calculated-Value), which shows each step from one series to another.

For baselines and thresholds, data may be manually input using the `value = x` setting at the **[series]** level, where `x` is the constant value.

Once you have modified a configuration, click the **Run** button to apply the new settings.

![](images/run-button.png)

If you would like to create a new version of the current portal by adding a version suffix to the current URL, click **Save**.

To save the portal under an entirely new URL click **Clone**. 

![](images/save-clone-button.png)

**TRENDS** is a sandbox for everyone, we encourage users to create their own charts and share it with others.

### Further Reading 

For more detailed information about ATSD, the underlying mechanics, or download instructions see the [ATSD Documentation](https://github.com/axibase/atsd). Reach out to us with questions, comments, or suggestions [here](mailto:hello@axibase.com) via email or [here](https://github.com/axibase/atsd-use-cases/issues) on our GitHub page. For a complete list of metrics stored in **TRENDS**, see the following [index](https://trends.axibase.com/public/reference.html). Good luck and happy data hunting!
