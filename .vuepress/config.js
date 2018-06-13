const githubSettings = {
    docsRepo: 'axibase/atsd-use-cases',
    editLinks: true,
    editLinkText: 'Help us improve this page!'
}

const topNavMenu = [
    { text: 'Research', link: '/research/' },
    { text: 'Chart of the Day', link: '/chart-of-the-day/' },
    { text: 'Integration', link: '/how-to/' },
    { text: 'Tutorials', link: '/how-to/database/' },
]

const landingPageMenu = [
    '',
];

const chartofthedayMenu = [
    {
        title: "Chart of the Day", children: [
            ['2018.md', '2018'],
            ['2017.md', '2017'],
        ]
    },
];

const researchMenu = [
    {
        title: "Research", children: [
            ['2018.md', '2018'],
            ['2017.md', '2017'],
            ['2016.md', '2016'],
        ]
    },
];

const integrationMenu = [
    {
        title: "Integration", children: [
            ['activemq/', 'ActiveMQ'],
            ['aws/', 'AWS'],
            ['docker/', 'Docker'],
            ['github/', 'GitHub'],
            ['itm/', 'IBM Tivoli Monitoring'],
            ['kafka/', 'Kafka'],
            ['marathon/capacity-and-usage/', 'Marathon'],
            ['socrata/', 'Socrata Open Data'],
            ['zookeeper/', 'Zookeeper'],
        ]
    },
];

const tutorialsMenu = [
    '',
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
            '/how-to/': integrationMenu,
            '/how-to/database/': tutorialsMenu,
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
