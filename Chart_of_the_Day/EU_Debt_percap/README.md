European Union Debt by Country Per Capita (2005-2016)
==

Data Source: [EuroStat](http://ec.europa.eu/eurostat)

Visualization Tool: [ChartLab](https://apps.axibase.com)

**Figure 1.1**

![](Images/eudpc-003.png)

[![](Images/button.png)](https://apps.axibase.com/chartlab/e92a4f6c/10/#fullscreen)

> Use the dropdown menus at the top of the visualization to navigate through time by selecting the desired start and end
years for the observation period.

Recently, [European Union Debt Data](https://axibase.github.io/atsd-use-cases/DataShorts/EU_Debt/) sorted by country was published 
in the [Axibase Data Library](https://axibase.com/blog/data-library/). After its release, there were a number of requests to explore
that data considering population numbers to arrive at a modified debt per capita visualization, representing how much of a
government's gross debt is represented by individual citizens of that particular country. 

The visualization above shows the growth of per capita debt in the European Union over the entire observed period of time, 
sorted by member country and below that same information is displayed in one year increments.

**Figure 1.2**

![](Images/eudpc-002.png)

[![](Images/button.png)](https://apps.axibase.com/chartlab/d38e750e/#fullscreen)

> Open the visualization above and navigate through time with the dropdown menu.

Per capita debt data does not represent the average amount of debt carried by an individual consumer but rather the debt of 
a given government distributed to every citizen of that country, whom the government officially represents. A large country
with a lot of debt is considered equal to small country with only a little debt because the ratio of population
to gross government debt is being considered.

The following visualization tracks debt growth by country from 2006 to 2016:

**Figure 1.3**

![](Images/eudpc-013.png)

[![](Images/button.png)](https://apps.axibase.com/chartlab/d38e750e/#fullscreen)

This dataset is queried further and indexed in the [Data Library](https://axibase.com/blog/data-library/) using the [SQL Console](https://github.com/axibase/atsd/tree/master/api/sql).
See the complete entry [here](/DataShorts/EU_percap_Debt/README.md).
