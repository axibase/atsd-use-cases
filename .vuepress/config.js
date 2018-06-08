const githubSettings = {
    docsRepo: 'axibase/atsd-use-cases',
    editLinks: true,
    editLinkText: 'Help us improve this page!'
}

const topNavMenu = [
    { text: 'Research', link: '/research/' },
    { text: 'Chart of the Day', link: '/chart-of-the-day/' },
    { text: 'Examples', link: '/how-to/' }
]

const landingPageMenu = [
    '',
];

const chartofthedayMenu = [
    ['austin-power/', "Public Utilities and Private Industry in Austin"],
    ['cdc-top25/', "Center for Disease Control Top 25 Cities"],
    ['credit-delinquency/', 'Credit Card Loan Delinquency at 25 Year Low'],
    ['eu-debt-per-capita/', "European Union Debt by Country Per Capita (2005-2016)"],
    ['facebook/', "The Fall of Facebook"],
    ['hawaii-gdp/', "Island Living is Recession Proof"],
    ['hetzner-outage/', "Hetzner Outage May 2018"],
    ['international-students/', "United States International Students"],
    ['iowa-dropouts/', "Dropping Out in Iowa"],
    ['la-lights/', "Streetlight Savings in Los Angeles"],
    ['libor/', "The London Interbank Offer Rate"],
    ['ny-employment/', "The Most Crowded Industries in New York City"],
    ['overnight-fund-rate/', "The Creeping Overnight Fund Rate"],
    ['profit-margin/', "Profit Margin by Industry"],
    ['seattle-complaint/', "Complaints in the Emerald City"],
    ['sfo-noise/', "Air Traffic Noise Complaints in San Francisco"],
    ['student-loan-debt/', "Student Loan Debt Exceeding One Trillion Dollars"],
    ['tech-import-export/', "Going From Advanced Tech Importer to Exporter"],
    ['unemployment/', "United States Approaching Three Years of Full Employment"],
    ['us-food-insecurity/', "Food Insecurity in America (2009-2013)"],
    ['us-inflation/', "Using Thresholds to Track United States Inflation"],
    ['voter-turnout/', "United States Voter Turnout"],
    ['wa-wqi/', "The Cleanest Water in Washington State"],
    ['world-progress-explorer/', "The World Progress Explorer"],
];

const researchMenu = [
    ['aging-america/', "Aging America: Modeling Birth Trends in the United States"],
    ['analysis/bitcoin-after-ghash/', "Bitcoin After the GHash Era"],
    ['analysis/cpi-ppi/', "Producers are Spending Less but Consumers are Paying More"],
    ['analysis/economic-policy-uncertainty/', "The Economic Policy Uncertainty Index"],
    ['analysis/fed-fund-interest/', "The Rising Federal Fund Rate"],
    ['analysis/the-new-bubble/', "The New Bubble"],
    ['analysis/treasuries-as-assets/', "China's Role in the Federal Fund Rate"],
    ['average-american-debt-profile/', "The Average American Debt Profile"],
    ['bag-tax/', "The Effectiveness of the Bag Tax"],
    ['baltimore-pd/', "Violence Begets Violence"],
    ['cbisrael-cpi/', "The Consumer Price Index Versus Your Savings Account"],
    ['chicago-crime-stats/', "Analyzing Chicago Crime Statistics"],
    ['chicago-l-train/', "Riding the L Train in 2025"],
    ['consumer-finance/', "Consumer Finance Protection"],
    ['data-lib/austin-real-estate/', "Comprehensive Housing Market Analysis: City of Austin"],
    ['data-lib/baltimore-employment-projections/', "Projected Baltimore Employment Figure (2001-2040)"],
    ['data-lib/central-bank-israel/asset-distro/', "Distribution of the Public Asset Portfolio"],
    ['data-lib/central-bank-israel/debt/', "Bank of Israel Debt"],
    ['data-lib/connecticut-prison-pop/', "Connecticut Prison Population"],
    ['data-lib/dollar-forex/', "United States Dollar International Exchange Rate"],
    ['data-lib/eu-debt/', "European Union Debt by Country"],
    ['data-lib/eu-debt-per-capita/', "European Union Debt by Country per Capita"],
    ['data-lib/eu-migration/', "European Union Net Migration"],
    ['data-lib/hong-kong-foreign-investment/', "Foreign Businesses Operating in Hong Kong"],
    ['data-lib/maryland-mort-stats/', "Maryland Mortality Statistics"],
    ['data-lib/ny-income/', "New York City Income Adjusted by Gross Income"],
    ['data-lib/ny-insurance-profits/', "New York Insurance Assets and Liabilities"],
    ['data-lib/taxes-by-state/', "Tax Rates by State"],
    ['expatriation/', "Axibase Expatriation Report"],
    ['fitness-index/', "Quantifying Public Health: The American Fitness Index"],
    ['hartford-fire/', "How to Predict a Fire in Hartford"],
    ['hawaii-prices/', "Pain at the Pump: A Closer Look at Hawaii Gas Prices"],
    ['illinois-birthrates/', "Modeling Falling Birthrates in the Prairie State"],
    ['irs-tax-filings/', "Axibase Tax Filings Report"],
    ['la-port/', "The Port of Los Angeles: Sustainable Progress for the Future of the City"],
    ['norway-cars/', "Norway: Electric Vehicles Close the Gap with Diesel in 2016"],
    ['nuclear-proliferation/', "The New Face of Nuclear Proliferation"],
    ['oroville-dam/', "Realtime Analysis of the Oroville Dam Disaster"],
    ['paris-accords/', "Climate Change: Back to the Drawing Board"],
    ['python-budget/', "Wrangling Federal Reserve Economic Data with SQL and Declarative Graphics"],
    ['sf-call-center/', "Calls May be Monitored or Recorded for Quality Purposes"],
    ['uk-aviation/', "Analyzing UK Aviation Statistics using CAA Datasets"],
    ['us-auto/', "The Slow Death of the American Auto Industry"],
    ['us-international-trade/', "Analyzing American International Trade History"],
    ['us-mortality/', "Computing U.S. Mortality Statistics with a Structured Query Language"],
    ['us-visa/', "Visa Travel to America"],
    ['us-visa-refusal/', "U.S. State Department: Getting Paid $400 Million While Rejecting Visitors"],
];

