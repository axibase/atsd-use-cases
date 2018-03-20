# Tracking Application Latency Issues with ATSD and Route53

![](images/route-53-connection-times.png)

## Introduction

Amazon Web Services' Route 53 networking and content delivery tool supports worldwide endpoint health checks which may be 
monitored using ATSD and Axibase Collector to historize data for longer intervals than the two weeks which are
recorded by Route 53.

Additionally, using latency checks to monitor connectivity issues at each endpoint can provide valuable insight
for system administrators who need to diagnose whether an endpoint itself is unhealthy or the target application is not 
performing as expected and causing connection timeouts. 

Integrate your instance of ATSD with Route 53 as described [here](README.md) to enable availabilty reports before beginning this process. 

![](images/route53-1.png)

### Prerequisites

* Create an AWS [IAM account](https://github.com/axibase/axibase-collector/blob/master/jobs/aws-iam.md) to query CloudWatch 
statistics with [Route 53](https://aws.amazon.com/route53/?nc2=h_m1) enabled.
* 4 GB of available RAM for ATSD sandbox containers.
* [Integration](README.md) of ATSD and Amazon Web Services.

## Import AWS Route53 Connection Time Latency Portal Configuration

Once you have configured your instance of ATSD to work with Amazon Web Services, upload the following [portal configuration](resources/aws-route53-connection-time-latency.xml) to visualize endpoint monitoring.

From the **AWS Route53** tab in ATSD, open the **Portals** drop-down menu and select **Create**.

![](images/upload-portal.png)

## Import Entity View Configuration

Upload the following entity view [configuration](resources/entity-views.xml) to ATSD. From the **Entity Views** tab, expand the operation drop-down menu and select **Create**.

![](images/aws-entity-config.png)

Directly upload the provided xml file or copy/paste the document's contents into the text editor.
