# Data Visualization with ChartLab

![Titlephoto](./images/Titlephoto.png)

## Introduction

Are you looking for clear and concise graphical presentations for datasets?

Do you want to explore different graphical outputs **all in one place**?

Chart Lab is a versatile online tool which allows users to test drive Axibase Time Series Database (ATSD) visualization capabilities. Chart Lab doesn't require any kind of
registration and allows you to experiment with different layouts and widget settings prior to deploying it in your own ATSD instance. For front-end developers familiar with
[`jsfiddle.net`](http://jsfiddle.net/da1rosy8/), Chart Lab shares many of the same properties and characteristics.

The purpose of this article is to walk the new user through the whole process and showcase all of the different features of ChartLab.

## Chart Lab Features

A blank, customizable ChartLab portal for can be found here:

[![View in ChartLab](./images/button.png)](https://apps.axibase.com/chartlab/)

The ChartLab menu contains these items:

* Editor - Toggle configuration editor;
* Run - Apply and view a portal based on the current configuration in the Editor window;
* Save - Save the current configuration under as new version in the current directory;
* Clone - Save current configuration in a new directory;
* Widget - Append a widget template to the current desired configuration;
* Source - Switch between data sources: Random or ATSD.

Below is an image of the standard default ChartLab configuration.

![Figure 1](./images/Figure1.png)

## Source

ChartLab supports two data sources:

1. Random Data Generator;
2. Axibase Time Series Database.

![Figure 2](./images/Figure2.png)

The Random data generator is a non-existent dataset which invokes the math.random() javascript function. As defined by the [Mozilla Developer Network](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/random),
this function returns a floating-point, pseudo-random number in the range [0,1], which is inclusive from 0 up to but not including 1. This range can
be scaled to fit any desired dataset. These numbers have no meaning; every 60 seconds new random numbers are generated with the goal of merely
providing different ranges for visualization purposes. In ChartLab, it may be used to quickly design visualization or portal templates for use with real data later on.

ATSD data is actual data collected by Axibase from a variety of sources, including server equipment, network devices, and online resources. Using ChartLab, a user is able to draw upon a publicly-accessible ATSD instance operated by Axibase. Once a user installs ATSD, they will be able to visualize
their own data, updated in real time as new incoming data is processed.

## Widget

ChartLab contains each of these **Widgets**, shown in this image.

![Figure 3](./images/Figure3.png)

These visualizations can be found at here:

[https://axibase.com/products/axibase-time-series-database/visualization/widgets/](https://axibase.com/products/axibase-time-series-database/visualization/widgets/)

To add a Widget template to the Editor window, click the Widget dropdown and select a widget from the list.

![Figure 19](./images/Figure19.png)

## Run

Once a **Source** and **Widget** have been defined, click **Run** to render a visualization. This will display a portal based on the current
Editor window configuration.

## Widget Settings

We will now run through several settings for Widgets in ChartLab.

Widgets are always added to the bottom of the configuration. In the figure below, a chart Widget was initially added, followed by a histogram Widget.

![Figure 13](./images/Figure13.png)

As a default, Widgets are arranged in a single horizontal row. In order to split the Widgets up into several different row, you must add
a new `[group]` clause to the configuration. In the image below, a third pie chart Widget was added in the ChartLab configuration.

![Figure 14](./images/Figure14.png)

If we add a second group (as shown in the below image) and hit Run, the below visualization will be rendered.

![Figure 15](./images/Figure15.png)

In order to fit more Widgets in a single view, you may change the **height-units** and **width-units** settings in the Editor window. For example, if we change both
of these values from 2 to 4, this visualization will be rendered:

![Figure 16](./images/Figure16.png)

Single-line comment start with **#**. Text on the same line after a **#** will be ignored.

Multi-line comments start with `/*` and end with `*/`. Any text between `/*` and `*/` will be ignored.

The figure below shows two histogram Widgets. The histogram on the left has the right and top axis commented out.

![Figure 17](./images/Figure17.png)

By selecting Ctrl + Space in the Chart Lab portal, a drop-down menu will appear. This dropdown contains the key sections of the configuration. Press
to select one of the sections.

![Figure 20](./images/Figure20.png)

If you have a configuration that looks like the image below, there is a quick fix for this.

![Figure 21](./images/Figure21.png)

Press Ctrl + A to select all the text, then Shift + Tab to align the text.

![Figure 22](./images/Figure22.png)

## Save

After a visualization has been created, the user has the option of selecting **Save** to save the current configuration as a new revision in the current
directory. After pressing **Save**, the current configuration will be assigned a unique URL and a revision number. We will run through a quick example to
demonstrate this process.

1. Open a blank ChartLab portal.
1. Select **Random** as the Source.
1. Select **Run** to create a visualization.
1. At this point, the current visualization and configuration may be saved to the current directory by clicking **Save** or cloned to a new directly by clicking **Clone**.

After a save, our configuration has been assigned a unique URL and revision number, in this case:

**[https://apps.axibase.com/chartlab/a9977177](https://apps.axibase.com/chartlab/a9977177)** with revision number **1**.

![Figure 4](./images/Figure4.png)

It is worth noting that for a Random Source, because of the math.random() javascript function, specific, unique values will not end up being saved. The configuration
has been saved, but regardless new random values will continue to be output after every 60 seconds.

Let's continue with saving a second revision.

1. Change Source to **ATSD**.
1. Select **Save**.

After saving for a second time, this second configuration has been assigned a unique URL and revision number, in this case:

**[https://apps.axibase.com/chartlab/a9977177/2/](https://apps.axibase.com/chartlab/a9977177/2/)** and revision number **2**.

![Figure 5](./images/Figure5.png)

Since ATSD, which contains real data, was selected as the Source, the saved configuration will query the same data. Future access to this visualization will access the same information.

Let's continue with saving a third revision.

1. Change the **max-range** from 100 to 80.

![Figure 6](./images/Figure6.png)

* Select **Save**.

After saving for a third time, this third configuration has been assigned a unique URL and revision number, in this case:

**[https://apps.axibase.com/chartlab/a9977177/3/](https://apps.axibase.com/chartlab/a9977177/3/)** and revision number **3**.

![Figure 7](./images/Figure7.png)

Now the user has the options of toggling between each of the three saved revisions. These three unique URLs will be stored permanently within the ChartLab application.
The user has the option of coming back to these examples at any time.

![Figure 8](./images/Figure8.png)

## Clone

By selecting **Clone**, a user may save the current configuration in a new directory. For example, if we clone the third revision from the previous section,
a new unique URL will be generated, separate from the previous nested example.

![Figure 12](./images/Figure12.png)

In this unique case, the URL that was generated is listed below:

[https://apps.axibase.com/chartlab/3fa686a5](https://apps.axibase.com/chartlab/3fa686a5)

All the features of the cloned output are the same as the original, with the noteworthy point being that an entirely new directory was created as a result. This is a useful feature for final edition publishing, where earlier versions of the final visualization should not be accessed by end users.

## Editor

By selecting **Editor**, a user may display their configuration in fullscreen. By appending #fullscreen at the end of the Chart Lab URL
you can open the configuration in full-screen mode directly from a link. To revert back to the standard view, click the **Editor** button once more.

![Figure 9](./images/Figure9.png)

## Miscellaneous Features

In the upper right hand corner of the portal are three additional features that may be used to edit your visualization.

![Figure 10](./images/Figure10.png)

By clicking **Theme**, a black background will appear behind your visualization. Click **Theme** once more to remove the background.

![Figure 11](./images/Figure11.png)

By clicking **Full Screen**, a user may display their visualization in fullscreen. Fullscreen hides the Editor window with ChartLab features. To return to the standard Chart Lab view, press **Esc**.

Clicking the information icon takes you to **[Portal Settings](https://axibase.com/products/axibase-time-series-database/visualization/widgets/portal-settings/)** documentation.
This tab contains configuration settings and examples.

## Action Items

If this guide has been interesting to you, create an example and send it over to us. If you have any comments, questions, or concerns please do not hesitate
to [contact us](https://axibase.com/feedback/)!