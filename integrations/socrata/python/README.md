# Querying Data.gov Dataset with Python and SQL

## Overview

This **10 minute** tutorial demonstrates how to load a [data.gov](https://catalog.data.gov/dataset/solar-photovoltaic-pv-incentive-program-completed-projects-by-city-and-contractor-beginnin) dataset into a python DataFrame in a few simple steps.

For this particular exercise, import the data on the [New York State Solar Photovoltaic Incentive Program](https://www.nyserda.ny.gov/All-Programs/Programs/NY-Sun/Customers) into Axibase Time Series Database and query it with SQL to identify the top 10 contractors by total project cost and installed capacity.

## Prerequisites

* [Docker](https://docs.docker.com/engine/installation/)

## Procedure

### Download the `docker-compose.yml` file

```sh
curl -o docker-compose.yml https://raw.githubusercontent.com/axibase/atsd-use-cases/master/integrations/socrata/python/docker-compose.yml
```

The [`docker-compose.yml`](./resources/docker-compose.yml) file configures Axibase Time Series Database (ATSD) and Axibase Collector services along with the required dependencies. The role of the Collector is to automatically download and parse a specific data.gov JSON file while ATSD serves as the SQL-enabled database.

### Launch containers

```sh
export C_USER=myuser; \
export C_PASSWORD=mypassword; \
export S_PATH=https://data.ny.gov/api/views/3pzs-2zsk; \
docker-compose pull && docker-compose up -d
```

```txt
Pulling atsd (axibase/atsd:latest)...
latest: Pulling from axibase/atsd
...
Creating atsd
Creating axibase-collector
```

Once images you have downloaded the images, it may take several minutes to initialize the services. Monitor the progress by watching the container logs.

```sh
docker logs -f atsd
```

An `ATSD start completed` message means that the setup completed successfully.

```txt
...
 * [ATSD] Starting ATSD ...
 * [ATSD] ATSD not running.
 * [ATSD] ATSD java version "1.7.0_111"
 * [ATSD] Waiting for ATSD to start. Checking ATSD web-interface port 8088 ...
 * [ATSD] Waiting for ATSD to bind to port 8088 ...( 1 of 20 )
...
 * [ATSD] Waiting for ATSD to bind to port 8088 ...( 11 of 20 )
 * [ATSD] ATSD web interface:
...
 * [ATSD] http://172.17.0.2:8088
 * [ATSD] https://172.17.0.2:8443
 * [ATSD] ATSD start completed.
```

### Install `atsd_client`, `pandas` and `tabulate` python modules

```sh
pip install atsd_client pandas tabulate
```

The [ATSD Python client](https://github.com/axibase/atsd-api-python) implements a set of methods to load series, properties, and message records from the database, as well as acts as an SQL client.

### Open python shell and execute the query

```sh
python
```

Replace `localhost` with the actual Docker hostname, if necessary.

```sh
python
```

```python
import atsd_client
from atsd_client.services import SQLService
```

```python
conn = atsd_client.connect_url('http://localhost:8088', 'myuser', 'mypassword')
```

```python
sql = SQLService(conn)
```

```python
q = """SELECT p.tags.contractor AS contractor,
        COUNT(p.value) AS project_count,
        ROUND(SUM(p.value)/1000, 0) AS total_gwh_annual_production,
        ROUND(SUM(c.value)/1000000, 1) AS total_cost_mln,
        ROUND(SUM(c.value)/SUM(p.value), 2) AS cost_per_kwh
       FROM expected_kwh_annual_production p
        JOIN project_cost c
       WHERE p.tags.contractor != 'Other'
        GROUP BY p.tags.contractor
       ORDER BY total_gwh_annual_production DESC
        LIMIT 10"""
```

```python
df = sql.query(q)
```

```python
from tabulate import tabulate
print(tabulate(df, headers='keys', tablefmt='psql'))
```

### Examine the results

```ls
+----+---------------------------------------------+-----------------+-------------------------------+------------------+----------------+
|    | contractor                                  |   project_count |   total_gwh_annual_production |   total_cost_mln |   cost_per_kwh |
|----+---------------------------------------------+-----------------+-------------------------------+------------------+----------------|
|  0 | SolarCity(CS)                               |             344 |                         28347 |            130.3 |           4.6  |
|  1 | SunPower Capital LLC (E)                    |              55 |                         14525 |             63.1 |           4.34 |
|  2 | New York Light Energy                       |              16 |                          9194 |             37.8 |           4.11 |
|  3 | Monolith Solar Associates LLC(CS)           |              45 |                          8248 |             33.2 |           4.02 |
|  4 | SunRun Inc. (E)                             |             124 |                          7653 |             26.4 |           3.45 |
|  5 | Solar Liberty Energy Systems Inc. (CS)      |              61 |                          7219 |             30.9 |           4.28 |
|  6 | NRG Residential Solar Solutions LLC (E)(CS) |              65 |                          4270 |             14.6 |           3.41 |
|  7 | Sungevity Development LLC (E)               |              87 |                          3629 |             14.3 |           3.95 |
|  8 | Kilowatt Systems LLC                        |              53 |                          3627 |             12.4 |           3.43 |
|  9 | Best Energy Power (CS)                      |              14 |                          3290 |             12.9 |           3.91 |
+----+---------------------------------------------+-----------------+-------------------------------+------------------+----------------+
```

### Conclusion

This tutorial provides an example on how to load one particular `data.gov` dataset into ATSD while minimizing time spent on designing table schema and implementing parsers.

In a more advanced (consolidation) scenario, the Collector can be scheduled to store and even incrementally update a wide range of datasets from data.gov into the same ATSD instance. This can be accomplished by creating additional [Socrata](https://axibase.com/docs/axibase-collector/jobs/socrata.html) jobs in the Collector web interface accessible at `https://localhost:9443`.
