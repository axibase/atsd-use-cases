# Introduction

[Axibase Time Series Database](https://axibase.com/docs/atsd/)  is a non-relational database optimized for collecting, storing, and analyzing temporal data from IT infrastructure, industrial equipment, smart meters, and IoT devices.

ATSD is developed by [Axibase Corporation](https://axibase.com/about-us/), established in 2004, based on our decade-long experience with IT infrastructure management systems. We sought to build a specialized database with a focus on data quality where historical data was treated like a first-class citizen. More specifically, ATSD was designed to overcome challenges with write-heavy warehouse systems such as Tivoli DW, which suffered from all kinds of data collection issues.

**Use Cases** documentation contains [Research Articles](#research-articles) demonstrating solutions to real-world data problems using ATSD, [How-To](#how-to) guides for programmatic integration instructions with some of the most commonly-used enterprise softwares and services, our [Chart of the Day](#chart-of-the-day) publications, a [Data Library](#data-library) with in-depth SQL guides, and [Analysis](#analysis) of complex data problems faced on the modern data science landscape.

## Analysis

Detailed use cases that feature in-depth data exploration and complex functionality used to solve modern data problems.

* [SQL Queries and Data Visualization with Python and ATSD](research/python-budget/README.md) (May 2018)
* [The World Progress Explorer: In-Depth Visualization with SQL and User-Defined Functions](chart-of-the-day/world-progress-explorer/README.md) (April 2018)

View the complete [Research Repository](research/README.md).

## Chart of the Day

Short publications tracking interesting datasets from a variety of sources. The Chart of the Day uses [ChartLab](how-to/shared/chartlab.md) or [Trends](how-to/shared/trends.md) services, which are visualization tools supported by data processing and management tasks performed by [ATSD](https://axibase.com/docs/atsd/).

* [Hetzner May 2018 Outage](chart-of-the-day/hetzner-outage/README.md) (May 2018)
* [Going from Advanced Tech Exporter to Importer](chart-of-the-day/tech-import-export/README.md) (May 2018)

View more [Charts](chart-of-the-day/README.md).

## How-To

Walkthrough guides for ATSD integration with various IT infrastructure systems and services.

### Amazon Web Services

* [Configure Launch Notifications for AWS Resources](how-to/aws/cloud-watch-alert/README.md) (March 2018)
* [Route53 Health Status Alarms](how-to/aws/route53-email-notifications/README.md) (March 2018)

### Apache Kafka

* [Monitoring Kafka Brokers](how-to/kafka/brokers-monitoring/README.md) (April 2018)
* [Monitoring Kafka Consumer Lag](how-to/kafka/consumers-monitoring/README.md) (April 2018)

### ATSD

* [Historizing Metrics Stored in Database](how-to/database/historize/README.md) (April 2018)
* [Using Trends](how-to/shared/trends.md) (April 2018)

### Docker

* [Notifications for Docker Hub Build Failures](how-to/docker/README.md) (April 2018)
* [ATSD + Docker for Anomaly Detection](how-to/docker/docker-engine.md) (September 2017)

### GitHub

* [Daily Pull Request Report for GitHub Organizations](how-to/github/pr-report.md) (June 2018)
* [Notifications for New GitHub Repository Subscriptions](how-to/github/watch-notification.md) (April 2018)

### Marathon

* [How to Monitor Marathon Applications as Services](how-to/marathon/capacity-and-usage/README.md) (March 2018)

### Socrata

* [From data.gov Dataset to Python DataFrame in 10 minutes](how-to/socrata/python/README.md) (February 2017)
* [Analyzing Socrata Datasets for Iowa Compensation](how-to/socrata/iowa-compensation/README.md) (October 2016)

View more [Examples](how-to/README.md)

## Research Articles

ATSD functionality and features applied to real-world public data to solve common data problems and demonstrate use cases with meaningful information.

* [Technical Writing for Software Developers](research/workshop/technical-writing.md) (May 2018)
* [Tracking Expatriation with ChartLab, SQL, and Web Crawler in ATSD](research/expatriation/README.md) (May 2018)

View the complete [Research Repository](research/README.md).