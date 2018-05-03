Consumer Finance Protection: League Tables
==============

* Reporting Agency: Bureau of Consumer Financial Protection
* Dataset: https://catalog.data.gov/dataset/consumer-complaint-database

## Complaints by Banking Product or Service

```sql
SELECT tags.product, COUNT(*)
  FROM "cfpb.row_number.s6ew-h6mp"
  GROUP BY tags.product
ORDER BY COUNT(*) DESC
```

| tags.product            | count(*) |
|-------------------------|---------:|
| Mortgage                | 224189   |
| Debt collection         | 141598   |
| Credit reporting        | 135832   |
| Credit card             | 87370    |
| Bank account or service | 84480    |
| Student loan            | 30802    |
| Consumer Loan           | 30651    |
| Payday loan             | 5378     |
| Money transfers         | 5216     |
| Prepaid card            | 3698     |
| Other financial service | 998      |
| Virtual currency        | 17       |

## Top-25 Companies by the Number of Complaints

```sql
SELECT tags.company, COUNT(*)
  FROM "cfpb.row_number.s6ew-h6mp"
GROUP BY tags.company
  --HAVING COUNT(*) >= 1000
ORDER BY COUNT(*) DESC
  LIMIT 25
```

| tags.company                           | count(*) |
|----------------------------------------|---------:|
| Bank of America                        | 65232    |
| Wells Fargo & Company                  | 52912    |
| Equifax                                | 47068    |
| Experian                               | 44378    |
| JPMorgan Chase & Co.                   | 42039    |
| TransUnion Intermediate Holdings, Inc. | 38577    |
| Citibank                               | 34156    |
| Ocwen                                  | 23885    |
| Capital One                            | 19893    |
| Navient Solutions, LLC.                | 16855    |
| Nationstar Mortgage                    | 16016    |
| Synchrony Financial                    | 12724    |
| U.S. Bancorp                           | 12152    |
| Ditech Financial LLC                   | 11305    |
| PNC Bank N.A.                          | 8525     |
| Amex                                   | 8142     |
| Encore Capital Group                   | 7690     |
| HSBC North America Holdings Inc.       | 7132     |
| Discover                               | 6303     |
| SunTrust Banks, Inc.                   | 6105     |
| TD Bank US Holding Company             | 5835     |
| Select Portfolio Servicing, Inc        | 5691     |
| Portfolio Recovery Associates, Inc.    | 4946     |
| Citizens Financial Group, Inc.         | 3967     |
| Barclays PLC                           | 3929     |


## Bank of America: Annual Complaint Counts

```sql
SELECT date_format(time, 'yyyy') AS "Year", COUNT(*)
  FROM "cfpb.row_number.s6ew-h6mp"
WHERE tags.company = 'Bank of America'
  AND datetime >= '2012-01-01T00:00:00Z' AND datetime < CURRENT_YEAR
GROUP BY PERIOD(1 YEAR)
```

| Year | count(*) |
|------|---------:|
| 2012 | 16038    |
| 2013 | 16455    |
| 2014 | 10286    |
| 2015 | 9833     |
| 2016 | 9782     |

## Bank of America: Quarterly Complaint Counts

```sql
SELECT date_format(time, 'yyyy') AS "Year",
  CEIL(CAST(date_format(time, 'M') AS NUMBER)/3) AS "Quarter", COUNT(*)
  FROM "cfpb.row_number.s6ew-h6mp"
WHERE tags.company = 'Bank of America'
  AND datetime >= '2012-01-01T00:00:00Z' AND datetime < CURRENT_QUARTER
GROUP BY PERIOD(1 QUARTER)
```

| Year | Quarter | count(*) |
|------|---------|---------:|
| 2012 | 1       | 2879     |
| 2012 | 2       | 5000     |
| 2012 | 3       | 4438     |
| 2012 | 4       | 3721     |
| 2013 | 1       | 5972     |
| 2013 | 2       | 4544     |
| 2013 | 3       | 3554     |
| 2013 | 4       | 2385     |
| 2014 | 1       | 2721     |
| 2014 | 2       | 2638     |
| 2014 | 3       | 2641     |
| 2014 | 4       | 2286     |
| 2015 | 1       | 2292     |
| 2015 | 2       | 2649     |
| 2015 | 3       | 2653     |
| 2015 | 4       | 2239     |
| 2016 | 1       | 2412     |
| 2016 | 2       | 2410     |
| 2016 | 3       | 2545     |
| 2016 | 4       | 2415     |
| 2017 | 1       | 2254     |

## Bank of America: Complaints by Banking Product or Service

```sql
SELECT tags.product, COUNT(*)
  FROM "cfpb.row_number.s6ew-h6mp"
WHERE tags.company = 'Bank of America'
  GROUP BY tags.product
ORDER BY COUNT(*) DESC
```

| tags.product            | count(*) |
|-------------------------|---------:|
| Mortgage                | 39759    |
| Bank account or service | 13609    |
| Credit card             | 8965     |
| Debt collection         | 1622     |
| Consumer Loan           | 669      |
| Money transfers         | 261      |
| Credit reporting        | 110      |
| Student loan            | 100      |
| Other financial service | 69       |
| Prepaid card            | 54       |
| Payday loan             | 14       |


---

## Running SQL Queries Locally

Below are the summarized steps to follow to install local instances of Axibase Time Series Database for analyzing this data.gov dataset with SQL.

1. Install [Docker](https://docs.docker.com/engine/installation/linux/ubuntulinux/).
2. Download the [`docker-compose.yml`](https://raw.githubusercontent.com/axibase/atsd-use-cases/master/ConsumerFinance/resources/docker-compose.yml) file to launch the container bundle.

   ```bash
   curl -o docker-compose.yml https://raw.githubusercontent.com/axibase/atsd-use-cases/master/ConsumerFinance/resources/docker-compose.yml
   ```

3. Launch containers.

   ```bash
   export C_USER=myuser; export C_PASSWORD=mypassword; docker-compose pull && docker-compose up -d
   ```

4. Log in to ATSD at `https://docker_host:8443`, click on the **SQL** tab in the top menu to submit queries.
