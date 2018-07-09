# Real Slack Bot for Trends

 * [Data Specifics](#data-specifics)
 * [Webhook User](#webhook-user)
 * [Slack App Configuration](#slack-app-configuration)
    
    * [Interactive Components](#interactive-components)
    * [Slash Commands](#slash-commands)
 
 * [ATSD Configuration](#atsd-configuration)
    
    * [Outgoing Webhooks](#outgoing-webhooks)
    * [Replacement Tables](#replacement-tables)
    * [Portal](#portal)
    * [Rule](#rule)
 
## Overview

This document describes how to create a bot that sends a portal with metrics and the type specified by user through Slack Interactive messages [framework](https://api.slack.com/interactive-messages#building_workflows). The metrics are stored in ATSD from [trends](../tutorials/shared/trends.md#using-trends) sandbox.

![](images/trends_bot_7.png) 

## Data Specifics

Features of [metrics](https://trends.axibase.com/public/reference.html) stored in the trends ATSD:

* there are 33,760 metrics;
* metric names are not informative.

Therefore, the user will be asked to select multiple tags: "Parent Category", "Category", "Frequency", "Seasonal Adjustment" and execute [search](https://github.com/axibase/atsd/tree/master/search#search) query using specified parameters.
Each tag will contain no more than 10 values  to not overload the tutorial.

![](images/trends_bot_6.png)

## Webhook User

* Create webhook user as described [here](https://github.com/axibase/atsd/blob/master/api/data/messages/webhook.md#webhook-user-wizard).
* Copy webhook url.

## Slack App Configuration

If necessary, create new Slack app with the bot user as described [here](https://github.com/axibase/atsd/blob/master/rule-engine/notifications/slack.md#create-atsd-slack-bot).

### Interactive Components

In order to allow the user to select options, use interactive messages [menus](https://api.slack.com/docs/message-menus) and [buttons](https://api.slack.com/docs/message-buttons). When user selects some item, ATSD receives a HTTP `POST` with a payload body parameter containing a urlencoded JSON object.

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


To convert JSONs into message tags, use [`jsonParse`](https://github.com/axibase/atsd/blob/master/api/data/messages/webhook.md#parse-parameters) parameter:

```elm
json.parse=payload
```

Objects `actions`,`original_message` do not need, [exclude](https://github.com/axibase/atsd/blob/master/api/data/messages/webhook.md#filter-parameters) them from payload received by ATSD:

```elm
exclude=payload.ac*;payload.or*
```

The `"value"` fields will store items selected by user, so [include](https://github.com/axibase/atsd/blob/master/api/data/messages/webhook.md#filter-parameters) them:

```elm
include=payload.actions[0].selected_options[0].value;payload.actions[0].value
```

It is important to distinguish between webhook messages, set message text to `payload.callback_id` value:

```elm
command.message=payload.callback_id
```

Set webhook url to the **Interactive Components > Request URL** field:

```http request
https://username:password@atsd_hostname:8443/api/v1/messages/webhook/axibase-bot?entity=slack&json.parse=payload&exclude=payload.ac*;payload.or*&include=payload.actions[0].selected_options[0].value;payload.actions[0].value&command.message=payload.callback_id
```

> Don't forget to replace source and entity.

![](images/trends_bot_1.png)

### Slash Commands

In order to allow the user to call bot directly from Slack use [Slash Commands](https://api.slack.com/slash-commands).

In the case of a Slash Command, all is need to be done is figure out what exactly Slash Command is it:

```elm
message=/chart
```

Specify command and webhook url at the Slash Command Editor:

```http request
https://username:password@atsd_hostname:8443/api/v1/messages/webhook/axibase-bot?entity=slack&message=/chart
```

![](images/trends_bot_2.png)

![](images/trends_bot_3.png)

## ATSD Configuration

### Outgoing Webhooks

Two Slack integrations must be configured in ATSD:

* [built-in](https://github.com/axibase/atsd/blob/master/rule-engine/notifications/slack.md#configure-web-notification-in-atsd)
* [custom](https://github.com/axibase/atsd/blob/master/rule-engine/notifications/custom.md#custom-notification)

All fields of custom webhook should be specified as placeholders to be customizable in Rule Engine:

```bash
Endpoint URL: https://slack.com/api/chat.postMessage
Headers: Authorization: Bearer BOT_TOKEN
Body: {
        "channel":"${channel}",
        "text": "${text}",
        "attachments":"${attachments}"
      }
```

`Channels` and `Text` fields in the built-in ATSD integration must be exposed to the Rule Engine too:

![](images/trends_bot_4.png)

### Replacement Tables

To send user buttons and menu it is useful to store preconfigured JSONs. ATSD Replacement Tables provide a convenient way of storing `key=value` pairs.

Navigate to **Data > Replacement Tables** page an create a table with JSON format and the following keys:

<details><summary>category</summary>
<p>

```json
[
    { 
      "text": "Select Category",
      "color": "#3AA3E3",
      "attachment_type": "default",
      "callback_id": "Category Selected",
      "actions": [
        {
          "name": "category_list",
          "text": "Category...",
          "type": "select",
          "options": [
            {
              "text": "Apparel",
              "value": "category_id:32417"
            },
            {
              "text": "Construction",
              "value": "category_id:32310"
            },
            {
              "text": "Education and Health Services",
              "value": "category_id:32322"
            },
            {
              "text": "Food and Beverages",
              "value": "category_id:32415"
            },
            {
              "text": "GDP/GNP",
              "value": "category_id:106"
            },
            {
              "text": "Medical Care",
              "value": "category_id:32419"
            },
            {
              "text": "Labor Force",
              "value": "category_id:32285"
            },
            {
              "text": "Population",
              "value": "category_id:32292"
            },
            {
              "text": "Services",
              "value": "category_id:33441"
            },
            {
              "text": "Recreation",
              "value": "category_id:32420"
            },
            {
              "text": "Retail Trade",
              "value": "category_id:6"
            }
          ]
        }
      ]
    }
  ]
```
</p>
</details>

<details><summary>frequency</summary>
<p>

```json
[
    { 
      "text": "Select Frequency",
      "color": "#3AA3E3",
      "attachment_type": "default",
      "callback_id": "Frequency Selected",
      "actions": [
        {
          "name": "frequency_list",
          "text": "Frequency...",
          "type": "select",
          "options": [
            {
              "text": "Daily",
              "value": "frequency:\"Daily\""
            },
			{
              "text": "Monthly",
              "value": "frequency:\"Monthly\""
            },            
            {
              "text": "Quarterly",
              "value": "frequency:\"Quarterly\""
            },
            {
              "text": "Annual",
              "value": "frequency:\"Annual\""
            }
          ]
        }
      ]
    }
  ]
```

</p>
</details>

<details><summary>seasonal_adj</summary>
<p>

```json
[
    { 
      "text": "Seasonally Adjusted?",
      "color": "#3AA3E3",
      "attachment_type": "default",
      "callback_id": "Seasonal Adj. Selected",
      "actions": [
        {
          "name": "seasonal_adj_list",
          "text": "Seasonal Adjustment...",
          "type": "select",
          "options": [
            {
              "text": "No",
              "value": "seasonal_adjustment_short:\"NSA\""
            },
			{
              "text": "Yes",
              "value": "seasonal_adjustment_short:\"SA\""
            },
            {
              "text": "Annual Rate",
              "value": "seasonal_adjustment_short:\"SAAR\""
            }
          ]
        }
      ]
    }
  ]
```
</p>
</details>

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

![](images/trends_bot_5.png)

### Portal

Create [template](https://github.com/axibase/atsd/blob/master/portals/portals-overview.md#portal-types) portal:

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
    list metrics = ${metrics}
  for m in metrics
     [series] 
	  metric = @{m}
  endfor
```

### Rule

> The full rule configuration available [here](images/trends-bot.xml).

Finally create and configure new rule. Navigate to **Alerts > Rules**, click **Create** and use settings below.

As mentioned above "Parent Category", "Category", "Frequency", "Seasonal Adjustment" settings will be collected to find the metrics and "Chart Type" to allow user customize portal. The window will be in 'OPEN' and 'REPEAT' status until the user selects chart type and ATSD receives the "Chart Type Selected":

```ls
Data Type: message
Condition: message != 'Chart Type Selected'
```

To prevent ATSD react to messages for other source/type/entity and to messages sent by bot specify filters:

```ls
Filter: type='webhook' && source='axibase-bot' && tags.event.subtype != 'bot_message' && tags.event.username != 'axibase_bot'
Group Filter: axibase-bot-entities
```

To answer the user to the same channel from which he called slash command and mention him in answer use `channel` and `usr` variables:

```ls
channel = ifEmpty(tags.payload.channel.id, tags.channel_id)
usr = ifEmpty(tags.payload.user.id, tags.user_id)
```

If user has specified all search settings, [retrieve](https://github.com/axibase/atsd/blob/master/rule-engine/functions-message.md#db_messages) the message records stored within last 30 seconds for the current channel and user:

```ls
tgs = ["payload.channel.id":channel,"payload.user.id":usr]
msgs != 'Chart Type Selected'?null:db_messages('30 SECOND', 'webhook', 'axibase-bot', tgs, 'slack', 'message LIKE "*Selected"')
```

Prepare search [query](https://github.com/axibase/atsd/blob/master/search/README.md):

```ls
v = 'payload.actions[0].selected_options[0].value'
q = msgs=null?'':'entity:fred.stlouisfed.org AND ('+msgs[0].tags[v]+' AND '+msgs[1].tags[v]+' AND '+msgs[2].tags[v]+' AND '+msgs[3].tags[v]+')'

// Example for 'q':
// entity:fred.stlouisfed.org AND (category_id:32417 AND parent_category_id:9 AND frequency:"Monthly" AND seasonal_adjustment_short:"SA")
```

Retrieve five top metrics matching specified tags using `/api/v1/search` endpoint:

```ls
url = "https://username:password@localhost:8443/api/v1/search?limit=5&query="
search = q=''?'':queryGet(url+urlencode(q)).content
```

Prepare metrics string to be sent as parameter for portal using [`jsonPathFilter`](https://github.com/axibase/atsd/blob/5d0d53635ec149095296998c2da971035e37b453/rule-engine/functions-table.md#jsonpathfilter):

```ls
// For example, "cbr54093wva647ncen, cbr38073nda647ncen"
metrics = search!=''?concat(jsonPathFilter(search, "$.data[*][0]")):''
```

At the **Webhooks** tab configure triggers for custom and built-in integrations:

1. **[CUSTOM]**

 * On Open
        
    * `attachments`
    
    ```
    @if{message == '/chart'}
       ${replacementTable('slack').parent_category}
    @else{message == 'Parent Category Selected'}
       ${replacementTable('slack').category}
    @else{message == 'Category Selected'}
       ${replacementTable('slack').frequency}
    @else{message == 'Frequency Selected'}
       ${replacementTable('slack').seasonal_adj}  
    @else{message == 'Seasonal Adj. Selected'}
       ${replacementTable('slack').chart_type}  
    @else{}
    null
    @end{}
    ```
     
    * `channel`
    
    ```
    ${channel}
    ```
    
    * `text`
    
    ```
    @if{message == '/chart'}
       Hello, <@${usr}>! Tell me a little bit about the chart you want to see.
    @else{}
    
    @end{}
    ```
    
 * On Repeat = Same as 'On Open'
 * On Cancel
 
     * `attachments`
     
     ```
     null
     ```
      
     * `channel`
     
     ```
     ${channel}
     ```
     
     * `text`
     
     ```
     Searching for metrics...
     ```
       
2. **[SLACK]**

To use the [`addPortal`](https://github.com/axibase/atsd/blob/master/rule-engine/functions-portal.md#syntax) function configure built-in notification:

 * On Cancel
 
     * `Channels`
     
     ```
     ${channel}
     ```
     * `Text`
     
     ```
     @if{metrics!=''} 
        ${addPortal('Axibase Bot Portal','fred.stlouisfed.org','',['type':tags["payload.actions[0].value"],'metrics':metrics])}
     @else{}
        No metrics have been found. Try again.
     @end{}
     ```