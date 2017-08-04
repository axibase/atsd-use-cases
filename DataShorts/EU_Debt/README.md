European Union Debt by Country (1995-2016)
==

> **Data Source**: [Eurostat](http://ec.europa.eu/eurostat)

> **Visualization**: [ChartLab](https://apps.axibase.com) from [Axibase](https://axibase.com)

> **Structured Query Language**: [SQL Console](https://github.com/axibase/atsd/tree/master/api/sql) in the [Axibase Timeseries Database](https://axibase.com)

## Debt Total

**Figure 1.1**

![](Images/eud-01.png)

[![](Images/button.png)](https://apps.axibase.com/chartlab/e4e290d2/2/#fullscreen)

> Open the ChartLab visualization above and use the dropdown menus to navigate between countries or select the European Union
total. Use both charts to compare two countries, one country to the EU total, or any other desired combination.

## Debt as Percent of GDP

**Figure 2.1** 

![](Images/eud-03.png)

[![](Images/button.png)](https://apps.axibase.com/chartlab/5d6d6252/2/#fullscreen)

> Open the ChartLab visualization above and use the dropdown menu to navigate between countries. The red line represents
the European Union debt as a percent of GDP, used as a baseline for reference.

## Debt as a Portion of the European Union Total

**Figure 3.1**

![](Images/eud-04.png)

[![](Images/button.png)](https://apps.axibase.com/chartlab/64b4fd84/7/#fullscreen)

> Open the ChartLab visualization above and use the dropdown menu to navigate through time. 

## Data

Use the following index to navigate between countries, the numerical data associated with the above [ChartLab](https://apps.axibase.com)
visualizations and their corresponding SQL queries are shown below:

**European Union Countries Index**:

* [European Union Total](#european-union-total)
* [Austria](#austria)
* [Belgium](#belgium)
* [Bulgaria](#bulgaria)
* [Croatia](#croatia)
* [Cyprus](#cyprus)
* [Czech Republic](#czech-republic)
* [Denmark](#denmark)
* [Estonia](#estonia)
* [Finland](#finland)
* [France](#france)
* [Germany](#germany)
* [Greece](#greece)
* [Hungary](#hungary)
* [Ireland](#ireland)
* [Italy](#italy)
* [Latvia](#latvia)
* [Lithuania](#lithuania)
* [Luxembourg](#luxembourg)
* [Malta](#malta)
* [Netherlands](#netherlands)
* [Poland](#poland)
* [Portugal](#portugal)
* [Romania](#romania)
* [Slovakia](#slovakia)
* [Slovenia](#slovenia)
* [Spain](#spain)
* [Sweden](#sweden)
* [United Kingdom](#united-kingdom)

### European Union Total

#### Debt

**Script 1.1**
```
SELECT date_format(time, 'yyyy') AS 'Year', value/10000 AS 'Debt (Billion Euro)'
  FROM 'eutotal' WHERE date_format(time, 'yyyy') != '2016'
```

**Table 1.1**

```ls
| Year | Debt (Billion Euro) | 
|------|---------------------| 
| 1995 | 1333.98             | 
| 1996 | 1462.37             | 
| 1997 | 1647.50             | 
| 1998 | 1794.12             | 
| 1999 | 2010.67             | 
| 2000 | 2320.30             | 
| 2001 | 2605.39             | 
| 2002 | 2805.61             | 
| 2003 | 3225.61             | 
| 2004 | 3531.62             | 
| 2005 | 4024.47             | 
| 2006 | 4507.65             | 
| 2007 | 5187.88             | 
| 2008 | 5934.52             | 
| 2009 | 6202.39             | 
| 2010 | 6295.53             | 
| 2011 | 6501.08             | 
| 2012 | 6252.30             | 
| 2013 | 6210.74             | 
| 2014 | 6369.41             | 
| 2015 | 6372.06             | 
```

#### Debt as Percent of GDP

**Script 1.2**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value AS 'Debt as Percent of GDP'
  FROM '%eutotal' WHERE date_format(time, 'yyyy') != '2016'
```

**Table 1.2**

```ls
| Year | Debt as Percent of GDP | 
|------|------------------------| 
| 1995 | 68.07                  | 
| 1996 | 68.65                  | 
| 1997 | 70.54                  | 
| 1998 | 73.50                  | 
| 1999 | 76.12                  | 
| 2000 | 79.80                  | 
| 2001 | 90.46                  | 
| 2002 | 101.86                 | 
| 2003 | 105.84                 | 
| 2004 | 115.90                 | 
| 2005 | 122.03                 | 
| 2006 | 129.18                 | 
| 2007 | 144.89                 | 
| 2008 | 153.41                 | 
| 2009 | 161.84                 | 
| 2010 | 159.21                 | 
| 2011 | 154.13                 | 
| 2012 | 154.74                 | 
| 2013 | 150.50                 | 
| 2014 | 143.61                 | 
| 2015 | 127.93                 | 
```
Return to the **[index](#data)**

### Austria

#### Debt

**Script 2.1**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value/10000 AS 'Debt (Billion Euro)'
  FROM 'austria'
```

**Table 2.1**

```ls
| Year | Debt (Billion Euro) | 
|------|---------------------| 
| 1995 | 18.17               | 
| 1996 | 19.03               | 
| 1997 | 20.50               | 
| 1998 | 21.43               | 
| 1999 | 23.43               | 
| 2000 | 25.94               | 
| 2001 | 27.09               | 
| 2002 | 27.71               | 
| 2003 | 28.93               | 
| 2004 | 29.78               | 
| 2005 | 31.37               | 
| 2006 | 32.75               | 
| 2007 | 35.19               | 
| 2008 | 37.22               | 
| 2009 | 38.00               | 
| 2010 | 39.15               | 
| 2011 | 40.14               | 
| 2012 | 40.97               | 
| 2013 | 41.29               | 
| 2014 | 41.70               | 
| 2015 | 42.97               | 
```

#### Debt as Percent of GDP

**Script 2.2**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value AS 'Debt as Percent of GDP'
  FROM '%austria'
```

**Table 2.2**

```ls
| Year | Debt as Percent of GDP | 
|------|------------------------| 
| 1995 | 103.20                 | 
| 1996 | 104.50                 | 
| 1997 | 108.90                 | 
| 1998 | 109.40                 | 
| 1999 | 115.20                 | 
| 2000 | 121.70                 | 
| 2001 | 123.10                 | 
| 2002 | 122.40                 | 
| 2003 | 125.20                 | 
| 2004 | 123.30                 | 
| 2005 | 124.00                 | 
| 2006 | 122.90                 | 
| 2007 | 124.60                 | 
| 2008 | 127.50                 | 
| 2009 | 132.80                 | 
| 2010 | 132.90                 | 
| 2011 | 130.10                 | 
| 2012 | 129.20                 | 
| 2013 | 128.00                 | 
| 2014 | 126.20                 | 
| 2015 | 126.40                 | 
```

Return to the **[index](#data)**

### Belgium

#### Debt

**Script 3.1**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value/10000 AS 'Debt (Billion Euro)'
  FROM 'belgium'
```

**Table 3.1**

```ls
| Year | Debt (Billion Euro) | 
|------|---------------------| 
| 1995 | 19.37               | 
| 1996 | 20.81               | 
| 1997 | 22.66               | 
| 1998 | 24.73               | 
| 1999 | 27.27               | 
| 2000 | 29.59               | 
| 2001 | 30.12               | 
| 2002 | 30.91               | 
| 2003 | 33.18               | 
| 2004 | 36.11               | 
| 2005 | 37.57               | 
| 2006 | 39.99               | 
| 2007 | 46.25               | 
| 2008 | 57.49               | 
| 2009 | 57.78               | 
| 2010 | 59.36               | 
| 2011 | 66.28               | 
| 2012 | 72.28               | 
| 2013 | 63.65               | 
| 2014 | 68.39               | 
| 2015 | 73.38               | 
```

#### Debt as Percent of GDP

**Script 3.2**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value AS 'Debt as Percent of GDP'
  FROM '%belgium'
```

**Table 3.2**

```ls
| Year | Debt as Percent of GDP | 
|------|------------------------| 
| 1995 | 91.50                  | 
| 1996 | 96.40                  | 
| 1997 | 100.30                 | 
| 1998 | 105.40                 | 
| 1999 | 111.70                 | 
| 2000 | 114.60                 | 
| 2001 | 113.30                 | 
| 2002 | 112.40                 | 
| 2003 | 117.40                 | 
| 2004 | 91.00                  | 
| 2005 | 87.00                  | 
| 2006 | 92.50                  | 
| 2007 | 99.50                  | 
| 2008 | 99.70                  | 
| 2009 | 102.60                 | 
| 2010 | 104.30                 | 
| 2011 | 105.60                 | 
| 2012 | 106.70                 | 
| 2013 | 106.00                 | 
| 2014 | 105.90                 | 
| 2015 | 105.70                 | 
```

Return to the **[index](#data)**

### Bulgaria

#### Debt

**Script 4.1**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value/10000 AS 'Debt (Billion Euro)'
  FROM 'bulgaria'
```

**Table 4.1**

```ls
| Year | Debt (Billion Euro) | 
|------|---------------------| 
| 2000 | 0.75                | 
| 2001 | 0.89                | 
| 2002 | 1.09                | 
| 2003 | 1.50                | 
| 2004 | 2.34                | 
| 2005 | 3.39                | 
| 2006 | 4.85                | 
| 2007 | 7.83                | 
| 2008 | 9.56                | 
| 2009 | 9.77                | 
| 2010 | 9.91                | 
| 2011 | 10.03               | 
| 2012 | 10.25               | 
| 2013 | 10.83               | 
| 2014 | 10.34               | 
| 2015 | 9.78                | 
```

#### Debt as Percent of GDP

**Script 4.2**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value AS 'Debt as Percent of GDP'
  FROM '%bulgaria'
```

**Table 4.2**

```ls
| Year | Debt as Percent of GDP | 
|------|------------------------| 
| 2000 | 26.80                  | 
| 2001 | 28.90                  | 
| 2002 | 32.20                  | 
| 2003 | 41.30                  | 
| 2004 | 57.30                  | 
| 2005 | 72.60                  | 
| 2006 | 91.20                  | 
| 2007 | 123.40                 | 
| 2008 | 131.40                 | 
| 2009 | 133.80                 | 
| 2010 | 132.50                 | 
| 2011 | 124.20                 | 
| 2012 | 125.00                 | 
| 2013 | 131.90                 | 
| 2014 | 123.60                 | 
| 2015 | 110.50                 | 
```

Return to the **[index](#data)**

### Croatia

#### Debt

**Script 5.1**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value/10000 AS 'Debt (Billion Euro)'
  FROM 'croatia'
```

**Table 5.1**

```ls
| Year | Debt (Billion Euro) | 
|------|---------------------| 
| 2001 | 10.51               | 
| 2002 | 13.39               | 
| 2003 | 15.83               | 
| 2004 | 18.26               | 
| 2005 | 21.61               | 
| 2006 | 27.01               | 
| 2007 | 32.65               | 
| 2008 | 38.51               | 
| 2009 | 39.41               | 
| 2010 | 41.20               | 
| 2011 | 40.93               | 
| 2012 | 39.71               | 
| 2013 | 39.06               | 
| 2014 | 39.13               | 
| 2015 | 38.39               | 
```

#### Debt as Percent of GDP

**Script 5.2**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value AS 'Debt as Percent of GDP'
  FROM '%croatia'
```

**Table 5.2**

```ls
| Year | Debt as Percent of GDP | 
|------|------------------------| 
| 2001 | 54.10                  | 
| 2002 | 63.30                  | 
| 2003 | 68.10                  | 
| 2004 | 72.80                  | 
| 2005 | 80.00                  | 
| 2006 | 91.70                  | 
| 2007 | 101.30                 | 
| 2008 | 110.80                 | 
| 2009 | 119.10                 | 
| 2010 | 125.60                 | 
| 2011 | 123.10                 | 
| 2012 | 120.20                 | 
| 2013 | 118.50                 | 
| 2014 | 119.30                 | 
| 2015 | 114.40                 | 
```

Return to the **[index](#data)**

### Cyprus

#### Debt

**Script 6.1**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value/10000 AS 'Debt (Billion Euro)'
  FROM 'cyprus'
```

**Table 6.1**

```ls
| Year | Debt (Billion Euro) | 
|------|---------------------| 
| 1995 | 2.44                | 
| 1996 | 2.51                | 
| 1997 | 2.64                | 
| 1998 | 2.81                | 
| 1999 | 2.95                | 
| 2000 | 3.23                | 
| 2001 | 3.13                | 
| 2002 | 3.29                | 
| 2003 | 3.31                | 
| 2004 | 3.43                | 
| 2005 | 3.95                | 
| 2006 | 4.15                | 
| 2007 | 4.65                | 
| 2008 | 5.42                | 
| 2009 | 5.71                | 
| 2010 | 6.09                | 
| 2011 | 6.35                | 
| 2012 | 6.37                | 
| 2013 | 6.18                | 
| 2014 | 6.22                | 
| 2015 | 6.24                | 
```

#### Debt as Percent of GDP

**Script 6.2**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value AS 'Debt as Percent of GDP'
  FROM '%cyprus'
```

**Table 6.2**

```ls
| Year | Debt as Percent of GDP | 
|------|------------------------| 
| 1995 | 317.60                 | 
| 1996 | 314.70                 | 
| 1997 | 315.20                 | 
| 1998 | 310.00                 | 
| 1999 | 303.60                 | 
| 2000 | 304.60                 | 
| 2001 | 274.00                 | 
| 2002 | 277.10                 | 
| 2003 | 258.00                 | 
| 2004 | 247.70                 | 
| 2005 | 266.50                 | 
| 2006 | 259.20                 | 
| 2007 | 265.50                 | 
| 2008 | 285.00                 | 
| 2009 | 306.00                 | 
| 2010 | 315.60                 | 
| 2011 | 321.60                 | 
| 2012 | 327.40                 | 
| 2013 | 340.90                 | 
| 2014 | 354.30                 | 
| 2015 | 353.70                 | 
```

Return to the **[index](#data)**

### Czech Republic

#### Debt

**Script 7.1**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value/10000 AS 'Debt (Billion Euro)'
  FROM 'czechrepublic'
```

**Table 7.1**

```sql
| Year | Debt (Billion Euro) | 
|------|---------------------| 
| 1995 | 102.44              | 
| 1996 | 118.51              | 
| 1997 | 142.86              | 
| 1998 | 133.41              | 
| 1999 | 136.22              | 
| 2000 | 135.32              | 
| 2001 | 130.23              | 
| 2002 | 139.42              | 
| 2003 | 130.30              | 
| 2004 | 143.87              | 
| 2005 | 156.71              | 
| 2006 | 185.98              | 
| 2007 | 220.47              | 
| 2008 | 255.89              | 
| 2009 | 258.76              | 
| 2010 | 269.18              | 
| 2011 | 275.70              | 
| 2012 | 286.93              | 
| 2013 | 301.92              | 
| 2014 | 308.58              | 
| 2015 | 312.42              | 
```

#### Debt as Percent of GDP

**Script 7.2**
```sql
SELECT date_format(time, 'yyyy') AS 'Year', value AS 'Debt as Percent of GDP'
  FROM '%czechrepublic'
```

**Table 7.2**

```ls
| Year | Debt as Percent of GDP | 
|------|------------------------| 
| 1995 | 64.60                  | 
| 1996 | 65.20                  | 
| 1997 | 72.90                  | 
| 1998 | 62.20                  | 
| 1999 | 60.70                  | 
| 2000 | 56.90                  | 
| 2001 | 50.70                  | 
| 2002 | 52.00                  | 
| 2003 | 46.40                  | 
| 2004 | 47.00                  | 
| 2005 | 48.00                  | 
| 2006 | 52.90                  | 
| 2007 | 57.40                  | 
| 2008 | 63.60                  | 
| 2009 | 65.80                  | 
| 2010 | 67.90                  | 
| 2011 | 68.30                  | 
| 2012 | 70.70                  | 
| 2013 | 73.70                  | 
| 2014 | 71.50                  | 
| 2015 | 68.00                  | 
```

Return to the **[index](#data)**

### Denmark

#### Debt

**Script 8.1**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value/10000 AS 'Debt (Billion Euro)'
  FROM 'denmark'
```
**Table 8.1**

```ls
| Year | Debt (Billion Euro) | 
|------|---------------------| 
| 1995 | 143.16              | 
| 1996 | 155.35              | 
| 1997 | 165.16              | 
| 1998 | 173.25              | 
| 1999 | 183.62              | 
| 2000 | 209.74              | 
| 2001 | 231.87              | 
| 2002 | 235.68              | 
| 2003 | 248.95              | 
| 2004 | 260.50              | 
| 2005 | 297.71              | 
| 2006 | 336.39              | 
| 2007 | 362.50              | 
| 2008 | 400.42              | 
| 2009 | 399.88              | 
| 2010 | 399.55              | 
| 2011 | 408.15              | 
| 2012 | 424.49              | 
| 2013 | 417.06              | 
| 2014 | 424.43              | 
| 2015 | 420.82              | 
```

#### Debt as Percent of GDP

**Script 8.2**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value AS 'Debt as Percent of GDP'
  FROM '%denmark'
```

**Table 8.2**

```ls
| Year | Debt as Percent of GDP | 
|------|------------------------| 
| 1995 | 138.10                 | 
| 1996 | 142.80                 | 
| 1997 | 144.10                 | 
| 1998 | 146.10                 | 
| 1999 | 147.90                 | 
| 2000 | 158.10                 | 
| 2001 | 169.10                 | 
| 2002 | 167.10                 | 
| 2003 | 173.30                 | 
| 2004 | 173.00                 | 
| 2005 | 187.70                 | 
| 2006 | 200.00                 | 
| 2007 | 208.50                 | 
| 2008 | 222.30                 | 
| 2009 | 232.20                 | 
| 2010 | 220.60                 | 
| 2011 | 221.00                 | 
| 2012 | 224.00                 | 
| 2013 | 216.10                 | 
| 2014 | 214.70                 | 
| 2015 | 207.60                 | 
```

Return to the **[index](#data)**

### Estonia

#### Debt

**Script 9.1**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value/10000 AS 'Debt (Billion Euro)'
  FROM 'estonia'
```

**Table 9.1**

```ls
| Year | Debt (Billion Euro) | 
|------|---------------------| 
| 1995 | 0.08                | 
| 1996 | 0.13                | 
| 1997 | 0.23                | 
| 1998 | 0.29                | 
| 1999 | 0.29                | 
| 2000 | 0.33                | 
| 2001 | 0.43                | 
| 2002 | 0.53                | 
| 2003 | 0.65                | 
| 2004 | 0.83                | 
| 2005 | 1.09                | 
| 2006 | 1.54                | 
| 2007 | 2.00                | 
| 2008 | 2.26                | 
| 2009 | 2.17                | 
| 2010 | 2.07                | 
| 2011 | 2.01                | 
| 2012 | 2.11                | 
| 2013 | 2.19                | 
| 2014 | 2.31                | 
| 2015 | 2.36                | 
```

#### Debt as Percent of GDP

**Script 9.2**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value AS 'Debt as Percent of GDP'
  FROM '%estonia'
```

**Table 9.2**

```ls
| Year | Debt as Percent of GDP | 
|------|------------------------| 
| 1995 | 28.90                  | 
| 1996 | 35.30                  | 
| 1997 | 52.00                  | 
| 1998 | 56.50                  | 
| 1999 | 54.10                  | 
| 2000 | 54.00                  | 
| 2001 | 61.60                  | 
| 2002 | 68.00                  | 
| 2003 | 74.80                  | 
| 2004 | 85.40                  | 
| 2005 | 96.60                  | 
| 2006 | 114.00                 | 
| 2007 | 123.00                 | 
| 2008 | 136.70                 | 
| 2009 | 153.20                 | 
| 2010 | 140.40                 | 
| 2011 | 120.40                 | 
| 2012 | 117.80                 | 
| 2013 | 115.90                 | 
| 2014 | 116.70                 | 
| 2015 | 116.60                 | 
```

Return to the **[index](#data)**

### Finland

#### Debt

**Script 10.1**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value/10000 AS 'Debt (Billion Euro)'
  FROM 'finland'
```

**Table 10.1**

```ls
| Year | Debt (Billion Euro) | 
|------|---------------------| 
| 1995 | 9.39                | 
| 1996 | 9.42                | 
| 1997 | 9.39                | 
| 1998 | 9.97                | 
| 1999 | 11.14               | 
| 2000 | 12.67               | 
| 2001 | 13.38               | 
| 2002 | 15.01               | 
| 2003 | 15.90               | 
| 2004 | 17.05               | 
| 2005 | 19.06               | 
| 2006 | 20.58               | 
| 2007 | 23.07               | 
| 2008 | 25.70               | 
| 2009 | 25.85               | 
| 2010 | 27.85               | 
| 2011 | 28.62               | 
| 2012 | 29.69               | 
| 2013 | 30.04               | 
| 2014 | 30.74               | 
| 2015 | 32.04               | 
```

#### Debt as Percent of GDP

**Script 10.2**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value AS 'Debt as Percent of GDP'
  FROM '%finland'
```

**Table 10.2**

```ls
| Year | Debt as Percent of GDP | 
|------|------------------------| 
| 1995 | 95.30                  | 
| 1996 | 92.30                  | 
| 1997 | 84.80                  | 
| 1998 | 82.80                  | 
| 1999 | 87.80                  | 
| 2000 | 93.00                  | 
| 2001 | 92.60                  | 
| 2002 | 101.20                 | 
| 2003 | 104.90                 | 
| 2004 | 107.60                 | 
| 2005 | 115.90                 | 
| 2006 | 119.20                 | 
| 2007 | 123.60                 | 
| 2008 | 132.70                 | 
| 2009 | 142.80                 | 
| 2010 | 148.90                 | 
| 2011 | 145.40                 | 
| 2012 | 148.60                 | 
| 2013 | 147.70                 | 
| 2014 | 149.60                 | 
| 2015 | 152.90                 | 
```

Return to the **[index](#data)**

### France

#### Debt

**Script 11.1**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value/10000 AS 'Debt (Billion Euro)'
  FROM 'france'
```

**Table 11.1**

```ls
| Year | Debt (Billion Euro) | 
|------|---------------------| 
| 1995 | 113.87              | 
| 1996 | 116.54              | 
| 1997 | 119.90              | 
| 1998 | 123.39              | 
| 1999 | 133.36              | 
| 2000 | 147.05              | 
| 2001 | 159.68              | 
| 2002 | 164.89              | 
| 2003 | 169.25              | 
| 2004 | 179.22              | 
| 2005 | 193.53              | 
| 2006 | 208.65              | 
| 2007 | 225.01              | 
| 2008 | 243.93              | 
| 2009 | 253.05              | 
| 2010 | 263.43              | 
| 2011 | 278.67              | 
| 2012 | 289.04              | 
| 2013 | 291.36              | 
| 2014 | 304.76              | 
| 2015 | 314.74              | 
```

#### Debt as Percent of GDP

**Script 11.2**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value AS 'Debt as Percent of GDP'
  FROM '%france'
```

**Table 11.2**

```ls
| Year | Debt as Percent of GDP | 
|------|------------------------| 
| 1995 | 93.00                  | 
| 1996 | 92.60                  | 
| 1997 | 92.30                  | 
| 1998 | 90.80                  | 
| 1999 | 94.70                  | 
| 2000 | 99.00                  | 
| 2001 | 103.40                 | 
| 2002 | 103.40                 | 
| 2003 | 103.40                 | 
| 2004 | 104.80                 | 
| 2005 | 109.20                 | 
| 2006 | 112.60                 | 
| 2007 | 115.60                 | 
| 2008 | 122.20                 | 
| 2009 | 130.50                 | 
| 2010 | 131.80                 | 
| 2011 | 135.30                 | 
| 2012 | 138.50                 | 
| 2013 | 137.70                 | 
| 2014 | 141.90                 | 
| 2015 | 143.40                 | 
```

Return to the **[index](#data)**

### Germany

#### Debt

**Script 12.1**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value/10000 AS 'Debt (Billion Euro)'
  FROM 'germany'
```

**Table 12.1**

```ls
| Year | Debt (Billion Euro) | 
|------|---------------------| 
| 1995 | 200.58              | 
| 1996 | 212.30              | 
| 1997 | 222.22              | 
| 1998 | 235.44              | 
| 1999 | 247.11              | 
| 2000 | 260.33              | 
| 2001 | 268.33              | 
| 2002 | 269.74              | 
| 2003 | 272.88              | 
| 2004 | 269.97              | 
| 2005 | 269.09              | 
| 2006 | 272.91              | 
| 2007 | 278.60              | 
| 2008 | 280.96              | 
| 2009 | 278.07              | 
| 2010 | 275.30              | 
| 2011 | 276.91              | 
| 2012 | 281.05              | 
| 2013 | 289.81              | 
| 2014 | 290.47              | 
| 2015 | 298.85              | 
```

#### Debt as Percent of GDP

**Script 12.2**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value AS 'Debt as Percent of GDP'
  FROM '%germany'
```

**Table 12.2**

```ls
| Year | Debt as Percent of GDP | 
|------|------------------------| 
| 1995 | 105.60                 | 
| 1996 | 110.20                 | 
| 1997 | 113.00                 | 
| 1998 | 116.70                 | 
| 1999 | 119.70                 | 
| 2000 | 123.00                 | 
| 2001 | 123.10                 | 
| 2002 | 122.10                 | 
| 2003 | 122.90                 | 
| 2004 | 118.90                 | 
| 2005 | 117.00                 | 
| 2006 | 114.00                 | 
| 2007 | 110.90                 | 
| 2008 | 109.70                 | 
| 2009 | 113.00                 | 
| 2010 | 106.70                 | 
| 2011 | 102.40                 | 
| 2012 | 101.90                 | 
| 2013 | 102.50                 | 
| 2014 | 99.30                  | 
| 2015 | 98.50                  | 
```

Return to the **[index](#data)**

### Greece

#### Debt

**Script 13.1**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value/10000 AS 'Debt (Billion Euro)'
  FROM 'greece'
```

**Table 13.1**

```ls
| Year | Debt (Billion Euro) | 
|------|---------------------| 
| 1995 | 3.32                | 
| 1996 | 3.74                | 
| 1997 | 4.24                | 
| 1998 | 5.06                | 
| 1999 | 5.86                | 
| 2000 | 7.46                | 
| 2001 | 9.13                | 
| 2002 | 10.42               | 
| 2003 | 12.15               | 
| 2004 | 14.26               | 
| 2005 | 17.07               | 
| 2006 | 20.16               | 
| 2007 | 23.62               | 
| 2008 | 27.36               | 
| 2009 | 27.67               | 
| 2010 | 28.95               | 
| 2011 | 26.96               | 
| 2012 | 25.14               | 
| 2013 | 23.33               | 
| 2014 | 22.86               | 
| 2015 | 22.20               | 
```

#### Debt as Percent of GDP

**Script 13.2**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value AS 'Debt as Percent of GDP'
  FROM '%greece'
```

**Table 13.2**

```ls
| Year | Debt as Percent of GDP | 
|------|------------------------| 
| 1995 | 35.70                  | 
| 1996 | 36.30                  | 
| 1997 | 37.00                  | 
| 1998 | 40.40                  | 
| 1999 | 43.80                  | 
| 2000 | 52.80                  | 
| 2001 | 60.00                  | 
| 2002 | 63.80                  | 
| 2003 | 67.90                  | 
| 2004 | 73.60                  | 
| 2005 | 85.70                  | 
| 2006 | 92.50                  | 
| 2007 | 101.50                 | 
| 2008 | 113.00                 | 
| 2009 | 116.50                 | 
| 2010 | 128.10                 | 
| 2011 | 130.20                 | 
| 2012 | 131.50                 | 
| 2013 | 129.10                 | 
| 2014 | 128.50                 | 
| 2015 | 126.40                 | 
```

Return to the **[index](#data)**

### Hungary

#### Debt

**Script 14.1**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value/10000 AS 'Debt (Billion Euro)'
  FROM 'hungary'
```

**Table 14.1**

```ls
| Year | Debt (Billion Euro) | 
|------|---------------------| 
| 1995 | 238.20              | 
| 1996 | 304.67              | 
| 1997 | 393.54              | 
| 1998 | 466.99              | 
| 1999 | 570.79              | 
| 2000 | 746.49              | 
| 2001 | 884.05              | 
| 2002 | 983.64              | 
| 2003 | 1289.40             | 
| 2004 | 1482.85             | 
| 2005 | 1780.23             | 
| 2006 | 2022.32             | 
| 2007 | 2406.46             | 
| 2008 | 2854.74             | 
| 2009 | 3075.68             | 
| 2010 | 3129.19             | 
| 2011 | 3236.93             | 
| 2012 | 2924.80             | 
| 2013 | 2875.53             | 
| 2014 | 2960.70             | 
| 2015 | 2878.66             | 
```

#### Debt as Percent of GDP

**Script 14.2**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value AS 'Debt as Percent of GDP'
  FROM '%hungary'
```

**Table 14.2**

```ls
| Year | Debt as Percent of GDP | 
|------|------------------------| 
| 1995 | 40.90                  | 
| 1996 | 42.90                  | 
| 1997 | 44.70                  | 
| 1998 | 44.80                  | 
| 1999 | 49.00                  | 
| 2000 | 56.00                  | 
| 2001 | 57.50                  | 
| 2002 | 56.50                  | 
| 2003 | 67.60                  | 
| 2004 | 70.50                  | 
| 2005 | 79.20                  | 
| 2006 | 83.70                  | 
| 2007 | 94.10                  | 
| 2008 | 105.50                 | 
| 2009 | 117.00                 | 
| 2010 | 115.50                 | 
| 2011 | 114.90                 | 
| 2012 | 102.00                 | 
| 2013 | 95.40                  | 
| 2014 | 91.40                  | 
| 2015 | 84.70                  | 
```

Return to the **[index](#data)**

### Ireland

##### Debt

**Script 15.1**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value/10000 AS 'Debt (Billion Euro)'
  FROM 'ireland'
```

**Table 15.1**

```ls
| Year | Debt (Billion Euro) | 
|------|---------------------| 
| 2001 | 16.99               | 
| 2002 | 18.69               | 
| 2003 | 20.57               | 
| 2004 | 23.34               | 
| 2005 | 28.95               | 
| 2006 | 35.25               | 
| 2007 | 39.06               | 
| 2008 | 44.39               | 
| 2009 | 43.56               | 
| 2010 | 43.11               | 
| 2011 | 46.88               | 
| 2012 | 48.99               | 
| 2013 | 48.17               | 
| 2014 | 54.33               | 
| 2015 | 77.61               | 
```

#### Debt as Percent of GDP

**Script 15.2**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value AS 'Debt as Percent of GDP'
  FROM '%ireland'
```

**Table 15.2**

```ls
| Year | Debt as Percent of GDP | 
|------|------------------------| 
| 2001 | 139.30                 | 
| 2002 | 137.40                 | 
| 2003 | 141.30                 | 
| 2004 | 149.50                 | 
| 2005 | 170.10                 | 
| 2006 | 190.60                 | 
| 2007 | 198.10                 | 
| 2008 | 236.40                 | 
| 2009 | 256.10                 | 
| 2010 | 257.20                 | 
| 2011 | 272.70                 | 
| 2012 | 279.10                 | 
| 2013 | 267.10                 | 
| 2014 | 279.30                 | 
| 2015 | 296.20                 | 
```

Return to the **[index](#data)**

### Italy

#### Debt

**Script 16.1**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value/10000 AS 'Debt (Billion Euro)'
  FROM 'italy'
```

**Table 16.1**

```ls
| Year | Debt (Billion Euro) | 
|------|---------------------| 
| 1995 | 67.44               | 
| 1996 | 69.22               | 
| 1997 | 71.93               | 
| 1998 | 75.64               | 
| 1999 | 84.11               | 
| 2000 | 93.99               | 
| 2001 | 103.57              | 
| 2002 | 111.25              | 
| 2003 | 119.97              | 
| 2004 | 130.01              | 
| 2005 | 142.96              | 
| 2006 | 158.31              | 
| 2007 | 176.55              | 
| 2008 | 185.85              | 
| 2009 | 192.69              | 
| 2010 | 197.82              | 
| 2011 | 200.96              | 
| 2012 | 201.87              | 
| 2013 | 195.52              | 
| 2014 | 194.55              | 
| 2015 | 192.17              | 
```

#### Debt as Percent of GDP

**Script 16.2**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value AS 'Debt as Percent of GDP'
  FROM '%italy'
```

**Table 16.2**

```ls
| Year | Debt as Percent of GDP | 
|------|------------------------| 
| 1995 | 68.50                  | 
| 1996 | 66.40                  | 
| 1997 | 66.00                  | 
| 1998 | 66.60                  | 
| 1999 | 71.80                  | 
| 2000 | 75.80                  | 
| 2001 | 79.70                  | 
| 2002 | 82.70                  | 
| 2003 | 86.30                  | 
| 2004 | 89.80                  | 
| 2005 | 96.00                  | 
| 2006 | 102.20                 | 
| 2007 | 109.70                 | 
| 2008 | 113.90                 | 
| 2009 | 122.50                 | 
| 2010 | 123.30                 | 
| 2011 | 122.70                 | 
| 2012 | 125.10                 | 
| 2013 | 121.90                 | 
| 2014 | 120.00                 | 
| 2015 | 116.80                 | 
```

Return to the **[index](#data)**

### Latvia

#### Debt

**Script 17.1**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value/10000 AS 'Debt (Billion Euro)'
  FROM 'latvia'
```

**Table 17.1**

```ls
| Year | Debt (Billion Euro) | 
|------|---------------------| 
| 2004 | 0.71                | 
| 2005 | 1.10                | 
| 2006 | 1.66                | 
| 2007 | 2.32                | 
| 2008 | 2.54                | 
| 2009 | 2.36                | 
| 2010 | 2.40                | 
| 2011 | 2.34                | 
| 2012 | 2.14                | 
| 2013 | 2.11                | 
| 2014 | 2.27                | 
| 2015 | 2.16                | 
```

#### Debt as Percent of GDP

**Script 17.2**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value AS 'Debt as Percent of GDP'
  FROM '%latvia'
```

**Table 17.2**

```ls
| Year | Debt as Percent of GDP | 
|------|------------------------| 
| 2004 | 64.00                  | 
| 2005 | 81.10                  | 
| 2006 | 97.20                  | 
| 2007 | 102.60                 | 
| 2008 | 104.50                 | 
| 2009 | 125.40                 | 
| 2010 | 134.00                 | 
| 2011 | 115.30                 | 
| 2012 | 97.90                  | 
| 2013 | 92.60                  | 
| 2014 | 96.20                  | 
| 2015 | 88.70                  | 
```

Return to the **[index](#data)**

### Lithuania

#### Debt

**Script 18.1**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value/10000 AS 'Debt (Billion Euro)'
  FROM 'lithuania'
```

**Table 18.1**

```sql
| Year | Debt (Billion Euro) | 
|------|---------------------| 
| 1995 | 0.16                | 
| 1996 | 0.20                | 
| 1997 | 0.27                | 
| 1998 | 0.33                | 
| 1999 | 0.38                | 
| 2000 | 0.40                | 
| 2001 | 0.42                | 
| 2002 | 0.45                | 
| 2003 | 0.58                | 
| 2004 | 0.74                | 
| 2005 | 1.05                | 
| 2006 | 1.50                | 
| 2007 | 2.17                | 
| 2008 | 2.51                | 
| 2009 | 2.24                | 
| 2010 | 2.09                | 
| 2011 | 2.02                | 
| 2012 | 2.04                | 
| 2013 | 1.97                | 
| 2014 | 1.97                | 
| 2015 | 2.05                | 
```

#### Debt as Percent of GDP

**Script 18.2**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value AS 'Debt as Percent of GDP'
  FROM '%lithuania'
```

**Table 18.2**

```ls
| Year | Debt as Percent of GDP | 
|------|------------------------| 
| 1995 | 21.00                  | 
| 1996 | 20.90                  | 
| 1997 | 23.30                  | 
| 1998 | 25.40                  | 
| 1999 | 29.80                  | 
| 2000 | 30.10                  | 
| 2001 | 29.30                  | 
| 2002 | 29.70                  | 
| 2003 | 34.90                  | 
| 2004 | 40.40                  | 
| 2005 | 50.20                  | 
| 2006 | 62.40                  | 
| 2007 | 74.70                  | 
| 2008 | 76.70                  | 
| 2009 | 83.30                  | 
| 2010 | 74.50                  | 
| 2011 | 64.70                  | 
| 2012 | 61.10                  | 
| 2013 | 56.30                  | 
| 2014 | 54.00                  | 
| 2015 | 55.00                  | 
```

Return to the **[index](#data)**

### Luxembourg

#### Debt

**Script 19.1**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value/10000 AS 'Debt (Billion Euro)'
  FROM 'luxembourg'
```

**Table 19.1**

```ls
| Year | Debt (Billion Euro) | 
|------|---------------------| 
| 2002 | 6.05                | 
| 2003 | 6.22                | 
| 2004 | 7.08                | 
| 2005 | 6.01                | 
| 2006 | 6.76                | 
| 2007 | 14.79               | 
| 2008 | 13.45               | 
| 2009 | 12.70               | 
| 2010 | 12.07               | 
| 2011 | 14.07               | 
| 2012 | 15.42               | 
| 2013 | 14.89               | 
| 2014 | 16.16               | 
| 2015 | 17.57               | 
```

#### Debt as Percent of GDP

**Script 19.2**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value AS 'Debt as Percent of GDP'
  FROM '%luxembourg'
```

**Table 19.2**

```ls
| Year | Debt as Percent of GDP | 
|------|------------------------| 
| 2002 | 241.00                 | 
| 2003 | 237.50                 | 
| 2004 | 253.60                 | 
| 2005 | 200.10                 | 
| 2006 | 200.00                 | 
| 2007 | 397.90                 | 
| 2008 | 352.90                 | 
| 2009 | 343.40                 | 
| 2010 | 300.40                 | 
| 2011 | 326.00                 | 
| 2012 | 349.50                 | 
| 2013 | 319.90                 | 
| 2014 | 323.30                 | 
| 2015 | 335.80                 | 
```

Return to the **[index](#data)**

### Malta

#### Debt

**Script 20.1**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value/10000 AS 'Debt (Billion Euro)'
  FROM 'malta'
```

**Table 20.1**

```ls
| Year | Debt (Billion Euro) | 
|------|---------------------| 
| 2004 | 0.62                | 
| 2005 | 0.68                | 
| 2006 | 0.76                | 
| 2007 | 0.84                | 
| 2008 | 0.94                | 
| 2009 | 1.03                | 
| 2010 | 1.07                | 
| 2011 | 1.09                | 
| 2012 | 1.11                | 
| 2013 | 1.12                | 
| 2014 | 1.19                | 
| 2015 | 1.22                | 
```

#### Debt as Percent of GDP

**Script 20.2**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value AS 'Debt as Percent of GDP'
  FROM '%malta'
```

**Table 20.2**

```ls
| Year | Debt as Percent of GDP | 
|------|------------------------| 
| 2004 | 127.70                 | 
| 2005 | 132.80                 | 
| 2006 | 142.00                 | 
| 2007 | 145.30                 | 
| 2008 | 152.90                 | 
| 2009 | 167.60                 | 
| 2010 | 162.00                 | 
| 2011 | 159.50                 | 
| 2012 | 154.70                 | 
| 2013 | 147.40                 | 
| 2014 | 140.60                 | 
| 2015 | 131.80                 | 
```

Return to the **[index](#data)**

### Netherlands

#### Debt

**Script 21.1**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value/10000 AS 'Debt (Billion Euro)'
  FROM 'netherlands'
```

**Table 21.1**

```ls
| Year | Debt (Billion Euro) | 
|------|---------------------| 
| 1995 | 59.49               | 
| 1996 | 63.34               | 
| 1997 | 67.39               | 
| 1998 | 74.26               | 
| 1999 | 82.95               | 
| 2000 | 92.45               | 
| 2001 | 98.84               | 
| 2002 | 103.32              | 
| 2003 | 109.42              | 
| 2004 | 111.28              | 
| 2005 | 117.58              | 
| 2006 | 124.70              | 
| 2007 | 131.79              | 
| 2008 | 138.23              | 
| 2009 | 141.32              | 
| 2010 | 142.61              | 
| 2011 | 144.64              | 
| 2012 | 145.71              | 
| 2013 | 145.85              | 
| 2014 | 149.66              | 
| 2015 | 153.83              | 
```

#### Debt as Percent of GDP

**Script 21.2**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value AS 'Debt as Percent of GDP'
  FROM '%netherlands'
```

**Table 21.2**

```ls
| Year | Debt as Percent of GDP | 
|------|------------------------| 
| 1995 | 182.90                 | 
| 1996 | 185.80                 | 
| 1997 | 184.60                 | 
| 1998 | 190.70                 | 
| 1999 | 200.00                 | 
| 2000 | 206.30                 | 
| 2001 | 207.30                 | 
| 2002 | 208.90                 | 
| 2003 | 216.00                 | 
| 2004 | 212.40                 | 
| 2005 | 215.50                 | 
| 2006 | 215.30                 | 
| 2007 | 214.90                 | 
| 2008 | 216.30                 | 
| 2009 | 228.80                 | 
| 2010 | 225.80                 | 
| 2011 | 225.00                 | 
| 2012 | 225.90                 | 
| 2013 | 223.40                 | 
| 2014 | 225.70                 | 
| 2015 | 225.10                 | 
```

Return to the **[index](#data)**

### Poland

#### Debt

**Script 22.1**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value/10000 AS 'Debt (Billion Euro)'
  FROM 'poland'
```

**Table 22.1**

```ls
| Year | Debt (Billion Euro) | 
|------|---------------------| 
| 2003 | 39.15               | 
| 2004 | 38.60               | 
| 2005 | 41.62               | 
| 2006 | 50.92               | 
| 2007 | 64.59               | 
| 2008 | 86.52               | 
| 2009 | 92.04               | 
| 2010 | 100.76              | 
| 2011 | 115.82              | 
| 2012 | 119.66              | 
| 2013 | 124.94              | 
| 2014 | 134.31              | 
| 2015 | 141.68              | 
```

#### Debt as Percent of GDP

**Script 22.2**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value AS 'Debt as Percent of GDP'
  FROM '%poland'
```

**Table 22.2**

```ls
| Year | Debt as Percent of GDP | 
|------|------------------------| 
| 2003 | 46.30                  | 
| 2004 | 41.40                  | 
| 2005 | 42.00                  | 
| 2006 | 47.60                  | 
| 2007 | 54.40                  | 
| 2008 | 67.30                  | 
| 2009 | 67.10                  | 
| 2010 | 69.70                  | 
| 2011 | 73.90                  | 
| 2012 | 73.40                  | 
| 2013 | 75.40                  | 
| 2014 | 78.10                  | 
| 2015 | 78.70                  | 
```

Return to the **[index](#data)**

### Portugal

#### Debt

**Script 23.1**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value/10000 AS 'Debt (Billion Euro)'
  FROM 'portugal'
```

**Table 23.1**

```ls
| Year | Debt (Billion Euro) | 
|------|---------------------| 
| 1995 | 7.26                | 
| 1996 | 8.30                | 
| 1997 | 9.66                | 
| 1998 | 12.13               | 
| 1999 | 14.89               | 
| 2000 | 17.61               | 
| 2001 | 20.34               | 
| 2002 | 22.23               | 
| 2003 | 23.67               | 
| 2004 | 25.27               | 
| 2005 | 27.19               | 
| 2006 | 29.34               | 
| 2007 | 32.47               | 
| 2008 | 35.10               | 
| 2009 | 35.82               | 
| 2010 | 36.25               | 
| 2011 | 35.96               | 
| 2012 | 35.42               | 
| 2013 | 34.61               | 
| 2014 | 33.10               | 
| 2015 | 32.37               | 
```

#### Debt as Percent of GDP

**Script 23.2**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value AS 'Debt as Percent of GDP'
  FROM '%portugal'
```

**Table 23.2**
```ls
| Year | Debt as Percent of GDP | 
|------|------------------------| 
| 1995 | 81.50                  | 
| 1996 | 87.90                  | 
| 1997 | 94.40                  | 
| 1998 | 108.90                 | 
| 1999 | 124.50                 | 
| 2000 | 137.10                 | 
| 2001 | 149.80                 | 
| 2002 | 155.90                 | 
| 2003 | 162.00                 | 
| 2004 | 165.80                 | 
| 2005 | 171.40                 | 
| 2006 | 176.50                 | 
| 2007 | 185.00                 | 
| 2008 | 196.20                 | 
| 2009 | 204.20                 | 
| 2010 | 201.50                 | 
| 2011 | 204.10                 | 
| 2012 | 210.30                 | 
| 2013 | 203.30                 | 
| 2014 | 191.20                 | 
```

Return to the **[index](#data)**

### Romania

#### Debt

**Script 24.1**

``sql
SELECT date_format(time, 'yyyy') AS 'Year', value/10000 AS 'Debt (Billion Euro)'
  FROM 'romania'
``

**Table 24.1**

```ls
| Year | Debt (Billion Euro) | 
|------|---------------------| 
| 1998 | 1.34                | 
| 1999 | 1.57                | 
| 2000 | 2.16                | 
| 2001 | 3.13                | 
| 2002 | 4.70                | 
| 2003 | 6.52                | 
| 2004 | 8.23                | 
| 2005 | 11.35               | 
| 2006 | 15.43               | 
| 2007 | 24.16               | 
| 2008 | 34.37               | 
| 2009 | 36.72               | 
| 2010 | 39.44               | 
| 2011 | 41.19               | 
| 2012 | 42.80               | 
| 2013 | 42.45               | 
| 2014 | 41.49               | 
| 2015 | 42.14               | 
```

#### Debt as Percent of GDP

**Script 24.2**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value AS 'Debt as Percent of GDP'
  FROM '%romania'
```

**Table 24.2**

```ls
| Year | Debt as Percent of GDP | 
|------|------------------------| 
| 1998 | 35.90                  | 
| 1999 | 28.20                  | 
| 2000 | 26.60                  | 
| 2001 | 26.50                  | 
| 2002 | 30.80                  | 
| 2003 | 32.80                  | 
| 2004 | 33.10                  | 
| 2005 | 39.10                  | 
| 2006 | 44.50                  | 
| 2007 | 57.80                  | 
| 2008 | 65.50                  | 
| 2009 | 71.90                  | 
| 2010 | 73.90                  | 
| 2011 | 72.90                  | 
| 2012 | 71.90                  | 
| 2013 | 66.60                  | 
| 2014 | 62.10                  | 
```

Return to the **[index](#data)**

### Slovakia

#### Debt

**Script 25.1**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value/10000 AS 'Debt (Billion Euro)'
  FROM 'slovakia'
```

**Table 25.1**

```ls
| Year | Debt (Billion Euro) | 
|------|---------------------| 
| 1995 | 1.31                | 
| 1996 | 1.34                | 
| 1997 | 1.44                | 
| 1998 | 1.67                | 
| 1999 | 1.68                | 
| 2000 | 1.50                | 
| 2001 | 1.65                | 
| 2002 | 1.92                | 
| 2003 | 1.95                | 
| 2004 | 2.16                | 
| 2005 | 2.46                | 
| 2006 | 2.91                | 
| 2007 | 3.81                | 
| 2008 | 4.44                | 
| 2009 | 4.43                | 
| 2010 | 4.56                | 
| 2011 | 4.96                | 
| 2012 | 5.14                | 
| 2013 | 5.49                | 
| 2014 | 5.89                | 
| 2015 | 6.41                | 
```

#### Debt as Percent of GDP

**Script 25.2**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value AS 'Debt as Percent of GDP'
  FROM '%slovakia'
```

**Table 25.2**

```ls
| Year | Debt as Percent of GDP | 
|------|------------------------| 
| 1995 | 66.70                  | 
| 1996 | 60.90                  | 
| 1997 | 59.20                  | 
| 1998 | 62.70                  | 
| 1999 | 58.90                  | 
| 2000 | 47.60                  | 
| 2001 | 48.00                  | 
| 2002 | 51.60                  | 
| 2003 | 47.00                  | 
| 2004 | 46.80                  | 
| 2005 | 48.80                  | 
| 2006 | 51.80                  | 
| 2007 | 60.40                  | 
| 2008 | 64.90                  | 
| 2009 | 69.20                  | 
| 2010 | 67.40                  | 
| 2011 | 70.20                  | 
| 2012 | 70.60                  | 
| 2013 | 74.00                  | 
| 2014 | 77.60                  | 
| 2015 | 81.40                  | 
```

Return to the **[index](#data)**

### Slovenia

#### Debt

**Script 26.1**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value/10000 AS 'Debt (Billion Euro)'
  FROM 'slovenia'
```

**Table 26.1**

```sql
| Year | Debt (Billion Euro) | 
|------|---------------------| 
| 2001 | 1.21                | 
| 2002 | 1.39                | 
| 2003 | 1.62                | 
| 2004 | 1.86                | 
| 2005 | 2.23                | 
| 2006 | 2.60                | 
| 2007 | 3.39                | 
| 2008 | 4.01                | 
| 2009 | 4.11                | 
| 2010 | 4.17                | 
| 2011 | 4.17                | 
| 2012 | 4.05                | 
| 2013 | 3.89                | 
| 2014 | 3.66                | 
| 2015 | 3.37                | 
```

#### Debt as Percent of GDP

**Script 26.2**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value AS 'Debt as Percent of GDP'
  FROM '%slovenia'
```

**Table 26.2**

```ls
| Year | Debt as Percent of GDP | 
|------|------------------------| 
| 2001 | 57.40                  | 
| 2002 | 58.90                  | 
| 2003 | 62.90                  | 
| 2004 | 67.10                  | 
| 2005 | 76.30                  | 
| 2006 | 82.50                  | 
| 2007 | 96.30                  | 
| 2008 | 105.60                 | 
| 2009 | 113.50                 | 
| 2010 | 115.10                 | 
| 2011 | 113.00                 | 
| 2012 | 112.50                 | 
| 2013 | 108.20                 | 
| 2014 | 98.10                  | 
| 2015 | 87.30                  | 
```

Return to the **[index](#data)**

### Spain

#### Debt

**Script 27.1**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value/10000 AS 'Debt (Billion Euro)'
  FROM 'spain'
```

**Table 27.1**

```ls
| Year | Debt (Billion Euro) | 
|------|---------------------| 
| 1995 | 34.22               | 
| 1996 | 36.51               | 
| 1997 | 40.52               | 
| 1998 | 46.84               | 
| 1999 | 55.65               | 
| 2000 | 66.27               | 
| 2001 | 76.54               | 
| 2002 | 86.95               | 
| 2003 | 101.23              | 
| 2004 | 118.26              | 
| 2005 | 143.59              | 
| 2006 | 178.69              | 
| 2007 | 206.67              | 
| 2008 | 218.42              | 
| 2009 | 217.27              | 
| 2010 | 216.56              | 
| 2011 | 209.97              | 
| 2012 | 195.24              | 
| 2013 | 181.19              | 
| 2014 | 171.50              | 
| 2015 | 167.23              | 
```

#### Debt as Percent of GDP

**Script 27.2**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value AS 'Debt as Percent of GDP'
  FROM '%spain'
```

**Table 27.2**

```ls
| Year | Debt as Percent of GDP | 
|------|------------------------| 
| 1995 | 74.50                  | 
| 1996 | 74.80                  | 
| 1997 | 78.20                  | 
| 1998 | 84.50                  | 
| 1999 | 93.60                  | 
| 2000 | 102.50                 | 
| 2001 | 109.40                 | 
| 2002 | 116.00                 | 
| 2003 | 126.00                 | 
| 2004 | 137.30                 | 
| 2005 | 154.30                 | 
| 2006 | 177.30                 | 
| 2007 | 191.20                 | 
| 2008 | 195.70                 | 
| 2009 | 201.40                 | 
| 2010 | 200.30                 | 
| 2011 | 196.20                 | 
| 2012 | 187.80                 | 
| 2013 | 176.70                 | 
| 2014 | 165.40                 | 
| 2015 | 155.50                 | 
```

Return to the **[index](#data)**

### Sweden

#### Debt

**Script 28.1**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value/10000 AS 'Debt (Billion Euro)'
  FROM 'sweden'
```

**Table 28.1**

```ls
| Year | Debt (Billion Euro) | 
|------|---------------------| 
| 1995 | 219.37              | 
| 1996 | 224.38              | 
| 1997 | 249.66              | 
| 1998 | 270.09              | 
| 1999 | 297.35              | 
| 2000 | 324.93              | 
| 2001 | 356.50              | 
| 2002 | 378.80              | 
| 2003 | 387.80              | 
| 2004 | 404.98              | 
| 2005 | 441.52              | 
| 2006 | 477.36              | 
| 2007 | 553.55              | 
| 2008 | 640.41              | 
| 2009 | 662.50              | 
| 2010 | 665.40              | 
| 2011 | 697.49              | 
| 2012 | 708.45              | 
| 2013 | 724.36              | 
| 2014 | 757.12              | 
| 2015 | 784.11              | 
```

#### Debt as Percent of GDP

**Script 28.2**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value AS 'Debt as Percent of GDP'
  FROM '%sweden'
```

**Table 28.2**

```ls
| Year | Debt as Percent of GDP | 
|------|------------------------| 
| 1995 | 116.50                 | 
| 1996 | 116.10                 | 
| 1997 | 123.60                 | 
| 1998 | 127.30                 | 
| 1999 | 132.90                 | 
| 2000 | 136.50                 | 
| 2001 | 143.90                 | 
| 2002 | 147.40                 | 
| 2003 | 144.80                 | 
| 2004 | 144.40                 | 
| 2005 | 151.90                 | 
| 2006 | 154.00                 | 
| 2007 | 167.90                 | 
| 2008 | 189.00                 | 
| 2009 | 201.50                 | 
| 2010 | 189.00                 | 
| 2011 | 190.70                 | 
| 2012 | 192.30                 | 
| 2013 | 192.10                 | 
| 2014 | 192.30                 | 
| 2015 | 187.50                 | 
```

Return to the **[index](#data)**

### United Kingdom

#### Debt

**Script 29.1**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value/10000 AS 'Debt (Billion Euro)'
  FROM 'unitedkingdom'
```

**Table 29.1**

```ls
| Year | Debt (Billion Euro) | 
|------|---------------------| 
| 1995 | 93.70               | 
| 1996 | 96.06               | 
| 1997 | 103.28              | 
| 1998 | 115.06              | 
| 1999 | 130.04              | 
| 2000 | 142.08              | 
| 2001 | 157.38              | 
| 2002 | 174.13              | 
| 2003 | 184.71              | 
| 2004 | 200.00              | 
| 2005 | 223.78              | 
| 2006 | 244.13              | 
| 2007 | 263.43              | 
| 2008 | 283.90              | 
| 2009 | 281.79              | 
| 2010 | 276.01              | 
| 2011 | 281.84              | 
| 2012 | 291.42              | 
| 2013 | 291.92              | 
| 2014 | 291.58              | 
| 2015 | 295.27              | 
```

#### Debt as Percent of GDP

**Script 29.2**

```sql
SELECT date_format(time, 'yyyy') AS 'Year', value AS 'Debt as Percent of GDP'
  FROM '%unitedkingdom'
```

**Table 29.2**

```ls
| Year | Debt as Percent of GDP | 
|------|------------------------| 
| 1995 | 112.00                 | 
| 1996 | 107.60                 | 
| 1997 | 110.00                 | 
| 1998 | 117.40                 | 
| 1999 | 127.30                 | 
| 2000 | 131.50                 | 
| 2001 | 140.40                 | 
| 2002 | 148.50                 | 
| #### Debt as Percent of GDP2003 | 148.70                 | 
| 2004 | 153.30                 | 
| 2005 | 162.20                 | 
| 2006 | 167.70                 | 
| 2007 | 172.10                 | 
| 2008 | 181.50                 | 
| 2009 | 185.50                 | 
| 2010 | 175.50                 | 
| 2011 | 173.10                 | 
| 2012 | 174.00                 | 
| 2013 | 167.80                 | 
| 2014 | 160.00                 | 
| 2015 | 157.70                 | 
```

Return to the **[index](#data)**