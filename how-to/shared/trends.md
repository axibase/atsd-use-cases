# Using TRENDS

![](images/portal.png)

### Overview

[**TRENDS**](https://trends.axibase.com/) is a data visualization sandbox based on the [ChartLab](https://apps.axibase.com/) API which relies on the [Axibase Time Series Database](https://axibase.com) for data storage and processing tasks. The **TRENDS** interface enables users to interact with the data that they are reading about and modify the visualizations to ask and answer questions without skewed visualization or biased information.

### Syntax

**TRENDS** uses a convenient [syntax](https://axibase.com/products/axibase-time-series-database/visualization/widgets/) for data modification that will be briefly discussed in this guide. Feel free to ask questions or suggest datasets or topics by dropping us a line [here](mailto:hello@axibase.com).

### Modifying a Visualization

If it is not already visible, open the **Editor** window in the **TRENDS** interface by clicking the button at the top of the visualization.

![](images/editor-window.png)
[![](images/button-new.png)](https://trends.axibase.com/167694d7#fullscreen)

In the Editor window you will see the configuration for the current visualization. All configurations have several levels of settings:

* **[configuration]**: Overall settings for the entire visualization. Even the most complex portals and visualizations will have one set of **[configuration]** settings. Define broad parameters for the visualization such as widget size, data entity, and additional formating parameters such as visualization offset.

* **[group]**: Each row of widgets is defined as a group. **[group]** level settings are applied to an entire row. Here, entities may be defined as well as metrics, chart titles or additional settings.  

* **[widget]**: Define the [type](https://axibase.com/products/axibase-time-series-database/visualization/widgets/) of visualization and additional shared parameter such as time characteristics.

* **[series]**: Each widget must have at least one series. **[series]** level settings may be used to distinguish several metrics when used together in one visualization. Data transformations, translations, and reflections should be performed at the **[series]** level.

> Some settings may be defined at multiple levels of a visualization. The most subordinate setting is given priority by **TRENDS**. That means, that if you define an entity `x` at the **[configuration]** level for several widgets, and at the **[widget]** level for one chart you define a different entity `y`, entity `x` will be used for all widgets **EXCEPT** for the one where you defined `entity = y`.  This is a useful setting when including an additional set of data from a unique entity.

Using the chart above as an example, 
