# Analyzing UK Aviation Statistics using CAA Datasets

![TitlePhoto](./images/TitlePhoto.png)

## Introduction

Are airports getting more and more crowded every year?

What some are the busiest airports in the United Kingdom?

How often are airplanes delayed?

to answer questions like these, the Civil Aviation Authority (CAA) serves as an independent data specialist for the UK government. Established in 1972, the CAA collects and reports on key aviation metrics which quantify various activities at UK airports. According to their official [website](https://www.caa.co.uk/Data-and-analysis/UK-aviation-market/Airports/Datasets/UK-Airport-data/Airport-data-2016-06/), the CAA collects statistics from more than 60 UK airports. Data is collected on a variety of topics:

* International passenger traffic to and from UK airports;
* Terminal passenger totals at different UK airports;
* International and domestic mail shipped to and from UK airports (tons).

CAA datasets are available in two formats: raw datasets and aviation trends.

## CAA Raw Datasets

CAA raw datasets are published every month, and are available all the way back to 1973. These reports are available in CSV and PDF format, although some reports are only stored in one form. These datasets contain raw data, that is they do not contain any information on analytics or trends, and do not contain any graphs or figures. A link to these raw datasets may be found here:

[https://www.caa.co.uk/Data-and-analysis/UK-aviation-market/Airports/Datasets/UK-airport-data/](https://www.caa.co.uk/Data-and-analysis/UK-aviation-market/Airports/Datasets/UK-airport-data/)

Below is an image of a typical raw data set, taken from [January 2016](https://www.caa.co.uk/uploadedFiles/CAA/Content/Standard_Content/Data_and_analysis/Datasets/Airport_stats/Airport_data_2016_01/Table_11_International_Air_Pax_Traffic_to_from_UK_by_Country.pdf)

![Figure 1](./images/Figure1.png)

## CAA Aviation Trends

CAA aviation trends are published quarterly. These reports date back to 2008 and are published in PDF format. General information is included along with these detailed reports to help contextualize the data. Graphs and tables showing volumes and year on year (y-o-y) growth rates of datasets are published. These aviation trend files may be found at the below link:

[https://www.caa.co.uk/Data-and-analysis/UK-aviation-market/Airports/Aviation-Trends/](https://www.caa.co.uk/Data-and-analysis/UK-aviation-market/Airports/Aviation-Trends/)

Below is an table of terminal passengers at UK airports from [AviationTrends_2008_Q4](https://www.caa.co.uk/uploadedFiles/CAA/Content/Standard_Content/Data_and_analysis/Analysis_reports/Aviation_trends/AviationTrends_2008_Q4.pdf). In the attached text, terminal passengers are described as "those travelers who board or disembark an aircraft on a commercial flight at a reporting UK airport." The data is shown for scheduled and chartered flights for London and Regional airports. Quantities of travelers and growth percentages are presented comparing, in this case, Q4-2008 to Q4-2007, and the rolling dates of Q1 through Q4 of 2007 and 2008, respectively.

![Figure 2](./images/Figure2.png)

Below is an table from the same report showing terminal passengers at UK airports by origin / destination.

![Figure 3](./images/Figure3.png)

The data is presented for scheduled and chartered flights for passengers from within the UK, Europe, North America, and the rest of the world. To summarize the graph: "Passenger numbers to all destination groups fell in quarter 4 2008, by around 8%, except for passengers numbers to the "Rest of the World" destination group, which fell by considerably less."

While the Aviation Trend PDF files can be helpful, they are not interactive and do not allow the user to easily move through different metrics and datasets. To gain a meaningful understanding of the data and trends over time, end users need to open multiple files at a time and compare data without visualization, which can be difficult and time consuming to work though.

## Axibase Time Series Database

Processing CAA datasets using ATSD is much simpler. Parsing the same data with ATSD is less time consuming because the user has the ability to easily toggle between different datasets and years, and filter for a specific airport location or metric. ATSD stores the data in the user's own database so that this public data can be combined with internal data sources as well as mixed and matched across different datasets. For example, you could combine the CAA datasets with weather patterns to see if there is any correlation between poor weather and flight delays; or with another country's aviation statistics to see how they compare to UK trends.

Once you install ATSD, you **do not** have to:

* Add additional datasets from caa.co.uk
* Manipulate and design table schema
* Provision an application server
* Write programs to parse and digest these types of files.

Rather, you can configure a scheduled job to retrieve the file from the specified endpoint and have ATSD parse it according to pre-defined rules. Once you have raw data in ATSD, creating and sharing reports with built-in widgets is fairly trivial. The reports will be continuously updated as new data comes in. Below is a image of the data flow of ATSD.

![dataflow](./images/dataflow.png)

Using the ATSD default portal for CAA metrics, the user has the ability to filter the CAA datasets to their liking. The following three filters are applied to the default portal:

* First filter: Sorts by CAA metric. **228** different CAA airport aviation metrics can be filtered for. These metrics may be found in the [Appendix](#appendix-caa-metric-list). The figure below shows the first metric in the first drop-down list: terminal passengers totals for January 2015 to February 2016.
* Second filter: Filters 55 different UK airports. In this case, all airports have been selected.
* Third filter: Filters by airport groups (London area, other UK, or no UK reporting airports). In this case, all groups have been selected.

![Figure 4](./images/Figure4.png)

This figure shows total freight (in tons) for 2015 for all 55 airports from January 2015 to February 2016.

![Figure 20](./images/Figure20.png)

Here, you can explore the complete dataset for CAA aviation statistics by clicking below on the default portal:

[![View in ChartLab](./images/button.png)](https://apps.axibase.com/chartlab/972babb9)

### Creating Custom Portals

Custom portals can be created from the default portal; users have the capability to change or display specific aspects of the dataset as needed. For example, the user may change graph styling, such as color, graph type, and other display options.

Custom data visualizations mean that you can filter out unnecessary information without discarding relevant information. If, for example, you are interested in comparing UK Domestic terminal traffic for scheduled flights for different years, you can customize your portal from the default portal to only show that information.

We will walk through a brief example on how to customize the default portal to compare UK Domestic terminal traffic for scheduled flights between 2015 and 2016.

### Example 1

1. Open the default portal and delete the configuration sections as shown in the image below. We only want to show one series, so there is no need for `multiple-series`, `series-limit`, `tags-dropdown`, `label-format`, `tags-dropdown-style`, or `dropdown` controls / settings.

    ![Figure 5](./images/Figure5.png)

2. Next, we want to select the one `metric` which we would like to filter. The first drop-down list in **ChartLab** only contains the shortened version of the metric names. This text file which contains the full raw metric names: [uk-caa-metrics.txt](uk-caa-metrics.txt). A complete list of metrics is also available in the [Appendix](#appendix-caa-metric-list).

    ![Figure 21](./images/Figure21.png)

    Once you've installed ATSD, navigate to the metric list to see the corresponding names. You will need to log in to your ATSD account to view the full raw metric names, which must be used in the configuration. The image below contains the standard view after you have logged in. Press **Entities**.

    ![Figure 6](./images/Figure6.png)

3. Enter **uk-caa** into **Name Mask** field. Press Apply.

    ![Figure 7](./images/Figure7.png)

4. Select **2016-06-01 00:00:00**.

    ![Figure 8](./images/Figure8.png)

5. Here, you will see a list of metrics, which are available for the CAA entity. In our case, we are looking for UK Domestic terminal traffic for scheduled flights. Copy the seventh entry from the top of the page, **uk-caa.air-pax-by-type-and-nat-of-op.pax_terminal_scheduled_uk**.

    ![Figure 10](./images/Figure10.png)

6. Navigate back to the portal. Use a `metric` setting and paste the copied metric name from the metrics list.
7. Since we are comparing 2015 and 2016 values, enter `starttime = current_year` and `endtime = next_year`.
8. As we will be looking at total domestic travel, enter `group-statistic = sum` and change mode from `column-stack` to `column`. The `group-statistic = sum` command calculates the total number of passengers for all airports in a given month, and the `column` will only show the total number of passengers together as one column per month.

    ![Figure 11](./images/Figure11.png)

9. Next, since we are looking at total domestic value, we need to select all airport and group names.  Create a new heading for `[tags]` below `[widget]` and enter `airport_name = *` and `group_name = *` (The asterisk `*` is one of the supported wildcard symbol in the Charts API).
10. To display data for 2016, create a new `[series]` and enter `label = current year`.
11. To display data for 2015, create a new `[series]` and enter `label = previous year`. Enter `time-offset = 1 year` and `color = orange`. The `time-offset = 1 year` command shifts historical data by the specific lag to the current time. In our case, data for the year 2015 is displayed as if it were data for 2016.

    ![Figure 12](./images/Figure12.png)

12. Press **Run**, your figure looks like the image below.

    ![Figure 13](./images/Figure13.png)

    Now, we can take a few more steps to clean up our figure.

13. Change the title to **UK Domestic Terminal Traffic on Scheduled Flights**.
14. Under **metric** enter **format = numeric** to shorten the length of the output numbers.
15. Press **Run**.

    ![Figure 19](./images/Figure19.png)

Here you can explore this configuration in **ChartLab**:

[![View in ChartLab](./images/button.png)](https://apps.axibase.com/chartlab/cca64be9)

### Example 2

Now that we are familiar with the CAA entity and different available metrics, as an alternative to building a configuration from the default portal, create a configuration from the generic widget settings in **ChartLab**. Let's walk through building a calendar Widget to show the total international passengers traveling from UK airports within the last year.

The default ChartLab portal can be found here:

[![View in ChartLab](./images/button.png)](https://apps.axibase.com/chartlab)

1. Press the ChartLab link above.
2. Change the source to **ATSD** and select **calendar** from the Widget drop-down list.
3. Delete the section of the configuration as shown in the image below.

    ![Figure 14](./images/Figure14.png)

4. Change the entity name to **uk-caa** and the metric name to **uk-caa.eu-and-other-intl-passenger-traffic.total_pax_eu_last_period**, which was taken from the metric list in ATSD.
5. Since we want to display international passenger figures for all available UK airports, create a **[tags]** heading. Under this heading, enter `airport_name = *`.
6. In the `[configuration]` heading, enter `timezone = UTC`.
7. Under the `[widget]` heading, delete the line `timespan = 3 hour`.
8. To specific our new timespan, enter in `starttime = 2015-01-01T00:00:00z` and on the next line `endtime = current_month`.
9. Modify the `summarize-period` line from 10 minutes to 1 month.
10. To display airport names in our figure, enter `label-format = tags.airport_name`.

    ![Figure 15](./images/Figure15.png)

11. Press **Run**.

    ![Figure 16](./images/Figure16.png)

12. To create a figure title, enter a title setting like the one shown here: `title = UK International Terminal Passenger Traffic: Total Passenger`
13. Modify size and offset settings by applying those settings. Under `[configuration]` change `offset-right` from 50 to 0 and height-units from 2 to 1.
14. Press **Run**.

    ![Figure 17](./images/Figure17.png)

    From our figure we can see a month-by-month breakdown of international passenger traffic from all UK airports. The calendar widget is useful for quickly gaining an understanding of the general trends of a particular dataset, as we as observing any outliers in the set. Generally speaking in our instance, we can see that in 2015 the most popular travel season was from May to October, as indicated by the clumping of lots of dark blue square shading. Additionally, we can see that very travel was taken from November to April.

We can quickly observe outliers in Shoreham and Oxford (Kidlington) for the months of January and February, respectively, as shown in the figure below.

![Figure 23](./images/Figure23.png)

Additionally, we can see observe outliers for Scatsta and Wick John O Groats for the high travel months of May to October, as can be seen in the figure below.

![Figure 24](./images/Figure24.png)

You can explore this portal by clicking on the link below.

[![View in ChartLab](./images/button.png)](https://apps.axibase.com/chartlab/8dc941e3)

`[widget]`-level settings may be used for overall modification of any ChartLab visualization.

1. Under the `[widget]` heading, change the `type` setting from `calendar` to `pie`. Use these settings: `summarize-period = 1 month` and `color-range = blue`.
1. Change from `starttime = 2015-01-01T00:00:00Z` to `starttime = current year`.
1. Apply a limit settings using a `display` parameter: `display = value > top(15)` will limit the visualization to contain on the top 15 results.
1. To show a legend with the figure, enter `legend-position = top`.
1. To display numeric values with the figure, enter `series-labels = connected`.
1. Pie charts in ChartLab support several visualization modes, for example: `mode = ring`.
1. Change the title to **UK International Terminal Passenger Traffic: Top 15 Airports June 2016**.
1. Press **Run**.

![Figure 18](./images/Figure18.png)

You can explore this portal by clicking on the link below.

[![View in ChartLab](./images/button.png)](https://apps.axibase.com/chartlab/1f9f05a1/4)

### Example 3

This is an advanced example using a graph Widget to show passenger traffic distribution between different UK airports for a given time period. This figure shows a single base airport and all of the associated destination airports, which are connected by flight path lines. These lines are drawn going from the base airport to airport "x", and from airport "x" back to the base airport. Additionally, values from the dataset are projected onto their respective flight-path lines. In the figure below, Heathrow is used as the base airport and we can see all the available flight paths to airports across the UK for May 2016. The heavier the flight path lines, the heavier the traffic between the two associated airports. The CAA dataset for this figure can be found [here](https://www.caa.co.uk/uploadedFiles/CAA/Content/Standard_Content/Data_and_analysis/Datasets/Airport_stats/Airport_data_2016_05/Table_12_3_Dom_Air_Pax_Route_Analysis_by_Each_Reporting_Airport_PDF.pdf).

![Figure 22](./images/Figure22.png)

The connections between Heathrow and Edinburgh are dark blue, which indicates heavy traffic. We can observe that the total passengers in May 2016 from Heathrow to Edinburgh was 95,569, and 92,342 for the trip from Edinburgh to Heathrow. We can see 48,566 passengers travelled from Heathrow to Aberdeen, and that 48,577 passengers travelled back from Aberdeen to Heathrow. Additionally, observing the figure, a user can observe the fact that there was **no** passenger traffic from quite a number of airports, including Coventry Shoreham, Prestwick, Exeter, and Humberside.

The user can change the base airport quite easily by modifying the configuration. You simply need to change the `var baseAirport` setting from `HEATHROW` to any airport for which you would like to see air passenger totals and connectivity.

![Figure 25](./images/Figure25.png)

Let's `var baseAirport` to `MANCHESTER`. Below is an image with passenger traffic distribution for Manchester to other UK airports for May 2016.

![Figure 26](./images/Figure26.png)

You can explore this portal by clicking on the link below.

[![View in ChartLab](./images/button.png)](https://apps.axibase.com/chartlab/e6822a69/5/)

## Action Items

Below are the steps to follow to install ATSD and create figures for CAA metrics:

1. [Install the database](https://axibase.com/docs/atsd/installation/) on a virtual machine or Linux container.
2. [Install Axibase Collector](https://axibase.com/docs/axibase-collector/#installation) and configure Collector to write data into your ATSD instance.
3. Import the [csv-configs.xml](csv-configs.xml) into Axibase Collector.
4. Import the [jobs.xml](jobs.xml) into Axibase Collector.
5. Log in to your ATSD instance.
6. Select your desired CAA metric and begin building your visualizations on the **Portals** page.

After installing ATSD and scrolling though the list of CAA metrics, create your own example and send it over to us.

If you require assistance in installing this software or have any questions, feel free to [contact us](https://axibase.com/feedback/) and we would be happy to help.

## Appendix: CAA Metric List

```txt
uk-caa.air-pax-by-type-and-nat-of-op.pax_terminal_scheduled_uk <br />
uk-caa.air-pax-by-type-and-nat-of-op.pax_terminal_charter_foreign_eu <br />
uk-caa.air-pax-by-type-and-nat-of-op.pax_terminal_charter_foreign_non_eu <br />
uk-caa.air-pax-by-type-and-nat-of-op.pax_terminal_charter_uk <br />
uk-caa.air-pax-by-type-and-nat-of-op.pax_terminal_scheduled_foreign_eu <br />
uk-caa.air-pax-by-type-and-nat-of-op.pax_terminal_scheduled_foreign_non_eu <br />
uk-caa.air-pax-by-type-and-nat-of-op.pax_terminal_scheduled_uk <br />
uk-caa.air-pax-by-type-and-nat-of-op.pax_transit_charter_foreign_eu <br />
uk-caa.air-pax-by-type-and-nat-of-op.pax_transit_charter_foreign_non_eu <br />
uk-caa.air-pax-by-type-and-nat-of-op.pax_transit_charter_uk <br />
uk-caa.air-pax-by-type-and-nat-of-op.pax_transit_scheduled_foreign_eu <br />
uk-caa.air-pax-by-type-and-nat-of-op.pax_transit_scheduled_foreign_non_eu <br />
uk-caa.air-pax-by-type-and-nat-of-op.pax_transit_scheduled_uk<br />
uk-caa.air-pax-by-type-and-nat-of-op.total_pax<br />
uk-caa.air-transport-\s-comparison.atms_cargo_aircraft_last_period<br />
uk-caa.air-transport-movements-comparison.atms_cargo_aircraft_percent<br />
uk-caa.air-transport-movements-comparison.atms_cargo_aircraft_this_period<br />
uk-caa.air-transport-movements-comparison.atms_passenger_aircraft_last_period<br />
uk-caa.air-transport-movements-comparison.atms_passenger_aircraft_percent<br />
uk-caa.air-transport-movements-comparison.atms_passenger_aircraft_this_period<br />
uk-caa.air-transport-movements-comparison.total_atms_last_period<br />
uk-caa.air-transport-movements-comparison.total_atms_percent<br />
uk-caa.air-transport-movements-comparison.total_atms_this_period<br />
uk-caa.air-transport-movements-vs-prev-year.atms_cargo_aircraft_last_period<br />
uk-caa.air-transport-movements-vs-prev-year.atms_cargo_aircraft_percent<br />
uk-caa.air-transport-movements-vs-prev-year.atms_cargo_aircraft_this_period<br />
uk-caa.air-transport-movements-vs-prev-year.atms_passenger_aircraft_last_period<br />
uk-caa.air-transport-movements-vs-prev-year.atms_passenger_aircraft_percent<br />
uk-caa.air-transport-movements-vs-prev-year.atms_passenger_aircraft_this_period<br />
uk-caa.air-transport-movements-vs-prev-year.total_atms_last_period<br />
uk-caa.air-transport-movements-vs-prev-year.total_atms_percent<br />
uk-caa.air-transport-movements-vs-prev-year.total_atms_this_period<br />
uk-caa.air-transport-movements.charter_all_domestic_atm<br />
uk-caa.air-transport-movements.charter_all_eu_international_atm<br />
uk-caa.air-transport-movements.charter_all_non_eu_international_atm<br />
uk-caa.air-transport-movements.charter_eu_international_passenger_atm<br />
uk-caa.air-transport-movements.charter_passenger_domestic_atm<br />
uk-caa.air-transport-movements.charter_passenger_non_eu_international_atm<br />
uk-caa.air-transport-movements.scheduled_all_domestic_atm<br />
uk-caa.air-transport-movements.scheduled_all_eu_international_atm<br />
uk-caa.air-transport-movements.scheduled_all_non_eu_international_atm<br />
uk-caa.air-transport-movements.scheduled_passenger_domestic_atm<br />
uk-caa.air-transport-movements.scheduled_passenger_eu_international_atm<br />
uk-caa.air-transport-movements.scheduled_passenger_non_eu_international_atm<br />
uk-caa.air-transport-movements.total_domestic_atm<br />
uk-caa.air-transport-movements.total_eu_atm<br />
uk-caa.air-transport-movements.total_non_eu_international_atm<br />
uk-caa.aircraft-movements.aero_club<br />
uk-caa.aircraft-movements.air_taxi<br />
uk-caa.aircraft-movements.air_transport<br />
uk-caa.aircraft-movements.business_aviation<br />
uk-caa.aircraft-movements.grand_total<br />
uk-caa.aircraft-movements.local_movements<br />
uk-caa.aircraft-movements.military<br />
uk-caa.aircraft-movements.official<br />
uk-caa.aircraft-movements.other_flights<br />
uk-caa.aircraft-movements.positioning_flights<br />
uk-caa.aircraft-movements.private_flights<br />
uk-caa.aircraft-movements.test_and_training<br />
uk-caa.aircraft-movementsaero_club<br />
uk-caa.aircraft-movementsair_taxi<br />
uk-caa.aircraft-movementsair_transport<br />
uk-caa.aircraft-movementsbusiness_aviation<br />
uk-caa.aircraft-movementsgrand_total<br />
uk-caa.aircraft-movementslocal_movements<br />
uk-caa.aircraft-movementsmilitary<br />
uk-caa.aircraft-movementsofficial<br />
uk-caa.aircraft-movementsother_flights<br />
uk-caa.aircraft-movementspositioning_flights<br />
uk-caa.aircraft-movementsprivate_flights<br />
uk-caa.aircraft-movementstest_and_training<br />
uk-caa.airport-landings-diverted.num_flights_day_1<br />
uk-caa.airport-landings-diverted.num_flights_day_10<br />
uk-caa.airport-landings-diverted.num_flights_day_11<br />
uk-caa.airport-landings-diverted.num_flights_day_12<br />
uk-caa.airport-landings-diverted.num_flights_day_13<br />
uk-caa.airport-landings-diverted.num_flights_day_14<br />
uk-caa.airport-landings-diverted.num_flights_day_15<br />
uk-caa.airport-landings-diverted.num_flights_day_16<br />
uk-caa.airport-landings-diverted.num_flights_day_17<br />
uk-caa.airport-landings-diverted.num_flights_day_18<br />
uk-caa.airport-landings-diverted.num_flights_day_19<br />
uk-caa.airport-landings-diverted.num_flights_day_2<br />
uk-caa.airport-landings-diverted.num_flights_day_20<br />
uk-caa.airport-landings-diverted.num_flights_day_21<br />
uk-caa.airport-landings-diverted.num_flights_day_22<br />
uk-caa.airport-landings-diverted.num_flights_day_23<br />
uk-caa.airport-landings-diverted.num_flights_day_24<br />
uk-caa.airport-landings-diverted.num_flights_day_25<br />
uk-caa.airport-landings-diverted.num_flights_day_26<br />
uk-caa.airport-landings-diverted.num_flights_day_27<br />
uk-caa.airport-landings-diverted.num_flights_day_28<br />
uk-caa.airport-landings-diverted.num_flights_day_29<br />
uk-caa.airport-landings-diverted.num_flights_day_3<br />
uk-caa.airport-landings-diverted.num_flights_day_30<br />
uk-caa.airport-landings-diverted.num_flights_day_31<br />
uk-caa.airport-landings-diverted.num_flights_day_4<br />
uk-caa.airport-landings-diverted.num_flights_day_5<br />
uk-caa.airport-landings-diverted.num_flights_day_6<br />
uk-caa.airport-landings-diverted.num_flights_day_7<br />
uk-caa.airport-landings-diverted.num_flights_day_8<br />
uk-caa.airport-landings-diverted.num_flights_day_9<br />
uk-caa.airport-landings-diverted.total_flights<br />
uk-caa.domestic-air-pax-route-analysis-by-airport.total_pax_charter_last_period<br />
uk-caa.domestic-air-pax-route-analysis-by-airport.total_pax_charter_this_period<br />
uk-caa.domestic-air-pax-route-analysis-by-airport.total_pax_last_period<br />
uk-caa.domestic-air-pax-route-analysis-by-airport.total_pax_percent<br />
uk-caa.domestic-air-pax-route-analysis-by-airport.total_pax_scheduled_last_period<br />
uk-caa.domestic-air-pax-route-analysis-by-airport.total_pax_scheduled_this_period<br />
uk-caa.domestic-air-pax-route-analysis-by-airport.total_pax_this_period<br />
uk-caa.domestic-air-pax-route-analysis-by-each-reporting-airport.total_pax_charter_last_period<br />
uk-caa.domestic-air-pax-route-analysis-by-each-reporting-airport.total_pax_charter_this_period<br />
uk-caa.domestic-air-pax-route-analysis-by-each-reporting-airport.total_pax_last_period<br />
uk-caa.domestic-air-pax-route-analysis-by-each-reporting-airport.total_pax_percent<br />
uk-caa.domestic-air-pax-route-analysis-by-each-reporting-airport.total_pax_scheduled_last_period<br />
uk-caa.domestic-air-pax-route-analysis-by-each-reporting-airport.total_pax_scheduled_this_period<br />
uk-caa.domestic-air-pax-route-analysis-by-each-reporting-airport.total_pax_this_period<br />
uk-caa.domestic-terminal-passenger-traffic.total_pax_charter_last_period<br />
uk-caa.domestic-terminal-passenger-traffic.total_pax_charter_this_period<br />
uk-caa.domestic-terminal-passenger-traffic.total_pax_last_period<br />
uk-caa.domestic-terminal-passenger-traffic.total_pax_percent<br />
uk-caa.domestic-terminal-passenger-traffic.total_pax_scheduled_last_period<br />
uk-caa.domestic-terminal-passenger-traffic.total_pax_scheduled_this_period<br />
uk-caa.domestic-terminal-passenger-traffic.total_pax_this_period<br />
uk-caa.domestic-terminal-pax-traffic.total_pax_charter_this_period<br />
uk-caa.domestic-terminal-pax-traffic.total_pax_last_period<br />
uk-caa.domestic-terminal-pax-traffic.total_pax_percent<br />
uk-caa.domestic-terminal-pax-traffic.total_pax_scheduled_this_period<br />
uk-caa.domestic-terminal-pax-traffic.total_pax_this_period<br />
uk-caa.eu-and-other-intl-passenger-traffic.total_pax_eu_charter_this_period<br />
uk-caa.eu-and-other-intl-passenger-traffic.total_pax_eu_cht_tp<br />
uk-caa.eu-and-other-intl-passenger-traffic.total_pax_eu_last_period<br />
uk-caa.eu-and-other-intl-passenger-traffic.total_pax_eu_lp<br />
uk-caa.eu-and-other-intl-passenger-traffic.total_pax_eu_pc<br />
uk-caa.eu-and-other-intl-passenger-traffic.total_pax_eu_percent<br />
uk-caa.eu-and-other-intl-passenger-traffic.total_pax_eu_scheduled_this_period<br />
uk-caa.eu-and-other-intl-passenger-traffic.total_pax_eu_shd_tp<br />
uk-caa.eu-and-other-intl-passenger-traffic.total_pax_eu_this_period<br />
uk-caa.eu-and-other-intl-passenger-traffic.total_pax_eu_tp<br />
uk-caa.eu-and-other-intl-passenger-traffic.total_pax_oi_cht_tp<br />
uk-caa.eu-and-other-intl-passenger-traffic.total_pax_oi_lp<br />
uk-caa.eu-and-other-intl-passenger-traffic.total_pax_oi_pc<br />
uk-caa.eu-and-other-intl-passenger-traffic.total_pax_oi_shd_tp<br />
uk-caa.eu-and-other-intl-passenger-traffic.total_pax_oi_tp<br />
uk-caa.eu-and-other-intl-passenger-traffic.total_pax_other_international_charter_this_period<br />
uk-caa.eu-and-other-intl-passenger-traffic.total_pax_other_international_last_period<br />
uk-caa.eu-and-other-intl-passenger-traffic.total_pax_other_international_percent<br />
uk-caa.eu-and-other-intl-passenger-traffic.total_pax_other_international_scheduled_this_period<br />
uk-caa.eu-and-other-intl-passenger-traffic.total_pax_other_international_this_period<br />
uk-caa.eu-and-other-intl-passenger-traffic.total_pax_this_period<br />
uk-caa.eu-and-other-intl-passenger-traffic.total_pax_tp<br />
uk-caa.eu-and-other-intl-terminal-pax-traffic.total_pax_eu_charter_this_period<br />
uk-caa.eu-and-other-intl-terminal-pax-traffic.total_pax_eu_last_period<br />
uk-caa.eu-and-other-intl-terminal-pax-traffic.total_pax_eu_percent<br />
uk-caa.eu-and-other-intl-terminal-pax-traffic.total_pax_eu_scheduled_this_period<br />
uk-caa.eu-and-other-intl-terminal-pax-traffic.total_pax_eu_this_period<br />
uk-caa.eu-and-other-intl-terminal-pax-traffic.total_pax_other_international_charter_this_period<br />
uk-caa.eu-and-other-intl-terminal-pax-traffic.total_pax_other_international_last_period<br />
uk-caa.eu-and-other-intl-terminal-pax-traffic.total_pax_other_international_percent<br />
uk-caa.eu-and-other-intl-terminal-pax-traffic.total_pax_other_international_scheduled_this_period<br />
uk-caa.eu-and-other-intl-terminal-pax-traffic.total_pax_other_international_this_period<br />
uk-caa.eu-and-other-intl-terminal-pax-traffic.total_pax_this_period<br />
uk-caa.eu_and_other_intl_passenger_traffic.total_pax_eu_cht_tp<br />
uk-caa.eu_and_other_intl_passenger_traffic.total_pax_eu_lp<br />
uk-caa.eu_and_other_intl_passenger_traffic.total_pax_eu_pc<br />
uk-caa.eu_and_other_intl_passenger_traffic.total_pax_eu_shd_tp<br />
uk-caa.eu_and_other_intl_passenger_traffic.total_pax_eu_tp<br />
uk-caa.eu_and_other_intl_passenger_traffic.total_pax_oi_cht_tp<br />
uk-caa.eu_and_other_intl_passenger_traffic.total_pax_oi_lp<br />
uk-caa.eu_and_other_intl_passenger_traffic.total_pax_oi_pc<br />
uk-caa.eu_and_other_intl_passenger_traffic.total_pax_oi_shd_tp<br />
uk-caa.eu_and_other_intl_passenger_traffic.total_pax_oi_tp<br />
uk-caa.eu_and_other_intl_passenger_traffic.total_pax_tp<br />
uk-caa.freight-by-aircraft-configuration.total_freight_cargo_aircraft_last_period<br />
uk-caa.freight-by-aircraft-configuration.total_freight_cargo_aircraft_percent_change<br />
uk-caa.freight-by-aircraft-configuration.total_freight_cargo_aircraft_this_period<br />
uk-caa.freight-by-aircraft-configuration.total_freight_last_period<br />
uk-caa.freight-by-aircraft-configuration.total_freight_passenger_aircraft_last_period<br />
uk-caa.freight-by-aircraft-configuration.total_freight_passenger_aircraft_percent_change<br />
uk-caa.freight-by-aircraft-configuration.total_freight_passenger_aircraft_this_period<br />
uk-caa.freight-by-aircraft-configuration.total_freight_percent_change<br />
uk-caa.freight-by-aircraft-configuration.total_freight_this_period<br />
uk-caa.freight-by-type-and-nat-of-op.freight_picked_up_charter_foreign_eu<br />
uk-caa.freight-by-type-and-nat-of-op.freight_picked_up_charter_foreign_non_eu<br />
uk-caa.freight-by-type-and-nat-of-op.freight_picked_up_charter_uk<br />
uk-caa.freight-by-type-and-nat-of-op.freight_picked_up_scheduled_foreign_eu<br />
uk-caa.freight-by-type-and-nat-of-op.freight_picked_up_scheduled_foreign_non_eu<br />
uk-caa.freight-by-type-and-nat-of-op.freight_picked_up_scheduled_uk<br />
uk-caa.freight-by-type-and-nat-of-op.freight_set_down_charter_foreign_eu<br />
uk-caa.freight-by-type-and-nat-of-op.freight_set_down_charter_foreign_non_eu<br />
uk-caa.freight-by-type-and-nat-of-op.freight_set_down_charter_uk<br />
uk-caa.freight-by-type-and-nat-of-op.freight_set_down_scheduled_foreign_eu<br />
uk-caa.freight-by-type-and-nat-of-op.freight_set_down_scheduled_foreign_non_eu<br />
uk-caa.freight-by-type-and-nat-of-op.freight_set_down_scheduled_uk<br />
uk-caa.freight-by-type-and-nat-of-op.total_freight<br />
uk-caa.freight-by-type-and-nationality.freight_picked_up_charter_foreign_eu<br />
uk-caa.freight-by-type-and-nationality.freight_picked_up_charter_foreign_non_eu<br />
uk-caa.freight-by-type-and-nationality.freight_picked_up_charter_uk<br />
uk-caa.freight-by-type-and-nationality.freight_picked_up_scheduled_foreign_eu<br />
uk-caa.freight-by-type-and-nationality.freight_picked_up_scheduled_foreign_non_eu<br />
uk-caa.freight-by-type-and-nationality.freight_picked_up_scheduled_uk<br />
uk-caa.freight-by-type-and-nationality.freight_set_down_charter_foreign_eu<br />
uk-caa.freight-by-type-and-nationality.freight_set_down_charter_foreign_non_eu<br />
uk-caa.freight-by-type-and-nationality.freight_set_down_charter_uk<br />
uk-caa.freight-by-type-and-nationality.freight_set_down_scheduled_foreign_eu<br />
uk-caa.freight-by-type-and-nationality.freight_set_down_scheduled_foreign_non_eu<br />
uk-caa.freight-by-type-and-nationality.freight_set_down_scheduled_uk<br />
uk-caa.freight-by-type-and-nationality.total_freight<br />
uk-caa.international-and-domestic-freight.freight_charter_cargo_aircraft_foreign_eu<br />
uk-caa.international-and-domestic-freight.freight_charter_cargo_aircraft_foreign_non_eu<br />
uk-caa.international-and-domestic-freight.freight_charter_cargo_aircraft_uk<br />
uk-caa.international-and-domestic-freight.freight_charter_passenger_aircraft_foreign_eu<br />
uk-caa.international-and-domestic-freight.freight_charter_passenger_aircraft_foreign_non_eu<br />
uk-caa.international-and-domestic-freight.freight_charter_passenger_aircraft_uk<br />
uk-caa.international-and-domestic-freight.freight_passenger_aircraft_foreign_eu<br />
uk-caa.international-and-domestic-freight.freight_schedueld_passenger_aircraft_uk<br />
uk-caa.international-and-domestic-freight.freight_scheduled_cargo_aircraft_foreign_eu<br />
uk-caa.international-and-domestic-freight.freight_scheduled_cargo_aircraft_foreign_non_eu<br />
uk-caa.international-and-domestic-freight.freight_scheduled_cargo_aircraft_uk<br />
uk-caa.international-and-domestic-freight.freight_scheduled_passenger_aircraft_foreign_eu<br />
uk-caa.international-and-domestic-freight.freight_scheduled_passenger_aircraft_foreign_eu1<br />
uk-caa.international-and-domestic-freight.freight_scheduled_passenger_aircraft_foreign_non_eu<br />
uk-caa.international-and-domestic-mail.mail_charter_cargo_aircraft_foreign_eu<br />
uk-caa.international-and-domestic-mail.mail_charter_cargo_aircraft_foreign_non_eu<br />
uk-caa.international-and-domestic-mail.mail_charter_cargo_aircraft_uk<br />
uk-caa.international-and-domestic-mail.mail_charter_passenger_aircraft_foreign_eu<br />
uk-caa.international-and-domestic-mail.mail_charter_passenger_aircraft_foreign_non_eu<br />
uk-caa.international-and-domestic-mail.mail_charter_passenger_aircraft_uk<br />
uk-caa.international-and-domestic-mail.mail_scheduled_cargo_aircraft_foreign_eu<br />
uk-caa.international-and-domestic-mail.mail_scheduled_cargo_aircraft_foreign_non_eu<br />
uk-caa.international-and-domestic-mail.mail_scheduled_cargo_aircraft_uk<br />
uk-caa.international-and-domestic-mail.mail_scheduled_passenger_aircraft_foreign_eu<br />
uk-caa.international-and-domestic-mail.mail_scheduled_passenger_aircraft_foreign_non_eu<br />
uk-caa.international-and-domestic-mail.mail_scheduled_passenger_aircraft_uk<br />
uk-caa.intl-air-pax-traffic-route-analysis.total_pax_charter_last_period<br />
uk-caa.intl-air-pax-traffic-route-analysis.total_pax_charter_this_period<br />
uk-caa.intl-air-pax-traffic-route-analysis.total_pax_last_period<br />
uk-caa.intl-air-pax-traffic-route-analysis.total_pax_percent<br />
uk-caa.intl-air-pax-traffic-route-analysis.total_pax_scheduled_last_period<br />
uk-caa.intl-air-pax-traffic-route-analysis.total_pax_scheduled_this_period<br />
uk-caa.intl-air-pax-traffic-route-analysis.total_pax_this_period<br />
uk-caa.intl-and-domestic-freight.freight_charter_cargo_aircraft_foreign_eu<br />
uk-caa.intl-and-domestic-freight.freight_charter_cargo_aircraft_foreign_non_eu<br />
uk-caa.intl-and-domestic-freight.freight_charter_cargo_aircraft_uk<br />
uk-caa.intl-and-domestic-freight.freight_charter_passenger_aircraft_foreign_non_eu<br />
uk-caa.intl-and-domestic-freight.freight_charter_passenger_aircraft_uk<br />
uk-caa.intl-and-domestic-freight.freight_passenger_aircraft_foreign_eu<br />
uk-caa.intl-and-domestic-freight.freight_schedueld_passenger_aircraft_uk<br />
uk-caa.intl-and-domestic-freight.freight_scheduled_cargo_aircraft_foreign_eu<br />
uk-caa.intl-and-domestic-freight.freight_scheduled_cargo_aircraft_foreign_non_eu<br />
uk-caa.intl-and-domestic-freight.freight_scheduled_cargo_aircraft_uk<br />
uk-caa.intl-and-domestic-freight.freight_scheduled_passenger_aircraft_foreign_eu<br />
uk-caa.intl-and-domestic-freight.freight_scheduled_passenger_aircraft_foreign_eu1<br />
uk-caa.intl-and-domestic-mail.mail_charter_cargo_aircraft_foreign_eu<br />
uk-caa.intl-and-domestic-mail.mail_charter_cargo_aircraft_foreign_non_eu<br />
uk-caa.intl-and-domestic-mail.mail_charter_cargo_aircraft_uk<br />
uk-caa.intl-and-domestic-mail.mail_charter_passenger_aircraft_foreign_eu<br />
uk-caa.intl-and-domestic-mail.mail_charter_passenger_aircraft_foreign_non_eu<br />
uk-caa.intl-and-domestic-mail.mail_charter_passenger_aircraft_uk<br />
uk-caa.intl-and-domestic-mail.mail_scheduled_cargo_aircraft_foreign_eu<br />
uk-caa.intl-and-domestic-mail.mail_scheduled_cargo_aircraft_foreign_non_eu<br />
uk-caa.intl-and-domestic-mail.mail_scheduled_cargo_aircraft_uk<br />
uk-caa.intl-and-domestic-mail.mail_scheduled_passenger_aircraft_foreign_eu<br />
uk-caa.intl-and-domestic-mail.mail_scheduled_passenger_aircraft_foreign_non_eu<br />
uk-caa.intl-and-domestic-mail.mail_scheduled_passenger_aircraft_uk<br />
uk-caa.mail-by-aircraft-configuration.total_mail_cargo_aircraft_last_period<br />
uk-caa.mail-by-aircraft-configuration.total_mail_cargo_aircraft_percent_change<br />
uk-caa.mail-by-aircraft-configuration.total_mail_cargo_aircraft_this_period<br />
uk-caa.mail-by-aircraft-configuration.total_mail_last_period<br />
uk-caa.mail-by-aircraft-configuration.total_mail_passenger_aircraft_last_period<br />
uk-caa.mail-by-aircraft-configuration.total_mail_passenger_aircraft_percent_change<br />
uk-caa.mail-by-aircraft-configuration.total_mail_passenger_aircraft_this_period<br />
uk-caa.mail-by-aircraft-configuration.total_mail_percent_change<br />
uk-caa.mail-by-aircraft-configuration.total_mail_this_period<br />
uk-caa.mail-by-type-and-nat-of-op.mail_picked_up_charter_foreign_eu<br />
uk-caa.mail-by-type-and-nat-of-op.mail_picked_up_charter_foreign_non_eu<br />
uk-caa.mail-by-type-and-nat-of-op.mail_picked_up_charter_uk<br />
uk-caa.mail-by-type-and-nat-of-op.mail_picked_up_scheduled_foreign_eu<br />
uk-caa.mail-by-type-and-nat-of-op.mail_picked_up_scheduled_foreign_non_eu<br />
uk-caa.mail-by-type-and-nat-of-op.mail_picked_up_scheduled_uk<br />
uk-caa.mail-by-type-and-nat-of-op.mail_set_down_charter_foreign_eu<br />
uk-caa.mail-by-type-and-nat-of-op.mail_set_down_charter_foreign_non_eu<br />
uk-caa.mail-by-type-and-nat-of-op.mail_set_down_charter_uk<br />
uk-caa.mail-by-type-and-nat-of-op.mail_set_down_scheduled_foreign_eu<br />
uk-caa.mail-by-type-and-nat-of-op.mail_set_down_scheduled_foreign_non_eu<br />
uk-caa.mail-by-type-and-nat-of-op.mail_set_down_scheduled_uk<br />
uk-caa.mail-by-type-and-nat-of-op.total_mail<br />
uk-caa.mail-by-type-and-nationality.mail_picked_up_charter_foreign_eu<br />
uk-caa.mail-by-type-and-nationality.mail_picked_up_charter_foreign_non_eu<br />
uk-caa.mail-by-type-and-nationality.mail_picked_up_charter_uk<br />
uk-caa.mail-by-type-and-nationality.mail_picked_up_scheduled_foreign_eu<br />
uk-caa.mail-by-type-and-nationality.mail_picked_up_scheduled_foreign_non_eu<br />
uk-caa.mail-by-type-and-nationality.mail_picked_up_scheduled_uk<br />
uk-caa.mail-by-type-and-nationality.mail_set_down_charter_foreign_eu<br />
uk-caa.mail-by-type-and-nationality.mail_set_down_charter_foreign_non_eu<br />
uk-caa.mail-by-type-and-nationality.mail_set_down_charter_uk<br />
uk-caa.mail-by-type-and-nationality.mail_set_down_scheduled_foreign_eu<br />
uk-caa.mail-by-type-and-nationality.mail_set_down_scheduled_foreign_non_eu<br />
uk-caa.mail-by-type-and-nationality.mail_set_down_scheduled_uk<br />
uk-caa.mail-by-type-and-nationality.total_mail<br />
uk-caa.pax-and-air-transport-movements-split-by-fixed-and-rotary-wing-aircraft.total_atms_fixed_wing_last_period<br />
uk-caa.pax-and-air-transport-movements-split-by-fixed-and-rotary-wing-aircraft.total_atms_fixed_wing_percent_change<br />
uk-caa.pax-and-air-transport-movements-split-by-fixed-and-rotary-wing-aircraft.total_atms_fixed_wing_this_period<br />
uk-caa.pax-and-air-transport-movements-split-by-fixed-and-rotary-wing-aircraft.total_atms_rotary_wing_last_period<br />
uk-caa.pax-and-air-transport-movements-split-by-fixed-and-rotary-wing-aircraft.total_atms_rotary_wing_percent_change<br />
uk-caa.pax-and-air-transport-movements-split-by-fixed-and-rotary-wing-aircraft.total_atms_rotary_wing_this_period<br />
uk-caa.pax-and-air-transport-movements-split-by-fixed-and-rotary-wing-aircraft.total_pax_fixed_wing_last_period<br />
uk-caa.pax-and-air-transport-movements-split-by-fixed-and-rotary-wing-aircraft.total_pax_fixed_wing_percent_change<br />
uk-caa.pax-and-air-transport-movements-split-by-fixed-and-rotary-wing-aircraft.total_pax_fixed_wing_this_period<br />
uk-caa.pax-and-air-transport-movements-split-by-fixed-and-rotary-wing-aircraft.total_pax_rotary_wing_last_period<br />
uk-caa.pax-and-air-transport-movements-split-by-fixed-and-rotary-wing-aircraft.total_pax_rotary_wing_percent_change<br />
uk-caa.pax-and-air-transport-movements-split-by-fixed-and-rotary-wing-aircraft.total_pax_rotary_wing_this_period<br />
uk-caa.pax-and-atm-by-fixed-rotary-wing-aircraft.total_atms_fixed_wing_last_period<br />
uk-caa.pax-and-atm-by-fixed-rotary-wing-aircraft.total_atms_fixed_wing_percent_change<br />
uk-caa.pax-and-atm-by-fixed-rotary-wing-aircraft.total_atms_fixed_wing_this_period<br />
uk-caa.pax-and-atm-by-fixed-rotary-wing-aircraft.total_atms_rotary_wing_last_period<br />
uk-caa.pax-and-atm-by-fixed-rotary-wing-aircraft.total_atms_rotary_wing_percent_change<br />
uk-caa.pax-and-atm-by-fixed-rotary-wing-aircraft.total_atms_rotary_wing_this_period<br />
uk-caa.pax-and-atm-by-fixed-rotary-wing-aircraft.total_pax_fixed_wing_last_period<br />
uk-caa.pax-and-atm-by-fixed-rotary-wing-aircraft.total_pax_fixed_wing_percent_change<br />
uk-caa.pax-and-atm-by-fixed-rotary-wing-aircraft.total_pax_fixed_wing_this_period<br />
uk-caa.pax-and-atm-by-fixed-rotary-wing-aircraft.total_pax_rotary_wing_last_period<br />
uk-caa.pax-and-atm-by-fixed-rotary-wing-aircraft.total_pax_rotary_wing_percent_change<br />
uk-caa.pax-and-atm-by-fixed-rotary-wing-aircraft.total_pax_rotary_wing_this_period<br />
uk-caa.size-of-uk-airports.last_year_pax<br />
uk-caa.size-of-uk-airports.last_year_total_pax_uk_airports<br />
uk-caa.size-of-uk-airports.this_year_pax<br />
uk-caa.size-of-uk-airports.this_year_total_pax_uk_airports<br />
uk-caa.size-of-uk-airportslast_year_pax<br />
uk-caa.size-of-uk-airportslast_year_total_pax_uk_airports<br />
uk-caa.size-of-uk-airportsthis_year_pax<br />
uk-caa.size-of-uk-airportsthis_year_total_pax_uk_airports<br />
uk-caa.summary-of-activity-at-uk-airports.atms_charter<br />
uk-caa.summary-of-activity-at-uk-airports.atms_scheduled<br />
uk-caa.summary-of-activity-at-uk-airports.charter_freight<br />
uk-caa.summary-of-activity-at-uk-airports.charter_mail<br />
uk-caa.summary-of-activity-at-uk-airports.scheduled_freight<br />
uk-caa.summary-of-activity-at-uk-airports.scheduled_mail<br />
uk-caa.summary-of-activity-at-uk-airports.terminal_charter_pax<br />
uk-caa.summary-of-activity-at-uk-airports.terminal_scheduled_pax<br />
uk-caa.summary-of-activity-at-uk-airports.transit_charter_pax<br />
uk-caa.summary-of-activity-at-uk-airports.transit_scheduled_pax<br />
uk-caa.terminal-and-transit-passengers.terminal_pax_last_period<br />
uk-caa.terminal-and-transit-passengers.terminal_pax_percent<br />
uk-caa.terminal-and-transit-passengers.terminal_pax_this_period<br />
uk-caa.terminal-and-transit-passengers.total_pax_last_period<br />
uk-caa.terminal-and-transit-passengers.total_pax_percent<br />
uk-caa.terminal-and-transit-passengers.total_pax_this_period<br />
uk-caa.terminal-and-transit-passengers.transit_pax_last_period<br />
uk-caa.terminal-and-transit-passengers.transit_pax_percent<br />
uk-caa.terminal-and-transit-passengers.transit_pax_this_period<br />
uk-caa.terminal-and-transit-pax.terminal_pax_last_period<br />
uk-caa.terminal-and-transit-pax.terminal_pax_percent<br />
uk-caa.terminal-and-transit-pax.terminal_pax_this_period<br />
uk-caa.terminal-and-transit-pax.total_pax_last_period<br />
uk-caa.terminal-and-transit-pax.total_pax_percent<br />
uk-caa.terminal-and-transit-pax.total_pax_this_period<br />
uk-caa.terminal-and-transit-pax.transit_pax_last_period<br />
uk-caa.terminal-and-transit-pax.transit_pax_percent<br />
uk-caa.terminal-and-transit-pax.transit_pax_this_period<br />
uk-caa.trans-move-by-type.airport_cluster<br />
uk-caa.trans-move-by-type.atms_charter_foreign_eu_operator<br />
uk-caa.trans-move-by-type.atms_charter_foreign_non_eu_operator<br />
uk-caa.trans-move-by-type.atms_charter_uk_operator<br />
uk-caa.trans-move-by-type.atms_scheduled_foreign_eu_operator<br />
uk-caa.trans-move-by-type.atms_scheduled_foreign_non_eu_operator<br />
uk-caa.trans-move-by-type.atms_scheduled_uk_operator<br />
uk-caa.trans-move-by-type.rpt_apt_grp_cd<br />
uk-caa.trans-move-by-type.total_atms<br />
uk-caa.transport-movements-by-type.airport_cluster<br />
uk-caa.transport-movements-by-type.atms_charter_foreign_eu_operator<br />
uk-caa.transport-movements-by-type.atms_charter_foreign_non_eu_operator<br />
uk-caa.transport-movements-by-type.atms_charter_uk_operator<br />
uk-caa.transport-movements-by-type.atms_scheduled_foreign_eu_operator<br />
uk-caa.transport-movements-by-type.atms_scheduled_foreign_non_eu_operator<br />
uk-caa.transport-movements-by-type.atms_scheduled_uk_operator<br />
uk-caa.transport-movements-by-type.rpt_apt_grp_cd<br />
uk-caa.transport-movements-by-type.total_atms<br />
```
