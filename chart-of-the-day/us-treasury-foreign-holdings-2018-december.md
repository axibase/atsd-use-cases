# Foreign U.S. Treasury Holders: Big Moves by France and Norway. December 2018

## Overview

* Norway almost doubled its long-term treasury position in December 2018.
* France sold holdings accumulated over the previous months.
* Ireland trimmed holdings down to 2016 levels in the aftermath of the overseas corporate tax changes.

## Dataset

* [TIC Data](http://ticdata.treasury.gov/Publish/slt3d_globl.txt).

## Keywords

`offset`, `delta`, `merge-columns`, `csv`

## Graphics

* Top-N countries by U.S. debt holdings, November 2018.

[![View in ChartLab](../research/images/new-button.png)](https://apps.axibase.com/chartlab/42a161bc/11/)

![](./images/us-treasury-foreign-2018-december-top.png)

* Reversal by France.

![](./images/us-treasury-foreign-2018-december-france.png)

* Norway goes shopping.

![](./images/us-treasury-foreign-2018-december-norway.png)

* Ireland tax flows.

![](./images/us-treasury-foreign-2018-december-ireland.png)

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
csv offsets = alias,offset,label
      now,0 month,Now
      m1,1 month,1 month ago
      y1,1 year,1 year ago
      y3,3 year,3 years ago 
      y5,5 year,5 years ago
endcsv
```
