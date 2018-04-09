# Using Thresholds to Track United States Inflation

![](images/us-inflation.png)
[![](images/button-new.png)](https://trends.axibase.com/491c2442#fullscreen)

*Fig 1.* The chart above tracks percentile inflation for the United States for a two-decade period beginning in 2000 and uses an `alert-expression` and **[threshold]** configuration to highlight values greater than the 90th-percentile and less than the 10th-percentile values.

### Overview

Inflation is an oft-debated topic which many experts claim is a nessesary part of a growing economy. At its core, inflation is a measure of the change in the cost of goods and services. High-inflation economies see steep and sometimes untenable increases in their cost of living and money supply without analogous growth in gross domestic product (GDP) and wages. Prolonged or unmanagable inflation sometimes results in a trend known as hyperinflation, whereby the money supply is increased to such a degree that the use of the country's currency becomes unrealistic due to the outrageous costs associated with even simple, everyday purchases. The wholesale price index (WPI), which is a measure of the cost of a representative basket of wholesale goods in a particular economic system, for Germany's Weimar Republic is shown in the years after German defeat in World War I.

| Date | WPI Value|
|:-:|:-:|
|July 1922| 100.6|
|Jan 1923|2,785.0|
|July 1923|194,000.0|
|Nov 1923|726,000,000,000.0|

The hyperinflation documentated during 1920s Germany created the economic desperation which resulted in the 1929-1930 German Great Depression that many historians credit as being among the main reasons for the meteoric rise of Hitler's National Socialist Party, who had won just 2.6% of the vote in 1928 but went on to become Germany's second-largest political party within 5 years.

Conversely, too little inflation has been known to create what John Maynard Keynes refered to as the Paradox of Thrift whereby consumers refuse to consistently purchase new goods, instead opting to wait until the price inevitably decreases dues to low or negative inflation. This phenomenon has been known to exacerbate economies already mired in recession as consumers stop spending, so businesses are unable to produce goods or afford employee salaries, so more people are laid off and begin to spend even less. This trend is personified by the struggling Japanese economy of the early 2000s as they recovered from the Lost Decade, marked by a speculative asset bubble of Japanese land and goods which was brought to a head with the Japanese stock market crash in 1989. Japanese markets took nearly two decades to fully recover.

Naturally, the ideal level of inflation is somewhere between these two extremes; high enough to encourage growth and consumption but low enough to keep the cost of living manageable. As the Fed has announced plans to raise the interest rate as many as three time in 2018, with a target inflation of 2%, the current generation of economic policy makers certainly have their work cut out for them as United States public debt continues to exceed $20 trillion.

### Resources

This section of the article discusses the underlying settings used for the chart above. For introductory information on using **TRENDS**, see this [guide](/../master/how-to/shared/trends.md).

The configuration for the above chart is shown here:

```sql
[configuration]
  import fred = fred.js
  
  timespan = 20 year
  entity = fred.stlouisfed.org
  offset-left = 50
  offset-right = 50
  offset-top = 50
  height-units = 2
  width-units = 1
  format = fixed(3)

[group]

[widget]
  type = chart
  title = US Inflation

  [series]
    metric = cpieall
    axis = right 
    display = false
    alias = s-1 
      
  [series]
    mode = column
    label-format = Annual Change, %
    value = fred.PercentChangeFromYearAgo('s-1')
    color = yellowgreen
    alert-expression = value
    alert-style = if (alert > 4) return 'color: red'
    alert-style = if (alert < 0.5) return 'color: steelblue'
    alias = s-2

  [threshold]
    value = percentile(90, 's-2', '10 year')
    label = 10 year - 90% percentile
    color = Salmon
    pointer-position = left
    alias = t-1
  
  [threshold]
    value = percentile(10, 's-2', '10 year')
    label = 10 year - 10% percentile
    color = DeepSkyBlue
    pointer-position = left
    alias = t-2
```

There are four series in this configuration, defined by their `alias` setting:

* **s-1**: United States Experimental CPI value for all items, sourced from the United States Federal Reserve. Data [here](https://fred.stlouisfed.org/series/CPIEALL). This series has a `display = false` expression so that it will not be shown in the final version of the visualization but may still be used for deriving a new series. The series is applied to the right axis using a [duel-axis](https://axibase.com/products/axibase-time-series-database/visualization/widgets/time-chart/#tab-id-2) setting, which is helpful when visualizing series with dramatically different orders of magnitude.

* **s-2**: A derived series which uses `fred.js` library to calculate percent change from a year ago. This is a set of [user-defined functions](https://github.com/axibase/charts/blob/master/syntax/udf.md) and must be imported using the `import fred = fred.js` expression at the **[configuration]** level. This functionality may be replicated with javascript-native [`Math.`](https://github.com/axibase/atsd-use-cases/blob/master/Solutions/calculated-values/README.md) functions, which are automatically supported in **TRENDS**. An `alert-expression` is defined for this series. Wherever the condition is satisfied, the bar correspondings to the date of the alert is given a user-definied `alert-style`, in this case, a specific color.

* **t-1**: The upper-limit threshold is defined using a stand-alone `value` statement, `value = percentile(90, 's-2', '10 year')`, where the first argument is the desired percentile, the second argument is the series from which the value should be calculated, and the third is the threshold's time period.

* **t-2**: The lower-limit threshold is defined using a stand-alone `value` statement, `value = percentile(10, 's-2', '10 year')`, where the first argumentis the desired percentile, the second argument is the series from which the should be calculated, and the third is the threshold's time period.

Complete Charts documentation may be found [here](https://axibase.com/products/axibase-time-series-database/visualization/widgets/).
