# Major Foreign Holders Reducing U.S. Treasury Holdings

## Overview

* What does France know about treasuries?
* Italy is stable, however its mix of short versus long maturities has changed.
* China and Japan trade offset each other.
* With 85% of treasuries sold, Russia keeps pushing its holdings even lower.

## Keywords

`offset`, `delta`, `merge-columns`, `csv`

## Graphics

* Top-N countries by U.S. debt holdings, November 2018.

[![View in ChartLab](../research/images/new-button.png)](https://apps.axibase.com/chartlab/42a161bc/8/)

![](./images/us-treasury-foreign-2018-november.png)

* Uptick by France in second half of 2018 continues.

[![View in ChartLab](../research/images/new-button.png)](https://apps.axibase.com/chartlab/6ad4415b)

![](./images/us-treasury-foreign-2018-november-france.png)

* Italy allocates more to short-term maturities.

![](./images/us-treasury-foreign-2018-november-italy.png)

## Syntax Features

* [`merge-columns`](https://axibase.com/docs/charts/widgets/series-table/#merge-columns) setting to merge multiple series into one row.

```ls
# merge base and offset series into a single row, one per country
merge-columns = a.tags.country == b.tags.country
```

* [`time-offset`](https://axibase.com/docs/charts/widgets/shared/#time-offset) setting to load series with a time lag.

```ls
[series]
  # load series with 1 month lag
  time-offset = 1 month  
```

* [`csv`](https://axibase.com/docs/charts/syntax/control-structures.html#csv) setting to create a list of objects with the same properties for iteration.

```ls
csv offsets = name,alias
      1 month,m1
      1 year,y1
      3 year,y3
      5 year,y5
endcsv
```
