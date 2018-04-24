# Overview

Axibase Time Series Database is a Hadoop-based time series database with SQL, rule-engine, and visualization.

The **Use Cases** repository contains [Research Articles](#research-articles) demonstrating solutions to real-world data problems using ATSD, [How-To](#how-to) guides for programmatic integration instructions with some of the most commonly-used enterprise softwares and services, our [Chart of the Day](#chart-of-the-day) publications, a [Data Library](#data-library) with in-depth SQL guides, and [Analysis](#analysis) of complex data problems faced on the modern data science landscape.
  
## Research Articles 

ATSD functionality and features applied to real-world public data to solve common data problems and demonstrate use cases with meaningful information. See older articles in the [Archive](#archive).

1. [Let's Encrypt SSL Certificates for Java Developers](workshop/lets-encrypt.md)
1. [U.S. Approaching 3-Year Mark for Full Employment](Chart_of_the_Day/unemployment/README.md)
1. [Tax Day 2018: Americans Reverse the Late-Filing Trend](IRSTaxFilings_2018/README.md)
1. [Analyzing Econometric Datasets with Calculated Series](Solutions/calculated-values/README.md)
1. [Slow Growth is Becoming a Human Trend Too](Chart_of_the_Day/life-expectancy/README.md)
1. [Aging America: Modeling Birth Trends in the United States](aging-america/README.md)
1. [The Slow Death of the American Auto Industry](Automobiles/README.md)
1. [The Port of Los Angeles: Sustainable Progress for the Future of the City](LA_Port/README.md)
1. [Debt Profile of the Average American](FED_FORDSR/README.md)
1. [U.S. Expatriation Statistics (Quarter 2 Update)](Expatriation_Q2/README.md)

## How-To

Walkthrough guides for ATSD integration with various IT infrastructure systems and services.

### Amazon Web Services
- [Build Availability Report for AWS Route53](how-to/aws/route53-health-checks)
- [Configure Launch Notifications for AWS Resources](how-to/aws/cloud-watch-alert)
- [Route53 Health Status Alarms](how-to/aws/route53-email-notifications)

### Apache Kafka
- [Monitoring Kafka Brokers](how-to/kafka/brokers-monitoring)
- [Monitoring Kafka Consumer Lag](how-to/kafka/consumers-monitoring)

### GitHub
- [Notifications for New GitHub Issues](how-to/github/issue-notification.md)
- [Notifications for New GitHub Project Releases](how-to/github/project-release-notification.md)
- [Notifications for New GitHub Pull Requests](how-to/github/pr-notification.md)
- [Notifications for New GitHub Repository Subscriptions](how-to/github/watch-notification.md)
- [Notifications for a New GitHub Repository Push](how-to/github/push-notification.md)

### Marathon
- [How to Monitor Marathon Applications as Services](how-to/marathon/capacity-and-usage)

### ATSD
- [Historizing Metrics Stored in Database](how-to/database/historize)
- [Using TRENDS](how-to/shared/trends.md)
- [Calculated Values With Schema-Based Parsing](Support/Schema-Parser-Mod-Pre-Import/README.md)
- [Curve Smoothing Using Moving Averages](Support/Moving-Avg/README.md)
- [Creating Calculated Metrics in ChartLab and SQL Console](Support/Add-Calculated-Value/README.md)

## Chart of the Day 

Sometimes data tell their own story and ChartLab visualizations can grab reader attention to make a statement. The Chart of the Day is reproduced in a variety of publications.

1. [Using Thresholds to Track United States Inflation](Chart_of_the_Day/us-inflation)
1. [The Creeping Overnight Fund Rate](Chart_of_the_Day/overnight-fund-rate/README.md)
1. [The Fall of Facebook](Chart_of_the_Day/facebook/README.md)
1. [500 Cities: Local Data for Better Health](Chart_of_the_Day/CDC_TOP25/README.md)
1. [Credit Card Loan Delinquency at 25 Year Low](Chart_of_the_Day/Credit_Delinquency/README.md)
1. [Outstanding Students Loan Debt Continues to Exceed One Trillion Dollars](Chart_of_the_Day/Student_Loan/README.md)
1. [United States Voter Turnout Since 1970](Chart_of_the_Day/voter-turnout/README.md)
1. [International Students in America by Country of Origin](Chart_of_the_Day/International_Students/README.md)
1. [European Union Per Capita Debt by Country](Chart_of_the_Day/EU_Debt_percap/README.md)
1. [Who is Dropping Out in the State with the Fewest Dropouts?](Chart_of_the_Day/IA_Dropouts/README.md)

## Analysis

Detailed use cases that feature in-depth data exploration and complex functionality used to solve the world's modern data problems.

1. [The World Progress Scorecard: In-Depth Visualization with SQL and User-Defined Functions](Chart_of_the_Day/world-progress-scorecard/README.md)
1. [United States Federal Reserve: The Economic Policy Uncertainty Index](Analysis/Economic_Policy_Uncertainty/README.md)
1. [The New Bubble: Fed Rates Stay Low While Debt Value Remains High](Analysis/The_New_Bubble/README.md)
1. [Realtime Analysis of the Oroville Dam Disaster](OrovilleDam/README.md)
1. [The Rising Federal Funds Rate in the Current Low Long-Term Interest Rate Environment](Analysis/FedFund_FedInterest/README.md)
1. [United States Treasuries as International Assets: China's Role in the Federal Fund Rate](Analysis/Treasuries_as_Assets/README.md)
1. [CPI vs. PPI: Producers are Spending Less While Consumers are Paying More](Analysis/CPI_PPI/README.md)
1. [BitCoin After the GHash.IO Era](Analysis/BitCoin_After_GHash/README.md)
1. [Visa Travel to the United States with Charts, SQL, and Redash](USVisa/README.md)
1. [Analyzing UK Aviation Statistics using CAA Datasets](UKAviation/README.md)

## Data Library

Visualizations and SQL queries that are indexed by topic to form the Axibase Data Library, an invaluable tool for researchers looking for specific data. Data shorts display comprehensive information from a wide-range of data sets.

1. [Foreign Businesses Operating in Hong Kong (1996-2016)](DataShorts/Hong_Kong_Business/README.md)
1. [New York Insurance Asset Versus Liability Data (2014-2015)](DataShorts/NY_Insurance/README.md)
1. [European Union Net Migration (2004-2015)](DataShorts/EU_Migration/README.md)
1. [European Union Debt by Country (2005-2016)](DataShorts/EU_Debt/README.md)
1. [European Union Per Capita Debt by Country (2005-2016)](DataShorts/EU_Debt_percap/README.md)
1. [Comprehensive Housing Market Analysis: City of Austin (2014)](DataShorts/Austin_Housing_Market/README.md)
1. [Connecticut Prison Population Statistics (2009-2017)](DataShorts/CT_Prison/README.md)
1. [US Dollar Exchange Rate Analysis (2012-2017)](DataShorts/Dollar-EX/README.md)
1. [Projected Baltimore Employment Figures (2001-2040)](DataShorts/Baltimore_MD_Employment/README.md)
1. [Asset Distribution of the Public's Asset Portfolio - Bank of Israel (1998-2017)](DataShorts/CBI/Asset_Distribution/README.md)
1. [Bank of Israel Debt (1997-2016)](DataShorts/CBI/Debt/README.md)
1. [Tax Rate by State (2017)](DataShorts/Taxes_By_State/README.md)
1. [New York City Income by Adjusted Gross Income (AGI) Range (2014)](DataShorts/NY_Pay/README.md)

## Archive

Older ATSD functionality and features applied to real-world public data to solve common data problems and demonstrate use cases with meaningful information. Some features may have been updated or function differently, see our latest features and functionality used in more recent [Research Articles](#research-articles) or the [Chart of the Day](#chart-of-the-day).

1. [Calls May Be Recorded or Monitored for Training Purposes: Using Call Abandonment Rates to Establish Thresholds](SF_Phone/README.md)
1. [Does the Bag Tax Work?](Bag_Tax/README.md)
1. [The Consumer Price Index Versus Your Savings Account (Bank of Israel)](CBI_CPI/README.md)
1. [Riding the L Train in 2025](L_Train2025/README.md)
1. [How to Predict a Fire in Hartford](CT_Fire/README.md)
1. [The Cleanest Water in Washington State](Chart_of_the_Day/WA_Water/README.md)
1. [Public Utilities and Private Industry in Austin](Chart_of_the_Day/Austin_Power/README.md)
1. [What Do Seattlelites Have to Complain About?](Chart_of_the_Day/Seattle_Complaints/README.md)
1. [Food Insecurity in America (2009-2013)](Chart_of_the_Day/Food_Insecurity/README.md)
1. [Citywide LED Streetlight Savings (Los Angeles, CA)](Chart_of_the_Day/LA_Lights/README.md)
1. [New York City's Most Crowded Industries](Chart_of_the_Day/NY_Jobs/README.md)
1. [San Francisco Air Traffic Noise Complaints by the Numbers](Chart_of_the_Day/SFO_Complaints/README.md)
1. [Island Living is Recession Proof](Chart_of_the_Day/Hawaii_GDP/README.md)
1. [Modeling Falling Birthrates in the Prairie State](IllinoisBirthrates/README.md)
1. [Quantifying Public Health: The American Fitness Index](FitnessIndex/README.md)
1. [Violence Begets Violence: An Analysis of the Baltimore Police Force and Baltimore Homicide Data](BaltimorePolice/README.md)
1. [Climate Change: Back to the Drawing Board](ClimateChange/README.md)
1. [U.S. Expatriation Statistics](Expatriation/README.md)
1. [Consumer Finance Complaints](ConsumerFinance/README.md)
1. [Tax Day 2017: Are U.S. Tax Payers Procrastinating?](IRSTaxFilings/README.md)
1. [Norway Car Registrations](NorwayCars/README.md)
1. [U.S. State Department: Getting Paid $400 Million While Rejecting Visitors](USVisaRefusal/README.md)
1. [From data.gov dataset to Python DataFrame in 10 minutes](SocrataPython/README.md)
1. [Analyzing America's International Trade history](USInternationalTrade/README.md)
1. [Pain at the Pump - a Closer Look at Hawaii's High Fuel Prices](HawaiiGasPrices/hawaii_gas_prices.md)
1. [Data Visualization with Chart Lab](ChartLabIntro/README.md)
1. [Country Living - Analyzing and Combining Iowa Employment and Consumer Price Index Datasets](SocrataIowaCompensation/README.md)
1. [Knocking on Heaven's Door - Computing U.S. Mortality Statistics](USMortality/README.md)
1. [Analyzing Chicago Crime Statistics](ChicagoCrime/README.md)
