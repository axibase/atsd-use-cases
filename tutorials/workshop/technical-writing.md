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

## Possessives

* Do not use possessives.

## Punctuation

### Colons

* Begin lists with colons (:), but use the appropriate formatting.
* Separate list titles from their content with a colon.

### Commas

* Do not use a comma to separate two clauses with multiple actors. Instead create two separate sentences.
* Add commas to numbers greater than 1,000.

### Hyphens

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

## Computer Interfaces

### Code in Text

* Fence code in documentation.
* When describing implementations or tools, fence the name.
  * `curl`
  * `bash`
* Do not fence program names, fields contents, or interface features unless there is code or non-standard naming present.

### Interface Elements

* Interface elements should be **bold**.
* When describing interface elements include the type of element, unless that element is a button.

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
* Use the imperative for new features.
* Use descriptive sentences for describing bugs.
* Link to the relevant documentation.
