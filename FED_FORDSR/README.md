The Average American Debt Profile
===

![](Images/fed-000.jpg)

### Introduction

Debt is a complicated concept. After the sub-prime mortgage crisis of the late 2000s, modern Americans are all too familiar
with the problems of irresponsible spending on credit. Student loan recipients who queue up to drop off another application
for a job in a field they did not study are quick to point to the trappings of deficit spending as a means of wealth creation. 
Politicians and voters on both sides of the aisle point to the ever-growing [United States Government debt](http://www.usdebtclock.org/)
with anxiety for the future.

And yet despite all the doom and gloom, the American financial system is one of the most stable and robust in the world, in 
no small part thanks to ingenious monetary policy and hegemonic economic position organized over the entire course of the country's history, 
modern American consumers are among the wealthiest on the planet.

The United States Federal Reserve is the central banking system of the United States, responsible for monitoring the global
financial climate and enacting policy that supports the American economy and American consumers. They maintain a number of statistics
about these consumers and their monetary practices to better inform their decisions and practices.

### Data

Provided by the [Federal Reserve](https://www.federalreserve.gov/), this [dataset](https://www.federalreserve.gov/releases/housedebt/default.htm)
must be modified during import. The data are aggregated by quarter, but stored with ambiguous denominations. Upon import, this value
must be reformatted to reflect the quarter's first month, so as not to be  interpreted incorrectly. [Axibase Schema 
Based Parsing](https://axibase.com/products/axibase-time-series-database/writing-data/csv/) supports javascript customization 
of data, the desired schema is shown below:

**Query 1.1**

```ls
function quarterToMonth(yearAndQuarter) {
    var month;
    switch (yearAndQuarter.charAt(5)) {
        case '1': month = '01'; break;
        case '2': month = '04'; break;
        case '3': month = '07'; break;
        case '4': month = '10'; break;
    }
    return yearAndQuarter.substring(0, 5) + month;
}

select("#row=2-*!1").select("#col=2-*!1").
addSeries().
timestamp(quarterToMonth(cell(row,1))).
metric(cell(1,col));
```

For step-by-step instructions on data customization with schema based parsing, see this [support tutorial](/Support/Schema-Parser-Mod-Pre-Import).

#### Financial Obligation Ratio:

The Financial Obligation Ratio (FOR) is an estimate of the ratio of required debt payments to disposable income. This is a broad
calculation and includes all kinds of debt:  mortgage payments, credit cards, property tax and lease payments. Each of these
metrics can be expanded further to include associated costs, such as homeowner's insurance for example. The Federal Reserve 
releases this number each quarter.

**Figure 1.1**

![](Images/fed-001.png)

[![](Images/button.png)](https://apps.axibase.com/chartlab/da132e01/2/#fullscreen)

> Use the dropdown menus at the top of the visualization screen to navigate through time, selecting the `starttime` and `endtime` values
to observe a desired period.

The data can also be queried with a structured query language in the [SQL Console](https://github.com/axibase/atsd/tree/master/api/sql).
The data will be aggregated annually, derived from the average value of each quarter within a given year:

**Query 2.1**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', AVG(value) AS 'Average FOR'
  FROM 'for'
GROUP BY date_format(time, 'yyyy')
```

**Table 1.1**

```ls
| Year | Average FOR | 
|------|-------------| 
| 1980 | 15.37       | 
| 1981 | 15.30       | 
| 1982 | 15.52       | 
| 1983 | 15.47       | 
| 1984 | 15.71       | 
| 1985 | 16.74       | 
| 1986 | 17.32       | 
| 1987 | 17.44       | 
| 1988 | 17.05       | 
| 1989 | 16.98       | 
| 1990 | 16.94       | 
| 1991 | 16.78       | 
| 1992 | 15.95       | 
| 1993 | 15.67       | 
| 1994 | 15.87       | 
| 1995 | 16.46       | 
| 1996 | 16.63       | 
| 1997 | 16.65       | 
| 1998 | 16.35       | 
| 1999 | 16.63       | 
| 2000 | 16.79       | 
| 2001 | 17.42       | 
| 2002 | 17.31       | 
| 2003 | 16.98       | 
| 2004 | 16.82       | 
| 2005 | 17.24       | 
| 2006 | 17.43       | 
| 2007 | 17.92       | 
| 2008 | 17.74       | 
| 2009 | 17.45       | 
| 2010 | 16.49       | 
| 2011 | 15.84       | 
| 2012 | 15.29       | 
| 2013 | 15.49       | 
| 2014 | 15.28       | 
| 2015 | 15.40       | 
| 2016 | 15.45       | 
| 2017 | 15.47       | 
```
> All values are shown as a percent of one hundred, where the whole is representative of the total income of the average person.

#### Debt Service Ratio:

The Debt Service Ratio (DSR) is more specific than the Financial Obligation Ratio in that it typically does not include
non-essential debt payments. Here, it has been parsed into two categories, mortgage debt and consumer debt. These numbers represent
the average percent of a person's earned salary each month which much be used to make the required payments associated with
consumer credit and mortgage.

Typically the DSR is an initial calculation performed to determine a person's eligibility to receive a mortgage. A DSR value
of less than 48% is generally preferred, meaning that with a particular mortgage plus other credit obligations at least 52%
of a person's gross monthly earning would still be available to them after making the required payments.

**Figure 2.1**

![](Images/fed-002.png)

[![](Images/button.png)](https://apps.axibase.com/chartlab/da132e01/3/#fullscreen)

**Query 3.1**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', AVG(value) AS 'Average DSR'
  FROM 'dsr_total'
GROUP BY date_format(time, 'yyyy')
```

**Table 2.1**

```ls
| Year | Average DSR | 
|------|-------------| 
| 1980 | 10.51       | 
| 1981 | 10.39       | 
| 1982 | 10.49       | 
| 1983 | 10.43       | 
| 1984 | 10.71       | 
| 1985 | 11.49       | 
| 1986 | 11.91       | 
| 1987 | 11.96       | 
| 1988 | 11.71       | 
| 1989 | 11.73       | 
| 1990 | 11.63       | 
| 1991 | 11.39       | 
| 1992 | 10.65       | 
| 1993 | 10.40       | 
| 1994 | 10.55       | 
| 1995 | 11.12       | 
| 1996 | 11.32       | 
| 1997 | 11.34       | 
| 1998 | 11.19       | 
| 1999 | 11.47       | 
| 2000 | 11.79       | 
| 2001 | 12.39       | 
| 2002 | 12.38       | 
| 2003 | 12.24       | 
| 2004 | 12.19       | 
| 2005 | 12.56       | 
| 2006 | 12.72       | 
| 2007 | 13.05       | 
| 2008 | 12.84       | 
| 2009 | 12.30       | 
| 2010 | 11.37       | 
| 2011 | 10.68       | 
| 2012 | 10.14       | 
| 2013 | 10.21       | 
| 2014 | 9.99        | 
| 2015 | 9.99        | 
| 2016 | 10.02       | 
| 2017 | 10.04       | 
```

### Analysis

Because the FOR value includes the DSR value plus additional non-essential credit values, and the DSR value is parsed into both consumer and mortgage
related debt, these three values can be shown in a new visualization that creates a typical consumer profile of the average
American. By using the calculated value setting shown below, additional data not specifically included in the set can be
displayed:

**Query 4.1**

```ls
    [series]
      metric = dsr_total
      display = false
      alias = dsr
      
    [series]
      metric = for
      display = false
      alias = for
      
    [series]
      value = value('for') - value('dsr')
      label = Non-Essential Debt Payment
```

Shown below is the debt profile of the average American consumer from 1980 to 2017, navigate through time using the dropdown
menus at the top of the screen to select a desired span of time and compare how bearing debt has changed over the course of
the last three decades.

**Figure 3.1**

![](Images/fed-003.png)

[![](Images/button.png)](https://apps.axibase.com/chartlab/da132e01/4/#fullscreen)

The visualization can also be organized to show the amount of each type of debt as it relates to the others:

**Figure 3.2**

![](Images/fed-004.png)

[![](Images/button.png)](https://apps.axibase.com/chartlab/da132e01/5/#fullscreen)

Additionally, these values can be compared on an annual basis as shown in the visualization below:

**Figure 3.3**

![](Images/fed-005.png)

[![](Images/button.png)](https://apps.axibase.com/chartlab/da132e01/6/#fullscreen)

To view the distribution of these values across time, a histogram is shown below:

**Figure 3.4**

![](Images/fed-006.png)

[![](Images/button.png)](https://apps.axibase.com/chartlab/da132e01/7/#fullscreen)

In the following box diagram, explore time with the dropdown menus at the top of the visualization screen. The visualization
shows the distribution of debt values as a percentage of total income, with the initial time period set to include the
entire data set:

**Figure 3.5**

![](Images/fed-007.png)

[![](Images/button.png)](https://apps.axibase.com/chartlab/da132e01/8/#fullscreen)

The following SQL query will detail the above visualizations in one table, displaying averaged annual values of each component
described above: non-essential credit payments, mortgage credit payments, and consumer credit payments, as well as the Financial
Obligation Ratio (FOR), or total debt obligations.

**Query 4.2**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', AVG(dsrM.value) AS 'Mortgage', AVG(dsrC.value) AS 'Consumer', AVG(for.value - dsr.value) AS 'Non-Essential', AVG(for.value) AS 'Total'
  FROM 'dsr_mortgage' AS dsrM JOIN 'dsr_consumer' AS dsrC JOIN 'for' AS for JOIN 'dsr_total' AS dsr
GROUP BY date_format(time, 'yyyy')
```

**Table 3.1**

```ls
| Year | Mortgage | Consumer | Non-Essential | Total | 
|------|----------|----------|---------------|-------| 
| 1980 | 4.48     | 6.03     | 4.86          | 15.37 | 
| 1981 | 4.73     | 5.66     | 4.91          | 15.30 | 
| 1982 | 4.92     | 5.57     | 5.03          | 15.52 | 
| 1983 | 4.88     | 5.55     | 5.04          | 15.47 | 
| 1984 | 4.98     | 5.74     | 4.99          | 15.71 | 
| 1985 | 5.36     | 6.13     | 5.25          | 16.74 | 
| 1986 | 5.60     | 6.31     | 5.41          | 17.32 | 
| 1987 | 5.77     | 6.18     | 5.48          | 17.44 | 
| 1988 | 5.77     | 5.94     | 5.34          | 17.05 | 
| 1989 | 5.89     | 5.83     | 5.25          | 16.98 | 
| 1990 | 6.10     | 5.53     | 5.31          | 16.94 | 
| 1991 | 6.19     | 5.20     | 5.39          | 16.78 | 
| 1992 | 5.89     | 4.76     | 5.31          | 15.95 | 
| 1993 | 5.71     | 4.70     | 5.26          | 15.67 | 
| 1994 | 5.56     | 4.98     | 5.32          | 15.87 | 
| 1995 | 5.67     | 5.45     | 5.34          | 16.46 | 
| 1996 | 5.60     | 5.72     | 5.31          | 16.63 | 
| 1997 | 5.62     | 5.72     | 5.31          | 16.65 | 
| 1998 | 5.49     | 5.70     | 5.16          | 16.35 | 
| 1999 | 5.54     | 5.93     | 5.16          | 16.63 | 
| 2000 | 5.65     | 6.14     | 5.01          | 16.79 | 
| 2001 | 5.80     | 6.59     | 5.03          | 17.42 | 
| 2002 | 5.81     | 6.57     | 4.94          | 17.31 | 
| 2003 | 5.83     | 6.41     | 4.74          | 16.98 | 
| 2004 | 5.89     | 6.29     | 4.63          | 16.82 | 
| 2005 | 6.35     | 6.21     | 4.68          | 17.24 | 
| 2006 | 6.75     | 5.97     | 4.71          | 17.43 | 
| 2007 | 7.09     | 5.96     | 4.88          | 17.92 | 
| 2008 | 6.98     | 5.87     | 4.90          | 17.74 | 
| 2009 | 6.71     | 5.59     | 5.15          | 17.45 | 
| 2010 | 6.21     | 5.16     | 5.12          | 16.49 | 
| 2011 | 5.62     | 5.06     | 5.16          | 15.84 | 
| 2012 | 5.17     | 4.97     | 5.14          | 15.29 | 
| 2013 | 4.98     | 5.22     | 5.29          | 15.49 | 
| 2014 | 4.72     | 5.27     | 5.29          | 15.28 | 
| 2015 | 4.58     | 5.41     | 5.41          | 15.40 | 
| 2016 | 4.48     | 5.54     | 5.43          | 15.45 | 
| 2017 | 4.42     | 5.63     | 5.43          | 15.47 | 
```

The above dataset can illuminate a number of features of the American economy and a number of characteristics of the average
American consumer. While modern Americans are quick to denounce the zeitgeist of living outside of one's means, the data
shows that in fact, the amount of debt carried by the average American is on par with or even lower in some cases than that
of his 1980's counterpart. In fact, the only metric which has demonstrated a legitimate increase in value over the last
several decades has been the roughly one percent increase in non-essential credit holdings by the average consumer.

According to [data](https://fred.stlouisfed.org/series/MEHOINUSA646N) from the [Economic Research Department](https://research.stlouisfed.org/)
of the [Saint Louis Branch of the Federal Reserve](https://www.stlouisfed.org/), the 2015 US median household income was $56,516
per year in 2015 USD. This number can be applied to the above table and visualized in [ChartLab](https://apps.axibase.com)
to create more comprehensive data. 

**Figure 3.6**

![](Images/fed-008.png)

[![](Images/button.png)](https://apps.axibase.com/chartlab/da132e01/11/#fullscreen)

The above visualization aggregates the values from **Table 3.1** based on a time period of the user's selection. Use the dropdown
menu at the top of the screen to select the aggregation period. The initial visualization shows the average values for each
metric over the entire period of time in 2015 USD by obligation amount per quarter. 

The following query summons the same data shown above, but further parses it to show annual average monthly payments instead
of quarterly values in 2015 USD for a person making the 2015 median United States income of $56,516 a year.

**Query 4.3**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', AVG((56516 * (dsrM.value/100))/4) AS 'Mortgage', AVG((56516 * (dsrC.value/100))/4) AS 'Consumer', AVG((56516 *(((for.value - dsr.value)/100)))/4) AS 'Non-Essential', AVG((56516 * (for.value/100))/4) AS 'Total'
  FROM 'dsr_mortgage' AS dsrM JOIN 'dsr_consumer' AS dsrC JOIN 'for' AS for JOIN 'dsr_total' AS dsr
GROUP BY date_format(time, 'yyyy')
```

**Table 3.2**

```ls
| Year | Mortgage | Consumer | Non-Essential | Total   | 
|------|----------|----------|---------------|---------| 
| 1980 | 632.98   | 851.98   | 686.67        | 2171.63 | 
| 1981 | 667.95   | 798.99   | 694.09        | 2161.74 | 
| 1982 | 695.15   | 786.63   | 711.04        | 2192.47 | 
| 1983 | 688.79   | 784.16   | 712.81        | 2185.76 | 
| 1984 | 703.62   | 810.30   | 705.39        | 2218.96 | 
| 1985 | 757.67   | 866.81   | 742.13        | 2365.90 | 
| 1986 | 791.22   | 891.19   | 764.38        | 2446.79 | 
| 1987 | 815.24   | 873.53   | 774.98        | 2464.45 | 
| 1988 | 814.54   | 839.62   | 754.84        | 2408.99 | 
| 1989 | 832.90   | 823.72   | 742.48        | 2399.46 | 
| 1990 | 861.52   | 780.98   | 749.90        | 2392.75 | 
| 1991 | 874.94   | 734.71   | 761.91        | 2371.20 | 
| 1992 | 832.55   | 672.54   | 749.90        | 2254.28 | 
| 1993 | 806.41   | 664.42   | 743.89        | 2214.01 | 
| 1994 | 786.28   | 704.33   | 751.66        | 2242.27 | 
| 1995 | 800.41   | 770.03   | 754.84        | 2325.28 | 
| 1996 | 791.58   | 807.83   | 750.25        | 2349.65 | 
| 1997 | 793.34   | 808.53   | 749.90        | 2352.48 | 
| 1998 | 775.68   | 805.00   | 728.70        | 2309.74 | 
| 1999 | 783.45   | 837.50   | 728.70        | 2350.01 | 
| 2000 | 798.29   | 867.52   | 707.51        | 2372.97 | 
| 2001 | 819.84   | 931.45   | 710.34        | 2461.27 | 
| 2002 | 820.89   | 927.92   | 697.62        | 2446.44 | 
| 2003 | 824.07   | 905.32   | 670.42        | 2399.81 | 
| 2004 | 832.20   | 888.71   | 654.53        | 2376.14 | 
| 2005 | 896.84   | 877.76   | 661.59        | 2436.19 | 
| 2006 | 953.35   | 843.50   | 665.12        | 2461.98 | 
| 2007 | 1001.04  | 842.44   | 689.14        | 2532.62 | 
| 2008 | 986.20   | 828.67   | 692.32        | 2507.19 | 
| 2009 | 948.06   | 789.81   | 728.00        | 2465.86 | 
| 2010 | 877.41   | 728.70   | 723.76        | 2330.23 | 
| 2011 | 793.34   | 715.28   | 728.35        | 2237.33 | 
| 2012 | 730.82   | 702.56   | 726.58        | 2159.97 | 
| 2013 | 703.98   | 737.89   | 746.72        | 2188.58 | 
| 2014 | 666.54   | 744.25   | 747.42        | 2158.56 | 
| 2015 | 647.11   | 764.38   | 764.03        | 2175.87 | 
| 2016 | 632.63   | 782.75   | 767.20        | 2182.58 | 
| 2017 | 624.50   | 795.46   | 767.20        | 2185.76 | 
```

#### Conclusions

As it turns out, the idea that your parents paid less for their house than you will is only true in absolute terms. When
compared with current numbers and controlled for inflation, the average 2017 consumer will pay roughly the same portion of their
income towards a place to hang their hat up as the average 1980 consumer.

The Federal Reserve is able to pull certain levers of power from the Eccles Building in Washington, D.C. such as printing
more money, or raising and lowering interest rates to cope with inflation. However, all of these are reactionary measures meant
to create small changes that have a butterfly effect over time. Ultimately, the machinations of the Board of Governers have
always be something opaque and esoteric to the average man, leading to many people denouncing the Federal Reserve System entirely, occasionally 
opting for a return of the gold standard or leveling accusations of wrong-doing.

However, after reviewing the data above, it seems that at least on a consumer level, the average American actually has more
today than they would have had thirty years ago, or even just five years ago. Of course, the Federal Reserve isn't completely 
responsible for the wise consumer choices made in the current decades, but monetary policy enacted by the various branches of the Federal
Reserve are responsible for maintaining the economic conditions that Americans, and consumers the world over, have come to expect
from the United States economy.
