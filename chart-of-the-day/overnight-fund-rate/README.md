# The Creeping Overnight Fund Rate

![](./images/on-fund.png)
[![](./images/button.png)](https://apps.axibase.com/chartlab/e83adce8#fullscreen)

* **Overnight Fund Data**: This charts uses a [`dual axis`](https://axibase.com/products/axibase-time-series-database/visualization/widgets/time-chart/#tab-id-2 ) setting to compare two series measured in different units, the Overnight Fund Rate and the Overnight Fund Volume. As expected, while interest rates were under 0.4%, overnight funding activity was the highest and as the Fed has steadily raised rates, overnight fund volume has steadily decreased.

* **Industrial Production Index**: The Industrial Production Index is a measure of real output from United States manufacturing, mining, and electric, and gas utilities. Because this time series data tracks a longer span of time that the target period, `starttime` and `endtime` [settings](https://axibase.com/products/axibase-time-series-database/visualization/widgets/time-chart/) are used to display only the target period.

* **Dow Jones Industrial Average**: One of the best indicators of economic strength is stock market performance. Using a `statistic` expression and [`weighted average (wtavg)`](../../how-to/database/moving-avg) setting, volatile trade volume values may be smoothed to show a rolling average for a desired time period. Here, the data is grouped by month and shown alongside the closing value of the stock market, which remains unmodified.

The overnight market is the shortest term loan market available, whereby banks borrow money overnight which must be repaid the following morning plus interest. Because of the extreme short term nature of these types of loans, they also have some of the lowest interest rates - typically reflective of the target interest rate mandated by the United States Federal Reserve.

This week, the Fed [announced](http://www.bbc.com/news/business-43489661) it was going to increase its target interest rate by 0.25% from 1.5% to 1.75% citing a stronger economic outlook in the future as a justification for the move. Fed Chairman Jay Powell also cited plans to increase the effective rate two more times during 2018.

An increased interest rate is among the top fears among stock market bears who feel that an increased rate could prevent the United States from making meaningful progress towards paying the over $21 trillion in outstanding debt that currently exists.