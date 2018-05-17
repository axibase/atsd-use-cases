# Computing Delta Values for Multiple Series

## Overview

[ATSD](https://axibase.com/products/axibase-time-series-database/) has a number of data transformation, tracking, and visualization tools. Each of these tools may perform a number of similar computations, but each has their own idiosyncracies when doing so.

Consider two concurrently tracked series, although having unique **Metric** labels and even potentially unique **Entity** labels as well, the `datetime` ISO timestamps for each of the two series is identical. Further suppose change per sample was the relevant metric and not the absolute value of the metric itself. Delta value is an important quantification for the computation of physical phenomena such as elastic potential energy, the overall charge in an electric field, and the downward acceleration experienced due to gravity. Likewise, intangible phenomena such as computational expenditures caused by increased workload, frequency and amount of page renders performed by a server, or remaining disk space during installation or updating tasks all rely on comparative analysis more frequently than absolute value alone.

## Purpose

