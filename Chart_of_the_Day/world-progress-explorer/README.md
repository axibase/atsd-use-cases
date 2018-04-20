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
SELECT tags.country AS "Country",
  value AS "Life Expectancy"
FROM "life_expectancy_at_birth_by_country"
  WHERE datetime = '2015'
ORDER BY "Life Expectancy" DESC
  LIMIT 10
```

Query uses the following clauses:
* [`FROM`](https://github.com/axibase/atsd/tree/master/sql#virtual-table)
* [Alias / `AS`](https://github.com/axibase/atsd/tree/master/sql#aliases)
* [`WHERE`](https://github.com/axibase/atsd/tree/master/sql#where-clause)
* [`LIMIT`](https://github.com/axibase/atsd/tree/master/sql#limiting)
* [`ORDER BY`](https://github.com/axibase/atsd/tree/master/sql#ordering)

| Country           | Life Expectancy | 
|-------------------|-----------------| 
| Hong Kong         | 84              | 
| Macao             | 84              | 
| Spain             | 83              | 
| Switzerland       | 83              | 
| Singapore         | 83              | 
| Sweden            | 83              | 
| Australia         | 82              | 
| Luxembourg        | 82              | 
| Republic of Korea | 82              | 
| Canada            | 82              | 

#### Lowest Life Expectancy at Birth for Year 2015

```sql
SELECT tags.country AS "Country",
  value AS "Life Expectancy"
FROM "life_expectancy_at_birth_by_country"
  WHERE datetime = 2015
ORDER BY "Life Expectancy" ASC
  LIMIT 10
```

| Country                   | Life Expectancy | 
|---------------------------|-----------------| 
| Central African Republic  | 51              | 
| Sierra Leone              | 51              | 
| Chad                      | 53              | 
| Nigeria                   | 53              | 
| Republic of Cote d'Ivoire | 53              | 
| Lesotho                   | 54              | 
| Somalia                   | 56              | 
| Republic of South Sudan   | 56              | 
| Swaziland                 | 57              | 
| Burundi                   | 57              | 

#### Greatest Growth in Life Expectancy Across Observed Period (1970-2015)

```sql
SELECT tags.country AS "Country",
  FIRST(value) AS "1971 Value",
  LAST(value) AS "2015 Value",
  LAST(value) - FIRST(value) AS "Change in Life Expectancy"
FROM "life_expectancy_at_birth_by_country"
  GROUP BY "Country"
  ORDER BY "Change in Life Expectancy" DESC
  LIMIT 10
```
Clauses used in this query:
* [`FIRST`](https://github.com/axibase/atsd/blob/master/sql/examples/aggregate-first-last.md#aggregate-functions-first-and-last)
* [`LAST`](https://github.com/axibase/atsd/blob/master/sql/examples/aggregate-first-last.md#aggregate-functions-first-and-last)

| Country                            | 1971 Value | 2015 Value | Change in Life Expectancy | 
|------------------------------------|------------|------------|---------------------------| 
| Maldives                           | 44.24      | 77.12      | 32.88                     | 
| Bhutan                             | 39.63      | 69.81      | 30.17                     | 
| Nepal                              | 40.50      | 69.87      | 29.37                     | 
| Democratic Republic of Timor-Leste | 39.54      | 68.58      | 29.04                     | 
| Senegal                            | 39.22      | 66.66      | 27.44                     | 
| Cambodia                           | 41.57      | 68.47      | 26.90                     | 
| Oman                               | 50.26      | 77.12      | 26.86                     | 
| Islamic Republic of Afghanistan    | 36.71      | 63.30      | 26.59                     | 
| Algeria                            | 50.34      | 75.86      | 25.51                     | 
| Mali                               | 32.39      | 57.46      | 25.06                     | 

#### Least Growth in Life Expectancy Across Observed Period (1970-2015)

```sql
SELECT tags.country AS "Country",
  FIRST(value) AS "1971 Value",
  LAST(value) AS "2015 Value",
  LAST(value) - FIRST(value) AS "Change in Life Expectancy"
FROM "life_expectancy_at_birth_by_country"
  GROUP BY "Country"
  ORDER BY "Change in Life Expectancy" ASC
  LIMIT 10
