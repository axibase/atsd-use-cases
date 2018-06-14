# Technical Writing for Axibase Developers

Each section contains links to the corresponding section of [Google Style Guides](https://developers.google.com/style/). Refer there for general guidelines.

## Index

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
  * [Fenced Text](#fenced-text)
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

## Language and Grammar

### Abbreviations

* For common file types, abbreviate using capital letters.
  * XLSX, CSV, JSON, XML.

* For other file types and extensions, fence the text, use lowercase letters, and include a period before the abbreviation.
  * `.jar`, `.yml`, `.bashrc`, `.exe`

* Do not fence HTTP request methods.

* Introduce an Axibase-specific abbreviations before using them:
  * Axibase Time Series Database (ATSD) is a non-relational database.

See [Abbreviations](https://developers.google.com/style/abbreviations).

### Active Voice

Maintain active voice for technical documentation. When you need to use passive voice, include a second clause which describes who or what performs the action taking place in the passive.

* The query is saved in the database.
  * Who saves the query? The database? The user?
* The data is loaded from CSV file.
  * By whom?

Describe both the actor and the action, or use the imperative to instruct a user.

* Save the query in the database.
* ATSD loads the data from the CSV file.

See [Active Voice](https://developers.google.com/style/voice).

### Capitalization

Capitalize proper nouns and interface elements. When using proper nouns which are purposely left lowercase, these nouns may be left lowercase.

* Axibase Time Series Database **not** Axibase Time Series database.
* Axibase Collector **not** Axibase collector.

For more information about capitalization, see the [Google Style Guides](https://developers.google.com/style/capitalization), [Headings and Titles](#headings-and-titles), and [Names and Meanings](#names-and-meanings).

### Contractions

Avoid using contractions. Contractions add a casual feeling which is not needed.

Recommended:

* If Collector does not start, check the logs for error messages.

Not recommended:

* If Collector doesn't start, check the logs for error messages.

For more information, see [Google Style Guides](https://developers.google.com/style/contractions) and [**Pronouns**](#pronouns).

### Plurals in Parentheses

Do not use **plural(s)** in parentheses.

See [Google Style Guides](https://developers.google.com/style/plurals-parentheses)

### Possessives

Avoid using possessives.

See [Google Style Guides](https://developers.google.com/style/possessives).

### Present Tense

Write in the present tense.

See [Google Style Guides](https://developers.google.com/style/tense).

### Pronouns

Avoid using pronouns such as "it" and "they."

See [Google Style Guides](https://developers.google.com/style/pronouns)

### Second Person

Do not use "we," instead, instruct users with "you."

See [Google Style Guides](https://developers.google.com/style/person)

> Return to the [Index](#index).

## Punctuation

### Colons

Begin lists with colons (:), but use the appropriate formatting. Separate list titles from their content with a colon.

See [Google Style Guides](https://developers.google.com/style/colons).

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

See [Commas](https://developers.google.com/style/commas).

### Hyphens

Hyphenate compound adjectives that do not have a component which ends in "-ly" (adverb-adjective compounds), hyphenate compound adjectives that begin with "self," and words a reader may otherwise confuse without a hyphen.

Do not use a hyphen to separate title from meaning, use a [colon](#colons).

See [Google Style Guides](https://developers.google.com/style/hyphens).

### Parentheses

Do not use parentheses. If you need to make a parenthetical note, use the [Notes](#notes) guidelines.

See [Parentheses](https://developers.google.com/style/parentheses)

### Quotation Marks

Do not use quotation marks to designate user [interface elements](#interface-elements), machine output, or features.

Do not use:

* Click "Save" and then "Export".

See [Quotation Marks](https://developers.google.com/style/quotation-marks).

### Slashes

Do not use slashes in technical writing.

See [Google Style Guides](https://developers.google.com/style/slashes)

> Return to the [Index](#index).

## Formatting and Organization

### Dates and Times

Avoid ambiguity when writing dates by writting out the data instead of using numbers.

See [Google Style Guides](https://developers.google.com/style/dates-times).

### Fenced Text

The following types of text should be surrounded by backticks:

* Machine output such as `All Applications started` and Unix epoch time `1524960000`.
* Fields which contain code such as a **Condition** field which contains `count == 1`.
* Interface elements with irregular names such as a job titled `activemq_health_status`.
* HTTP status codes.
* Software like `curl` and command languages like `bash`.

### Headings and Titles

For bullet points with sub-units, indent the sub-unit using two spaces, not with four spaces, not with a tab.

* This is a bullet point.
  * This is a sub-unit.
    * This is an even smaller sub-unit.

See [Google Style Guides](https://developers.google.com/style/lists)

### Notes

Include notes when needed but separate the note so as not to lead a reader to believe the note is critical to the process. General notes that do not refer to a specific part of a process but are relevant nonetheless should be appended to the end of a document by the author.

See [Google Style Guides](https://developers.google.com/style/notices)

### Numbers

Fence version numbers and HTTP status codes to maintain consistency. When describing amounts of memory, write literal numbers and separate the number from the unit.

* 4 GB **not** 4GB
* 80 MB **not** 80MB

See [Google Style Guides](https://developers.google.com/style/numbers)

> Return to the [Index](#index).

## Computer Interfaces

### Code in Text

Fence code in documentation. When describing implementations or tools, fence the name.

Examples:

* `curl`
* `bash`

Do not fence program names, fields contents, or interface features unless there is code or non-standard naming present.

* The **Condition** field contains `count == 1`
* The **Name** field contains **My Job Name**
* Open the **Rules** page and select `activemq_health_status`.

See [Code in Text](https://developers.google.com/style/code-in-text).

### Interface Elements

Interface elements should be **bold**. When describing interface elements include the type of element, unless that element is a button. 

For complete guidelines, see [Google Style Guides](https://developers.google.com/style/ui-elements)

> Return to the [Index](#index).

## Names and Meaning

### Files Names

Document names should be lowercase and contain no whitespace. Instead use a [hyphen](#hyphens).

Recommended:

* `my-new-document.md`

Not recommended:

* `MyNewDocument.md`
* `MY NEW DOCUMENT.md`

See [File Names](https://developers.google.com/style/file-names)

### Product Names

For brevity, you may shorten Axibase product names. The product name should remain capitalized unless you refer to a general concept in place of the product name. Articles may be omitted in most cases.

* Start Collector with the following command:

```sh
./axibase-collector/bin/start-collector.sh
```

* The database begins logging information immediately.
* ATSD is a Hadoop-based time series database.

See [Google Style Guides](https://developers.google.com/style/product-names)

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
