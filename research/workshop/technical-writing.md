# Technical Writing for Axibase Developers

## Index

* [Introduction](#introduction)
* [Language and Grammar](#language-and-grammar)
  * [Abbreviations](#abbreviations)
  * [Active Voice](#active-voice)
  * [Capitalization](#capitalization)
  * [Contractions](#contractions)
  * [Plurals in Parentheses](#plurals-in-parentheses)
  * [Possessives](#possessives)
  * [Present Tense](#present-tense)
  * [Pronouns](#pronouns)
  * [Second Person](#second-person)
* [Punctuation](#punctuation)
  * [Colons](#colons)
  * [Commas](#commas)
  * [Hyphens](#hyphens)
  * [Parentheses](#parentheses)
  * [Quotation Marks](#quotation-marks)
  * [Slashes](#slashes)
* [Formatting and Organization](#formatting-and-organization)
  * [Dates and Times](#dates-and-times)
  * [Headings and Titles](#headings-and-titles)
  * [Lists](#lists)
  * [Notes](#notes)
  * [Numbers](#numbers)
* [Computer Interfaces](#computer-interfaces)
  * [Code in Text](#code-in-text)
  * [Linking to External Sites](#linking-to-external-sites)
  * [Interface Elements](#interface-elements)
* [Names and Meaning](#names-and-meaning)
  * [File Names](#file-names)
  * [Product Names](#product-names)
  * [Documentation Names](#documentation-names)
  * [Issue Names](#issue-names)
  
## Introduction

Axibase Documentation adheres to most of the guidelines specified by the [Google Developer Documentation Style Guide](https://developers.google.com/style/). This documentation style focuses on clarity and simplicity, reducing ambiguity, and creating documentation that lets end users experience the full depth of Axibase tools and products.

These simple guidelines prevent documentation from ending up with a [GitHub Issue](https://github.com/search?q=terrible+documentation&type=Issues) for terrible documentation.

## Language and Grammar

### Abbreviations

Software documentation uses a lot of abbreviations. In technical documents, consistent practice is important to maintain style across repositories.

Follow these guidelines to remain in-sync with Axibase principles:

* For common file types, simply abbreviate using capital letters.
  * XLSX, CSV, JSON, XML.
* For other file types and extensions, fence the text, use lowercase letters, and include a period ebfore the abbreviation.
  * `.jar`, `.yml`, `.bashrc`, `.exe`

Fence `HTTP` request methods:

* `HTTP` Request Methods:
  * `GET`
  * `POST`
  * `PUT`
  * `DELETE`

Use "etc." with a period. Do not use "e.g." or "i.e.".

Other abbreviations such as API, UTC, or EST should not be fenced. Abbreviations such as `HTTP` and `HTTPS` should be fenced.

A good rule of thumb: if you say the abbreviation by reading each letter, do not fence the text. If you say the abbreviation as a word, fence the text.

### Active Voice

Maintain active voice for technical documentation. Unless absolutely necessary, avoid passive voice. When you need to use passive voice, include a second clause which describes who or what performs the action taking place in the passive. Passive voice makes it difficult to understand who or what performs the action taking place.

* The query is saved in the database.
  * Who saves the query? The database? The user?
* The data is loaded from CSV file.
  * By whom?

Instead, describe both the actor and the action, or use the imperative to instruct a user.

* Save the query in the database.
* ATSD will load the data from the CSV file.

### Capitalization

Capitalize proper nouns and interface elements. When using proper nouns which are purposely left lowercase, these nouns may be left lowercase.

* Axibase Time Series Database **not** Axibase Time Series database.
* nginx **not** NGINX.
* Axibase Collector **not** Axibase collector.

For more information about capitalization, see [Headings and Titles](#headings-and-titles) and [Names and Meanings](#names-and-meanings).

### Contractions

Although Google maintains that some contractions are acceptable in technical documentation, avoid using contractions when writing Axibase technical documentation. Contractions add a casual feeling which is not needed.

Recommended:

* If Collector does not start, check the logs for error messages.

Not recommended:

* If Collector doesn't start, check the logs for error messages.

For more information, see [**Pronouns**](#pronouns).

### Plurals in Parentheses

Avoid using **plural(s)** in parentheses. This creates ambiguity in technical documentation because a reader is unsure if multiple units are required or optional. If you have to indicate that there are one or multiple options, use both singular and plural form.

Avoid:

* The database parses the file(s) into human-readable format.

Instead use:

* The database parses the file or files into human-readable format.

### Possessives

Avoid using possessives unless they apply to a business, and even then, use caution. Find a way to reorganize a sentence if the subject possesses something included there.

Do not use:

* The database's Rule Engine enables automation of repetitive tasks.

Instead use:

* The Rule Engine in ATSD enables automation of repetitive tasks.

### Present Tense

Always write in the present tense. This practice avoids ambiguity in explanations that deal with time. If someone hears that something **will** happen, but does not have an answer to the question "when?" it may make completing the task more difficult. Describe events that occur in the future with the present tense plus time condition.

Avoid:

* The database will query the API and return JSON results.

Instead use:

* The database queries the API and returns JSON results.

This style keeps the reader engaged in the process, instead of expecting to wait around for an undefined period of time. This gives your writing the feeling of continuity.

### Pronouns

Do not use pronouns. "It" and "they" are abstract concepts, and technical documentation should strive to be anything but abstract. Sentences with multiple subjects can become confusing very quickly when ambiguous pronouns are introduced.

* This command launches ATSD and Axibase Collector, it logs errors in the file `axibase-collector.log` file.
  * Are you talking about the command, ATSD, or Collector?

Specify:

* This command launches ATSD and Axibase Collector. Collector logs errors in the file `axibase-collector.log`.

The above example is not as ambiguous as possible, because the subject doing the logging is named in the `.log` file. Other sentences however, do not offer such a straightforward solution:

* The script will continuously read consumer offsets from Kafka and send the offsets to ATSD as series commands. It can copy the commands to `stdout` for debugging.
  * Are you talking about the script, Kafka, or ATSD?

Specify:

* The script will continuously read consumer offsets from Kafka and send the offsets to ATSD as series commands. Kafka copies the commands to `stdout` for debugging.

### Second Person

The second person is "you" and "we." Using "you" is a good way to let the reader know you are addressing the reader directly and the task described is performed by the reader. That said, use "you" sparingly, and only when needed. "We" and "us" should be avoided.

* "Let's" is a contraction which means "let us." For this reason, and the reasons described by the [Contractions](#contractions) section, do not use this form.

Avoid:

* We can configure ATSD to alert anytime recorded values exceed expected values calculated by [Data Forecast](https://axibase.com/docs/atsd/forecasting/).

Instead use:

* You can configure ATSD to alert anytime recorded values exceed expected values calculated by [Data Forecast](https://axibase.com/docs/atsd/forecasting/).

> Return to the [Index](#index).

## Punctuation

### Colons

Begin lists with colons (:), but use the appropriate formatting.

Avoid:

* The best ways to download ATSD are:

Instead use:

* The best ways to download ATSD are as follows:

Use colons to separate a list title from the meaning.

* Name: what people call you.
* Age: laps around the sun.
* Hobbies: what you do for fun.

### Commas

Commas can create ambiguous sentences when two clauses of one sentence contain different actors. Similar to the ambiguity described by the [Pronouns](#pronouns) section, commas may create more problems than solutions.

Do not use:

* ATSD can upload job configuration files in XML format, navigate to the **Job Import** page to upload files.

Instead, break the sentence apart so each actor is understood:

* ATSD can upload job configuration files in XML format. Navigate to the **Job Import** page to upload files.

Add commas to numbers greater than 1,000.

Recommended:

* 1,000,000,000,001

Not recommended:

* 1000000000001

### Hyphens

Hyphenate compound adjectives that do not have a component which ends in "-ly" (adverb-adjective compounds), hyphenate compound adjectives that begin with "self," and words a reader may otherwise confuse without a hyphen.

The following examples demonstrate several cases where hyphenation is appropriate:

* Authorize the webhook to accept self-signed certificates.
* Open the **Portal** drop-down list and select **Configure**.
* If the launch fails, re-count the number of included parameters and restart the process.

> For more information about defining parts of the user interface, see [Interface Elements](#interface-elements)

The following examples demonstrate several cases where hyphenation is inappropriate:

* The world-wide web is used by everyone.
* The publicly-accessible [**Trends**](../../how-to/shared/trends.md) service is an excellent visualization tool.

Do not use a hyphen to separate title from meaning, use a [colon](#colons).

Recommended:

* Name: what people call you.
* Age: laps around the sun.
* Hobbies: what you do for fun.

Not recommended:

* Name - what people call you.
* Age - laps around the sun.
* Hobbies - what you do for fun.

### Parentheses

Use parentheses for parenthetical statements. That is, do not include important information in parentheses. Use parentheses to provide an example as to why a reader may do something.

* Modify the query (for example, remove [`LIMIT`](https://axibase.com/docs/atsd/sql/#limiting)), select a file format, and optionally include [metadata](https://axibase.com/docs/atsd/sql/#sql-report-metadata)

Removing `LIMIT` here is not a required step, but still germane to the provided information.

Not recommended:

* Open the **JMX Job** page (found by clicking **Jobs** on the top menu), and export the configuration.

### Quotation Marks

Write commas and periods inside quotation marks unless doing so would be aesthetically inadvisable. Do not use quotation marks to designate user [interface elements](#interface-elements) or features.

Write quoted text as follows:

* "This is the way to use quotation marks."

Do not use:

* Click "Save" and then "Export".

### Slashes

Do not use slashes to distinguish between two choices.

Avoid:

* ATSD can import/export data as needed.

Instead use:

* ATSD can import and export data as needed.

> Return to the [Index](#index).

## Formatting and Organization

### Dates and Times

Different countries use different date and time formats. Avoid ambiguity in technical writing by using the complete date. Fence machine output so readers know the date is written in a structure such as UTC time.

The correct way:

* June 2018
* June 8, 2018
* 8 June, 2018
* `2018-08-16`

The incorrect way:

* 06/08/18
* 08/06/18
* 18/08/06
* 18/06/08

### Headings and Titles

Avoid using fenced text in headings. Capitalize the words in a heading prepositions and articles. If these words are the first word of the heading, capitalize the word.

Recommended format:

#### Using a Docker Container to Launch ATSD

#### Webhook Configuration from GitHub API

#### From Data.gov Dataset to ATSD in Five Minutes

Do not punctuate headings or titles.

### Lists

If a list follows a step-by-step procedure, use numbers:

1. Log in to ATSD.
2. Open the **Entities** tab.
3. Expand the split button and select **Import**.

If a list contains multiple choices for one decision, use bullet points:

There are several ways to remove a Docker Container:

* Use `docker rm -vf` plus the container ID.
* Use `docker rm -vf` plus the image name.
* Destroy your computer.

If the list contains sentences (even fragments), end each point with a period. If the list contains single words, do not use punctuation.

The three best time series databases currently available are as follows:

* ATSD
* ATSD
* ATSD

For bullet points with sub-units, indent the sub-unit using two spaces, not with four spaces, not with a tab.

* This is a bullet point.
  * This is a sub-unit.
    * This is an even smaller sub-unit.

### Notes

Include notes when needed but separate the note so as not to lead a reader to believe the note is critical to the process.

1. Download the parser configuration
2. Open the **Data** menu and select **CSV Parsers**
3. On the **CSV Parsers** page click **Import** and select the file from your local filesystem.

> For more information about uploading CSV files, see the [Axibase Documentation](https://axibase.com/docs/atsd/parsers/csv/).

General notes that do not refer to a specific part of a process but are relevant nonetheless should be appended to the end of a document by the author.

### Numbers

Unless the number is part of machine output, write out numbers one through ten. If the number applies to a version number, write the number itself regardless of value. Write out ordinal numbers. Add commas to numbers greater than 1,000 (excluding machine output).

Recommended:

* Download the [ATSD Python Client](https://axibase.com/docs/atsd/api/clients/#python) for the following Python versions:
  * Python `v2.7.9` or later.
  * Python `v3` all versions.

Fence version numbers and HTTP status codes to maintain consistency.

HTTP status codes are shown below:

Response | Meaning
---|---
`2xx` | Success
`3xx` | Redirect
`4xx` | Client Error
`5xx` | Server Error

When describing amounts of memory, write literal numbers and separate the number from the unit.

* 4 GB **not** 4GB
* 80 MB **not** 80MB

Do not fence memory units or associated numbers.

> Return to the [Index](#index).

## Computer Interfaces

### Code in Text

Fence code in documentation. Use the appropriate label so Markdown properly displays all included code.

Javascript:

```javascript
var x, y, z;    // Statement 1
x = 5;          // Statement 2
y = 6;          // Statement 3
z = x + y;      // Statement 4
```

Shell:

```sh
cat file1                       # list file1 to screen
cat file1 file2 file3 > outfile # add files together into outfile
cat *.txt > outfile             # add all .txt files together
cat file1 file2 | grep fred     # pipe files
```

Python:

```python
if True:
   print "True"
else:
   print "False"
```

SQL:

```sql
SELECT NULL
  FROM "mpstat.cpu_busy"
LIMIT 1
```

When describing implementations or tools, fence the name.

Examples:

* `curl`
* `bash`

Do not fence program names, fields contents, or interface features unless there is code or non-standard naming present.

* The **Condition** field contains `count == 1`
* The **Name** field contains **My Job Name**
* Open the **Rules** page and select `activemq_health_status`.

### Linking to External Sites

If an article or document describes a third-party software or service, link to the the homepage of that software or service at the first mention. Where relevant, introduce specific documents or articles that are relevant to your documentation.

* For more information see the [GitHub Developer Guide](https://developer.github.com/v3/?).
* This article describes the ATSD Client for [Python](https://www.python.org/).

### Interface Elements

Interface elements should be **bold**. When describing interface elements include the type of element, unless that element is a button. Do not say **click on** something, rather **click** something.

* Open the **Portal** menu and click **Configure**.
* The **Job** page contains the list of available Collector Jobs.
* When you finish configuring the rule, click **Save**.

Do not bold program names such as Axibase Collector or ATSD, but do bold service names such as **ChartLab** and **Trends**.

Axibase products contain drop-down **lists**, not drop-down **menus**.

> Return to the [Index](#index).

## Names and Meaning

### Files Names

Document names should be lowercase and contain no whitespace. Instead use a [hyphen](#hyphens).

Recommended:

* `my-new-document.md`

Not recommended:

* `MyNewDocument.md`
* `MY NEW DOCUMENT.md`

### Product Names

For brevity, you may shorten Axibase product names. The product name should remain capitalized unless you refer to a general concept in place of the product name. Articles may be omitted in most cases.

* Start Collector with the following command:

```sh
./axibase-collector/bin/start-collector.sh
```

* The database begins logging information immediately.
* ATSD is a Hadoop-based time series database.

### Documentation Names

Axibase Documentation is a proper noun, capitalize Axibase Documentation every time. When referring to a specific document or guide, you may leave the type of document lowercase.

* For more information, see the [Axibase Documentation](https://axibase.com/docs/atsd/).
* To install ATSD, read the [Installation article](https://axibase.com/docs/atsd/installation/).

### Issue Names

Axibase tracks issues in Redmine. Follow these guidelines for proper issue reporting:

* Use prefixes for specific ticket subjects. If `rest-api` is too general a category, add **Python API Client** prefix to the issue subject.
* Use the imperative for new features.
* Use descriptive sentences for describing bugs.
* Link to the relevant documentation.

> Return to the [Index](#index).
