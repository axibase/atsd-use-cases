# The Most Crowded Industries in New York City

![NY1](./images/NY_Jobs1.png)

[![View in ChartLab](../../research/images/new-button.png)](https://apps.axibase.com/chartlab/6402f01c/19/#fullscreen)

Running New York City is a big business. In fact, according to [data](https://catalog.data.gov/dataset/jobs-by-industry)
released by the State of New York that tracks employment figures by industry, the top two industries
are partially staffed or entirely staffed by government employees and the third position
is sure to include government staffers on the payroll as well. That is big news considering
the annual budget for the current fiscal year (2017) of the state ranked second in the union at a whopping
[$153 billion dollars](https://www.nysenate.gov/newsroom/articles/senate-passes-2017-18-state-budget-protects-taxpayers-provides-record-investments)
and the City of New York has its own [local budget](https://council.nyc.gov/budget/) that totals about half that number as well.
New York City and State officials have stood behind the expansion and implementation of the Affordable Care Act
locally, which has seen the health care and social assistance industry add over 100,000 new jobs over the past four
years in the Big Apple alone.

![NY2](./images/NY_Jobs3.png)

[![View in ChartLab](../../research/images/new-button.png)](https://apps.axibase.com/chartlab/6402f01c/20/)

Additionally, the number of working government positions in the city has increased by roughly 38,000
and using the [SQL Console](https://axibase.com/docs/atsd/sql/) interface in ATSD,
New York City figures can be compared to New York State figures:

## New York State

| `tags.industry`                                                            | `total`     |
|--------------------------------------------------------------------------|-----------|
| Health Care and Social Assistance                                        | 1,490,611.0 |
| Government                                                               | 1,461,296.0 |
| Retail Trade                                                             | 967,686.0  |
| Accommodation and Food Services                                          | 738,279.0  |
| Professional, Scientific, and Technical Services                         | 717,452.0  |
| Finance and Insurance                                                    | 517,559.0  |
| Administrative and Support and Waste Management and Remediation Services | 478,621.0  |
| Other Services (except Public Administration)                            | 472,521.0  |
| Manufacturing                                                            | 461,920.0  |
| Educational Services (Private)                                           | 443,827.0  |
| Construction                                                             | 440,951.0  |
| Wholesale Trade                                                          | 321,104.0  |
| Transportation and Warehousing                                           | 290,617.0  |
| Information                                                              | 266,837.0  |
| Real Estate and Rental and Leasing                                       | 212,393.0  |
| Arts, Entertainment, and Recreation                                      | 207,120.0  |
| Management of Companies and Enterprises                                  | 137,955.0  |
| Agriculture, Forestry, Fishing and Hunting                               | 43,486.0   |
| Unclassified Industry                                                    | 37,759.0   |
| Utilities                                                                | 37,302.0   |
| Mining, Quarrying, and Oil and Gas Extraction                            | 4,708.0    |

```sql
SELECT tags.industry, sum(value) as total
  FROM "jobs"
WHERE date_format(time, 'yyyy') = '2015'
  GROUP BY tags.industry
ORDER BY total DESC
```

## New York City

| `tags.industry`                                                            | `total`    |
|--------------------------------------------------------------------------|----------|
| Health Care and Social Assistance                                        | 703,232.0 |
| Government                                                               | 569,354.0 |
| Professional, Scientific, and Technical Services                         | 427,707.0 |
| Retail Trade                                                             | 361,545.0 |
| Accommodation and Food Services                                          | 348,252.0 |
| Finance and Insurance                                                    | 331,925.0 |
| Other Services (except Public Administration)                            | 234,622.0 |
| Administrative and Support and Waste Management and Remediation Services | 231,492.0 |
| Educational Services (Private)                                           | 226,112.0 |
| Information                                                              | 186,987.0 |
| Construction                                                             | 176,174.0 |
| Transportation and Warehousing                                           | 146,998.0 |
| Wholesale Trade                                                          | 138,371.0 |
| Real Estate and Rental and Leasing                                       | 136,806.0 |
| Arts, Entertainment, and Recreation                                      | 109,737.0 |
| Manufacturing                                                            | 81,624.0  |
| Management of Companies and Enterprises                                  | 68,224.0  |
| Unclassified Industry                                                    | 22,212.0  |
| Utilities                                                                | 15,246.0  |
| Agriculture, Forestry, Fishing and Hunting                               | 560.0    |
| Mining, Quarrying, and Oil and Gas Extraction                            | 64.0     |

```sql
SELECT tags.industry, sum(value) as total
  FROM "jobs"
WHERE date_format(time, 'yyyy') = '2015' and tags.region = 'New York City'
  GROUP BY tags.industry
ORDER BY total DESC
```