# Pain at the Pump - a Closer Look at Hawaii's High Fuel Prices

![Title Photo](./images/Title-Photo.png)

## Introduction

Hawaii. Sunshine. Beautiful beaches. Mai Tais. These are a few of the great motivators for moving to one of America's favorite vacation destinations. However,
Hawaii has some of the most expensive consumer products in the nation. According to [expatistan.com](https://www.expatistan.com/cost-of-living/comparison/new-york-city/honolulu),
when compared to New York City, goods in Honolulu are more expensive:

* 1 liter of whole fat milk: +41%
* 1 kg (2 lbs) of apples: +68%
* Bread for 2 people for 1 day: +67%

In addition to exorbitant food prices, Hawaii currently holds the crown of having the highest fuel prices in the entire United States, according to [gasbuddy.com](https://www.gasbuddy.com/USA). The Aloha state has long held the
reputation of having the most expensive fuel in the land. However, until recently, such trends have been difficult to quantify.  to better analyze datasets such as Hawaiian fuel prices,
the US government in 2009 established a data collection website, [data.gov](https://www.data.gov/). Datasets are available online to conduct research, develop web applications, and design data visualizations,
on a variety of topics ranging from agriculture, to manufacturing, to health, among many other.

These datasets are published using the Socrata Open Data Format. [Socrata](https://socrata.com/) is a Seattle based company that develops software for
government agencies to publish and manage their data in an open format. According to their website, the Socrata Open Data Format is used by the US
Federal government, 25 US states, 300+ US cities, and contains 4,000+ datasets for numerous US counties.

## Hawaiian Fuel Prices Dataset

Let us take a look at a dataset from [data.gov](https://www.data.gov/) which looks at Hawaiian fuel prices.

From 2006 to 2012, the State of Hawaii compiled AAA fuel prices for each of these fuel types:

**Diesel**, **Gasoline - Regular**, **Gasoline - Midgrade**, **Gasoline - Premium**

In turn, each of these fuel prices were recorded for these locations:

**Hilo**, **Honolulu**, **Wailuku**, **US**, **State of Hawaii**

The dataset from data.gov can be found here: [http://catalog.data.gov/dataset/aaa-fuel-prices-52bf0](http://catalog.data.gov/dataset/aaa-fuel-prices-52bf0)

On the data.gov website, datasets can be downloaded as a CSV, RDF, JSON, or a XML file. To help interpret this data, the user is given the option of opening the CSV file with either [CartoDB](https://carto.com/)
or [plotly](https://plot.ly/).

### CartoDB

Mapping software CartoDB does not support plotting datasets (in this case gas prices of Hawaii) over some time period.

### plotly

This visualization tool allows the user to display the relationship of gas prices over time; however, without extensively manipulating the raw data set, each
location is allowed to be compared with only one fuel type at a time.

We will quickly run through plotting this dataset in plotly.

Once you click the above dataset, you are given the option of choosing `data.gov` preview, plotly, or CartoDB. Choose **plotly**.

![ZZZ](./images/ZZZ.png)

Once the raw data is opened via plotly, the user must select **Filter** from **Data Tools**, as shown below.

![Figure 1](./images/Figure1.png)

Next, choose **Filter** by, in our case for example, Gasoline - Regular. You must click **choose as x** for **Fuel** so that plotly knows which column to filter.

![Figure 2](./images/Figure2.png)

Finally, to output the data, the user must select **Group By** and choose **Month_of_Price** as the x axis, **County** as G (this will separate the prices of fuel for each
location), and the **Price** as the y axis.

![Figure 3](./images/Figure3.png)

The output will look as is shown below. The graph is relatively easy to interpret. The user can see that Gasoline - Regular fuel prices in Hawaii have for the last 6
years steadily remained more expensive than US average prices. The main drawback of using plotly to process datasets from data.gov is the extensive
time and effort it would take to create outputs for each of every fuel types. The same time-consuming steps would have to be taken for analyzing Diesel,
Gasoline - Midgrade, and Gasoline - Premium between all 5 locations. The same cumbersome process would have to be followed for comparing fuel types for each particular location. Additionally,
data in plotly is static, that is every time the data is updated, everything will need to be re-plotted.

![Figure 4](./images/Figure4.png)

## Axibase Time Series Database

Processing datasets using ATSD is much less cumbersome.  Processing the same data with ATSD is less time consuming
because its collection tool has built-in heuristics to handle the format in which data.gov datasets are published, namely the Socrata Open Data Format.
When loading data for a particular dataset the collector uses Socrata metadata to understand the meaning of columns and automatically extract dates, times,
and categories from the data files. Besides, ATSD stores the data in the user's own database so that this public data can be combined with internal data
sources as well as mixed and matched across different datasets. Once you install ATSD, you **do not** have to:

* Add additional datasets from data.gov
* Manipulate and design table schema
* Provision an application server
* Write programs to parse and digest these types of files.

Rather, you can configure a scheduled job to retrieve the file from the specified endpoint and have ATSD parse it according to pre-defined rules. Once you
have raw data in ATSD, creating and sharing reports with built-in widgets is fairly trivial. The reports will be continuously updated as new data comes in.

With ATSD, the user is able display the dataset in an easily understandable manner. The below figure shows each fuel type for each of the 5 locations.

![Figure 5](./images/Figure5.png)

The dataset can be sorted by location and/or fuel type, and the user can easily toggle through comparing different scenarios. The next 2 figures show outputs
comparing fuel types at Hilo and Diesel prices by location, respectively.

![Figure 6](./images/Figure6.png)

![Figure 7](./images/Figure7.png)

Here, you can explore the complete dataset for Hawaiian fuel prices using our portal:

[![View in ChartLab](./images/button.png)](https://apps.axibase.com/chartlab/ee379926)

### Creating Custom Portals

Custom portals can be created from the default portal. The user has the capability to change or display certain aspects of the dataset to their liking. For
example, the user may change graph styling, such as color, graph type, and other display options.

Likewise, by customizing the data the way you want, you can filter out any unnecessary information. If, for example, you are interested only in fuel prices
at Hilo, you can customize your portal to only show that information without the effort to toggle through for it.

A blank, customizable portal for your use can be found here: **[BLANK](https://apps.axibase.com/chartlab/)**

The default portal, from which you can customize the dataset results, again can be found here: **[DEFAULT](https://apps.axibase.com/chartlab/ee379926)**

We will walk through a brief example on how to customize the default dataset to only display fuel prices at Hilo.

### Example 1

* Open the blank portal and copy **configuration** section from the default portal. Delete the **entity** line.
* In the blank portal change the Source from **Random** to **ATSD**.

  ![Figure 11](./images/Figure11.png)

* Copy these settings to the blank portal under the `[group]` level.

  ```python
  [widget]
      type = chart
      legend-position = top
      [series]
        entity =
        metric =
        [tags]
        county =
        fuel =
  ```

* Copy the entity name from the default portal into the blank portal (in this case **dqp6-3idi**).
* In the blank portal enter **price** into metric. This will display the price of fuel as the y column.
* In the blank portal enter in the county and fuel. In this case, enter **Hilo** for county and `*` for fuel (`*` is the wildcard symbol).
* Your blank portal looks as is shown below. Click **Run** to output your customized graph.

![Figure 12](./images/Figure12.png)

Your customized graph looks like this:

![Figure 13](./images/Figure13.png)

Here, you can explore the this graph:

[![View in ChartLab](./images/button.png)](https://apps.axibase.com/chartlab/06a95d7c)

Now, we will quickly walk through creating a histogram to display the fuel price differences for Diesel fuel between Hilo and the US.

### Example 2

* Follow the first five steps in [Example 1](#example-1)

* In the blank portal enter in the county and fuel. In this case, enter **Hilo** for county and **Diesel** for fuel.
* Since we will be finding the difference between Hilo and US Diesel prices, we will need to make a second series. Copy and paste the existing series and change the name of the county to **US**. At this point your portal looks like this:

  ![Figure 14](./images/Figure14.png)

Next, we need to make a new series to find the difference between US and Hilo Diesel prices.

* In the Hilo series, enter in **alias = s1**. In the US series, enter in **alias = s2**. For both series enter **display = false**.
* Create a new series. Enter **label = Hilo over US Diesel Surcharges** and **value = value(s1) - value(s2)**.

At this point your portal looks something like this:

![Figure 15](./images/Figure15.png)

Your custom graph looks like this:

![Figure 16](./images/Figure16.png)

Now, you have the options of customizing your output further, by editing features such as color, graph type, and graph extents.

* Change the minimum price to 0. Enter **min-range = 0**.
* Change the graph type to columns. Enter **mode = column**.
* To showcase the exorbitant gas prices at Hilo, enter **color = red**.
* Under configuration (at the very top) enter **height-units = 2** to increase the size of your graph.
* Press **Run**.

Your customized graph looks like this:

![Figure 17](./images/Figure17.png)

Here, you can explore this graph:

[![View in ChartLab](./images/button.png)](https://apps.axibase.com/chartlab/aff8779b)

Various additional settings may be applied to create outputs that fit your needs. Below is a link to settings that may be applied to create custom data.gov charts:

[https://axibase.com/products/axibase-time-series-database/visualization/widgets/time-chart/](https://axibase.com/products/axibase-time-series-database/visualization/widgets/time-chart/)

### Adding/Combining a Second Dataset

Exploring the complete dataset for fuel prices, we can see that, generally speaking, Wailuku is more expensive for any fuel type than Hilo and Honolulu. Are products generally
more expensive in Wailuku than the other islands, or is this simply an anomaly? One way we can investigate further is to incorporate a second dataset with another
consumer product in Hawaii. If the price of this second consumer item is also more expensive in Wailuku than in Hali and Honolulu, then we may not be dealing with
an anomaly, but quite possibly a trend.

From the data.gov website, choose [Hawaii electricity prices](https://catalog.data.gov/dataset/hi-electricity-prices-815fa) as our second dataset.

From 2008 to 2012, the State of Hawaii collected electricity prices (in cents/kwh) for each of the Hawaiian islands:

**Hawaii**, **Kauai**, **Lanai**, **Maui**, **Molokai**, **Oahu**

In turn, each island had it's electricity broken into these sectors:

**All Sectors**, **Commercial**, **Residential**, **Street Lights**

Here, you can explore the portal for this dataset:

[![View in ChartLab](./images/button.png)](https://apps.axibase.com/chartlab/9e548f6b)

Next, let's look at which areas we can compare.

The specified locations for the 2 datasets are different: one compared cities, while the other compared islands. Areas for which we have both datasets
are marked in red in the figure below.

![HawaiiIslands](./images/HawaiiIslands.png)

To briefly demonstrate our capabilities, compare Diesel prices at Honolulu, Wailuku, and Hilo with the Residential electricity rates at their
respective corresponding islands (Oahu, Maui, Hawaii).

![Figure 10](./images/Figure10.png)

Again, guidelines for setting up the various settings to create outputs can be found [here](https://axibase.com/products/axibase-time-series-database/visualization/widgets/time-chart/).

This graph is a standard distribution of the datasets plotted side by side. As was stated previously, Wailuku was found to generally have the most expensive fuel,
which is shown here graphically. When looking at the electricity rates, we can see that the most expensive location is Hawaii island. So, based off our quick example,
we cannot say that there is a trend of consumer products being more expensive in Wailuku (or Maui island) than others. However, this quickly shows the user
the possibilities of combining and comparing multiple datasets.

Here you can explore the portal of this comparison:

[![View in ChartLab](./images/button.png)](https://apps.axibase.com/chartlab/b1046948)

### Additional Examples

Here is a table of additional datasets from data.gov that you can explore using Axibase's portal:

|State|data.gov dataset|Axibase Portal|
|-----------|-----------------------|-----------------------|
|Illinois |[Abortion Demographics, 1995-2012](http://catalog.data.gov/dataset/abortion-demographics-1995-2012-8f496)|[Portal](https://apps.axibase.com/chartlab/55eb27ce)|
|Maryland |[Anne Arundel County Crime Rate By Type](http://catalog.data.gov/dataset/anne-arundel-county-crime-rate-by-type-e5923)|[Portal](https://apps.axibase.com/chartlab/a85c4f60)|
|New York |[Automobiles Annual Imports and Exports Through Port Authority of NY NJ Maritime Terminals: Beginning 2000](http://catalog.data.gov/dataset/automobiles-annual-imports-and-exports-through-port-authority-of-ny-nj-maritime-terminals-)|[Portal](https://apps.axibase.com/chartlab/c041c40b)|
|Maryland |[Employment Figures](http://catalog.data.gov/dataset/employment-figures-f55ae)|[Portal](https://apps.axibase.com/chartlab/fc75db9b)|
|New York |[Solar Photovoltaic (PV) Incentive Program Completed Projects by City and Contractor: Beginning 2010](http://catalog.data.gov/dataset/solar-photovoltaic-pv-incentive-program-completed-projects-by-city-and-contractor-beginnin)|[Portal](https://apps.axibase.com/chartlab/a4936180)|
|Hawaii |[Solid Waste Recycled (in tons)](http://catalog.data.gov/dataset/table-17-solid-waste-recycled-in-tons-851c9)|[Portal](https://apps.axibase.com/chartlab/48b1d9b2)|
|Iowa |[Math And Reading Proficiency by School Year, Public School District and Grade Level](http://catalog.data.gov/dataset/math-and-reading-proficiency-by-school-year-public-school-district-and-grade-level)|[Portal](https://apps.axibase.com/chartlab/bc9ba2d9)|
|Connecticut|[Sales and Use Tax per Town by NAICS (2013 and 2014)](http://catalog.data.gov/dataset/sales-and-use-tax-per-town-by-naics-2013-and-2014)|[Portal](https://apps.axibase.com/chartlab/6be07c75)|
|Maryland |[Per Capita Electricity Consumption](http://catalog.data.gov/dataset/per-capita-electricity-consumption-7b888)|[Portal](https://apps.axibase.com/chartlab/db5aa772)|
|Maryland |[MVA Vehicle Sales Counts by Month for CY 2002-2015](http://catalog.data.gov/dataset/mva-vehicle-sales-counts-by-month-for-cy-2002-2015)|[Portal](https://apps.axibase.com/chartlab/f2083bc9)|
|Connecticut|[DAS HR Almanac - Executive Branch Employment By Race](http://catalog.data.gov/dataset/das-hr-almanac-executive-branch-employment-by-race)|[Portal](https://apps.axibase.com/chartlab/88942f63)|
|New York |[Scholarship Recipients and Dollars by Sector Group: Beginning 2009](http://catalog.data.gov/dataset/scholarship-recipients-and-dollars-by-sector-group-beginning-2009)|[Portal](https://apps.axibase.com/chartlab/9026c3d7)|
|New York |[Public Assistance and SNAP Fraud Prevention Performance Measures: Beginning 2013](http://catalog.data.gov/dataset/public-assistance-and-snap-fraud-prevention-performance-measures-beginning-2013)|[Portal](https://apps.axibase.com/chartlab/0e4a225d)|
|Maryland |[Maryland Veterans Unemployment Rate](http://catalog.data.gov/dataset/maryland-veterans-unemployment-rate-3ea61)|[Portal](https://apps.axibase.com/chartlab/61e23fa5)|
|Maryland |[Trips Taken on Public Transit by Transit Type - Monthly Total Trips](http://catalog.data.gov/dataset/trips-taken-on-public-transit-by-transit-type-4abd1)|[Portal](https://apps.axibase.com/chartlab/fd596ed9)|
|Iowa |[Employee Compensation by Industry in Iowa](http://catalog.data.gov/dataset/employee-compensation-by-industry-in-iowa)|[Portal](https://apps.axibase.com/chartlab/f5eae012)|

If you would like to view a data.gov dataset without installing the ATSD software, [contact us](https://axibase.com/feedback/) and we would be happy to add it to this table!

### Action Items

Below are the steps to follow to install ATSD:

1. [Install the database](https://axibase.com/docs/atsd/installation/) on a virtual machine or in a Linux container.
2. [Install Axibase Collector](https://axibase.com/docs/axibase-collector/#installation) and configure Collector to write data into your ATSD instance.
3. Import [SOCRATA Job](./hawaii_gas_prices.xml) into Axibase Collector.
4. Add your desired data.gov dataset to the job to enable data collection. Click **Run** to collect data for the first time.
5. Log in to ATSD and open a sample Socrata portal to explore the data.

If you require assistance in installing this software or have any questions, feel free to [contact us](https://axibase.com/feedback/) and we would be happy to help!