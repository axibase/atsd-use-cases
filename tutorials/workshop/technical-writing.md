# Axibase Documentation Guide

The guide contains a compilation of grammar, punctuation, and Markdown formatting rules for software developers.

* To comply with general Markdown syntax, use [`markdownlint`](https://www.npmjs.com/package/markdownlint).
* To comply with all or subset of custom rules discussed in this guide, enable [custom](#custom-rules) rules.

**References**:

* [Google Developer Documentation Style Guide](https://developers.google.com/style/).
* [Salesforce Style Guide for Documentation and User Interface Text](https://developer.salesforce.com/docs/atlas.en-us.salesforce_pubs_style_guide.meta/salesforce_pubs_style_guide/overview.htm).

---

## Contents

* [**Grammar**](#grammar)<br>
  * [Abbreviations](#abbreviations)<br>
  * [Capitalization](#capitalization)<br>
  * [Contractions](#contractions)<br>
  * [Commas](#commas)<br>
  * [Colons](#colons)<br>
  * [Hyphens](#hyphens)<br>
  * [Numbers](#numbers)<br>
  * [Parentheses](#parentheses)<br>
  * [Possessives](#possessives)<br>
  * [Quotation Marks](#quotation-marks)

* [**Formatting**](#formatting)<br>
  * [Backticks](#backticks)<br>
  * [Code Blocks](#code-blocks)<br>
  * [Dates and Times](#dates-and-times)<br>
  * [Headers](#headers)<br>
  * [Links](#links)

* [**Style**](#style)<br>
  * [Active Voice](#active-voice)<br>
  * [Blacklisted Words](#blacklisted-words)<br>
  * [Example Names](#examples-names)<br>
  * [Interface Elements](#interface-elements)<br>
  * [Issue Subjects](#issue-subjects)<br>
  * [Functions](#functions)<br>
  * [Phrasing](#phrasing)<br>
  * [Present Tense](#present-tense)<br>
  * [Product Names](#product-names)<br>
  * [Variables](#variables)

* [**Configuration**](#configuration)<br>
  * [Automated Checks](#automated-checks)<br>
  * [Custom Rules](#custom-rules)<br>
  * [Rule Scope](#rule-scope)

---

## Grammar

### Abbreviations

* Abbreviate if the acronym is known to the target audience.
* Introduce new acronyms in parentheses and re-use thereafter.
  * :white_check_mark: `Hadoop Distributed File System (HDFS) is a clustered system. HDFS is resilient.`
* Always abbreviate:
  * Known terms: SQL, API, REST, JVM, UTF, URL, URI.
    * :white_check_mark: `SQL report`
    * :no_entry: `Structure Query Language (SQL) report`
  * Data formats: CSV, JSON, XLS, XML, XLS, PDF.
  * Protocols: HTTP, HTTPS, SSL, JMX, TCP, UDP, SSH, DNS.
  * Standards and organizations: ISO, ASCII, ANSI, W3C.
  * Time zones: UTC, EST, GMT.
  * ATSD in Axibase documentation repositories.

### Capitalization

* Use [title case](https://titlecase.com/) in headers.
  * :white_check_mark: `## Import Data`.
  * :no_entry: `## Import data`.
* Do not capitalize program/file/function names such as `curl`, `atsd.log`, even in headers.
  * :white_check_mark: `## Import Data with curl`.
  * :no_entry: `## Import Data with Curl`.
* Do not capitalize the first word after the colon in a list.
  * :white_check_mark: `Step 3: unzip files`.
* Do not capitalize file extensions.
  * :white_check_mark: `.png`, `.xml`, `.jar`.
* Keep original product capitalization.
  * :white_check_mark: `SQL Server Database`, `Hadoop`, `HBase`.
* In ambiguous cases, adhere to one option for consistency:
  * :white_check_mark: Unix, bash, IPv4, IPv6, URL.
  * :no_entry: UNIX, Bash, IP v4, IP v6, Url.

### Contractions

* Replace "i.e." or "e.g." with "for example".
  * :white_check_mark: ``Specify the recipient, for example `user@example.org`.``
  * :no_entry: ``Specify the recipient, e.g. `user@example.org`.``
* "etc" is allowed.
* Replace `don't`, `can't`, `hasn't`, `isn't`, `didn't` with `do not`, `cannot`, etc.
  * :white_check_mark: `The parameter is not valid.`
  * :no_entry: `The parameter isn't valid.`

### Commas

* Do not use a comma to separate clauses with multiple actors. Create separate sentences.
  * :white_check_mark: `Submit the query. Review the results.`
  * :no_entry: `Submit the query, the result is displayed.`

### Colons

* Begin lists with colons (`:`).
  * :white_check_mark: `Execute the following commands to stop the database:`
* Separate list titles from their content with a colon.
  * :white_check_mark: `Step 1: stop ATSD process.`

### Hyphens

* Hyphenate compound adjectives.
  * :white_check_mark: `Cancel a long-running query`.
* Do not hyphenate adverb adjectives that end with `ly`.
  * :white_check_mark: `Review frequently used queries`.
  * :no_entry: `Load data from the publicly-accessible service`.
* Do not use a hyphen to separate title from meaning, use a [colon](#colons).
  * :white_check_mark: `Meta Query: retrieves metadata from the service.`
  * :no_entry: `Meta Query - retrieves metadata from the service.`

### Numbers

* Write out numbers one through ten, unless they have units.
  * :white_check_mark: `There are three ways to perform this calculation`.
* Write out ordinal numbers.
  * :white_check_mark: `The first query causes the database to lock the table`.
* Add thousands separator except for milliseconds and machine output.
  * :white_check_mark: `Stop the query if the row count exceeds 1,000`.
* Insert a space between a number and multiple-letter unit. Omit space for one-letter units.
  * :white_check_mark: `8 GB`, `128 MB`, `2 CPUs`, `10%`.

### Parentheses

* Do not use parentheses.
  * :white_check_mark: ``Execute `SELECT 1` query to test the connection.``
  * :no_entry: ``Execute any query (such as `SELECT 1`) to test the connection.``
* Parentheses are allowed to spell out a number or character sequence.
  * :white_check_mark: ``The field supports wildcards (`*`).``
  * :white_check_mark: ``Up to nine (`9`) fractions are printed.``

### Possessives

* Do not use possessives.
  * :white_check_mark: `Modify the file content` or `Modify the contents of the file`.
  * :no_entry: `Modify the file's content`.

### Quotation Marks

* Do not use quotation marks.
* To designate [UI elements](#interface-elements) use bold text.
  * :white_check_mark: `Click **View** to proceed`.
  * :no_entry: `Click on 'View' to proceed`.
* To designate single-line machine output use bold text or backticks.
  * :white_check_mark: `Watch the log file for **Start completed** message.`
  * :white_check_mark: ``Watch the log file for `Start completed` message.``
  * :no_entry: `Watch the log file for "Start completed" message.`
* To designate multiple-line machine output use code blocks with `txt` dialect.

---

## Formatting

### Backticks

Apply single backticks to the following:

* File names: `atsd.log`.
* Directory and file paths: `/opt/atsd/atsd/conf/server.properties`.
* File extensions: `.png`, `.xml`.
* Program names: `curl`, `wget`, `cron`.
* Email addresses: `user@example.org`.
* Host names and IP addresses: `127.0.0.1`, `2001:db8::1`.
* HTTP methods: `POST`, `GET`.
* HTTP status codes: `200 OK`, `404`.
* HTTP status code ranges: `2xx`, `3xx`.
* URI paths and query strings: `/api/v1/{entity}/metrics`.
* Header names and values.
  * Set `Content-Type` header to `application/json`.
* Function and procedure names.
* Reserved SQL keywords and clauses.
  * Add condition to the `HAVING` clause.
* Parameter, field, and variable names.
  * ``Reset `queue.policy` to `BLOCK` setting.``
  * ``Locate the `github-notify` rule on the **Alerts** page.``
* Parameter, field, and variable values, including boolean values and numbers.
  * ``Set `limit` field to `16` batches.``
* Usernames.
  * ``Switch to `axibase` user.``
* Port numbers.
  * ``Make sure ATSD is listening on port `8443`.``
* Version numbers.
  * ``Python `3.5` is required for ATSD version `19420`.``
* Single-line machine output. Bold text is also allowed.
  * :white_check_mark: ``Watch the log file for `Start completed` message.``
* Shell commands: `su`, `chown`, `sudo`.

**Exceptions**:

* Do not backtick an acronym, unless it represents a field or parameter value.
  * :white_check_mark: ``Select `GZIP` or `LZO` option in the **Codec** drop-down list.``
  * :no_entry: ``The file is exported in `CSV` format.``
* Do not use backticks in headings.
  * :white_check_mark: `## Install Python 3.5 using curl`.

### Code Blocks

* Fence code with triple backticks.
* Fence multiple-line machine output with triple backticks.
* Apply the correct dialect such as `javascript` or `python`.
  * Use `txt` for ASCII tables.
  * Use `json` for JSON documents, `xml` for XML files etc.
  * Use `txt` for machine output, unless the output is formatted, in which case use  appropriate dialect.
  * Use `ls` for Charts configuration.
  * Use `javascript` for rule engine expressions.

### Dates and Times

* Spell out month if the format is ambiguous:
  * :white_check_mark: `01/Jun/2018`.
  * :no_entry: `06/01/2018`.
* Do not use ordinal numbers in dates.
  * :white_check_mark: `April 15`.
  * :no_entry: `April 15th`.
* Use commas with full dates.
  * :white_check_mark: `The report was published on December 13, 2017`.
* Write time in 24-hour format.
  * :white_check_mark: `April 15, 2018 at 20:30`.
  * :no_entry: `April 15, 2018 at 8:30 pm`.

### Headers

* Use [title case](https://titlecase.com/) in headers.
  * :white_check_mark: `## Import Data from File`.
  * :no_entry: `## Import data from file`.
* Do not use backticks in headers.
  * :white_check_mark: `## Configure cron`.
  * :no_entry: ``## Configure `cron` schedule``.
* Do not terminate sentences in headers with dot.
  * :no_entry: `## Import data from file.`
* Avoid punctuation symbols in headers except colon (`:`).
  * :no_entry: `## Import Data from File (Directory)`.

### Links

* Use relative paths when linking markdown files in the same repository:
  * :white_check_mark: `Initiate a [restart](../../administration/restarting.md)`.
  * :no_entry: `Initiate a [restart](/administration/restarting.md)`.
* When linking to documents in the same repository, link to markdown files, and not to `https://axibase.com/` URLs:
  * :white_check_mark: `Initiate a [restart](../../administration/restarting.md)`.
  * :no_entry: `Initiate a [restart](https://axibase.com/docs/atsd/administration/restarting.html)`.
* Describe the linked document in the link title:
  * :white_check_mark: `Review [installation notes](install.md).`
  * :no_entry: `Click [here](install.md) to view installation notes.`

---

## Style

### Active Voice

* Maintain active voice for technical documentation.
  * :white_check_mark: `The database filters metrics based on user settings.`
  * :no_entry: `Metrics are filtered based on user settings`
* Describe both the actor and the action, or use the imperative to instruct a user.
  * :white_check_mark: `Log in to ATSD web interface to import the CSV file on the CSV Parsers page. Configure upload settings to filter unneeded metrics.`
  * :no_entry: `When the CSV file is imported, unneeded metrics are filtered.`

### Blacklisted Words

word | alternatives
---|---
`should` | use `must` or remove
`could` | -
`would` | -
`may` | `can`
`will` | use present tense
`was` | use present tense
`were` | use present tense
`had` | use present tense
`abort` | `stop`, `cancel`
`kill` | `stop`, `cancel`
`terminate` | `stop`, `cancel`
`admin` | `administrator`
`so, a lot` | use formal style
`deselect` | `clear`
`uncheck` | `clear`
`flag` | `option`, `setting`
`ingest` | `load`, `import`
`lets` | -
`please` | -
`regex` | `regular expression`
`Epoch time` | `Unix time`
`datacenter` | `data center`
`and/or` | clarify the meaning
`in order to` | `to`
`make sure` | `ensure`
`end-point` | `endpoint`
`click on` | `click`
`robust` | avoid trite words

### Example Names

* IPv4 address: `192.0.2.1`, `198.51.100.1`, `203.0.113.0` per [RFC 5737](https://tools.ietf.org/html/rfc5737).
* IPv4 address range: `192.0.2.0/24`, `198.51.100.0/24`, `203.0.113.0/24`.
* IPv6 address: `2001:db8::1` per [RFC 3849](https://tools.ietf.org/html/rfc3849).
* IPv6 address range: `2001:db8::/32`.
* Phone number: `(800) 555-0100`.
* Host name: `atsd_hostname`, `atsd_ip_address`.
* DNS name: `example.org` per [RFC 2606](https://tools.ietf.org/html/rfc2606), [localized domains](https://www.iana.org/domains/reserved).
* Subdomain: `test.example.org`, `atsd.example.org`.
* Organization: Example Foundation, Example Corporation. Avoid [`Contoso`](https://en.wikipedia.org/wiki/List_of_fictional_Microsoft_companies).
* Email: `user@example.org`, `test@example.org`, `john.doe@example.org`.
* First name: `John`, `Jack`, `Jane`, `Mary`.
* Last name: `Doe`, `Smith`, `Jones`.
* Credentials: `username` and `password`, `username:password`, and `john.doe:secret` in examples.
* SSN: `000-00-0000`.
* File path: `/path/to/new-dir`, `/path/to/new-file`. Replace `new-dir` and `new-file` to indicate the purpose, for example, `/path/to/backup-dir`.

### Interface Elements

* Interface elements must be **bold**, exactly as they appear in the UI.
* Add `>` to describe navigation sequences.
  * :white_check_mark: `Open the **Alerts > Rules** page`.
* Do not include types for named elements: button, split-button, checkbox, drop-down list, field, link, switch.
  * :white_check_mark: `Click **Next**`.
  * :white_check_mark: ``Select `CSV` from **File Format**``.
  * :white_check_mark: `Open the **Rules** page`.
  * :no_entry: `Click **Next** button`.
  * :no_entry: ``Select `CSV` from the **File Format** drop-down list``  .
* Use consistent UI element types:
  * button
  * split-button (not multi-action button, drop-down button, combo-button)
  * checkbox (not check box)
  * drop-down list (not drop-down menu)
  * tab
  * link
  * page
  * button
  * switch (not selector)
  * window
  * dialog window (not popup window)
  * left menu (also main menu)
  * top menu
* Use "the" article when referring to the element by type.
  * :white_check_mark: `Click the **Web Notifications** tab`
  * :no_entry: `Click **Web Notifications** tab`
* Use `log in` as verb and `login` as noun.
  * :white_check_mark: `Log in to ATSD`.

### Issue Subjects

* Add prefix (topic) to subject. The topic can repeat the category or clarify it if necessary.
  * :white_check_mark: `UI: SQL Query Statistics page error.`
* Use regular case (not title case) in the subject.
* Use the imperative for features.
  * :white_check_mark: `Storage: Add table details to data consistency page.`
* Use descriptive sentences for bugs.
  * :white_check_mark: `NMON Parser: property record is not updated.`

### Functions

* Use present tense for function descriptions. Omit the noun.
  * :white_check_mark: `Returns a collection of alert history records`.
  * :white_check_mark: `Returns the natural logarithm of x`.
  * :no_entry: `This function returns a collection of alert history records`.
  * :no_entry: `Return a collection of alert history records`.

### Phrasing

* Remove verbiage, such as `execute these steps`, `follow the prompts`, `perform these tasks`, `by executing the following command`.
  * :white_check_mark: `Create a Slack [workspace](https://slack.com/create).`
  * :no_entry: `Go to https://slack.com/create and follow the prompts to create a new workspace.`
  * :white_check_mark: ``Remove the ephemeral `/hbase` directory from Zookeeper cache.``  
  * :no_entry: ``Execute the command to remove the ephemeral `/hbase` directory from Zookeeper cache.``
  * :white_check_mark: `Add nmon to crontab to collect the data constantly.`
  * :no_entry: `Setup crontab with the following commands so that nmon will collect the data constantly.`
* Describe what the command does.
  * :white_check_mark: ``Launch the `inotify` script to watch for file changes.``
  * :no_entry: `Run the script with the following command:`
* Favor `example` over `sample`.
  * :white_check_mark: `Example configuration:`
  * :no_entry: `Sample configuration:`

### Present Tense

* Do not use `will`, `was`, `were`, `had`. Write in the present tense.
  * :white_check_mark: `Collector starts the job immediately.`
  * :no_entry: `Collector will start the job immediately.`

### Product Names

* Use original product names unless you introduce an abbreviation.
* Articles can be omitted from product names in most cases.
  * :white_check_mark: `Axibase Time Series Database`
  * :no_entry: `The Axibase Time Series Database`

### Variables

* Use curly brackets (`{}`) to designate a variable in URI path or query string:
  * :white_check_mark: `/api/{entity}/metrics`
  * :white_check_mark: `/api/metrics?id={metricId}`
* Use camelCase in compound variable names in REST API:
  * :white_check_mark: `entityGroup`
  * :no_entry: `entity-group`
* Add "the" article before the variables with types.
  * :white_check_mark: ``Open the `atsd.log` file.``
  * :no_entry: ``Open the file `atsd.log`.``

---

## Configuration

### Automated Checks

Configure Travis CI to check custom rules as part of the pull request workflow.

![Travis](./docs/images/travis-check.png)

### Custom Rules

The repository contains custom rules for identifying inconsistencies and style violations.

### Rule Scope

To enable or disable [rules](./linting-rules/) within a given Markdown file, wrap the text with non-printable HTML comments.

* Disable all rules: `<!-- markdownlint-disable -->`
* Enable all rules: `<!-- markdownlint-enable -->`
* Disable specific rules: `<!-- markdownlint-disable MD001 MD002 -->`
* Enable specific rules: `<!-- markdownlint-enable MD001 MD002 -->`

For example:

```markdown
<!-- markdownlint-disable MD037 -->
deliberate space * in * emphasis
<!-- markdownlint-enable MD037 -->
```

To disable the rule for the entire `*.md` file,
add the `markdownlint-disable` marker before the first header.

A `markdownlint-enable` marker is not necessary in this case.