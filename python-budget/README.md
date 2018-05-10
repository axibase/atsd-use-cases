# SQL Queries and Data Visualization with Python and ATSD

## Introduction

[Python](https://www.python.org/) is an easy-to-use and versatile programming language that boasts code readability and functionality for tasks of any size. [Pandas](http://pandas.pydata.org/) is an open-source data analytics library designed for Python which offers the functional solutions of a more purpose-specific language like [R](https://www.r-project.org/) from within the Python interface. [Axibase Time Series Database](https://axibase.com/products/axibase-time-series-database/) is an enterprise-level data storage and processing environment that features a rule engine, SQL, and visualization functionality. Using these three tools, data analysis tasks may be approached from the ground up to unlock meaningful results from within a single interface.

## Dataset

The [Federal Reserve Economic Research Division](https://fred.stlouisfed.org/) of the St. Louis Federal Reserve publishes open-source data on a range of topics from macroeconomic trends like Gross Domestic Product to microeconomic phenomena such as unemployment and producer / consumer price indices.

While native FRED visualization tools have a number of built-in manipulation and export features, meaningful data munging and preparation requires a third-party resource. With the ATSD Client for Python and pandas library, data may be queried using SQL and visualized for external use or analysis. This article will focus on the [net lending / borrowing](https://fred.stlouisfed.org/series/AD01RC1Q027SBEA) of the United States Government for the past several decades and explore the way these three tools may intersect to facilitate the data processing, storage, and exploration functionalities for true Big Data projects.

### Setup

Confirm these programs are present on the local machine:

* Python: `apt-get install python2.7` (alternatively, `python3` may be used);
* ATSD Client: `pip install atsd_client`.

> ATSD Client will import the `pandas` library upon installation.

For detailed installation instructions, this [guide](https://github.com/axibase/atsd-api-python/blob/master/README.md) offers troubleshooting, launch examples, and a step-by-step walkthrough.

## Querying Federal Reserve Data with Inline SQL 

After [setup](https://github.com/axibase/atsd-api-python#sql-queries), SQL queries may be performed from the Python command line. The FRED data is quarterly, use this query to track federal budget data from the final quarter for each recorded year:

```sql
SELECT date_format(time, 'yyyy'), LAST(value)
FROM "ad01rc1q027sbea"
GROUP BY date_format(time,'yyyy')
```

For multi-line queries in the Python interface, define a variable `q = """`, Then multi-line queries may be made. Close the query with `"""`. The complete query will be thus:

```python
>>> q = """
... SELECT date_format(time, 'yyyy'), LAST(value)
... FROM "ad01rc1q027sbea"
... GROUP BY date_format(time,'yyyy')
... """
>>> ...
```

The result set is shown here:

```txt
| Year  Deficit / Surplus (Billion USD)     |
|-------------------------------------------|
| 0   1970                          -61.217 |
| 1   1971                          -62.891 |
| 2   1972                          -50.513 |
| 3   1973                          -37.343 |
| 4   1974                          -70.448 |
| 5   1975                         -120.060 |
| 6   1976                          -92.043 |
| 7   1977                          -82.716 |
| 8   1978                          -69.087 |
| 9   1979                          -80.250 |
| 10  1980                         -109.876 |
| 11  1981                         -147.411 |
| 12  1982                         -247.870 |
| 13  1983                         -232.744 |
| 14  1984                         -245.549 |
| 15  1985                         -260.890 |
| 16  1986                         -257.616 |
| 17  1987                         -238.781 |
| 18  1988                         -215.789 |
| 19  1989                         -255.620 |
| 20  1990                         -339.853 |
| 21  1991                         -392.791 |
| 22  1992                         -433.156 |
| 23  1993                         -359.510 |
| 24  1994                         -338.100 |
| 25  1995                         -294.010 |
| 26  1996                         -193.928 |
| 27  1997                         -115.766 |
| 28  1998                          -23.666 |
| 29  1999                           -3.048 |
| 30  2000                           51.488 |
| 31  2001                         -253.246 |
| 32  2002                         -588.672 |
| 33  2003                         -650.718 |
| 34  2004                         -628.160 |
| 35  2005                         -537.567 |
| 36  2006                         -376.840 |
| 37  2007                         -594.622 |
| 38  2008                        -1357.509 |
| 39  2009                        -1838.034 |
| 40  2010                        -1727.036 |
| 41  2011                        -1635.086 |
| 42  2012                        -1402.966 |
| 43  2013                         -812.007 |
| 44  2014                         -868.867 |
| 45  2015                         -736.282 |
| 46  2016                         -949.905 |
| 47  2017                           14.676 |
```

To refine the query and show only data where the United States had an annual surplus, use this query:

```sql
SELECT date_format(time, 'yyyy') as "Year", LAST(value) AS "Surplus (Billion USD)"
FROM "ad01rc1q027sbea"
WHERE value > 0
GROUP BY date_format(time,'yyyy')
```

The result set shows only four years since 1970 when the United States achieved a net surplus:

```txt
| Year          Surplus (Billion USD)      |
|------------------------------------------|
| 0  1999                            6.352 |
| 1  2000                           51.488 |
| 2  2001                           18.484 |
| 3  2017                           14.676 |
```

For the first time since 2001, the United States Government has announced a positive budget balance. Much of the government's budget was subject to extensive refurbishment during the current administration's first year in office.

The highest annual budget deficits incurred may be gathered with this query:

```sql
SELECT date_format(time, 'yyyy') as "Year", LAST(value) AS "Deficit (Billion USD)"
FROM "ad01rc1q027sbea"
GROUP BY date_format(time,'yyyy')
ORDER BY LAST(value) ASC
LIMIT 10
```

The result set shows the years with the highest annual budget deficits:

```txt
| Year  Deficit (Billion USD)    |
|--------------------------------|
| 0  2009              -1838.034 |
| 1  2010              -1727.036 |
| 2  2011              -1635.086 |
| 3  2012              -1402.966 |
| 4  2008              -1357.509 |
| 5  2016               -949.905 |
| 6  2014               -868.867 |
| 7  2013               -812.007 |
| 8  2015               -736.282 |
| 9  2003               -650.718 |
```

It's no surprise that each of the years leading into and immediately following the Great Recession and housing market collapse are among those which saw the largest growing in government borrowing.

### Data Visualizations with `matplotlib` and the Trends Service

The `matplotlib` library is a Matlab-like tool which offers an inline visualization solution for the Python interface. Follow the integration instructions [here](https://github.com/axibase/atsd-api-python#graphing-results) to import the library and work with it from the Python command line. Using government lending / borrowing data, a simple visualization may be created inline, using data which is stored in ATSD.

![](images/matplotlib-demo.png)

While lacking some of the detail of a more robust visualization service, the `matplotlib` tool is helpful for visualizing data transformations inline.

Using the same data in the [**Trends**](https://github.com/axibase/atsd-use-cases/blob/master/how-to/shared/trends.md) service, which is a graphical environment supported by ATSD, more robust visualizations may be created with far less user input:

![](images/trends-budg.png)

[![](images/button-new.png)](https://trends.axibase.com/224fd492)

*Fig 1.* This visualization leverages [user-defined functions](https://github.com/axibase/atsd-use-cases/blob/master/how-to/shared/trends.md#user-defined-functions) to display both the raw data as well as monthly change in value using a [dual-axis](https://axibase.com/products/axibase-time-series-database/visualization/widgets/time-chart/#tab-id-2) setting and `[threshold]` series.

Using **Trends** is an alternate solution to native `matplotlib` functionality in Python. Trends offers a convenient and well-documented [syntax](https://axibase.com/products/axibase-time-series-database/visualization/widgets/) that supports *ad hoc* data modifications that do not change the underlying dataset.