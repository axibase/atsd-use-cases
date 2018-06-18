# Axibase Developer Documentation Style Guide

Refer to [Google Developer Documentation Style Guide](https://developers.google.com/style/) (GDG) for in-depth reviews of each section.

## Abbreviations

> [GDG: abbreviations](https://developers.google.com/style/abbreviations).

* Abbreviate if the acronym is known to the target audience.
* Do not backtick acronyms.
* Always abbreviate:
  * Common data formats: CSV, JSON, XLS, XML, XLS.
  * Protocols: HTTP, HTTPS, TCP, UDP, SSH.
  * Widely known terms: SQL, API, REST, JVM.
  * ATSD when used in our docs repositories: atsd, atsd-use-cases, axibase-collector.
* If an acronym is new, introduce it in the beginning and re-use thereafter.
  * "Axibase Time Series Database (ATSD) is a non-relational database. ATSD is fast."
  
## Contractions

* Replace "i.e." or "e.g." with "for example".
* Replace "don't", "can't", "hasn't", "isn't", "didn't" with full forms: "do not", "cannot", etc.  

## Capitalization

> [GDG: capitalization](https://developers.google.com/style/capitalization).

* Do not capitalize program names such as `curl`, `cron`.
* Use title case in headers, except prepositions, articles, and program names.
  * "### Import Data from Archive using curl"
* Do not capitalize the first word after the colon in a list.
  * Step 3: unzip files.
* Do not capitalize file extensions.
  * ".png", ".xml", ".jar"
* Capitalize product names.
  * "SQL Server Database"
* Preferred for consistency:
  * Unix, not UNIX
  * bash, not Bash
  
## Parentheses

* Do not use parentheses unless to spell out a number or character.
  * Remove text in parentheses in "Execute a sample query (such as `SELECT 1`) to test the connection"
  * "The expression supports wildcards (`*`)"
  * "Up to nine (9) fraction digits are allowed"
* If you need to make a note, refer to [Notes](#notes) guidelines.  

## Colons

> [GDG: colons](https://developers.google.com/style/colons)

* Begin lists with colons (:).
  * "Execute the following commands to stop the database:"
* Separate list titles from their content with a colon.
  * "Step 1: stop ATSD process."

## Quotation Marks

* Do not use quotation marks.
* To designate [UI elements](#interface-elements), machine output, or features use **bold** text.

## Commas

* Do not use a comma to separate two clauses with multiple actors. Instead create two separate sentences.
  * Re-write "Submit the query, the result is displayed." as "Submit the query. Review the results."

## Hyphens

> [GDG: hyphens](https://developers.google.com/style/hyphens)

* Hyphenate compound adjectives.
  * "Cancel a long-running query"
* Do not hyphenate adverb adjectives that end with "ly".
  * "Review frequently used queries"
* Do not use a hyphen to separate title from meaning, use a [colon](#colons).

## Backticks

Apply single backticks to the following:

* File names: `atsd.log`
* Directory and file paths: `/opt/atsd/atsd/conf/server.properties`
* File extensions: `.png`, `.xml`
* Program names: `curl`, `wget`
* HTTP methods: `POST`, `GET.`
* HTTP status codes: `200 OK`, `404`.
* URI paths and query strings: `/api/v1/{entity}/metrics`
* Header names and values.
  * Set `Content-Type` header to `application/json`.
* Function and procedure names.
* Reserved SQL keywords and clauses.
  * Add condition to the `HAVING` clause.
* Parameter, field, and variable names.
  * "Reset `queue.policy` to `BLOCK`"
  * "Local the `github-notify` rule on the **Alerts** page"
* Parameter, field, and variable values, including boolean values and numbers.
  * "Set `limit` field to `16`"
* Usernames.
  * "Switch to `axibase` user"
* Port numbers.
  * "Make sure ATSD is listening on port `8443`"
* Version numbers.
  * "Python `3.5` is required for ATSD version `19420`"

Exceptions:

* Do not use backticks in headings.
  * "## Install Python 3.5 using curl"
  
### Code Block

> [GDG: code in text](https://developers.google.com/style/code-in-text)

* Fence code block with triple backticks.
* Apply the correct dialect such as `javascript` or `python`.
  * Use `txt` for ASCII tables.
  * Use `ls` for Charts configuration.
  * Use `javascript` for rule engine expressions.

## Numbers

* Write out numbers one through ten, unless they have units.
  * "There are three ways to perform this calculation"
* Write out ordinal numbers.
  * "The first query causes the database to lock the table"  
* Add thousands separator except for milliseconds and machine output.
  * "Stop the query if the row count exceeds 1,000"
* When describing amounts of resource, write numeric value and space between the number and the unit.
  * 8 GB, 128 MB, 2 CPUs.
  
## Possessives

* Do not use possessives.
  * Rewrite "Modify the file's content" to "Modify the file content" or "Modify the contents of the file".

## Headers

* Use title case in headers.
  * "## Import Data from File"
* Do not use backticks in headers.
* Do not terminate sentences in headers with dot.
* Avoid punctuation symbols in headers except colon (`:`).

## Lists

* Use two spaces for indentation in bullet lists and numbered lists.

## Active Voice

> [GDG: active voice](https://developers.google.com/style/voice)

* Maintain active voice for technical documentation.
* Describe both the actor and the action, or use the imperative to instruct a user.  

## Present Tense

* Do not use "will" and "was". Right everything in one present tense.

## Blacklisted Words

> [GDG: words](https://developers.google.com/style/word-list)

word | alternatives
---|---
should | must
would | -
abort | stop, cancel
kill | stop, cancel
terminate | stop, cancel
admin | administrator
so | - rephrase in format style
deselect | clear
uncheck | clear
flag | option, setting
ingest | load, import
lets | -
please | -
regex | regular expression
Epoch time | Unix time

## Notes

* Include notes when needed but separate the note so as not to lead a reader to believe the note is critical to the process.
* Notes that are not important but are relevant nonetheless must be appended to the end of a document.

## Interface Elements

* Interface elements are **bold**.
* When describing interface elements include the type of element, except for button. Use the defined article "the".
  * "Click **Next**"
  * "Open the **Alerts** page"
* UI elements in Axibase products:
  * drop-down list (not drop-down menu)
  * tab
  * link
  * page
  * button
  * switch
  * window
  * dialog window (not popup menu)
  * left menu (also main menu)
  * top menu
* In ATSD, the **top menu** appears along the top of the user interface while the **left menu** or the **main menu** appears on the left side of the page.

## Links

* Use relative paths when linking markdown files in the same repository.
  * :white_check_mark: `Perform [ATSD restart](../../administration/restarting.md)`
  * :no_entry: `Perform [ATSD restart](/administration/restarting.md)`  
* When linking to documents in the same repository, link to markdown files, and not to `https://axibase.com/` URLs.
  * :white_check_mark: `Perform [ATSD restart](../../administration/restarting.md)`
  * :no_entry: `Perform [ATSD restart](https://axibase.com/docs/atsd/administration/restarting.html)`

## Product Names

* Shorten product names after you introduce the abbreviation.
* Capitalize product name s unless you refer to a general concept in place of the product name.
* Articles may be omitted from product names in most cases.

## Documentation Names

* Axibase Documentation is a proper noun, capitalize Axibase Documentation every time.
* When referring to a specific document or guide, you may leave the type of document lowercase.

## Issue Subjects

* Use prefixes in subjects. Either repeat the category or clarify it in the prefix if the is too general.
  * "UI: SQL Query Statistics page error."
* Capitalize prefix, use regular case in the remained of the subject.
* Use the imperative for features.
  * "Storage: Add table details to data consistency page."
* Use descriptive sentences for bugs.
  * "NMON Parser: property record is not updated."
