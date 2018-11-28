# Combining Periodic and Sliding Windows

## Fixed Period Aggregation

The range of techniques to analyze trends and minimize noise in time series is extensive. One of the most common approaches is to regularize time series by applying a grouping function to observations made within each fixed-duration period. This transformation is called aggregation and it can be applied to raw series to calculate hourly averages from irregular samples. Each period in such an example starts at exactly `0` minutes `0` seconds each hour and has a duration of 60 minutes. The period includes all values that occurred between `HH:00:00.000` and `HH:59:59.999`.

The most commonly used aggregation functions:

* Sum
* Minimum
* Maximum
* Median
* Average / Mean
* Percentile (0 to 100%)
* Standard Deviation
* Variance

In relational databases aggregation for specific periods such as one minute, one hour, one day, one month, and one year can be computed via the `GROUP BY` function by formatting a timestamp with a truncated datetime pattern. Any other period is more difficult to implement and the query often involves database-specific syntax and nested queries.

```sql
SELECT server, AVG(cpu_busy), TO_CHAR(sample_time, 'YYYY-MM-DD HH24')
FROM metrics_os_intraday GROUP BY server, TO_CHAR(sample_time, 'YYYY-MM-DD HH24')
```

On the other hand, non-relational time series databases are built with support for custom aggregation periods and allow users to easily specify any period. In ATSD, period is specified by `interval = count time_unit` format, for example: `interval = 15 minute`. The aggregation period can be also customized interactively using aggregation controls in a time series chart.

Aggregators supported in [ATSD](https://axibase.com/docs/atsd/api/data/aggregation.html) are enumerated below:

* [`count`](https://axibase.com/docs/charts/configuration/aggregators.html#count)
* [`min`](https://axibase.com/docs/charts/configuration/aggregators.html#min)
* [`max`](https://axibase.com/docs/charts/configuration/aggregators.html#max)
* [`sum`](https://axibase.com/docs/charts/configuration/aggregators.html#sum)
* [`avg`](https://axibase.com/docs/charts/configuration/aggregators.html#avg)
* [`percentile`](https://axibase.com/docs/charts/configuration/aggregators.html#percentile)
* [`median`](https://axibase.com/docs/charts/configuration/aggregators.html#median)
* [`standard-deviation`](https://axibase.com/docs/charts/configuration/aggregators.html#standard-deviation)
* [`first`](https://axibase.com/docs/charts/configuration/aggregators.html#first)
* [`last`](https://axibase.com/docs/charts/configuration/aggregators.html#last)
* [`delta`](https://axibase.com/docs/charts/configuration/aggregators.html#delta)
* [`counter`](https://axibase.com/docs/charts/configuration/aggregators.html#counter)
* [`wtavg`](https://axibase.com/docs/charts/configuration/aggregators.html#wtavg)
* [`wavg`](https://axibase.com/docs/charts/configuration/aggregators.html#wavg)
* [`min-value-time`](https://axibase.com/docs/charts/configuration/aggregators.html#min-value-time)
* [`max-value-time`](https://axibase.com/docs/charts/configuration/aggregators.html#max-value-time)
* [`threshold_count`](https://axibase.com/docs/charts/configuration/aggregators.html#threshold-count)
* [`threshold_duration`](https://axibase.com/docs/charts/configuration/aggregators.html#threshold-duration)
* [`threshold_percent`](https://axibase.com/docs/charts/configuration/aggregators.html#threshold-percent)

## Sliding Window Aggregation

Sliding window aggregation is closely related to moving average, another widely used method to reduce the variance of individual observations and display any trends lurking behind raw data. Such an average is computed for the last `n` samples, or for samples taken during the last `n` minutes.
In both cases, the calculation relies on the concept of a [count-based](https://axibase.com/docs/atsd/rule-engine/window.html#count-based-windows) or [time-based](https://axibase.com/docs/atsd/rule-engine/window.html#time-based-windows) sliding window whose boundaries are continuously adjusted during progress along a timeline.

Window Type | Example | Description
:--:|:--:|:--:|:--:
`count` | `average(100)` | Average value of the last 100 samples.
`time` | `average(’15 minute’)` | Average value of all samples collected during the last 15 minutes.

There are different types of moving averages with better smoothing control for linear, geometric, or exponentially decreasing weights (refer to the [Moving Average](https://en.wikipedia.org/wiki/Moving_average) article on Wikipedia). As such, it is possible to utilize any grouping function such as `percentile(95)` instead of average.

Moving averages are often displayed alongside raw values and the chart can include multiple moving averages for different time intervals. This is especially common in the technical analysis used for finance and econometrics.

![](./images/trading-view.png)

*Source*: [Trading View](https://www.tradingview.com/stock-charts/)

The product of sliding window aggregation is not the same as periodic aggregation. Moving average series contain the same timestamps as the underlying raw series which means that such series can be irregular and contain an arbitrarily large number of samples.

## Combined Aggregation

Scenarios when it is beneficial to combine periodic and sliding aggregates in one representation exist.
<!-- markdownlint-disable MD101 -->
Consider the case of CPU utilization where you need to display hourly CPU averages over the last 24 hours and display values for the current hour since incoming data is streaming continuously. If you compute periodic aggregations, the average for the last and most current hour is quite volatile at the beginning of the hour because the grouping function is computed for only the first few samples. As a result, end users receive false alarms for sudden changes in monitored metrics at the start of every hour.

![](./images/chartlab.png)

Consider the above example. Note that the average for the last hour spikes from 5% to 23% and back within a matter of several minutes. This can raise false positive alerts, particularly if the underlying metric is collected at high frequency and exhibits significant variance.

The solution is to implement a [`moving-average`](https://axibase.com/docs/charts/widgets/time-chart/#moving-average) setting, which controls how the aggregate for the most recent period is calculated. If `moving-average` is enabled, the last period is computed as a sliding window. The end of the sliding window is equal to last sample time, and the length of the window equals aggregation period. This allows you to smooth aggregate values displayed at the beginning of the period.

[**ChartLab**](../shared/chartlab.md) is a data visualization service which relies on ATSD for data monitoring and storage tasks and tracking CPU utilization right now.

[![](../../research/images/new-button.png)](https://apps.axibase.com/chartlab/7edd79fe/5/)

![](./images/combing-windows.png)