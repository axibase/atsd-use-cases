#!/usr/bin/python

from atsd_client import connect_url
from jsonpath import jsonpath
import argparse
import logging

logger = logging.getLogger()
logger.disabled = True

# Parse script arguments
parser = argparse.ArgumentParser(
    description='Retreive series based on user-specified data.')
parser.add_argument('query', help='Query string for /search endpoint.')
parser.add_argument('message', help='Message identifying which setting was configured by user.')
args = parser.parse_args()
message = args.message

# Connect to ATSD server
connection = connect_url('https://atsd_hostname:8443', 'username', 'password')


def search(limit=100, metric_tags=''):
    """
    Retrieve matched series using low level request wrapper from atsd_client.
    :param limit: Maximum number of records to be returned by the server. Default: 100.
    :param metric_tags: Metric tags to be included in the response.
    :return: `str`
    """
    params = {"query": args.query, "limit": limit, "metricTags": metric_tags}
    # Query example: entity:fred.stlouisfed.org AND category_id:32417 AND parent_category_id:9
    return connection.get('v1/search', params)


def make_attachments_json(text, callback_id, name, actions_text, option_entries):
    """
    Prepare JSON file with Slack interactive message menu.
    :return: `str`
    """
    search_result = search(metric_tags=','.join(option_entries))
    tags = jsonpath(search_result, "$.data[*][3]")
    option_text = option_entries[0]
    option_value = option_entries[1]
    unique = list({v[option_text]: v for v in tags}.values())
    first_five = unique[:5]
    options = []
    for el in first_five:
        options.append({"text": el[option_text].encode('utf-8'),
                        "value": '{}:{}'.format(option_value, el[option_value])})

    attach_json = [{
        "text": text,
        "color": "#3AA3E3",
        "attachment_type": "default",
        "callback_id": callback_id,
        "actions": [
            {
                "name": name,
                "text": actions_text,
                "type": "select",
                "options": options
            }
        ]
    }]
    print(attach_json)


if message == 'Parent Category Selected':
    make_attachments_json("Select Category", "Category Selected",
                          "category_list", "Category...", ["category", "category_id"])
elif message == 'Category Selected':
    make_attachments_json("Select Frequency", "Frequency Selected",
                          "frequency_list", "Frequency...", ["frequency", "frequency_short"])
elif message == 'Frequency Selected':
    make_attachments_json("Seasonally Adjusted?", "Seasonal Adj. Selected",
                          "seasonal_adj_list", "Seasonal Adjustment...", ["seasonal_adjustment",
                                                                          "seasonal_adjustment_short"])
elif message == 'Chart Type Selected':
    # Search metrics when all settings have been specified.
    result = search(limit=5)
    metrics = jsonpath(result, "$.data[*][0]")
    # encode() required for Python 2
    encoded_metrics = [m.encode('utf-8') for m in metrics]
    # Example:
    # ['cbr54093wva647ncen', 'cbr38073nda647ncen']
    print(encoded_metrics)

# python3 dynamic_response.py 'entity:fred.stlouisfed.org AND parent_category_id:9' 'Parent Category Selected'
# python3 dynamic_response.py 'entity:fred.stlouisfed.org AND parent_category_id:9 AND category_id:32421' 'Category Selected'
# python3 dynamic_response.py 'entity:fred.stlouisfed.org AND parent_category_id:9 AND category_id:32421 AND frequency_short:M' 'Frequency Selected'
# python3 dynamic_response.py 'entity:fred.stlouisfed.org AND parent_category_id:9 AND category_id:32421 AND frequency_short:M AND seasonal_adjustment_short:SA' 'Chart Type Selected'