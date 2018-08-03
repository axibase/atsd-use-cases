# Crazy Slack Bot for Trends

* [Data Specifics](#data-specifics)
* [Webhook User](#webhook-user)
* [Slack App Configuration](#slack-app-configuration)
  * [Configure Webhook URL](#configure-webhook-url)
  * [Slash Commands](#slash-commands)
* [ATSD Configuration](#atsd-configuration)
  * [Outgoing Webhooks](#outgoing-webhooks)
  * [Replacement Tables](#replacement-tables)
  * [Portal](#portal)
  * [Script](#script)
  * [Rule](#rule)
    * [Filters Tab](#filters-tab)
    * [Condition Tab](#condition-tab)
    * [Webhooks Tab](#webhooks-tab)

## Overview

This document describes how to create bot that sends portal with metrics and the type specified by user through Slack Interactive messages [framework](https://api.slack.com/interactive-messages#building_workflows). The metrics are stored in ATSD from [trends](../tutorials/shared/trends.md#using-trends) sandbox.

![](./images/trends_bot_7.png)

## Data Specifics

Features of [metrics](https://trends.axibase.com/public/reference.html) stored in the Trends ATSD:

* there are > 33,000 metrics;
* metric names are not informative.

Therefore, the user will be asked to select multiple tags: "Parent Category", "Category", "Frequency", "Seasonal Adjustment".
ATSD will execute [search](https://axibase.com/docs/atsd/api/meta/misc/search.html) request using specified parameters, retrieve metric names from response and pass them to template portal.

![](./images/trends_bot_6.png)

## Webhook User

* Create webhook user as described [here](https://axibase.com/docs/atsd/administration/user-authorization.html#webhook-user).
* Copy webhook URL.

To search series user also must have `API_META_READ` role and `Read` permission for bot entities:

![](./images/trends_bot_9.png)

Check that bot entity group contains the following entities:

```ls
axibase-bot
fred.stlouisfed.org
slack
```

## Slack App Configuration

If necessary, create new Slack app with the bot user as described [here](https://axibase.com/docs/atsd/rule-engine/notifications/slack.html#create-bot).

### Configure Webhook URL

To allow the user select options, use interactive [menus](https://api.slack.com/docs/message-menus) and [buttons](https://api.slack.com/docs/message-buttons). When user selects some item, ATSD will receive a HTTP `POST` with a `payload` body parameter containing a JSON object.

<details><summary>Sample JSON sent by Slack Menu</summary>
<p>

```json
{
    "type": "interactive_message",
    "actions": [
        {
            "name": "games_list",
            "selected_options": [
                {
                    "value": "maze"
                }
            ]
        }
    ],
    "callback_id": "game_selection",
    "team": {
        "id": "T012AB0A1",
        "domain": "pocket-calculator"
    },
    "channel": {
        "id": "C012AB3CD",
        "name": "general"
    },
    "user": {
        "id": "U012A1BCD",
        "name": "muzik"
    },
    "action_ts": "1481579588.685999",
    "message_ts": "1481579582.000003",
    "attachment_id": "1",
    "token": "verification_token_string",
    "original_message": {
        "text": "Pick a game...",
        "bot_id": "B08BCU62D",
        "attachments": [
            {
                "callback_id": "game_selection",
                "fallback": "Upgrade your Slack client to use messages like these.",
                "id": 1,
                "color": "3AA3E3",
                "actions": [
                    {
                        "name": "games_list",
                        "text": "Pick a game...",
                        "type": "select",
                        "options": [
                            {
                                "text": "Chess",
                                "value": "chess"
                            },
                            {
                                "text": "Falken's Maze",
                                "value": "maze"
                            },
                            {
                                "text": "Global Thermonuclear War",
                                "value": "war"
                            }
                        ]
                    }
                ]
            }
        ],
        "type": "message",
        "subtype": "bot_message",
        "ts": "1481579582.000003"
    },
    "response_url": "https://hooks.slack.com/actions/T012AB0A1/1234567890/JpmK0yzoZ5eRiqfeduTBYXWQ",
    "trigger_id": "13345224609.738474920.8088930838d88f008e0"
}
```

</p>
</details>
<br>
<details><summary>Sample JSON sent by Slack Button</summary>
<p>

```json
{
  "type": "interactive_message",
  "actions": [
    {
      "name": "recommend",
      "value": "recommend",
      "type": "button"
    }
  ],
  "callback_id": "comic_1234_xyz",
  "team": {
    "id": "T47563693",
    "domain": "watermelonsugar"
  },
  "channel": {
    "id": "C065W1189",
    "name": "forgotten-works"
  },
  "user": {
    "id": "U045VRZFT",
    "name": "brautigan"
  },
  "action_ts": "1458170917.164398",
  "message_ts": "1458170866.000004",
  "attachment_id": "1",
  "token": "xAB3yVzGS4BQ3O9FACTa8Ho4",
  "original_message": {
    "text": "New comic book alert!",
    "attachments": [
      {
        "title": "The Further Adventures of Slackbot",
        "fields": [
          {
            "title": "Volume",
            "value": "1",
            "short": true
          },
          {
            "title": "Issue",
            "value": "3",
            "short": true
          }
        ],
        "author_name": "Stanford S. Strickland",
        "author_icon": "https://api.slack.comhttps://a.slack-edge.com/bfaba/img/api/homepage_custom_integrations-2x.png",
        "image_url": "http://i.imgur.com/OJkaVOI.jpg?1"
      },
      {
        "title": "Synopsis",
        "text": "After @episod pushed exciting changes to a devious new branch back in Issue 1, Slackbot notifies @don about an unexpected deploy..."
      },
      {
        "fallback": "Would you recommend it to customers?",
        "title": "Would you recommend it to customers?",
        "callback_id": "comic_1234_xyz",
        "color": "#3AA3E3",
        "attachment_type": "default",
        "actions": [
          {
            "name": "recommend",
            "text": "Recommend",
            "type": "button",
            "value": "recommend"
          },
          {
            "name": "no",
            "text": "No",
            "type": "button",
            "value": "bad"
          }
        ]
      }
    ]
  },
  "response_url": "https://hooks.slack.com/actions/T47563693/6204672533/x7ZLaiVMoECAW50Gw1ZYAXEM",
  "trigger_id": "13345224609.738474920.8088930838d88f008e0"
}
```

</p>
</details>

To convert JSON structures into message tags, use [`jsonParse`](https://axibase.com/docs/atsd/api/data/messages/webhook.html#parse-parameters) parameter:

```elm
json.parse=payload
```

Objects `actions`, `original_message` are not required, [exclude](https://axibase.com/docs/atsd/api/data/messages/webhook.html#filter-parameters) them from payload received by ATSD:

```elm
exclude=payload.ac*;payload.or*
```

The `value` fields will store items selected by user, [include](https://axibase.com/docs/atsd/api/data/messages/webhook.html#filter-parameters) them:

```elm
include=payload.actions[0].selected_options[0].value;payload.actions[0].value
```

It is important to distinguish between webhook messages, set [message text](https://axibase.com/docs/atsd/api/data/messages/webhook.html#literal-value-parameters) to `payload.callback_id` value:

```elm
command.message=payload.callback_id
```

Set webhook URL to the **Interactive Components > Request URL** field:

```elm
https://username:password@atsd_hostname:8443/api/v1/messages/webhook/axibase-bot?entity=slack&json.parse=payload&exclude=payload.ac*;payload.or*&include=payload.actions[0].selected_options[0].value;payload.actions[0].value&command.message=payload.callback_id
```

![](./images/trends_bot_1.png)

### Slash Commands

To allow the user to call bot directly from Slack use [Slash Commands](https://api.slack.com/slash-commands).

In the case of a Slash Command, all is need to be done is figure out what exactly Slash Command is it:

```elm
message=/chart
```

Specify **Command** and **Request URL** at the Slash Command editor:

```elm
https://username:password@atsd_hostname:8443/api/v1/messages/webhook/axibase-bot?entity=slack&message=/chart
```

![](./images/trends_bot_2.png)

![](./images/trends_bot_3.png)

## ATSD Configuration

### Outgoing Webhooks

Two Slack integrations must be configured in ATSD:

* [custom](https://axibase.com/docs/atsd/rule-engine/notifications/custom.html)
* [built-in](https://axibase.com/docs/atsd/rule-engine/notifications/slack.html)

All fields of custom webhook must be specified as placeholders to be customizable in Rule Engine:

```css
Endpoint URL: https://slack.com/api/chat.postMessage
Headers: Authorization: Bearer BOT_TOKEN
Body: {
        "channel":"${channel}",
        "text": "${text}",
        "attachments":"${attachments}"
      }
```

![](./images/trends_bot_8.png)

`Channels` and `Text` fields in the built-in ATSD integration must be exposed to the Rule Engine too:

![](./images/trends_bot_4.png)

### Replacement Tables

To send buttons and menu it is useful to store preconfigured JSON files. ATSD Replacement Tables provide a convenient way of storing `key=value` pairs.

Navigate to **Data > Replacement Tables** page an create a table with JSON format and the following keys:

<details><summary>parent_category</summary>
<p>

```json
[
  {
    "text": "Select Parent Category",
    "color": "#3AA3E3",
    "attachment_type": "default",
    "callback_id": "Parent Category Selected",
    "actions": [
      {
        "name": "parent_category_list",
        "text": "Parent Category...",
        "type": "select",
        "options": [
          {
            "text": "Consumer Price Indexes (CPI and PCE)",
            "value": "parent_category_id:9"
          },
          {
            "text": "Production & Business Activity",
            "value": "parent_category_id:33441"
          },
          {
            "text": "National Income & Product Accounts",
            "value": "parent_category_id:18"
          },
          {
            "text": "Population, Employment, & Labor Markets",
            "value": "parent_category_id:32999"
          }
        ]
      }
    ]
  }
]
```

</p>
</details>

<details><summary>chart_type</summary>
<p>

```json
[
  {
    "text": "Would you like to select the type?",
    "fallback": "You are unable to choose a chart",
    "callback_id": "Chart Type Selected",
    "color": "#3AA3E3",
    "attachment_type": "default",
    "actions": [
      {
        "name": "histogram",
        "text": "Histogram",
        "type": "button",
        "value": "histogram"
      },
      {
        "name": "box",
        "text": "Box",
        "type": "button",
        "value": "box"
      },
      {
        "name": "pie",
        "text": "Pie",
        "type": "button",
        "value": "pie"
      },
      {
        "name": "default",
        "text": "Default",
        "style": "primary",
        "type": "button",
        "value": "chart"
      }
    ]
  }
]
```

</p>
</details>

![](./images/trends_bot_5.png)

### Portal

Create [template](https://axibase.com/docs/atsd/portals/portals-overview.html#template-portals) portal:
<!-- markdownlint-disable MD010 -->

```ls
[configuration]
  width-units = 1
  height-units = 1
  offset-right = 50
  timespan = 10 year
  entity = fred.stlouisfed.org
  markers = true
  add-meta = true
  label-format = javascript: (meta.metric.label ? meta.metric.label : metric)

[group]
  [widget]
    type = ${type}
    multiple-series = true
    var metrics = ${metrics}
    for m in metrics
    [series]
      metric = @{m}
    endfor
```

<!-- markdownlint-enable MD010 -->

### Script

To ensure that metrics with the specified tags are present in ATSD, JSON with interactive attachment will be build dynamically based on options selected by user.

[ATSD Client for Python](https://github.com/axibase/atsd-api-python#axibase-time-series-database-client-for-python) provides convenient functionality for searching series.
Log in to ATSD server and ensure `atsd_client` version >= `2.2.6`:

```bash
$ pip list
Package         Version  
--------------- ---------
atsd-client     2.2.5

$ pip install --upgrade atsd_client
```

Install [`jsonpath`](https://pypi.org/project/jsonpath/) to find and extract tags and metrics out of JSON structures:

```bash
pip install jsonpath --user
```

Create [`dynamic_response.py`](./resources/dynamic_response.py) script to be used in [`scriptOut`](https://axibase.com/docs/atsd/rule-engine/functions-script.html#syntax) function:

```bash
chmod u=rwx,g=rx,o=r /opt/atsd/atsd/conf/script/*

nano /opt/atsd/atsd/conf/script/dynamic_response.py
```

Replace `atsd_hostname`, `username` and `password` with appropriate values:

<details><summary>dynamic_response.py</summary>
<p>

```python
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
    # Query example: entity:fred.stlouisfed.org AND parent_category_id:9
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
    # Metric list example: ['cbr54093wva647ncen', 'cbr38073nda647ncen']
    print(encoded_metrics)
```

</p>
</details>
<br>
<details><summary>Example of attachment JSON</summary>
<p>

```json
[
  {
    "text": "Select Category",
    "attachment_type": "default",
    "color": "#3AA3E3",
    "callback_id": "Category Selected",
    "actions": [
      {
        "text": "Category...",
        "options": [
          {
            "text": "Recreation",
            "value": "category_id:32420"
          },
          {
            "text": "Medical Care",
            "value": "category_id:32419"
          },
          {
            "text": "Food and Beverages",
            "value": "category_id:32415"
          },
          {
            "text": "Education and Communication",
            "value": "category_id:32421"
          },
          {
            "text": "Apparel",
            "value": "category_id:32417"
          }
        ],
        "name": "category_list",
        "type": "select"
      }
    ]
  }
]
```

</p>
</details>

### Rule

> The full rule configuration available [here](./resources/trends-bot.xml).

Navigate to **Alerts > Rules**, click **Create** and specify settings below.

#### Filters Tab

To prevent ATSD react to messages sent by bot, specify filters:

```ls
Data Type: message
Type: webhook
Source: axibase-bot
Filter Expression: tags.event.subtype != 'bot_message' && tags.event.username != 'axibase_bot'
Entity Group: axibase-bot-entities
```

#### Windows Tab

Ensure that no grouping tags are used:

```ls
Group by Tags: No Tags
```

#### Condition Tab

As mentioned above "Parent Category", "Category", "Frequency", "Seasonal Adjustment" settings are collected to find the metrics and "Chart Type" to allow user customize portal. The window will be in `OPEN` and `REPEAT` status until the user selects chart type and ATSD receives the "Chart Type Selected" message:

```ls
Condition: message != 'Chart Type Selected'
```

To answer the user specify `channel` and `usr` variables:

```ls
channel: ifEmpty(tags.payload.channel.id, tags.channel_id)
usr: ifEmpty(tags.payload.user.id, tags.user_id)
```

Refer to [`ifEmpty`](https://axibase.com/docs/atsd/rule-engine/functions-utility.html#ifempty) function.

To dynamically create a query string, access the previous window with [`last_open`](https://axibase.com/docs/atsd/rule-engine/functions-alert-history.html#last_open) function and configure `query` variable:

```ls
last_query: last_open().query
query: message != '/chart' ? (message != 'Chart Type Selected' ? last_query + ' AND ' + tags['payload.actions[0].selected_options[0].value']:last_query) :'entity:fred.stlouisfed.org'
```

Create attachments or search the metrics depending on `query` and `message` sent by Slack.

```ls
dynamic_response: scriptOut('dynamic_response.py',[query, message])
```

#### Webhooks Tab

Configure triggers for custom and built-in integrations:

1. **[CUSTOM]**

* On Open
  * `attachments`

    ```ls
    @if{message == '/chart'}
      ${replacementTable('slack').parent_category}
    @else{message IN ('Parent Category Selected','Category Selected','Frequency Selected')}
      ${dynamic_response}  
    @else{message == 'Seasonal Adj. Selected'}
      ${replacementTable('slack').chart_type}  
    @else{}
    null
    @end{}
    ```

  * `channel`

    ```ls
    ${channel}
    ```
  * `text`

    ```ls
    @if{message == '/chart'}
       Hello, <@${usr}>! Tell me a little bit about the chart you want to see.
    @else{}

    @end{}
    ```

  Refer to [Control Flow](https://axibase.com/docs/atsd/rule-engine/control-flow.html).

  ![](./images/trends_bot_10.png)

* On Repeat = Same as 'On Open'
* On Cancel
  * `attachments`

    ```ls
    null
    ```
  * `channel`

    ```ls
    ${channel}
    ```
  * `text`

    ```ls
    Searching for metrics...
    ```

  ![](./images/trends_bot_11.png)
  
1. **[SLACK]**

To use the [`addPortal`](https://axibase.com/docs/atsd/rule-engine/functions-portal.html#portal-functions) function configure built-in notification:

* On Cancel
  * `Channels`
  
    ```ls
    ${channel}
    ```
  * `Text`

    Replace `Trends Bot Portal` with appropriate value:

    ```ls
    ${addPortal('Trends Bot Portal','fred.stlouisfed.org','',['type':tags["payload.actions[0].value"],'metrics':dynamic_response])}
    ```

  ![](./images/trends_bot_12.png)