# Aging America: Modeling Birth Trends in the United States

![](./images/aging-america-title.png)
[![](./images/button-new.png)](https://trends.axibase.com/9703ea57#fullscreen)

> The upper graph shows the growing senior population contrasted against the diminishing birth rate while the lower graphs show the growing difference in total population and total work-eligible population aged 15-64.

## Overview

The United States provides retirement security for the elderly and disabled in a number of ways: Medicaid, Medicare, and Social Security are the main components of the social welfare program. Each of these systems is financed primarily with payroll taxes called the Federal Insurance Contribution Act (FICA) tax. The underlying philosophy of this, and almost any, social welfare program is thus: the young should pay for the healthcare of those unable to pay for themselves due to age or disability in the hopes that one day the next generation does the same for them. Sound logic to be sure, but what happens when the previous generation failed to repopulate the nation in the same way their parents did? What happens when this trend is repeated through one, two, three, or four generations? For a long time analysts have been warning about the coming drought in the Social Security Administration coffers, but more and more it is starting to appear that it may be just over the horizon.

## Objectives

Using [**Forecasting**](https://axibase.com/docs/atsd/forecasting/) functionality from ATSD, current population figures and birth data, models may be created to predict trends in the potential American population crisis.

## Data

All data is sourced from the United States Federal Reserve.

* [U.S. Population Aged 65 or Above](https://fred.stlouisfed.org/series/SPPOP65UPTOZSUSA)
* [Crude Birth Rate for the United States](https://fred.stlouisfed.org/series/SPDYNCBRTINUSA)
* [Working Age Population: Aged 15 - 64](https://fred.stlouisfed.org/series/LFWA64TTUSM647S)
* [Population Total: United States](https://fred.stlouisfed.org/series/POPTOTUSA647NWDB)

Data is visualized using **Trends** service from Axibase, a public data repository with subsets of public data from organizations like the United States Federal Reserve, the Central Bank of Israel, the SEC, FCC, and other government agencies.

## Methodology

1. Visualize Datasets using [Trends](https://trends.axibase.com/);
2. Implement Forecasting for a five year period.

## Visualization

### Working Population as a Portion of Total Population

Open the **Trends** visualization and use the drop-down menu to navigate through time to compare working-aged population to the United States total population.

![](./images/working-population.png)
[![](./images/button-new.png)](https://trends.axibase.com/2228bbde#fullscreen)

*Fig 2.*: The portion of the population eligible for work (aged between 15 and 64) is shown in purple, while the remaining ineligible population is shown in red.

### Births per 1000 / Population Over 65

The upper histogram plots the frequency of each value of annual crude births per one thousand persons and the lower histogram tracks the 65+ population in percentile terms. Deceptively, the data seems to show that the average amount of births outperforms the aging population, but when scaled to 100, in fact, the aged population severely outnumbers the amount of crude births which are occurring.

![](./images/population-histogram.png)
[![](./images/button-new.png)](https://trends.axibase.com/df87fe0c#fullscreen)

*Fig 3.*: Open the **Trends** visualization and modify the number of bars in either histogram using a [`bar-count`](https://axibase.com/products/axibase-time-series-database/visualization/widgets/histogram-chart/#tab-id-1) setting for more granularized data visualization.

### Diminishing Working Population

Using a `value` expression, calculated series may be created using existing data. Here, working-aged population data is subtracted from total population data to create a new series and then visualized. This setting is shown here.

```ls
# Sample configuration for calculating and visualizing an ad-hoc derived series.

[group]
  [widget]
    title = Working Population Bar Chart
    type = chart
    mode = column
    starttime = 1980
    endtime = 2017

    [series]
    metric = POPTOTUSA647NWDB
    display = false
    alias = pop

# Each series is given an alias and display setting is false (series is only used for calulation).

    [series]
    metric = LFWA64TTUSM647S_
    display = false
    alias = wpop

    [series]
    value = value('pop') - value('wpop')
    style = stroke-width: 2
    color = green
    label = Difference in Total Population and Working Populaton
    alert-expression = value > 104
    alert-style = color: red

# Calculated series has no metric value as it is only derived. Alert expression is entered based on information provided by box graph
```

Each of the target series is given an `alias` which is then used to create the calculated series. For more information about creating calculated series in **Trends** or **ChartLab**, see the [Calculated Series Tutorial](../../tutorials//calculated-values/README.md).

![](./images/working-population-charts.png)
[![](./images/button-new.png)](https://trends.axibase.com/68f93899#fullscreen)

*Fig 4.*: The [box chart](https://axibase.com/products/axibase-time-series-database/visualization/widgets/box-chart-widget/) and [histogram](https://axibase.com/products/axibase-time-series-database/visualization/widgets/histogram-chart/) establish the median and range values of the dataset, which are then used in the [`alert-expression`](https://axibase.com/products/axibase-time-series-database/visualization/widgets/time-chart/#tab-id-14), which activates when a condition is satisfied. Here, the condition is set to color a bar red if it is greater than the calculated median value. This expression shows that since late 1998, the number of people deemed ineligible to work has surpassed the calculated median value and continued to grow.

### Forecasting

The ATSD Forecast tool may be used to model future trends based on existing data. See the [Resources](#resources) section of this article to download the complete configuration used in this forecast or reference the abbreviated table below for a basic understanding of the mechanics at work.

|Basic Forecast Configuration Information| |
|--|--|
|Algorithm | Holt-Winters |
|Alpha Value| 0.5|
|Beta Value|0.4|
|Gamma Value|0.5|
|Score Interval|5 Years|

Forecasting for each of the original metrics is shown below for roughly 20 years into the future.

![](./images/forecast_data.png)
[![](./images/button-new.png)](https://trends.axibase.com/a2967bc9#fullscreen)

*Fig 5.*: The original data is shown here with forecasts performed in ATSD showing the potentially widening gap between those eligible to pay in to the Social Security system and those needing to be paid out from that system.

The Forecasting tool may be scaled to work with per annum data as seen here just as readily as millisecond-frequency data input from a sensor or other device.

### Conclusion

Using forecasting, the continuation of mathematical trends may be readily observed and predicted. Forecasts may include periodicity settings for data which is repetitive over some interval. In this example, only mathematical factors have been considered which any sociologist can tell you is flawed methodology since population reproduction is the result of an array of complicated non-mathematical factors as well. However, strictly mathematical modeling is often used to predict trends under the assumption that social factors remain constant for a given period of time.

### Resources

The following tools may be used to replicate these results in a local instance of ATSD:

* For information about modifying data visualizations in the **Trends** interface, see the [Trends Guide](../../tutorials/shared/trends.md);
* [Forecast Configuration](./resources/forecast-settings.xml);
* For detailed information about configuring the Forecasting tool, see this [guide](../../tutorials/shared/import-forecast.md).