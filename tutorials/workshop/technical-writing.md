# Technical Writing for Axibase Developers

Each section contains links to the corresponding section of [Google Style Guides](https://developers.google.com/style/). Refer there for general guidelines.

## Index

* [Language and Grammar](#language-and-grammar)
  * [Abbreviations](#abbreviations)
  * [Active Voice](#active-voice)
  * [Capitalization](#capitalization)
  * [Contractions](#contractions)
  * [Possessives](#possessives)
* [Punctuation](#punctuation)
  * [Colons](#colons)
  * [Commas](#commas)
  * [Hyphens](#hyphens)
  * [Parentheses](#parentheses)
  * [Quotation Marks](#quotation-marks)
* [Formatting and Organization](#formatting-and-organization)
  * [Backticks](#backticks)
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

* Abbreviate if the acronym is known to the target audience.
* Do not backtick acronyms.

### Active Voice

* Maintain active voice for technical documentation.
* Describe both the actor and the action, or use the imperative to instruct a user.

### Capitalization

* Capitalize proper nouns, headings, and interface elements.

### Contractions

* Do not use contractions.

### Possessives

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

* File names.
* Program names.
* HTTP Methods.
* API Endpoint paths.
* Parameter names, field names, variables.

Exceptions:

* Do not use backticks in headings.

### Headings and Titles

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
