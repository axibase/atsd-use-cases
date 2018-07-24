#!/usr/bin/python

from atsd_client import connect_url
from atsd_client.models import EntityFilter, DateFilter, MessageQuery
from atsd_client.services import MessageService
from jsonpath import jsonpath
import argparse
import logging

logger = logging.getLogger()
logger.disabled = True

# Parse script arguments
parser = argparse.ArgumentParser(
    description='Retreive metric names based on user-specified data.')
parser.add_argument('channel', help='ID of dialog with bot.')
parser.add_argument('user', help='User ID.')
args = parser.parse_args()

# Connect to ATSD server
connection = connect_url('https://atsd_hostname:8443', 'username', 'password')

# Retrieve user-specified search settings from messages using atsd_client.MessageService
message_service = MessageService(connection)
ef = EntityFilter(entity='slack')
df = DateFilter(interval={"count": 30, "unit": "SECOND"}, end_date='NOW')
query = MessageQuery(entity_filter=ef, date_filter=df,
                     type='webhook', source='axibase-bot',
                     tags={"payload.channel.id":args.channel, "payload.user.id":args.user}, 
                     expression='message LIKE "*Selected" AND message NOT LIKE "Chart*"')
messages = message_service.query(query)

# Retrieve matched metrics using low level request wrapper from atsd_client
selected_options = [m.tags['payload.actions[0].selected_options[0].value'] for m in messages]
# Query example: 
# entity:fred.stlouisfed.org AND (category_id:32417 AND parent_category_id:9 AND frequency:"Monthly" AND seasonal_adjustment_short:"SA")
query = 'entity:fred.stlouisfed.org AND (' + selected_options[0] + \
        ' AND ' + selected_options[1] + \
        ' AND ' + selected_options[2] + \
        ' AND ' + selected_options[3] + ')'
params = {"query": query, "limit": 5}
search_result = connection.get('v1/search', params)
metrics = jsonpath(search_result, "$.data[*][0]")
# encode() required for Python 2
encoded_metrics = [m.encode('utf-8') for m in metrics] if metrics else ''
# Example:
# ['cbr54093wva647ncen', 'cbr38073nda647ncen']
print(encoded_metrics)