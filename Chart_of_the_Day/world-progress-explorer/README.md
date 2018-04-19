# The World Progress Explorer: In-Depth Visualization with SQL and User-Defined Functions

![](images/wps-title.png)
[![](images/button-new.png)](https://trends.axibase.com/ecb8def7#fullscreen)

### Introduction

The **World Progress Scorecard** is an aggregation of many statistics that are collected by various international agencies including the [World Bank](http://www.worldbank.org/) and [United Nations Statistical Division](https://unstats.un.org/home/) and retrieved from the [Federal Reserve Economic Research](https://fred.stlouisfed.org/) API. 

Open the **TRENDS** visualization above and use the drop-down menus to navigate between all countries which have recorded data, grouped in alphabetically ascending order. The observed metric may be changed using the right-most drop-down menu. The metrics tracked in the visualization are described in the table below:

|Metric Name |Description |
|------------|------------|
|adolescent_fertility_rate_by_country | Recorded births by women aged 15-19 |
|age_dependency_ratio_by_country | Population aged 0-14 or 65+ |
|crude_birth_rate_by_country| Recorded births by women aged 15-65 per 100,000 members of a population|
|fertility_rate_total_by_country|Recorded births by women aged 15-65 per 100,000 women|
|infant_mortality_rate_by_country| Recorded deaths of infants under 1 year old per 1000 live births|
|life_expectancy_at_birth_by_country|Number of years a newborn is predicted to live given constant mortality figures|
|population_total_by_country| Recorded number of people living in a given country|

For detailed information about using the **TRENDS** service, read this [guide](/../master/how-to/shared/trends.md).

### Visualization

The visualizations in the chart above demonstrate a [user-defined function](/../master/how-to/shared/trends.md#user-defined-functions) which sets the year 1990 as the baseline using the [`fred.js`](https://apps-chartlab.axibase.com/portal/resource/scripts/fred.js) library. Using the `PercentChangeFromYearAgo` function instead creates the visualization below. Open the **TRENDS** interface and explore the data using the same drop-down menus to navigate between countries and metrics.

![](images/wps-1.png)
[![](images/button-new.png)](https://trends.axibase.com/5d0563d2#fullscreen)

Axibase [Charts API](https://axibase.com/products/axibase-time-series-database/visualization/widgets/) uses a simple syntax with robust functionality. The underlying mechanics of the `PercentChangeFromYearAgo` function are shown here:

```
value = var v = value('cpi'); var p = value('prev_cpi'); if(p!=null && v!=null) return (v / p - 1) * 100
```

To implement this function, the following syntax is used:

```sql
value = fred.PercentChangeFromYearAgo('raw')
```

Open the **TRENDS** visualization and use any of the supported user-defined functions from the [`fred.js` library](/../master/how-to/shared/trends.md#fred-library).

### SQL Queries

Although a non-relational database, ATSD supports an SQL-like feature called [SQL Console](https://github.com/axibase/atsd/tree/master/sql#overview), a convenient interface which lets users quickly query data.

#### Greatest Life Expectancy for Year 2015

```sql
SELECT year(time) AS "Year",
  tags.country AS "Country",
  value AS "Life Expectancy"
FROM "life_expectancy_at_birth_by_country"
  WHERE "Year" = 2015
ORDER BY "Life Expectancy" DESC
  LIMIT 10
```

Query uses the following clauses:
* [`FROM`](https://github.com/axibase/atsd/tree/master/sql#virtual-table)
* [Alias / `AS`](https://github.com/axibase/atsd/tree/master/sql#aliases)
* [`WHERE`](https://github.com/axibase/atsd/tree/master/sql#where-clause)
* [`LIMIT`](https://github.com/axibase/atsd/tree/master/sql#limiting)
* [`ORDER BY`](https://github.com/axibase/atsd/tree/master/sql#ordering)

| Year | Country           | Life Expectancy | 
|------|-------------------|-----------------| 
| 2015 | Hong Kong         | 84              | 
| 2015 | Macao             | 84              | 
| 2015 | Spain             | 83              | 
| 2015 | Switzerland       | 83              | 
| 2015 | Singapore         | 83              | 
| 2015 | Sweden            | 83              | 
| 2015 | Australia         | 82              | 
| 2015 | Luxembourg        | 82              | 
| 2015 | Republic of Korea | 82              | 
| 2015 | Canada            | 82              | 

#### Lowest Life Expectancy at Birth for Year 2015

```sql
SELECT year(time) AS "Year",
  tags.country AS "Country",
  value AS "Life Expectancy"
FROM "life_expectancy_at_birth_by_country"
  WHERE "Year" = 2015
ORDER BY "Life Expectancy" ASC
  LIMIT 10
```

| Year | Country                   | Life Expectancy | 
|------|---------------------------|-----------------| 
| 2015 | Central African Republic  | 51              | 
| 2015 | Sierra Leone              | 51              | 
| 2015 | Chad                      | 53              | 
| 2015 | Nigeria                   | 53              | 
| 2015 | Republic of Cote d'Ivoire | 53              | 
| 2015 | Lesotho                   | 54              | 
| 2015 | Somalia                   | 56              | 
| 2015 | Republic of South Sudan   | 56              | 
| 2015 | Swaziland                 | 57              | 
| 2015 | Burundi                   | 57              | 

#### Greatest Average Life Expectancy Across Observed Period (1970-2015)

```sql
SELECT tags.country AS "Country",
  AVG(value) AS "Life Expectancy"
FROM "life_expectancy_at_birth_by_country"
  GROUP BY "Country"
  ORDER BY AVG(value) DESC
  LIMIT 10
```

Query uses the following clauses:
* [`AVG` Aggregator](https://github.com/axibase/atsd/tree/master/sql#aggregation-functions)
* [`GROUP BY`](https://github.com/axibase/atsd/tree/master/sql#grouping)

| Country       | Life Expectancy | 
|---------------|-----------------| 
| Liechtenstein | 80              | 
| Switzerland   | 78              | 
| Bermuda       | 78              | 
| Sweden        | 78              | 
| Hong Kong     | 78              | 
| Norway        | 78              | 
| Spain         | 78              | 
| Canada        | 78              | 
| Macao         | 78              | 
| Netherlands   | 77              | 

#### Lowest Average Life Expectancy Across Observed Period (1970-2015)

```sql
SELECT tags.country AS "Country",
  AVG(value) AS "Life Expectancy"
FROM "life_expectancy_at_birth_by_country"
  GROUP BY "Country"
  ORDER BY AVG(value) ASC
  LIMIT 10
```

| Country                  | Life Expectancy | 
|--------------------------|-----------------| 
| Sierra Leone             | 41              | 
| Republic of South Sudan  | 45              | 
| Mali                     | 46              | 
| Angola                   | 46              | 
| Niger                    | 46              | 
| Mozambique               | 46              | 
| Nigeria                  | 47              | 
| Chad                     | 47              | 
| Central African Republic | 47              | 
| Somalia                  | 48              | 

#### Greatest Growth in Life Expectancy Across Observed Period (1970-2015)

```sql
SELECT tags.country AS "Country",
  LAST(value) - FIRST(value) AS "Change in Life Expectancy"
FROM "life_expectancy_at_birth_by_country"
  GROUP BY "Country"
  ORDER BY "Change in Life Expectancy" DESC
  LIMIT 10
```
Clauses used in this query:
* [`FIRST`](https://github.com/axibase/atsd/blob/master/sql/examples/aggregate-first-last.md#aggregate-functions-first-and-last)
* [`LAST`](https://github.com/axibase/atsd/blob/master/sql/examples/aggregate-first-last.md#aggregate-functions-first-and-last)

| Country                            | Change in Life Expectancy | 
|------------------------------------|---------------------------| 
| Maldives                           | 33                        | 
| Bhutan                             | 30                        | 
| Nepal                              | 29                        | 
| Democratic Republic of Timor-Leste | 29                        | 
| Senegal                            | 27                        | 
| Cambodia                           | 27                        | 
| Oman                               | 27                        | 
| Islamic Republic of Afghanistan    | 27                        | 
| Algeria                            | 26                        | 
| Mali                               | 25                        | 

#### Greatest Population Growth Across Observed Period (1970-2015)

```sql
SELECT tags.country AS "Country",
CONCAT(CAST((LAST(value) - FIRST(value))/1000000 AS string), ' Million') AS "Change in Population"
FROM "population_total_by_country"
  GROUP BY "Country"
  ORDER BY LAST(value) - FIRST(value) DESC
  LIMIT 10
```

Clauses used in this query:
* [`CONCAT` String Function](https://github.com/axibase/atsd/tree/master/sql#string-functions)
* [`CAST`](https://github.com/axibase/atsd/tree/master/sql#cast)

| Country       | Change in Population | 
|---------------|----------------------| 
| India         | 770.59 Million       | 
| China         | 560.35 Million       | 
| Indonesia     | 146.28 Million       | 
| Pakistan      | 135.11 Million       | 
| Nigeria       | 130 Million          | 
| United States | 118.07 Million       | 
| Brazil        | 112.32 Million       | 
| Bangladesh    | 97.9 Million         | 
| Mexico        | 75.51 Million        | 
| Ethiopia      | 73.98 Million        | 

#### Greatest Population Decline Across Observed Period (1970-2015)

```sql
SELECT tags.country AS "Country",
CONCAT(CAST((LAST(value) - FIRST(value))/1000000 AS string), ' Million') AS "Change in Population"
FROM "population_total_by_country"
  GROUP BY "Country"
  ORDER BY LAST(value) - FIRST(value) ASC
  LIMIT 10
```

| Country                | Change in Population | 
|------------------------|----------------------| 
| Ukraine                | -2.08 Million        | 
| Bulgaria               | -1.36 Million        | 
| Romania                | -0.54 Million        | 
| Serbia                 | -0.52 Million        | 
| Hungary                | -0.51 Million        | 
| Georgia                | -0.4 Million         | 
| Latvia                 | -0.39 Million        | 
| Lithuania              | -0.26 Million        | 
| Bosnia and Herzegovina | -0.24 Million        | 
| Croatia                | -0.24 Million        | 

#### Greatest Fertility Rate (2015)

```sql
SELECT tags.country AS "Country",
LAST(value) AS "Fertility Rate"
FROM "fertility_rate_total_by_country"
  GROUP BY "Country"
  ORDER BY LAST(value) DESC
  LIMIT 10
```

| Country                            | Fertility Rate | 
|------------------------------------|----------------| 
| Niger                              | 7.29          | 
| Somalia                            | 6.36          | 
| Democratic Republic of Congo       | 6.2           | 
| Mali                               | 6.14          | 
| Chad                               | 6.05          | 
| Burundi                            | 5.78          | 
| Angola                             | 5.76          | 
| Democratic Republic of Timor-Leste | 5.61          | 
| Nigeria                            | 5.59          | 
| Republic of Gambia                 | 5.48          | 


#### Lowest Fertility Rate (2015)

```sql
SELECT tags.country AS "Country",
LAST(value) AS "Fertility Rate"
FROM "fertility_rate_total_by_country"
  GROUP BY "Country"
  ORDER BY LAST(value) ASC
  LIMIT 10
```

| Country                | Fertility Rate | 
|------------------------|----------------| 
| Hong Kong              | 1.19          | 
| Portugal               | 1.23          | 
| Republic of Korea      | 1.23          | 
| Singapore              | 1.24          | 
| Republic of Moldova    | 1.24          | 
| Macao                  | 1.28          | 
| Greece                 | 1.3           | 
| Poland                 | 1.32          | 
| Spain                  | 1.32          | 
| Bosnia and Herzegovina | 1.34          | 

