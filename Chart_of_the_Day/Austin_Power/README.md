Public Utilities and Private Industry in Austin
===

**Figure 1.1**

![](Images/AP-001.png)

[![View in ChartLab](Images/button.png)](https://apps.axibase.com/chartlab/efc684ff/2/#fullscreen)

Austin, Texas is the Lone Star State's capital city and one of the fastest growing cities in America. Home to the University
of Texas at Austin, which produces thousands of well-qualified computer science graduates each year and funnels new talent into
the city's largest employers. Dubbed "the Silicon Hills" for the high concentration of post-dot-com-boom and other newer
high-tech companies that populate the city, Austin is seen as an all-around business friendly city.

One of the tenets of good business is healthy competition but currently, Austin residents only have one choice for an electricity
provider: [Austin Energy](https://austinenergy.com/wps/portal/ae/home/!ut/p/a1/jY_NCsIwEISfxUOOmk2rUr3F-tOqWPBQay6SSqyVmoQ0VXx7o-BFFF3YwzLfzuxihjPMJL-UBbelkrx6zKy_I1GvS0ZA5sGUDIBGq266DmN_RogDtg6AL0Xh1_4GsycCXuBFIXhxMknGEKdJSpNFCLPQfwHfI-Z_HEll7gcFZkYchBGm0xj33NFaXQ8RIOBNbUsppDDFrbNXZwRXXSPQylheOVm4zlVjEThRc3lra6MOZSU-eR9VbXH2bon1OYNTr7osaat1B4vV0aY!/dl5/d5/L2dBISEvZ0FBIS9nQSEh/).
The company, formed in 1895, has almost half a million client accounts and through its public infrastructure, gives lighting 
to more than a million residents.

**Figure 1.1** above highlights one of the main reasons that "Public Utility" has become a dirty word in certain
circles. Opponents of city-managed utilities claim government mismanagement leads to increased prices that would be positively
affected by introducing competitors whereas proponents of regulation say just the opposite, electricity is more than a business
it is a modern necessity, and government regulation ensures access for everyone. Using a structured query language in the 
[SQL Console](https://github.com/axibase/atsd/blob/master/sql/README.md) in [Axibase Time Series Database](https://axibase.com/products/axibase-time-series-database/), the numerical information associated with the above visualization is shown:

**Script 1.1**

```sql
SELECT tags.customer_class AS "Customer Class", AVG(value) AS "Avg KWH (Cents)"
  FROM "rate_cents_per_kwh" WHERE tags.customer_class != 'Total'
GROUP BY tags.customer_class
  ORDER BY AVG(value) DESC
```

**Table 1.1**

```ls
| Customer Class            | Avg KWH (Cents) | 
|---------------------------|-----------------| 
| Residential               | 10.11           | 
| Commercial                | 9.45            | 
| Lighting (Public & Other) | 7.83            | 
| Industrial                | 6.29            | 
```

> Over the observed time period, residential customers paid an average $0.04 more per kilowatt hour (KWH) than industrial
clients.

While four cents an hour certainly doesn't seem like much, **Figure 1.2** below shows the amount of revenue generated from each class of customer. Typically, business and industry 
pays the lion's share of utility costs because of the nature of their usage: large-scale power grids and 24/7 operation, but
in Austin, the exact opposite is true. In fact, the industrial class paid an average 35% of the residential class over the
observed period, which is detailed in **Table 1.2** below the visualization.

**Figure 1.2**

![](Images/AP-002.png)

[![View in ChartLab](Images/button.png)](https://apps.axibase.com/chartlab/efc684ff/3/#fullscreen)

**Script 1.2**

```sql
SELECT tags.customer_class AS "Customer Class", AVG(value)/1000000 AS "Revenue (Million USD)"
  FROM "revenue" WHERE tags.customer_class != 'Total'
GROUP BY tags.customer_class
  ORDER BY AVG(value) DESC
```

**Table 1.2**

```ls
| Customer Class            | Revenue (Million USD) | 
|---------------------------|-----------------------| 
| Commercial                | 430.45                | 
| Residential               | 429.32                | 
| Industrial                | 151.99                | 
| Lighting (Public & Other) | 83.19                 | 
```

This dramatic difference may be explainable by looking at electricity usage numbers, in **Figure 1.3** below, where residential
customers significantly out-use the industrial sector by almost double. 

**Figure 1.3**

![](Images/AP-003.png)

[![View in ChartLab](Images/button.png)](https://apps.axibase.com/chartlab/efc684ff/4/#fullscreen)

**Script 1.3**

```sql
SELECT tags.customer_class AS "Customer Class", AVG(value)/1000000 AS "Usage (Million MWh)"
  FROM "megawatt_hour" WHERE tags.customer_class != 'Total'
GROUP BY tags.customer_class
  ORDER BY AVG(value) DESC
```

**Table 1.3**

```ls
| Customer Class            | Usage (Million MWh) | 
|---------------------------|---------------------| 
| Commercial                | 4.55                | 
| Residential               | 4.24                | 
| Industrial                | 2.40                | 
| Lighting (Public & Other) | 1.06                | 
```

Whether you are a proponent, opponent, or some compromise of the two, with respect to government regulation of public utilities,
understanding the data surrounding the issue is the most critical step to having an informed opinion and thanks to [City of Austin](https://data.austintexas.gov/)
efforts to publish data for the public to inspect, that possibility is becoming a reality for more and more people every day.
