# Window Functions in SQL

## Overview

What follows is a rather unusual introduction into the `LAG` function in SQL. The purpose of this exercise however is not to provide a definitive comparison between [Generations X, Y, and Z](https://hbr.org/2017/08/a-survey-of-19-countries-shows-how-generations-x-y-and-z-are-and-arent-different) but to draw the reader's attention to the last line in the table.

*Table 1*: The Impact of Generational Shift on Workplace Evolution

| | 1985-2000 | 2000-2015 | 2015+ |
|---|---|---|---|
| Organizational Structure | Hierarchical | Matrix | Horizontal |
| Work Unit | Function | Product | Project |
| Dominant Tribe | Baby Boomers | Gen X | Millennials |
| Runner-up Tribe | Gen X | Millennials | Digital Natives |
| Workspace Layout | Private Office | Cubicle | Open Floor |
| Schedule | 9-to-5 | Flex Hours | Always On |
| Communications | Phone | Email | Chat |
| Knowledge Medium | Book | Article | Video |
| Data Analysis | Excel | Excel | Excel |

As the [Digital Natives](https://cyber.harvard.edu/research/youthandmedia/digitalnatives) enter the workforce, they're finding themselves in a rather peculiar situation where their _digital_ skills are not up to date. We're talking about to perform data analysis in **Excel** - the reigning king of number crunching. Despite repeated (and apparently failed) [attempts](https://www.wsj.com/articles/stop-using-excel-finance-chiefs-tell-staffs-1511346601) to depose it, Excel remains the most commonly used tool for business analysis and reporting. Although BI systems such as Qlik and Tableau have seen some adoption, they're still used primarily to interact with and interpret curated reports rather for analysis per se.

How is it possible for Excel to survive fierce competition over such a long period of time? Here's my take on the main reasons:

* Database and code in a single file. This bundling approach works well for ad hoc (task specific) analysis. Unlike R and Python, changing the existing data or creating new records with copy-paste is user friendly, even for non-programmers.

* Charting library that covers all the bases for graphical representation of data. It may not offer the latest and greatest visualization options (choropleths, Voronoy diagrams, cross-tabs, etc) but works for the majority of use cases.

* Reference style that works for staged calculations. Whether `R1C1` or `A1`, users find Excel's way of passing calculation results _by reference_ most intuitive.  In combination with a compact syntax that allows to fix the referenced row or column `$A$1` and `LOOKUP`/`VLOOKUP` functions, it provides a visual programming environment that works.

:::warn Network effects at work.
Anecdotal evidence. One of our customers in the Bay Area offers its engineers a fully paid annual training entitlement. To this day, the Advanced Excel class remains well attended by the company's IT infrastructure engineers.
:::

Let's go through cell reference basics in Excel using the following time series data. The table shows the amount of goods sold by a hypothetical company, measured in $US millions.

```txt
| Year | Sales Volume, $M |
|------|------------------|
| 2010 |               50 |
| 2011 |               52 |
| 2012 |               55 |
| 2013 |               55 |
| 2014 |               70 |
| 2015 |               72 |
| 2016 |               70 |
| 2017 |               75 |
| 2018 |               80 |
```

The 


## Data

The tonnage dataset is visualized below. Because of the differences in the ranges of the data, there are two charts to show the high variance for each of the metrics:

*Figure 1*: JFK Cargo Tonnage (1977-2015)

![](./images/ra-001.png)

[![View in ChartLab](../../research/images/new-button.png)](https://apps.axibase.com/chartlab/479e4525/#fullscreen)

*Figure 2*: LGA Cargo Tonnage (1977-2015)

![](./images/ra-002.png)

[![View in ChartLab](../../research/images/new-button.png)](https://apps.axibase.com/chartlab/f36262ee/#fullscreen)
