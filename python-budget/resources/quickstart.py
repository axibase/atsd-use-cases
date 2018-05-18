## Launch this program to return the results of the first query from the article 'SQL Queries and Data Visualization with Python and ATSD.'

## Establish a connection to Trends database, the ATSD instance where data for this article is stored.

from atsd_client import connect_url
conn = connect_url('https://trends.axibase.com:8443/', 'username', 'password')

## Imports Series Service. All services available to ATSD Client available at: https://github.com/axibase/atsd-api-python#services.

from atsd_client.services import *
svc = SeriesService(conn)

## Insert FRED data from ATSD.

from atsd_client.models import *

from datetime import datetime

sf = SeriesFilter(metric="AD01RC1Q027SBEA")
ef = EntityFilter(entity="fred.stlouisfed.org")
df = DateFilter(start_date="1970-01-01T00:00:00Z", end_date=datetime.now())
query_data = SeriesQuery(series_filter=sf, entity_filter=ef, date_filter=df)
result = svc.query(query_data)

## Import SQL Service.

from atsd_client.services import *

sql = SQLService(conn)

## Define SQL Query.

q = """
SELECT datetime "Year", LAST(value) "Net Lending/Borrowing"
FROM "ad01rc1q027sbea"
GROUP BY period(1 year)
ORDER BY datetime DESC
limit 18
"""

result = sql.query(q)

## Print Result Set.

print(result)