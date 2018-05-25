# SQL Queries and Data Visualization with Python and ATSD

## Introduction

[Python](https://www.python.org/) is an easy-to-use and versatile programming language that boasts code readability and functionality for tasks of any size. [Axibase Time Series Database](https://axibase.com/products/axibase-time-series-database/) is an enterprise-level data storage and processing environment that features a rule engine, SQL, and visualization functionality. Using these two tools, data analysis tasks may be approached from the ground up to unlock meaningful results within a single interface.

## Dataset

The [Federal Reserve Economic Research Division](https://fred.stlouisfed.org/) of the St. Louis Federal Reserve publishes publicly available data on a range of topics related to macroeconomic trends such as GDP, employment and national statistics.

While native FRED visualization tools have a number of built-in manipulation and export features, meaningful data wrangling requires specialized capabilities. With the ATSD [API Client for Python](https://github.com/axibase/atsd-api-python), data may be queried using SQL and visualized for ad-hoc analysis. This article will focus on the [net lending / borrowing](https://fred.stlouisfed.org/series/AD01RC1Q027SBEA) of the United States Government for the past several decades and explore the way these tools intersect to facilitate data processing.

### Handling Special Items

The `AD01RC1Q027SBEA` series is annualized and each quarterly value is therefore multiplied by a factor of four to arrive at an annual estimate. This calculation is used to show the annual total should a specific quarter's trends be replicated over the course of the year. During the final quarter of 2017, a potential $250 billion windfall from one-time corporate repatriation taxes was added to the total by virtue of annualized calculation. In fact, the $250 billion extra income translated to $1 trillion after transformation. The original [FRED blog post](https://fredblog.stlouisfed.org/?s=surplus) discussing this data includes a visualization which considers this annualized value:

![](images/fred-chart.png)

This article illustrates how the declarative graphics library in ATSD can be utilized to perform ad hoc data transformations such as the removal of this and other special items from any dataset. This same dataset is visualized using **Trends** service and applies a [`replace-value`](https://axibase.com/products/axibase-time-series-database/visualization/widgets/configuring-the-widgets/) setting to remove the special budget revenue item from the annual total. Additionally, a third visualization is shown where the one-time $250 billion addition remains, but the annualized $750 billion is removed.

The original data and new data are shown together. The range of conclusions one can draw from these three series are vastly different.

![](images/ad-hoc.png)

[![](images/button-new.png)](https://trends.axibase.com/04b1ad9f#fullscreen)

The `replace-value` settings used in the visualization:

```javascript
# remove extraordinary item completely.
replace-value = time == new Date('2017-10-01T00:00:00Z').getTime() ? value-1000 : value
```

```javascript
# remove extraordinary annualization calculation, leave expected repatriation tax.
replace-value = time == new Date('2017-10-01T00:00:00Z').getTime() ? value-750 : value
```

These settings targets a defined date, and evaluate an `if-else` expression which subtracts $1 trillion or $750 billion from the defined date's value or else returns the original value.

### Querying FRED Data with SQL

Similar to graphs, the same analysis and data cleanup may be performed by executing SQL queries using the ATSD API Client for Python.

The FRED data is quarterly, this query tracks non-annualized federal budget data for each recorded year:

```sql
SELECT date_format(time, 'yyyy') "Year", SUM(value/4) "Net Lending/Borrowing"
  FROM "ad01rc1q027sbea"
GROUP BY period(1 year)
  ORDER BY datetime DESC
```

For multi-line queries in the Python interface, define a variable `q = """`. Close the query with `"""`. The complete query will be:

```python
>>> q = """
... SELECT date_format(time, 'yyyy') "Year", SUM(value/4) "Net Lending/Borrowing"
... FROM "ad01rc1q027sbea"
... GROUP BY period(1 year)
... ORDER BY datetime DESC
... """
```

The ten most recent years of federal government lending / borrowing:

| Year | Net Lending/Borrowing |
|------|-----------------------|
| 2017 | -685.56               |
| 2016 | -931.36               |
| 2015 | -781.12               |
| 2014 | -851.12               |
| 2013 | -913.30               |
| 2012 | -1447.01              |
| 2011 | -1666.73              |
| 2010 | -1818.96              |
| 2009 | -1847.06              |
| 2008 | -1054.96              |
| 2007 | -535.13               |

<details><summary>View the complete result set here:</summary>
<p>

| Year | Net Lending/Borrowing |
|------|-----------------------|
| 2017 | -685.56               |
| 2016 | -931.36               |
| 2015 | -781.12               |
| 2014 | -851.12               |
| 2013 | -913.30               |
| 2012 | -1447.01              |
| 2011 | -1666.73              |
| 2010 | -1818.96              |
| 2009 | -1847.06              |
| 2008 | -1054.96              |
| 2007 | -535.13               |
| 2006 | -429.80               |
| 2005 | -556.31               |
| 2004 | -675.52               |
| 2003 | -684.35               |
| 2002 | -523.37               |
| 2001 | -149.72               |
| 2000 | 81.14                 |
| 1999 | -2.84                 |
| 1998 | -37.36                |
| 1997 | -139.61               |
| 1996 | -244.25               |
| 1995 | -319.11               |
| 1994 | -330.87               |
| 1993 | -406.51               |
| 1992 | -441.19               |
| 1991 | -352.32               |
| 1990 | -296.46               |
| 1989 | -225.68               |
| 1988 | -217.87               |
| 1987 | -237.38               |
| 1986 | -270.47               |
| 1985 | -248.06               |
| 1984 | -224.12               |
| 1983 | -242.26               |
| 1982 | -201.48               |
| 1981 | -113.69               |
| 1980 | -115.53               |
| 1979 | -67.98                |
| 1978 | -73.20                |
| 1977 | -80.50                |
| 1976 | -96.37                |
| 1975 | -123.55               |
| 1974 | -51.64                |
| 1973 | -39.21                |
| 1972 | -52.12                |
| 1971 | -63.07                |
| 1970 | -49.26                |
</p>
</details>

To refine the query and show only years where the United States had an annual lending surplus, use this query:

```sql
SELECT date_format(time, 'yyyy') "year", SUM(value)/4 "surplus"
  FROM "ad01rc1q027sbea"
  GROUP BY period(1 year)
HAVING SUM(value) > 0
```

Using the [`HAVING`](https://github.com/axibase/atsd/tree/master/sql#having-filter) condition to filter returned samples, the result set shows only one year since 1970 when the United States achieved a net lending surplus:

| year | surplus |
|------|---------|
| 2000 | 81.14   |

Although in the FRED visualization it appeared that the United States government has finally achieved a budget surplus, in fact the nature of the data is such that it only seems that way. The dataset here is annualized, meaning that each quarter's data is plotted as if the trend were to remain constant for the entire year. Thus, the administration's $250 billion tax relief is considered as $1 trillion due to annualization calculations. See [Non-Annualized Data](#non-annualized-data) for further data transformation examples.

### Data Visualizations with `matplotlib` and **Trends** Service

The `matplotlib` library is a Matlab-like tool which offers an inline visualization solution for the Python interface. Follow the integration instructions [here](https://github.com/axibase/atsd-api-python#graphing-results) to import the library and work with it from the Python command line. Using government lending / borrowing data, a simple visualization may be created inline, using data stored in ATSD.

![](images/matplotlib-demo.png)

While lacking web-based presentation capability, the `matplotlib` tool is helpful for visualizing data transformations inline.

In order to create this visualization, query the desired data using the [SQLService](https://github.com/axibase/atsd-api-python#querying-data).

<details><summary>View command line examples to convert the data to a <code>pandas</code> data frame:</summary>
<p>

```python
## 'series' previously defined as series to be converted.
>>> ts = series.to_pandas_series()

## Confirm successful conversion.
>>> print(ts)

## Import tools and plot queued data.
>>> import matplotlib.pyplot as plt
>>> series.plot()

## Display newly-created visualization.
>>> plt.show()
```

</p>
</details>

Using the same data in the [**Trends**](https://github.com/axibase/atsd-use-cases/blob/master/how-to/shared/trends.md) service, which is a graphical environment supported by ATSD, more robust visualizations may be created with far less user input:

![](images/trends-budg.png)

[![](images/button-new.png)](https://trends.axibase.com/224fd492)

*Fig 1.* This visualization leverages [user-defined functions](https://github.com/axibase/atsd-use-cases/blob/master/how-to/shared/trends.md#user-defined-functions) to display both the raw data as well as monthly change in value using a [dual-axis](https://axibase.com/products/axibase-time-series-database/visualization/widgets/time-chart/#tab-id-2) setting and several `[threshold]` series.

### Non-Annualized Data

As noted previously, this dataset is annualized. The non-annualized data set shown above still considered the extraordinary tax relief item. This section of the article details how to remove and recalculate this datapoint. [`CASE`](https://github.com/axibase/atsd/tree/master/sql#case-expression) expressions may be used to replicate `if-else` statements in SQL console:

```sql
SELECT date_format(time, 'yyyy') "Year",
  CASE
  WHEN datetime = '2017-01-01' THEN ((SUM(value) -1000)/4)
  ELSE SUM(value/4)
  END AS "Annual Lending / Borrowing"
FROM "ad01rc1q027sbea"
GROUP BY period(1 year)
ORDER BY datetime DESC
```

The result set from 2007 onward:

| Year | Annual Lending / Borrowing |
|------|----------------------------|
| 2017 | -935.56                    |
| 2016 | -931.36                    |
| 2015 | -781.12                    |
| 2014 | -851.12                    |
| 2013 | -913.30                    |
| 2012 | -1447.01                   |
| 2011 | -1666.73                   |
| 2010 | -1818.96                   |
| 2009 | -1847.06                   |
| 2008 | -1054.96                   |
| 2007 | -535.13                    |

<details><summary>View the complete result set here:</summary>
<p>

| Year | Annual Lending / Borrowing |
|------|----------------------------|
| 2017 | -935.56                    |
| 2016 | -931.36                    |
| 2015 | -781.12                    |
| 2014 | -851.12                    |
| 2013 | -913.30                    |
| 2012 | -1447.01                   |
| 2011 | -1666.73                   |
| 2010 | -1818.96                   |
| 2009 | -1847.06                   |
| 2008 | -1054.96                   |
| 2007 | -535.13                    |
| 2006 | -429.80                    |
| 2005 | -556.31                    |
| 2004 | -675.52                    |
| 2003 | -684.35                    |
| 2002 | -523.37                    |
| 2001 | -149.72                    |
| 2000 | 81.14                      |
| 1999 | -2.84                      |
| 1998 | -37.36                     |
| 1997 | -139.61                    |
| 1996 | -244.25                    |
| 1995 | -319.11                    |
| 1994 | -330.87                    |
| 1993 | -406.51                    |
| 1992 | -441.19                    |
| 1991 | -352.32                    |
| 1990 | -296.46                    |
| 1989 | -225.68                    |
| 1988 | -217.87                    |
| 1987 | -237.38                    |
| 1986 | -270.47                    |
| 1985 | -248.06                    |
| 1984 | -224.12                    |
| 1983 | -242.26                    |
| 1982 | -201.48                    |
| 1981 | -113.69                    |
| 1980 | -115.53                    |
| 1979 | -67.98                     |
| 1978 | -73.20                     |
| 1977 | -80.50                     |
| 1976 | -96.37                     |
| 1975 | -123.55                    |
| 1974 | -51.64                     |
| 1973 | -39.21                     |
| 1972 | -52.12                     |
| 1971 | -63.07                     |
| 1970 | -49.26                     |

</p>
</details>

A transformation which still considers the $250 billion tax repatriation:

```sql
SELECT date_format(time, 'yyyy') "Year",
  CASE
  WHEN datetime = '2017-01-01' THEN ((SUM(value) -750)/4)
  ELSE SUM(value/4)
  END AS "Annual Lending / Borrowing"
FROM "ad01rc1q027sbea"
GROUP BY period(1 year)
ORDER BY datetime DESC
```

The 10-year result set:

| Year | Annual Lending / Borrowing |
|------|----------------------------|
| 2017 | -873.06                    |
| 2016 | -931.36                    |
| 2015 | -781.12                    |
| 2014 | -851.12                    |
| 2013 | -913.30                    |
| 2012 | -1447.01                   |
| 2011 | -1666.73                   |
| 2010 | -1818.96                   |
| 2009 | -1847.06                   |
| 2008 | -1054.96                   |
| 2007 | -535.13                    |

<details><summary>View the complete result set here:</summary>
<p>

| Year | Annual Lending / Borrowing |
|------|----------------------------|
| 2017 | -873.06                    |
| 2016 | -931.36                    |
| 2015 | -781.12                    |
| 2014 | -851.12                    |
| 2013 | -913.30                    |
| 2012 | -1447.01                   |
| 2011 | -1666.73                   |
| 2010 | -1818.96                   |
| 2009 | -1847.06                   |
| 2008 | -1054.96                   |
| 2007 | -535.13                    |
| 2006 | -429.80                    |
| 2005 | -556.31                    |
| 2004 | -675.52                    |
| 2003 | -684.35                    |
| 2002 | -523.37                    |
| 2001 | -149.72                    |
| 2000 | 81.14                      |
| 1999 | -2.84                      |
| 1998 | -37.36                     |
| 1997 | -139.61                    |
| 1996 | -244.25                    |
| 1995 | -319.11                    |
| 1994 | -330.87                    |
| 1993 | -406.51                    |
| 1992 | -441.19                    |
| 1991 | -352.32                    |
| 1990 | -296.46                    |
| 1989 | -225.68                    |
| 1988 | -217.87                    |
| 1987 | -237.38                    |
| 1986 | -270.47                    |
| 1985 | -248.06                    |
| 1984 | -224.12                    |
| 1983 | -242.26                    |
| 1982 | -201.48                    |
| 1981 | -113.69                    |
| 1980 | -115.53                    |
| 1979 | -67.98                     |
| 1978 | -73.20                     |
| 1977 | -80.50                     |
| 1976 | -96.37                     |
| 1975 | -123.55                    |
| 1974 | -51.64                     |
| 1973 | -39.21                     |
| 1972 | -52.12                     |
| 1971 | -63.07                     |
| 1970 | -49.26                     |

</p>
</details>

## Accessing Data

The dataset used for this article is stored in the **Trends** instance of ATSD. If you would like read-only credentials to the database to recreate the queries shown here, test drive the **ATSD API Client for Python**, or query any of the other [datasets](https://trends.axibase.com/public/reference.html) stored there, [reach out to us](https://axibase.com/feedback/), we're happy to provide them.

If you have access to your own instance of ATSD, upload the [FRED data crawler](https://github.com/axibase/atsd-data-crawlers/blob/master/crawlers/fred-category-crawler/README.md#fred-category-crawler). The data crawler can upload the needed dataset along with all metadata information.

### Setup

Confirm these programs are present on the local machine:

* Python: `apt-get install python3` (alternatively, [`python2.7`](https://github.com/axibase/atsd-api-python#requirements) may be used);
* ATSD Client: `pip install atsd_client`.

> ATSD Client will import the `pandas` library upon installation.

For detailed installation instructions, this [guide](https://github.com/axibase/atsd-api-python/blob/master/README.md#installation) offers troubleshooting, launch examples, and a step-by-step walkthrough.

## Conclusion

Python programming language offers a convenient syntax for inline SQL queries. Using **ATSD API Client for Python** alongside other libraries improves upon native functionality by reducing the workload during data preparation. ATSD manages all data storage tasks and provides a client which makes data quickly available without loading it via Python.

**Trends** visualizaton services, supported by ATSD data storage and processing, support and enhance these features by offering a more robust graphical output with a less tedious syntactical input.
