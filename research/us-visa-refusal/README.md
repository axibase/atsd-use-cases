# Denied Visa Application Fees Total Over $400 Million

![TitlePhoto](./images/TitlePhoto.png)

In 2015, the U.S. State Department earned over **$400 million** from non-immigrant visa applications that ended up being rejected. This article analyzes a dataset from [`travel.state.gov`](https://travel.state.gov) which examines non-immigrant visa figures from 1997 through 2015 together with a second `travel.state.gov` dataset concerning visa refusal rates
from 2006 to 2016.

Publicly available data can be loaded into ATSD, analyzed using [SQL Console](https://axibase.com/docs/atsd/sql/), and visualized with [**ChartLab**](../../tutorials/shared/chartlab.md)

## Dataset

Access the gzipped tarball in the [Resources](./resources/visas.tar.gz) directory or download the collection of annual CSV files from [`travel.state.gov`](https://travel.state.gov). Search for **Nonimmigrant Visa Issuances by Visa Class and by Nationality FY1997-2015 NIV Detail Table**.

The dataset contains yearly totals for non-immigrant visas issued from 1997 through 2015. Totals are collected for 84 different visa types. You can find the complete list of all
the visa types included in this dataset in the [Resources](./resources/visalist.txt) directory. Read descriptions of each visa type on the [U.S. Department of State](https://travel.state.gov) website.

Visa figures are collected from 200 countries, 7 continents, and for those of unknown national origins. You can find a complete list of all the countries included in this dataset in the [Resources](./resources/countrylist.txt) directory.

Visa refusal rates are taken from [`travel.state.gov`](https://travel.state.gov/content/dam/visas/Statistics/Non-Immigrant-Statistics/refusalratelanguage.pdf#3). Access the raw data in the [Resources](./resources/visa-refusal.csv) directory as individual CSV files for each year.

These refusal rates are only tracked for [`B` visas](https://en.wikipedia.org/wiki/B_visa). `B-1`
visas are issued for individuals seeking entry for business purposes, while `B-2` visas are issued for tourism and non-business purposes.

As opposed to analyzing this information in Excel, it is much more convenient to interact with the data by loading it into a database. Load the dataset into a local ATSD instance by following the procedure outlined in [Action Items](#action-items).

## U.S. Visa Refusal Rates

The below figure shows the refusal rates from 2006 through 2016. Notice that refusal rates for Syrian nationals grew from **23.6%** in 2009 to **60.0%** in 2016. Filter
by country by clicking on the drop-down list. Listed here are a few more countries with figures showing how refusal rates have changed over time.

* **Mexico**: 33.0% (2007) to 23.5% (2016)
* **Russia**: 15.3% (2006) to 9.3% (2016)
* **Iran**: 45% (2006) to 45% (2016)
* **China**: 24.5% (2006) to 12.4% (2016)

![Figure1](./images/Figure1.png)

[![View in ChartLab](./images/button.png)](https://apps.axibase.com/chartlab/8c9bb9cc/4/#fullscreen)

The below image tracks how refusal rates have changed over time for Afghanistan, Canada, Mainland China, India, Mexico, Norway, Russia, and Vatican City.

![Figure4](./images/Figure4.png)

[![View in ChartLab](./images/button.png)](https://apps.axibase.com/chartlab/8c9bb9cc/5/#fullscreen)

The figure below shows the countries with the highest and lowest refusal rates in 2015. Cuba topped the list with the highest refusal rate at **82%**, while Liechtenstein, Monaco, and
San Marino all showed refusal rates of **0%**.

![Figure3](./images/Figure3.png)

[![View in ChartLab](./images/button.png)](https://apps.axibase.com/chartlab/b8675093/2/#fullscreen)

The figure below shows distribution over time of the lowest and highest refusal rates from 2015. Navigate through the distributions and observe the maximum and minimum refusal rates for the country from 2006 through 2016, as well as values for the 25th, 50th, and 75th percentiles. The visa refusal rates
for nationals from Monaco has increased to **57%** in 2015 and Cuba has increased to **82%** in 2015.

![Figure2](./images/Figure2.png)

[![View in ChartLab](./images/button.png)](https://apps.axibase.com/chartlab/b8675093#fullscreen)

## SQL Queries

In addition **ChartLab** visualizations, ATSD supports [SQL queries](https://axibase.com/docs/atsd/sql/) from the web-based [**SQL Console**](https://axibase.com/docs/atsd/sql/sql-console.html),
used to select specific information in the dataset. Read more about SQL syntax in the [SQL Documentation](https://axibase.com/docs/atsd/sql/#syntax).

The first query shows countries where refusals have increased the most over the last 10 years. Surprisingly, two countries that have long been considered U.S. allies, Canada and Norway,
saw refusal rates considerably increase during the observed period. Refusal rate in Canada increased from **25.5%** in 2006 to **47.9%** in 2016, while in the same period the
refusal rate in Norway increased by **17.1%**. Cuba, the country with the largest visa refusal rate in 2016, saw a **20.5%** increase from 2006 to 2016, despite having diplomatic relations improve
in the last several years: `https://www.state.gov/s/d/rm/rls/perfrpt/2015/html/249702.htm`.

```sql
SELECT tags.country AS "Country",
  first(value) AS "Refusal Rate, 2006",
  median(value) AS "Median Rate, 2006-2016",
  last(value) AS "Refusal Rate, 2016",
  last(value)-first(value) AS "Change, 2006-2016"
FROM "state.visa-refusal-rate"
  GROUP BY tags.country
  HAVING COUNT(value) > 10
ORDER BY 'Change, 2006-2016' DESC
  LIMIT 25
```

```ls
| Country                           | Refusal Rate, 2006  | Median Rate, 2006-2016  | Refusal Rate, 2016  | Change, 2006-2016 |
|-----------------------------------|---------------------|-------------------------|---------------------|-------------------|
| Vatican City                      | 0.0                 | 11.8                    | 62.5                | 62.5              |
| Angola                            | 11.1                | 19.9                    | 48.5                | 37.4              |
| Afghanistan                       | 39.8                | 56.0                    | 73.8                | 34.0              |
| Burkina Faso                      | 33.2                | 43.1                    | 65.4                | 32.1              |
| Comoros                           | 21.6                | 25.0                    | 53.7                | 32.1              |
| Haiti                             | 32.7                | 54.4                    | 64.5                | 31.8              |
| Maldives                          | 16.3                | 16.3                    | 47.6                | 31.3              |
| Liberia                           | 39.4                | 57.6                    | 70.2                | 30.8              |
| Burundi                           | 32.9                | 52.2                    | 61.3                | 28.4              |
| Guinea-Bissau                     | 44.5                | 55.0                    | 71.9                | 27.4              |
| Venezuela                         | 13.8                | 16.1                    | 40.2                | 26.4              |
| Tajikistan                        | 31.2                | 32.4                    | 55.2                | 24.0              |
| Syria                             | 36.7                | 36.7                    | 59.8                | 23.1              |
| Canada                            | 25.5                | 47.9                    | 47.9                | 22.4              |
| Kyrgyzstan                        | 29.4                | 29.8                    | 51.7                | 22.3              |
| Cuba                              | 61.3                | 53.1                    | 81.8                | 20.5              |
| Congo, Rep. of the (Brazzaville)  | 29.0                | 33.0                    | 46.6                | 17.5              |
| Norway                            | 4.9                 | 17.8                    | 22.0                | 17.1              |
| Algeria                           | 20.2                | 23.1                    | 36.0                | 15.8              |
| Bangladesh                        | 47.2                | 47.2                    | 62.8                | 15.6              |
| Pakistan                          | 31.3                | 40.0                    | 46.4                | 15.1              |
| Kazakhstan                        | 12.5                | 11.7                    | 27.6                | 15.0              |
| Mauritania                        | 56.5                | 54.7                    | 71.4                | 15.0              |
| Mali                              | 42.7                | 52.8                    | 57.6                | 14.9              |
| Marshall Islands                  | 14.7                | 14.0                    | 29.4                | 14.7              |
```

The query below shows countries where refusals have decreased the most over the last 10 years. Poland experienced a decrease of **20.8%**, most likely resulting from Polish admittance
to the [European Union](https://en.wikipedia.org/wiki/European_Union) in 2004. Seven African countries (Cote d'Ivoire, Kiribati, Malawi, Niger, Nigeria, Zambia, Zimbabwe) experienced decreases
greater than **12.4%** from 2006 to 2016.

```sql
SELECT tags.country AS "Country",
  first(value) AS "Refusal Rate, 2006",
  median(value) AS "Median Rate, 2006-2016",
  last(value) AS "Refusal Rate, 2016",
  last(value)-first(value) AS "Change, 2006-2016"
FROM "state.visa-refusal-rate"
  GROUP BY tags.country
  HAVING COUNT(value) > 10
ORDER BY 'Change, 2006-2016'
  LIMIT 25
```

```ls
| Country                          | Refusal Rate, 2006  | Median Rate, 2006-2016  | Refusal Rate, 2016  | Change, 2006-2016 |
|----------------------------------|---------------------|-------------------------|---------------------|-------------------|
| Micronesia, Federated States of  | 100.0               | 50.0                    | 25.0                | -75.0             |
| Guyana                           | 60.3                | 52.7                    | 25.8                | -34.5             |
| Burma                            | 44.9                | 32.0                    | 13.0                | -31.9             |
| Palau                            | 78.6                | 53.3                    | 53.3                | -25.3             |
| San Marino                       | 25.0                | 0.0                     | 0.0                 | -25.0             |
| Cambodia                         | 58.3                | 44.0                    | 35.6                | -22.7             |
| Romania                          | 34.1                | 22.4                    | 11.4                | -22.7             |
| Poland                           | 26.2                | 10.2                    | 5.4                 | -20.8             |
| Niger                            | 51.9                | 41.3                    | 31.1                | -20.8             |
| Malawi                           | 35.1                | 26.9                    | 14.5                | -20.6             |
| Peru                             | 48.6                | 26.0                    | 28.6                | -20.0             |
| Paraguay                         | 26.3                | 7.6                     | 7.5                 | -18.8             |
| Albania                          | 54.5                | 39.8                    | 36.0                | -18.5             |
| Zambia                           | 39.8                | 23.1                    | 22.3                | -17.5             |
| Zimbabwe                         | 40.1                | 22.9                    | 22.9                | -17.2             |
| Bolivia                          | 31.4                | 17.4                    | 14.4                | -17.0             |
| Turkmenistan                     | 48.7                | 24.3                    | 33.0                | -15.8             |
| Costa Rica                       | 24.1                | 13.7                    | 8.4                 | -15.7             |
| Colombia                         | 33.3                | 21.7                    | 17.8                | -15.5             |
| Monaco                           | 14.3                | 12.5                    | 0.0                 | -14.3             |
| Cote d`Ivoire                    | 51.3                | 37.4                    | 37.4                | -13.9             |
| Vanuatu                          | 30.0                | 16.7                    | 16.7                | -13.3             |
| Armenia                          | 58.7                | 48.9                    | 45.9                | -12.8             |
| Nigeria                          | 54.0                | 35.1                    | 41.4                | -12.6             |
| Kiribati                         | 18.2                | 19.6                    | 5.8                 | -12.4             |
```

Countries with greater refusal rates in 2016:

```sql
SELECT tags.country AS "Country",
  first(value) AS "Refusal Rate, 2006",
  median(value) AS "Median Rate, 2006-2016",
  last(value) AS "Refusal Rate, 2016",
  last(value)-first(value) AS "Change, 2006-2016"
FROM "state.visa-refusal-rate"
  GROUP BY tags.country
  HAVING COUNT(value) > 10
ORDER BY last(value) DESC
  LIMIT 10
```

```ls
| Country        | Refusal Rate, 2006  | Median Rate, 2006-2016  | Refusal Rate, 2016  | Change, 2006-2016 |
|----------------|---------------------|-------------------------|---------------------|-------------------|
| Cuba           | 61.3                | 53.1                    | 81.8                | 20.5              |
| Afghanistan    | 39.8                | 56.0                    | 73.8                | 34.0              |
| Guinea-Bissau  | 44.5                | 55.0                    | 71.9                | 27.4              |
| Mauritania     | 56.5                | 54.7                    | 71.4                | 15.0              |
| Liberia        | 39.4                | 57.6                    | 70.2                | 30.8              |
| Gambia, The    | 65.5                | 67.2                    | 69.9                | 4.4               |
| Bhutan         | 57.0                | 54.6                    | 69.8                | 12.8              |
| Ghana          | 66.1                | 59.8                    | 65.7                | -0.4              |
| Burkina Faso   | 33.2                | 43.1                    | 65.4                | 32.1              |
| Haiti          | 32.7                | 54.4                    | 64.5                | 31.8              |
```

Countries with lowest refusal rates in 2016:

```sql
SELECT tags.country AS "Country",
  first(value) AS "Refusal Rate, 2006",
  median(value) AS "Median Rate, 2006-2016",
  last(value) AS "Refusal Rate, 2016",
  last(value)-first(value) AS "Change, 2006-2016"
FROM "state.visa-refusal-rate"
  GROUP BY tags.country
  HAVING COUNT(value) > 10
ORDER BY last(value)
  LIMIT 10
```

```ls
| Country               | Refusal Rate, 2006  | Median Rate, 2006-2016  | Refusal Rate, 2016  | Change, 2006-2016 |
|-----------------------|---------------------|-------------------------|---------------------|-------------------|
| Liechtenstein         | 5.9                 | 5.9                     | 0.0                 | -5.9              |
| Monaco                | 14.3                | 12.5                    | 0.0                 | -14.3             |
| San Marino            | 25.0                | 0.0                     | 0.0                 | -25.0             |
| Oman                  | 5.2                 | 2.8                     | 1.9                 | -3.3              |
| Cyprus                | 2.2                 | 1.9                     | 2.0                 | -0.2              |
| Argentina             | 6.7                 | 2.5                     | 2.1                 | -4.6              |
| Uruguay               | 12.6                | 3.8                     | 3.1                 | -9.5              |
| Qatar                 | 4.1                 | 3.0                     | 3.5                 | -0.6              |
| Malaysia              | 11.4                | 5.4                     | 3.6                 | -7.8              |
| United Arab Emirates  | 9.8                 | 8.0                     | 4.0                 | -5.8              |
```

Import visa refusal rates from
[`travel.state.gov`](https://travel.state.gov/content/dam/visas/Statistics/Non-Immigrant-Statistics/RefusalRates/FY16.pdf) to ATSD as a series, and calculate the dollar amount earned from denied visas. In 2015 Mexico paid the most for refused visa applications at **$59,794,320** with India at a close second paying **$47,992,945**.

```sql
SELECT  t1.tags.country AS "Country", t1.value AS "Total Visas Issued", t2.value AS "Visa Refusal Rate",
  ROUND(t1.value/((100-t2.value)/100)) AS "Applications",
  ROUND(t1.value/((100-t2.value)/100))* (t2.value/100) AS "Refusals",
  ROUND(160*(t1.value/((100-t2.value)/100))* (t2.value/100)) AS "Refusal Fees"
  FROM "state.non-immigrant-visa" t1
JOIN "state.visa-refusal-rate" t2
WHERE t1.tags.country NOT LIKE '%Total%' AND t1.tags.visa_type = 'Grand Total' AND date_format(t1.time, 'yyyy') = '2015'
ORDER BY 'Refusal Fees' DESC
```

```ls
| Country                                | Total Visas Issued  | Visa Refusal Rate  | Applications  | Refusals  | Refusal Fees |
|----------------------------------------|---------------------|--------------------|---------------|-----------|--------------|
| Mexico                                 | 1479109             | 20                 | 1852823       | 373714    | 59794320     |
| India                                  | 961423              | 24                 | 1261379       | 299956    | 47992945     |
| China - mainland                       | 2626584             | 10                 | 2919400       | 292816    | 46850528     |
| Philippines                            | 198571              | 28                 | 275640        | 77069     | 12331028     |
| Nigeria                                | 156147              | 33                 | 231535        | 75388     | 12062032     |
| Cuba                                   | 22797               | 76                 | 95106         | 72309     | 11569501     |
| Ecuador                                | 157430              | 31                 | 229289        | 71859     | 11497480     |
| Colombia                               | 368358              | 16                 | 436030        | 67672     | 10827493     |
| Jamaica                                | 101025              | 38                 | 161951        | 60926     | 9748151      |
| Haiti                                  | 36966               | 60                 | 93466         | 56500     | 9040080      |
| Brazil                                 | 930306              | 5                  | 982995        | 52689     | 8430161      |
| El Salvador                            | 60875               | 46                 | 112150        | 51275     | 8203994      |
| Pakistan                               | 74150               | 40                 | 124413        | 50263     | 8042040      |
| Dominican Republic                     | 93071               | 34                 | 140548        | 47477     | 7596348      |
| Guatemala                              | 55618               | 45                 | 101809        | 46191     | 7390485      |
| Venezuela                              | 237926              | 16                 | 281803        | 43877     | 7020268      |
| Ukraine                                | 77203               | 34                 | 117027        | 39824     | 6371910      |
| Vietnam                                | 107205              | 23                 | 140009        | 32804     | 5248663      |
| Honduras                               | 49311               | 40                 | 81817         | 32506     | 5200932      |
| Bangladesh                             | 21636               | 60                 | 54036         | 32400     | 5183994      |
| Egypt                                  | 55317               | 34                 | 83271         | 27954     | 4472658      |
| Jordan                                 | 43475               | 38                 | 69660         | 26185     | 4189650      |
| Great Britain and Northern Ireland     | 93516               | 20                 | 117497        | 23981     | 3836988      |
| Iran                                   | 35363               | 39                 | 57548         | 22185     | 3549536      |
| Ghana                                  | 11660               | 63                 | 31754         | 20094     | 3215010      |
| Peru                                   | 111918              | 14                 | 130837        | 18919     | 3027046      |
| Guyana                                 | 30757               | 37                 | 49039         | 18282     | 2925053      |
| Russia                                 | 159896              | 10                 | 178137        | 18241     | 2918601      |
| Syria                                  | 10061               | 63                 | 27512         | 17451     | 2792099      |
| Turkey                                 | 105519              | 14                 | 122526        | 17007     | 2721047      |
| Nepal                                  | 21992               | 42                 | 38042         | 16050     | 2567978      |
| Iraq                                   | 13499               | 53                 | 28612         | 15113     | 2418032      |
| Nicaragua                              | 19656               | 41                 | 33423         | 13767     | 2202702      |
| Ethiopia                               | 14573               | 48                 | 28199         | 13626     | 2180085      |
| Korea, South                           | 73402               | 13                 | 84574         | 11172     | 1787562      |
| Australia                              | 40290               | 21                 | 51155         | 10865     | 1738465      |
| Uzbekistan                             | 11043               | 50                 | 21906         | 10863     | 1738139      |
| Japan                                  | 75700               | 12                 | 86238         | 10538     | 1686132      |
| Lebanon                                | 26150               | 27                 | 35871         | 9721      | 1555369      |
| France                                 | 48378               | 16                 | 57785         | 9407      | 1505196      |
| Trinidad and Tobago                    | 27310               | 25                 | 36491         | 9181      | 1468989      |
| Georgia                                | 8823                | 51                 | 17853         | 9030      | 1444815      |
| Thailand                               | 63952               | 12                 | 72963         | 9011      | 1441747      |
| Kenya                                  | 22090               | 27                 | 30402         | 8312      | 1329899      |
| Italy                                  | 29132               | 22                 | 37397         | 8265      | 1322346      |
| Germany                                | 65798               | 11                 | 73823         | 8025      | 1283921      |
| Liberia                                | 4545                | 62                 | 12104         | 7559      | 1209418      |
| Armenia                                | 8292                | 47                 | 15696         | 7404      | 1184580      |
| Canada                                 | 7495                | 49                 | 14734         | 7239      | 1158182      |
| Indonesia                              | 70297               | 9                  | 77004         | 6707      | 1073128      |
| Costa Rica                             | 61248               | 10                 | 67925         | 6677      | 1068325      |
| Spain                                  | 30580               | 18                 | 37184         | 6604      | 1056616      |
| Afghanistan                            | 4156                | 61                 | 10665         | 6509      | 1041378      |
| Poland                                 | 95097               | 6                  | 101567        | 6470      | 1035169      |
| Israel                                 | 160249              | 4                  | 166666        | 6417      | 1026660      |
| Romania                                | 47352               | 11                 | 53300         | 5948      | 951730       |
| Mongolia                               | 10803               | 35                 | 16559         | 5756      | 920938       |
| Congo, Dem. Rep. of the (Kinshasa)     | 6851                | 46                 | 12598         | 5747      | 919581       |
| Senegal                                | 4684                | 54                 | 10265         | 5581      | 892988       |
| Argentina                              | 252525              | 2                  | 258047        | 5522      | 883554       |
| Burkina Faso                           | 5424                | 50                 | 10929         | 5505      | 880780       |
| Palestinian Authority Travel Document  | 7381                | 43                 | 12877         | 5496      | 879333       |
| Yemen                                  | 4525                | 54                 | 9839          | 5314      | 850255       |
| Morocco                                | 20320               | 21                 | 25592         | 5272      | 843510       |
| Moldova                                | 7045                | 42                 | 12111         | 5066      | 810569       |
| Albania                                | 8260                | 37                 | 13074         | 4814      | 770201       |
| Algeria                                | 13689               | 26                 | 18479         | 4790      | 766347       |
| Laos                                   | 2305                | 67                 | 6918          | 4613      | 738043       |
| Saudi Arabia                           | 133235              | 3                  | 137696        | 4461      | 713818       |
| Panama                                 | 34036               | 11                 | 38398         | 4362      | 697922       |
| Bulgaria                               | 20854               | 17                 | 25204         | 4350      | 696041       |
| Cameroon                               | 10089               | 30                 | 14390         | 4301      | 688199       |
| Ireland                                | 18606               | 18                 | 22785         | 4179      | 668595       |
| Kyrgyzstan                             | 3236                | 56                 | 7313          | 4077      | 652319       |
| Sri Lanka                              | 14337               | 22                 | 18397         | 4060      | 649645       |
| Angola                                 | 10565               | 27                 | 14427         | 3862      | 617944       |
| Serbia                                 | 19411               | 17                 | 23258         | 3847      | 615496       |
| Sweden                                 | 12733               | 23                 | 16577         | 3844      | 615083       |
| Gambia, The                            | 1228                | 76                 | 5041          | 3813      | 610088       |
| Bolivia                                | 23118               | 14                 | 26745         | 3627      | 580250       |
| Eritrea                                | 2810                | 56                 | 6339          | 3529      | 564612       |
| Uganda                                 | 7917                | 31                 | 11413         | 3496      | 559314       |
| Sudan                                  | 5080                | 40                 | 8531          | 3451      | 552103       |
| Cambodia                               | 3662                | 48                 | 7098          | 3436      | 549804       |
| South Africa                           | 61997               | 5                  | 65315         | 3318      | 530880       |
| Guinea                                 | 2205                | 60                 | 5486          | 3281      | 525030       |
| Kosovo                                 | 4162                | 44                 | 7436          | 3274      | 523860       |
| Macedonia                              | 5505                | 36                 | 8612          | 3107      | 497172       |
| Norway                                 | 9106                | 25                 | 12161         | 3055      | 488766       |
| China - Taiwan                         | 30601               | 9                  | 33557         | 2956      | 473025       |
| Kazakhstan                             | 20264               | 13                 | 23212         | 2948      | 471666       |
| Hong Kong S.A.R.                       | 61288               | 4                  | 64082         | 2794      | 447036       |
| Netherlands                            | 18553               | 13                 | 21328         | 2775      | 443958       |
| Mali                                   | 2359                | 53                 | 4995          | 2636      | 421713       |
| Singapore                              | 11958               | 18                 | 14551         | 2593      | 414878       |
| Mauritania                             | 1607                | 61                 | 4169          | 2562      | 409858       |
| Montenegro                             | 5597                | 31                 | 8142          | 2545      | 407244       |
| Libya                                  | 3303                | 43                 | 5797          | 2494      | 399003       |
| Hungary                                | 5406                | 31                 | 7870          | 2464      | 394263       |
| Denmark                                | 8999                | 21                 | 11352         | 2353      | 376534       |
| Cote d`Ivoire                          | 5813                | 29                 | 8140          | 2327      | 372371       |
| Chile                                  | 14223               | 14                 | 16473         | 2250      | 360039       |
| Sierra Leone                           | 1963                | 53                 | 4178          | 2215      | 354460       |
| Rwanda                                 | 2245                | 49                 | 4417          | 2172      | 347469       |
| Belize                                 | 4745                | 30                 | 6824          | 2079      | 332703       |
| Belarus                                | 14505               | 13                 | 16583         | 2078      | 332453       |
| Zimbabwe                               | 7743                | 21                 | 9805          | 2062      | 329918       |
| Greece                                 | 7339                | 22                 | 9396          | 2057      | 329076       |
| Burma                                  | 10357               | 16                 | 12377         | 2020      | 323186       |
| New Zealand                            | 9809                | 17                 | 11810         | 2001      | 320086       |
| Cabo Verde                             | 3536                | 36                 | 5529          | 1993      | 318931       |
| Kuwait                                 | 31634               | 6                  | 33557         | 1923      | 307649       |
| Tunisia                                | 7596                | 20                 | 9458          | 1862      | 297976       |
| Burundi                                | 1327                | 58                 | 3186          | 1859      | 297452       |
| Bosnia and Herzegovina                 | 6121                | 20                 | 7688          | 1567      | 250683       |
| United Arab Emirates                   | 20403               | 7                  | 21962         | 1559      | 249492       |
| Lithuania                              | 3037                | 33                 | 4566          | 1529      | 244677       |
| Togo                                   | 1983                | 43                 | 3505          | 1522      | 243484       |
| Malaysia                               | 43783               | 3                  | 45296         | 1513      | 242061       |
| Tajikistan                             | 1860                | 44                 | 3348          | 1488      | 238037       |
| Bahamas, The                           | 15607               | 7                  | 16854         | 1247      | 199554       |
| Saint Lucia                            | 3373                | 27                 | 4614          | 1241      | 198596       |
| Benin                                  | 2155                | 36                 | 3354          | 1199      | 191770       |
| Congo, Rep. of the (Brazzaville)       | 1707                | 41                 | 2882          | 1175      | 187998       |
| Bhutan                                 | 962                 | 55                 | 2117          | 1155      | 184738       |
| Azerbaijan                             | 7507                | 13                 | 8622          | 1115      | 178368       |
| Tanzania                               | 8061                | 12                 | 9162          | 1101      | 176210       |
| Belgium                                | 7024                | 13                 | 8060          | 1036      | 165707       |
| Grenada                                | 2110                | 32                 | 3103          | 993       | 158871       |
| Barbados                               | 9408                | 10                 | 10400         | 992       | 158748       |
| Croatia                                | 16373               | 5                  | 17288         | 915       | 146321       |
| Zambia                                 | 3394                | 21                 | 4295          | 901       | 144178       |
| Tonga                                  | 2277                | 28                 | 3166          | 889       | 142313       |
| Fiji                                   | 4742                | 15                 | 5574          | 832       | 133052       |
| Paraguay                               | 12145               | 6                  | 12941         | 796       | 127338       |
| Uruguay                                | 28021               | 3                  | 28799         | 778       | 124410       |
| Saint Vincent and the Grenadines       | 2080                | 27                 | 2855          | 775       | 124029       |
| Palau                                  | 31                  | 96                 | 775           | 744       | 119040       |
| Saint Kitts and Nevis                  | 2005                | 27                 | 2732          | 727       | 116257       |
| Niger                                  | 1599                | 31                 | 2321          | 722       | 115481       |
| Finland                                | 5327                | 12                 | 6044          | 717       | 114687       |
| Slovakia                               | 5632                | 11                 | 6338          | 706       | 112970       |
| Chad                                   | 1352                | 34                 | 2044          | 692       | 110793       |
| Djibouti                               | 609                 | 52                 | 1269          | 660       | 105560       |
| Dominica                               | 1275                | 33                 | 1912          | 637       | 101985       |
| Somalia                                | 331                 | 65                 | 935           | 604       | 96645        |
| Austria                                | 7356                | 7                  | 7944          | 588       | 94055        |
| Antigua and Barbuda                    | 2234                | 20                 | 2798          | 564       | 90311        |
| Switzerland                            | 11282               | 5                  | 11828         | 546       | 87436        |
| Turkmenistan                           | 1570                | 25                 | 2105          | 535       | 85574        |
| Portugal                               | 5704                | 8                  | 6228          | 524       | 83801        |
| Czech Republic                         | 7732                | 6                  | 8255          | 523       | 83602        |
| Suriname                               | 6121                | 8                  | 6637          | 516       | 82622        |
| Latvia                                 | 2275                | 18                 | 2788          | 513       | 82078        |
| Samoa                                  | 1180                | 30                 | 1685          | 505       | 80876        |
| South Sudan                            | 603                 | 42                 | 1036          | 433       | 69208        |
| Gabon                                  | 1946                | 16                 | 2310          | 364       | 58163        |
| Macau S.A.R.                           | 3464                | 9                  | 3819          | 355       | 56829        |
| Guinea-Bissau                          | 176                 | 65                 | 505           | 329       | 52713        |
| Botswana                               | 1502                | 17                 | 1802          | 300       | 48076        |
| Qatar                                  | 9366                | 3                  | 9653          | 287       | 45870        |
| Equatorial Guinea                      | 1096                | 19                 | 1358          | 262       | 41939        |
| Estonia                                | 1514                | 14                 | 1751          | 237       | 37903        |
| Madagascar                             | 1910                | 11                 | 2146          | 236       | 37809        |
| Mauritius                              | 3685                | 6                  | 3908          | 223       | 35705        |
| Malawi                                 | 1737                | 10                 | 1935          | 198       | 31671        |
| Bahrain                                | 4921                | 4                  | 5116          | 195       | 31187        |
| Iceland                                | 2048                | 8                  | 2229          | 181       | 28920        |
| Comoros                                | 144                 | 54                 | 316           | 172       | 27531        |
| Slovenia                               | 1430                | 11                 | 1599          | 169       | 27014        |
| Cyprus                                 | 4481                | 4                  | 4645          | 164       | 26235        |
| Central African Republic               | 285                 | 32                 | 422           | 137       | 21886        |
| Oman                                   | 6122                | 2                  | 6247          | 125       | 19990        |
| Namibia                                | 1400                | 7                  | 1512          | 112       | 17979        |
| Kiribati                               | 557                 | 16                 | 663           | 106       | 17038        |
| Mozambique                             | 2282                | 4                  | 2378          | 96        | 15332        |
| Papua New Guinea                       | 1583                | 5                  | 1669          | 86        | 13724        |
| Korea, North                           | 89                  | 48                 | 170           | 81        | 12972        |
| Swaziland                              | 511                 | 13                 | 587           | 76        | 12163        |
| Maldives                               | 325                 | 15                 | 385           | 60        | 9531         |
| Lesotho                                | 318                 | 14                 | 370           | 52        | 8248         |
| Micronesia, Federated States of        | 5                   | 86                 | 35            | 30        | 4798         |
| Malta                                  | 311                 | 8                  | 338           | 27        | 4251         |
| Brunei                                 | 335                 | 7                  | 360           | 25        | 3923         |
| Timor-Leste                            | 165                 | 13                 | 189           | 24        | 3834         |
| Luxembourg                             | 378                 | 6                  | 402           | 24        | 3778         |
| Marshall Islands                       | 57                  | 27                 | 78            | 21        | 3317         |
| Tuvalu                                 | 77                  | 21                 | 98            | 21        | 3285         |
| Seychelles                             | 236                 | 7                  | 254           | 18        | 2956         |
| Vanuatu                                | 145                 | 11                 | 162           | 17        | 2730         |
| Vatican City                           | 44                  | 25                 | 59            | 15        | 2347         |
| Solomon Islands                        | 167                 | 7                  | 180           | 13        | 2092         |
| Monaco                                 | 45                  | 12                 | 51            | 6         | 1029         |
| Sao Tome and Principe                  | 90                  | 6                  | 95            | 5         | 872          |
| Nauru                                  | 40                  | 5                  | 42            | 2         | 355          |
| Andorra                                | 27                  | 0                  | 27            | 0         | 0            |
| Liechtenstein                          | 55                  | 0                  | 55            | 0         | 0            |
| San Marino                             | 25                  | 0                  | 25            | 0         | 0            |
```

The query below shows the total revenue for refusal fees from 2006 to 2016, as well as the number of visas issued, total applications, refusals, and refusal percentages.

```sql
SELECT date_format(t1.time, 'yyyy') AS "Year", sum(t1.value)/power(10, 6) AS "Visas, Mln",
  sum(t1.value/(100-t2.value)*100)/power(10, 6) AS "Applications, Mln",
  sum(t1.value/(100-t2.value)*t2.value)/power(10, 6) AS "Refusals, Mln",
  sum(t1.value/(100-t2.value)*t2.value)/sum(t1.value/(100-t2.value)*100)*100 AS "Refusals, %",
  sum(t1.value/(100-t2.value)*t2.value)*160/power(10, 6) AS "Refusal Fees, $ Mln"
  FROM "state.non-immigrant-visa" t1
JOIN "state.visa-refusal-rate" t2
WHERE t1.tags.country NOT LIKE '%Total%' AND t1.tags.visa_type = 'Grand Total' and t2.value < 100
group by t1.datetime
```

```ls
| Year  | Visas, Mln  | Applications, Mln  | Refusals, Mln  | Refusals, %  | Refusal Fees, $ Mln |
|-------|-------------|--------------------|----------------|--------------|---------------------|
| 2006  | 5.8         | 7.3                | 1.5            | 20.8         | 241.9               |
| 2007  | 6.4         | 8.4                | 2.0            | 23.9         | 322.5               |
| 2008  | 6.6         | 8.2                | 1.6            | 20.0         | 262.4               |
| 2009  | 5.8         | 7.3                | 1.5            | 20.7         | 240.8               |
| 2010  | 6.4         | 7.9                | 1.5            | 19.0         | 240.0               |
| 2011  | 7.5         | 9.1                | 1.6            | 18.0         | 262.3               |
| 2012  | 8.9         | 10.5               | 1.5            | 14.6         | 244.8               |
| 2013  | 9.2         | 10.8               | 1.7            | 15.5         | 269.4               |
| 2014  | 9.9         | 11.9               | 2.0            | 16.5         | 313.9               |
| 2015  | 10.9        | 13.5               | 2.6            | 19.1         | 411.4               |
```

The total amount of money earned from denied visa applications is **$411.4 million**, a little less than `1/4` of the amount earned
from issued visas. These numbers are in line with the [2015 State Department Report](https://www.state.gov/documents/organization/249770.pdf), which stated that 10.9 million visas were issued at foreign posts. The total revenue earned by U.S. consular services in 2015 is [$5.8 billion](https://www.state.gov/s/d/rm/rls/perfrpt/2015/html/249727.htm), meaning that the amount earned from
refusal fees is not just pocket change.

## Action Items

* [Install ATSD](https://axibase.com/docs/atsd/installation/):

  ```sh
  docker run \
    --detach \
    --name=atsd \
    --restart=always \
    --publish 8088:8088 \
    --publish 8443:8443 \
    --publish 8081:8081 \
    --publish 8082:8082/udp \
    axibase/atsd:latest
  ```

* Log in to ATSD and configure an administrator account.
* Import the [`travel_visas.xml`](./resources/travel_visas.xml) and [`visa-refusal-rates-csv-parser.xml`](./resources/visa-refusal-rates-csv-parser.xml) datasets.
* Import the [`visas.tar.gz`](./resources/visas.tar.gz) tarball to ATSD using this [parser configuration](./resources/visa-refusal-rates-csv-parser.xml). For information about uploading parser configurations see the [Configuration Tutorial](../../tutorials/shared/import-csv-parser.md)
* Parse the [raw data](./resources/visa-refusal.csv).
* On the **Metrics** page of the ATSD web interface, the imported metrics `state.non-immigrant-visa` and `state.visa-refusal-rate` are visible.
