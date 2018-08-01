# Presidential Economic Metrics Portal

![]()

## Overview

The portal above tracks economic metrics through American Presidential administrations from Gerald Ford (1974-1977) to Donald J. Trump (2016-present). Open the portal and use the drop-down lists to navigate between Presidential administrations and metrics.

The portal is available through the **Trends** service, which is a public instance of ATSD, the database responsible for the underlying data management and processing tasks used to create the visualization.

## Data

The underlying economic data used in this portal is sources from the St. Louis Branch of the Federal Reserve data portal [FRED]()

### Presidential Administrations

President | In Office | Portrait
:--:|:--:|:--:
Gerald Ford | August 9, 1974 - January 20, 1977 | ![](./images/1ford.png)
Jimmy Carter | January 20, 1977 – January 20, 1981 | ![](./images/1carter.png)
Ronald Reagan | January 20, 1981 – January 20, 1989 | ![](./images/1reagan.png)
George H.W. Bush | January 20, 1989 – January 20, 1993 | ![](./images/1hwbush.png)
Bill Clinton | January 20, 1993 – January 20, 2001 | ![](./images/1clinton.png)
George W. Bush | January 20, 2001 – January 20, 2009 | ![](./images/1wbush.png)
Barack Obama | January 20, 2009 – January 20, 2017 | ![](./images/1obama.png)
Donald Trump | January 20, 2017 - Present | ![](./images/1trump.png)

### Economic Metrics

Metric | FRED ID | Description
--|--|--
Consumer Price Index | `CPIAUCSL` | The Consumer Price Index is a measure of the average monthly change in the price for goods and services paid by urban consumers between any two time periods.
Real Gross National Product | `A001RO1Q156NBEA` | Gross national product (GNP) is the market value of all the goods and services produced in one year by labor and property supplied by the citizens of a country.
National Income | `A032RC1A027NBEA` | National income is the monetary value of the final goods and services produced by an economy over a period of time.
Corporate Profits Before Tax | `A464RC1A027NBEA` | Profit before tax (PBT) is a measure that looks at a company's profits before the company has to pay corporate income tax. It deducts all expenses from revenue including interest expenses and operating expenses except for income tax.
GDP Per Capita | `A939RC0A052NBEA` | The Gross Domestic Product of the United States per individual.
Average Sale Price of Houses | `ASPUS` | The mean sale price of homes in the United States.
Capacity Utilization | `CAPUTLB50001SQ` | For a given industry, the capacity utilization rate is equal to an output index divided by a capacity index. The Federal Reserve Board capacity indexes attempt to capture the concept of sustainable maximum output-the greatest level of output a plant can maintain within the framework of a realistic work schedule, after factoring in normal downtime and assuming sufficient availability of inputs to operate the capital in place.
Cash Surplus or Deficit (% GDP) | `CASHBLUSA188A` | Cash surplus or deficit is revenue (including grants) minus expense, minus net acquisition of non-financial assets.

## Creating the Portal

The Presidential Economic Indicators Portal features a number of syntax features enumerated below:

### User Defined Functions

Charts services support [user defined functions](https://github.com/axibase/charts/blob/master/syntax/udf.md),
which are JavaScript files which comprise particular mathematical functions not available using typical Charts syntax.

This portal uses the [`fred.js`](https://apps-chartlab.axibase.com/portal/resource/scripts/fred.js)  library to modify the index position. This modification transforms data to reflect the selected Presidential administration.

```ls
[series]
  value = fred.Index('raw', '1974')
```

### Inline CSV

The portal contains two CSV files which enumerate the Presidential administrations and their years of service as well as the tracked economic metrics and their associated `FRED ID`.

```ls
csv index =
  president,inauguration
  Gerald Ford, 1974
  Jimmy Carter, 1977
  Ronald Reagan, 1981
  George H.W. Bush, 1989
  Bill Clinton, 1993
  George W. Bush, 2001
  Barack Obama, 2009
  Donald Trump, 2017
endcsv
```



Define [inline CSV](https://github.com/axibase/charts/blob/master/syntax/functions.md#csv-inline-text-mode) files to associate labels and metrics.

## Action Items

* To begin work within the **Trends** environment, refer to the [Getting Started Tutorial](../../tutorials/shared/trends.md).
* For more information about ATSD, or to deploy a local instance, see [ATSD Documentation](https://axibase.com/docs/atsd/).
* For complete Charts syntax, refer to the [Charts Documentation](https://github.com/axibase/charts).
* To access raw datasets, append the `FRED ID` of any metric to the URL `https://fred.stlouisfed.org/series/`
* To view all metrics stored in the **Trends** environment, refer to the [Reference Catalog](https://trends.axibase.com/public/reference.html).