const examplesMenu = [
    ['activemq/', "ActiveMQ"],
    ['aws/cloud-watch-alert/', "Launch Notifications for AWS Resources"],
    ['aws/route53-email-notifications/', 'Route53 Health Status Alarms'],
    ['aws/route53-health-checks/', "Availability Report for AWS Route 53"],
    ['database/add-calculated-value/', "Managing Calculated Values in SQL Console and ChartLab"],
    ['database/calculated-values/', "Analyzing Econometric Datasets with Calculated Series"],
    ['database/historize/', "Historizing Metrics Stored in Database"],
    ['database/moving-avg/', "Curve Smoothing Using Moving Averages"],
    ['database/schema-based-parser-mod/', "Calculated Values with Schema-Based Parsing"],
    ['docker/', "Notifications When a Docker Hub Build Fails"],
    ['github/', "GitHub Integration Tools"],
    ['itm/', "IBM Tivoli Monitoring"],
    ['kafka/', "Kafka"],
    ['marathon/capacity-and-usage/', "Monitor Marathon Applications as Services"],
    ['shared/', "General Guides"],
    ['zookeeper/', "Zookeeper"],
];

module.exports = {
    base: '/docs/atsd-use-cases/',
    title: 'ATSD Use Cases',
    description: "Use Cases and Walkthrough Guides for Axibase® Time Series Database",
    head: [
        ['link', { rel: 'shortcut icon', href: '/favicon.ico' }]
    ],
    staticFilesExtensionsTest: /(?:tcollector|\.(?:pdf|xlsx?|xml|txt|csv|str|java|json|sql|sps|yxmd|htm|prpt|do|tdc|jsonld|ktr|service))$/,
    themeConfig: {
        nav: topNavMenu,
        logo: '/images/axibase_logo_site.png',

        sidebarDepth: 1,
        sidebar: {
            '/chart-of-the-day/': chartofthedayMenu,
            '/research/': researchMenu,
            '/how-to/': examplesMenu,
            // Keep it last
            '/': landingPageMenu,
            '': [],
        },        

        searchMaxSuggestions: 10,

        ...githubSettings
    }
}

loadFromEnv("ga", "GA_API_KEY");
loadFromEnv("sc", "STATCOUNTER_ID");
loadFromEnv("scSec", "STATCOUNTER_SEC");

function loadFromEnv(setting, varName) {
    if (!(setting in module.exports)) {
        let value = require('process').env[varName];
        if (value) {
            module.exports[setting] = value;
        }
    }
}
