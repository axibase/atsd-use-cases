# Creating Local Instances for ATSD and Axibase Collector using Docker

Below is a step-by-step guide for setting up local instances of the Axibase Time Series Database and Axibase Collector on a Docker host.

1. Install [Docker](https://docs.docker.com/engine/installation/linux/ubuntulinux/).

2. Download the `docker-compose.yml` file to launch the ATSD/Collector container bundle.

   ```sh
   curl -o docker-compose.yml https://raw.githubusercontent.com/axibase/atsd-use-cases/master/research/us-mortality/resources/docker-compose.yml
   ```

3. Launch containers by specifying the built-in collector account credentials used by Axibase Collector to insert data into ATSD.

   ```sh
   export C_USER=myuser; export C_PASSWORD=mypassword; docker-compose pull && docker-compose up -d
   ```

4. Access the ATSD user interface by navigating to `https://localhost:8443`. Note that it may take several minutes for the containers to launch and for ATSD to become
   available. Create a username and password.

   ![](./images/Figure11.png)

5. After completing Step 4, you are redirected to the page shown below. Log in to ATSD with the username and password you just created.

    ![](./images/Figure12.png)

6. Now, navigate to the **Entities** tab in ATSD. The job creates a new entity in ATSD, with the name `mr8w-325u`. Note that it may take a minute or two for the label **Deaths
   in 122 U.S. cities - 1962-2016. 122 Cities Mortality Reporting System** to show up in ATSD.

   ![Figure 19](./images/Figure19.png)

7. Click **Configuration -> Replacement Tables**.

   ![Figure 20](./images/Figure20.png)

8. Copy and paste the files included in this repository ([`city-size`](./resources/city-size.txt), [`us-regions`](./resources/us-regions.txt),
   [`new-york-city-2010-population`](./resources/new-york-city-2010-population.txt), and [`youngstown-2010-population`](./resources/youngstown-2010-population.txt))
   into the Replacement Table. Click **Save**. `city-size` contains 2015 population figures for each of the 122 cities included in this dataset. `us-regions` is a list of all of the regions
   (i.e. 1=New-England, 2=Middle-Atlantic etc.). `new-york-city-2010-population` and `youngstown-2010-population` are used to compute mortality statistics.

   ![Figure 21](./images/Figure21.png)

9. Navigate to **Configuration -> Parsers:CSV** and import the [`parser.xml`](./resources/parser.xml) file.

   ![Figure 22](./images/Figure22.png)

   ![Figure 23](./images/Figure23.png)

   ![Figure 24](./images/Figure24.png)

10. After uploading the parser proceed to importing the [`us.population.csv`](./resources/us.population.csv) file.

    This file contains population estimates from [census.gov](http://www.census.gov/data.html) for all 122 cities for 1960, 1970, 1980, 1990, 2000, 2010,
    and 2015. **Save** a local copy of this file. Open the **Parsers:CSV** drop-down list, click **Upload** and select the `us.population.csv` file.

    ![Figure 25](./images/Figure25.png)

    ![Figure 26](./images/Figure26.png)

    Click **To submitted tasks** button.

    ![Figure 27](./images/Figure27.png)

   If the upload is successful, ATSD notifies:

   ![Figure 28](./images/Figure28.png)

Next, navigate to **Metrics** and enter in `us.population` into the **Name Mask** bar.

   ![Figure 29](./images/Figure29.png)

   Select **Series**.

   ![Figure 30](./images/Figure30.png)

   ![Figure 31](./images/Figure31.png)

Begin to query the dataset.