Creating Local Instances for ATSD and Axibase Collector using Docker
=========================================================================

Below is a step-by-step guide for setting up local instances of the Axibase Time Series Database and Axibase Collector on a Docker host.

1. Install [Docker](https://docs.docker.com/engine/installation/linux/ubuntulinux/).

2. Download the `docker-compose.yml` file to launch the ATSD/Collector container bundle.

   ```sh
   curl -o docker-compose.yml https://raw.githubusercontent.com/axibase/atsd-use-cases/master/USMortality/resources/docker-compose.yml
   ```

3. Launch containers by specifying the built-in collector account credentials that will be used by Axibase Collector to insert data into ATSD.

   ```sh
   export C_USER=myuser; export C_PASSWORD=mypassword; docker-compose pull && docker-compose up -d
   ```

4. Access the ATSD user interface by navigating to `https://localhost:8443`. Note that it may take several minutes for the containers to launch and for ATSD to become
   available. Create a username and password.

   <img src="Images/Figure11.png" width="500" >

5. After completing Step 4, you will be redirected to the page shown below. Log in to ATSD with the username and password you just created.

    <img src="Images/Figure12.png" width="500" >

6. Now, navigate to the **Entities** tab in ATSD. We can see that the job has created a new entity in ATSD, with the name `mr8w-325u`. Note that it may take a minute or two for the label **Deaths
   in 122 U.S. cities - 1962-2016. 122 Cities Mortality Reporting System** to show up in ATSD.

   ![Figure 19](Images/Figure19.png)

7. Click on **Configuration -> Replacement Tables**.

   ![Figure 20](Images/Figure20.png)

8. Copy and paste the files included in this repository ([`city-size`](resources/city-size), [`us-regions`](resources/us-regions),
   [`new-york-city-2010-population`](resources/new-york-city-2010-population), and [`youngstown-2010-population`](resources/youngstown-2010-population))
   into the Replacement Table. Click **Save**. `city-size` contains 2015 population figures for each of the 122 cities included in this dataset. `us-regions` is a list of all of the regions
   (i.e. 1=New-England, 2=Middle-Atlantic etc.). `new-york-city-2010-population` and `youngstown-2010-population` will be used to compute mortality statistics.

   ![Figure 21](Images/Figure21.png)

9. Navigate to **Configuration -> Parsers:CSV** and import the [`parser.xml`](resources/parser.xml) file.

   ![Figure 22](Images/Figure22.png)

   ![Figure 23](Images/Figure23.png)

   ![Figure 24](Images/Figure24.png)

10. After the parser has been added, we will proceed to uploading our [`us.population.csv`](resources/us.population.csv) file.
    This file contains population estimates from [census.gov](http://www.census.gov/data.html) for all 122 cities for 1960, 1970, 1980, 1990, 2000, 2010,
    and 2015. **Save** a local copy of this file. Click on the **Parsers:CSV** dropdown, and then on the **Upload** button and select our `us.population.csv` file.

   ![Figure 25](Images/Figure25.png)

   ![Figure 26](Images/Figure26.png)

   Click on the **To submitted tasks** button.

   ![Figure 27](Images/Figure27.png)

   If the upload was success, you should see something like the below image.

   ![Figure 28](Images/Figure28.png)

11. Next, navigate to **Metrics** and enter in `us.population` into the **Name Mask** bar.

   ![Figure 29](Images/Figure29.png)

   Select **Series**. If the data was parsed successfully, you should see something like the second image.

   ![Figure 30](Images/Figure30.png)

   ![Figure 31](Images/Figure31.png)

We are now ready to begin querying our dataset.
