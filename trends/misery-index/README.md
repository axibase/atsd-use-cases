# The Misery Index, Revisited

## Overview

><b><big>*Misery Index*</big></b> = *Unemployment Rate (%)* + *Inflation Rate (%)*

* The Misery Index was created in the seventies by American economist [Arthur Okun](https://www.brookings.edu/opinions/the-brookings-institutions-arthur-okun-father-of-the-misery-index/) to track the combined values of unemployment and inflation.
* The Misery Index was created during the OPEC embargo on western nations, a period which saw both high inflation and high unemployment.<sup>[1](https://online.scu.edu.au/blog/what-is-stagflation-and-how-can-it-happen/)</sup>
* Typically, the Misery Index is considered during times of high inflation and unemployment.
* The index is used as a baseline from which to judge the overall state of an economy.

## Graphics

### United States

[![](../images/button-new.png)](https://trends.axibase.com/8c6b6ac8#fullscreen)

![](./images/mi-2.png)

Use the [drop-down lists](https://axibase.com/docs/charts/configuration/drop-down-lists.html) in the widget header to navigate through time, for example, to observe the index value during the term of a specific president; expand the link below to see the Misery Index for the presidency of Barack Obama.

<details><summary>Misery Index for <b>President Obama</b> (click image to open configuration)</summary>

[![](./images/mi-3.png)](https://trends.axibase.com/9520db11#fullscreen)

</details>

### Canada

[![](../images/button-new.png)](https://trends.axibase.com/71ca5c35#fullscreen)

![](./images/mi-4.png)

Canadian newspaper *The Globe and Mail* predicted a low score for the Misery Index north of the Frontière Internationale in 2015, attributing some of the success to low energy prices curbing inflation.<sup>[2](https://www.theglobeandmail.com/report-on-business/economy/canadas-misery-index/article25112820/)</sup>

Use a [user-defined function](https://axibase.com/docs/charts/syntax/udf.html) to track custom metrics using the underlying Misery Index data:

* Remove `/*` multi-line comment `*/` surrounding derived `[series]`; click **Run**.

  ```ls
  /*
   [series]
     value = fred.PercentChangeFromYearAgo('mi')
     axis = right
     color = black
     style = opacity: 0.5;stroke-width:2
     format = percent
  */
  ```

* If necessary, replace `PercentChangeFromYearAgo()` function with any [included function](https://axibase.com/docs/charts/syntax/udf.html#examples).

### France

[![](../images/button-new.png)](https://trends.axibase.com/0b09f1eb#fullscreen)

![](./images/mi-6.png)

French data is only stored for the period 1996-2018. Using [SQL Console](https://axibase.com/docs/atsd/sql/sql-console.html) to query the data shows a significant gap in the value of unemployment and inflation.

```sql
SELECT datetime, (((inflation.value/LAG(inflation.value))-1)*100) AS "Inflation", unemployment.value AS "Unemployment", (((inflation.value/LAG(inflation.value))-1)*100) + unemployment.value AS "Misery Index"
  FROM LRUN74TTFRA156N AS unemployment
  JOIN FRACPIHICAINMEI AS inflation
WHERE datetime > '1995-01-01'
```

<details><summary>Expand this section to view query results.</summary>

```txt
| datetime   | Inflation | Unemployment | Misery Index |
|------------|-----------|--------------|--------------|
| 1996-01-01 | 1.05      | 10.56        | 11.61         |
| 1997-01-01 | 1.27      | 10.72        | 11.98        |
| 1998-01-01 | 0.69      | 10.29        | 10.97        |
| 1999-01-01 | 0.56      | 9.98         | 10.55        |
| 2000-01-01 | 1.82      | 8.53         | 10.35        |
| 2001-01-01 | 1.78      | 7.74         | 9.52         |
| 2002-01-01 | 1.93      | 7.88         | 9.81         |
| 2003-01-01 | 2.18      | 8.12         | 10.31        |
| 2004-01-01 | 2.33      | 8.47         | 10.80        |
| 2005-01-01 | 1.90      | 8.50         | 10.40        |
| 2006-01-01 | 1.89      | 8.45         | 10.34        |
| 2007-01-01 | 1.61      | 7.65         | 9.26         |
| 2008-01-01 | 3.15      | 7.08         | 10.23        |
| 2009-01-01 | 0.11      | 8.72         | 8.83         |
| 2010-01-01 | 1.74      | 8.85         | 10.59        |
| 2011-01-01 | 2.29      | 8.80         | 11.09        |
| 2012-01-01 | 2.21      | 9.40         | 11.61        |
| 2013-01-01 | 1.00      | 9.93         | 10.92        |
| 2014-01-01 | 0.60      | 10.32        | 10.93        |
| 2015-01-01 | 0.09      | 10.38        | 10.47        |
| 2016-01-01 | 0.31      | 10.05        | 10.36        |
| 2017-01-01 | 1.16      | 9.40         | 10.56        |
```

</details>

To view this discrepancy in the original visualization, hide the `display` settings for series `unemp` and `inf`.

```ls
[series]
  alias = unemp
  # display = false
  # hide the display setting using the single-line comment hash symbol
```

<details><summary>View the modified chart here, which includes unemployment, inflation, and misery index data together.</summary>

[![](./images/mi-7.png)](https://trends.axibase.com/8e1eb8e9#fullscreen)

</details>