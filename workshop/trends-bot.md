# Real Slack Bot for Trends

## Introduction

## "Technology Stack"

To make it easier to understand the further description it is better to get acquainted with the following key concepts:

* [Webhook](https://github.com/axibase/atsd/blob/master/api/data/messages/webhook.md)
    
    * [Filter Parameters](https://github.com/axibase/atsd/blob/master/api/data/messages/webhook.md#filter-parameters)

* [Rule Engine](https://github.com/axibase/atsd/tree/master/rule-engine#rule-engine)

    * [Filters](https://github.com/axibase/atsd/blob/master/rule-engine/filters.md#filters)
    * [Placeholder](https://github.com/axibase/atsd/blob/master/rule-engine/placeholders.md#placeholders)

## Webhook User

* Create webhook user as described [here](https://github.com/axibase/atsd/blob/master/api/data/messages/webhook.md#webhook-user-wizard).
* Copy webhook url.

## Slack App Configuration

If necessary, create new Slack app with the bot user as described [here](https://github.com/axibase/atsd/blob/master/rule-engine/notifications/slack.md#create-atsd-slack-bot).

### Interactive Components

In order to allow the user to select options, we will use interactive messages [menus](https://api.slack.com/docs/message-menus) and [buttons](https://api.slack.com/docs/message-buttons). When user selects some item ATSD receives a HTTP POST with a payload body parameter containing a urlencoded JSON object.

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

Objects `actions`,`original_message` do not need, exclude them from payload received by ATSD:

```elm
exclude=payload.ac*;payload.or*
```

The `"value"` fields will store items selected by user, so include them:

```elm
include=payload.actions[0].selected_options[0].value;payload.actions[0].value
```

It is useful to distinguish between webhook messages, set message text to `payload.callback_id` value:

```elm
command.message=payload.callback_id
```

Set webhook url to the **Interactive Components > Request URL** filed:

```elm
https://user:password@atsd_hostname:8443/api/v1/messages/webhook/axibase-bot?entity=slack&json.parse=payload&exclude=payload.ac*;payload.or*&include=payload.actions[0].selected_options[0].value;payload.actions[0].value&command.message=payload.callback_id
```

> Don't forget to replace source and entity.

![](images/trends_bot_1.png)

### Slash Commands

In order to allow the user to call bot directly from Slack we will use [Slash Commands](https://api.slack.com/slash-commands).

In the case of a Slash Command, all we need to do is figure out what exactly Slash Command it is:

```elm
message=/chart
```

Specify command and webhook url at the Slash Command Editor:

```elm
https://user:password@atsd_hostname:8443/api/v1/messages/webhook/axibase-bot?entity=slack&message=/chart
```

![](images/trends_bot_2.png)

![](images/trends_bot_3.png)