```

| Country            | 1971 Value | 2015 Value | Change in Life Expectancy | 
|--------------------|------------|------------|---------------------------| 
| Ukraine            | 70.24      | 71.19      | 0.95                      | 
| Russian Federation | 68.13      | 70.91      | 2.77                      | 
| Curacao            | 74.71      | 77.82      | 3.11                      | 
| Bulgaria           | 71.26      | 74.47      | 3.21                      | 
| Belarus            | 70.08      | 73.62      | 3.55                      | 
| Liechtenstein      | 78.42      | 82.07      | 3.65                      | 
| Serbia             | 71.49      | 75.49      | 4.00                      | 
| Armenia            | 69.92      | 74.21      | 4.28                      | 
| Latvia             | 69.84      | 74.12      | 4.29                      | 
| Lithuania          | 70.80      | 75.12      | 4.32                      | 


#### Greatest Population Growth Across Observed Period (1970-2015)

```sql
SELECT tags.country AS "Country",
ROUND((LAST(value) - FIRST(value))/1000000,0) AS "Change in Population (Million)"
FROM "population_total_by_country"
  GROUP BY "Country"
  ORDER BY LAST(value) - FIRST(value) DESC
  LIMIT 10
```

Clauses used in this query:

* [`ROUND`](https://github.com/axibase/atsd/tree/master/sql#mathematical-functions)

| Country       | Change in Population (Million) | 
|---------------|-----------------------------| 
| India         | 770                         | 
| China         | 560                         | 
| Indonesia     | 146                         | 
| Pakistan      | 135                         | 
| Nigeria       | 130                         | 
| United States | 118                         | 
| Brazil        | 112                         | 
| Bangladesh    | 97                          | 
| Mexico        | 75                          | 
| Ethiopia      | 73                          | 

#### Greatest Population Growth Percent Across Observed Period (1970-2015)

```
SELECT tags.country AS "Country",
  FIRST(value)/1000000 AS "Population 1971 (Million)",
  LAST(value)/1000000 AS "Population 2015 (Million)",
  ((LAST(value) - FIRST(value)) / FIRST(value)) * 100 AS "Change in Population (%)"
FROM "population_total_by_country"
  GROUP BY "Country"
  ORDER BY "Change in Population (%)" DESC
  LIMIT 10
```

| Country                      | Population 1971 (Million) | Population 2015 (Million) | Change in Population (%) | 
|------------------------------|---------------------------|---------------------------|--------------------------| 
| United Arab Emirates         | 0.24                      | 9.27                      | 3836.16                  | 
| Qatar                        | 0.11                      | 2.57                      | 2246.55                  | 
| Bahrain                      | 0.21                      | 1.43                      | 570.34                   | 
| Cayman Islands               | 0.01                      | 0.06                      | 564.53                   | 
| Turks and Caicos Islands     | 0.01                      | 0.03                      | 519.56                   | 
| Oman                         | 0.72                      | 4.42                      | 511.28                   | 
| Djibouti                     | 0.16                      | 0.94                      | 490.22                   | 
| Collectivity of Saint Martin | 0.01                      | 0.03                      | 486.22                   | 
| Saudi Arabia                 | 5.84                      | 32.28                     | 453.01                   | 
| Jordan                       | 1.72                      | 9.46                      | 450.10                   | 


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

#### Greatest Population Decline Percent Across Observed Period (1970-2015)

```
SELECT tags.country AS "Country",
  FIRST(value)/1000000 AS "Population 1971 (Million)",
  LAST(value)/1000000 AS "Population 2015 (Million)",
  ((LAST(value) - FIRST(value)) / FIRST(value)) * 100 AS "Change in Population (%)"
FROM "population_total_by_country"
  GROUP BY "Country"
  ORDER BY "Change in Population (%)" ASC
  LIMIT 10
```

| Country                | Population 1971 (Million) | Population 2015 (Million) | Change in Population (%) | 
|------------------------|---------------------------|---------------------------|--------------------------| 
| Latvia                 | 2.36                      | 1.96                      | -16.90                   | 
| Bulgaria               | 8.49                      | 7.13                      | -16.04                   | 
| Georgia                | 4.12                      | 3.72                      | -9.72                    | 
| Lithuania              | 3.14                      | 2.87                      | -8.52                    | 
| Serbia                 | 7.59                      | 7.06                      | -6.97                    | 
| Bosnia and Herzegovina | 3.76                      | 3.52                      | -6.48                    | 
| Croatia                | 4.41                      | 4.17                      | -5.45                    | 
| Hungary                | 10.34                     | 9.82                      | -5.03                    | 
| Ukraine                | 47.09                     | 45.00                     | -4.42                    | 
| Estonia                | 1.36                      | 1.32                      | -3.21                    | 

#### Greatest Fertlity Rate Rate (2015)

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

