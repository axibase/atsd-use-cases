# Axibase Developer Documentation Style Guide

Refer to [Google Developer Documentation Style Guide](https://developers.google.com/style/) (GDG) for more details.

## Abbreviations

* Follow [GDG: abbreviations](https://developers.google.com/style/abbreviations).
* Abbreviate if the acronym is known to the target audience.
* Do not backtick acronyms.
* Replace "i.e." or "e.g." with "for example".
* Always abbreviate:
  * ATSD (if used in our docs repositories).
  * Common data formats: CSV, JSON, XLS, XML, XLS.
  * Widely known terms: SSH, SQL, API, HTTP, REST, JVM.
* If an acronym is new, introduce it in the beginning and re-use thereafter.
  * "Axibase Time Series Database (ATSD) is a non-relational database."

## Active Voice

* Follow [GDG: active voice](https://developers.google.com/style/voice)
* Maintain active voice for technical documentation.
* Describe both the actor and the action, or use the imperative to instruct a user.

## Capitalization

* Follow [GDG: capitalization](https://developers.google.com/style/capitalization).
* Do not capitalize program names such as `curl`.
* Use title case in headers, except prepositions, articles, and program names.
  * "### Import Data from Archive using curl"
* Do not capitalize the first word after the colon in a list.
  * Step 3: unzip files.
* Do not capitalize file extensions.
  * ".png", ".xml", ".jar"  

## Contractions

* Do not use contractions.
  * "don't", "can't", "hasn't", "isn't", "didn't"

## Possessives

* Do not use possessives.
  * Modify server properties, not modify the server's properties.
  * The contents of the file, not the file's contents.

## Punctuation

### Colons

* Follow [GDG: colons](https://developers.google.com/style/colons)
* Begin lists with colons (:), but use the appropriate formatting.
* Separate list titles from their content with a colon.

### Commas

* Do not use a comma to separate two clauses with multiple actors. Instead create two separate sentences.
* Add commas to numbers greater than 1,000.

### Hyphens

* Follow [GDG: hyphens](https://developers.google.com/style/hyphens)
* Hyphenate compound adjectives that do not have a component which ends in "-ly" (adverb-adjective compounds).
* hyphenate compound adjectives that begin with "self."
* hyphenate words a reader may otherwise confuse without a hyphen.
* Do not use a hyphen to separate title from meaning, use a [colon](#colons).

### Parentheses

Do not use parentheses. If you need to make a parenthetical note, use the [Notes](#notes) guidelines.

### Quotation Marks

* Do not use quotation marks. To designate user [interface elements](#interface-elements), machine output, or features use **Bolding**.

## Formatting and Organization

### Backticks

Apply single backticks to the following:

* File names: `atsd.log`
* Directory and file paths: `/opt/atsd/atsd/conf/server.properties`
* File extensions: `.png`, `.xml`
* Program names: `curl`, `wget`
* HTTP Methods: `POST`, `GET.`
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

Exceptions:

* Do not use backticks in headings.

### Headers

* Use title case in headers. Anything prefixed with markdown hash is a header.
  * "Import Data from File"
* For bullet points with sub-units, indent the sub-unit using two spaces, not with four spaces, not with a tab.

### Notes

* Include notes when needed but separate the note so as not to lead a reader to believe the note is critical to the process.
* General notes that do not refer to a specific part of a process but are relevant nonetheless should be appended to the end of a document by the author.

### Numbers

* Backtick version numbers and HTTP status codes.
* When describing amounts of memory, write literal numbers and separate the number from the unit.
  * 8 GB, 128 MB, etc.
* Write out numbers one through ten, unless they pertain to amounts of memory:
  * There are three ways to perform this calculation
* Write out ordinal numbers:
  * First, second, third, etc.
* For numbers greater than 1,000 use commas where appropriates.
  * Do not use commas for machine output such as Unix epoch time: `1529074796`

## Computer Interfaces

### Code in Text

* Follow [GDG: code in text](https://developers.google.com/style/code-in-text)
* Fence code in documentation.
* Use the correct heading such as `javascript`, or `python`

### Interface Elements

* Interface elements should be **bold**.
* When describing interface elements include the type of element, unless that element is a button.
* Axibase products have drop-down lists.
* Dialogs are windows which open within a page.
* The **Top Menu** appears along the top of the user interface while the **Left Menu** appears on the left side of the page.

## Names and Meaning

### Files Names

* Document names should be lowercase and contain no whitespace

### Product Names

* Shorten Axibase product names after you introduce the abbreviation.
* The product name should remain capitalized unless you refer to a general concept in place of the product name.
* Articles may be omitted in most cases.

### Documentation Names

* Axibase Documentation is a proper noun, capitalize Axibase Documentation every time.
* When referring to a specific document or guide, you may leave the type of document lowercase.

### Issue Names

* Use prefixes for specific ticket subjects. If `rest-api` is too general a category, add **Python API Client** prefix to the issue subject.
  * "UI: SQL Query Statistics page error."
* Use the imperative for new features.
  * "Implement Data Consistency page."
* Use descriptive sentences for describing bugs.
  * "`nmon` property record is not updated."
* Link to the relevant documentation.
