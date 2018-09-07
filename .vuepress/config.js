const githubSettings = {
    docsRepo: 'axibase/atsd-use-cases',
    editLinks: true,
    editLinkText: 'Help us improve this page!'
}

const topNavMenu = [
    { text: 'Research', link: '/research/' },
    { text: 'Chart of the Day', link: '/chart-of-the-day/' },
    { text: 'Trends', link: '/trends/' },
    { text: 'Integrations', link: '/integrations/' },
    { text: 'Tutorials', link: '/tutorials/' },
    { text: 'Docs', link: 'https://axibase.com/docs/atsd/' },
]

const landingPageMenu = [
    ['/research/', 'Research'],
    [ '/chart-of-the-day/', 'Chart of the Day'],
    [ '/trends/',  'Trends' ],
    [ '/integrations/', 'Integrations' ],
    [ '/tutorials/', 'Tutorials' ],
    ['https://axibase.com/datasets/', 'Datasets'],
];

const chartofthedayMenu = [
    {
        title: "Chart of the Day", children: [
            ['2018.md', '2018'],
            ['2017.md', '2017'],
            ['2015.md', '2015'],
        ]
    },
];

const researchMenu = [
    {
        title: "Research", children: [
            ['2018.md', '2018'],
            ['2017.md', '2017'],
            ['2016.md', '2016'],
            ['2015.md', '2015'],
        ]
    },
];

const integrationsMenu = [
    {
        title: "Integration", children: [
            ['activemq/', 'ActiveMQ'],
            ['aws/', 'AWS'],
            ['cadvisor/', 'cAdvisor'],
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

const trendsMenu = [
    {
        title: "Trends", children: [
            ['2018.md', '2018'],
        ]
    },
];

module.exports = {
    base: '/use-cases/',
    title: 'Axibase Time Series Database Use Cases',
    titleNote: 'ATSD',
    description: "Use Cases and Walkthrough Guides for Axibase® Time Series Database",
    head: [
        ['link', { rel: 'shortcut icon', href: '/favicon.ico' }]
    ],
    staticFilesExtensionsTest: /(?:tcollector|\.(?:pdf|xlsx?|xml|txt|csv|str|java|json|sql|sps|yxmd|htm|prpt|do|tdc|jsonld|ktr|service|sh|ya?ml))$/,
    themeConfig: {
        nav: topNavMenu,
        logo: '/images/axibase_logo_site.png',

        sidebarDepth: 1,
        sidebar: {
            '/trends/': trendsMenu,
            '/chart-of-the-day/': chartofthedayMenu,
            '/research/': researchMenu,
            '/tutorials/': tutorialsMenu,
            '/integrations/': integrationsMenu,
            // Keep it last
            '/': landingPageMenu,
            '': [],
        },

        searchMaxSuggestions: 10,

        ...githubSettings
    },
    markdown: {
        slugify
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

const rControl = /[\u0000-\u001f]/g
const rSpecial = /[\s~`!@#$%^&*()\-+=[\]{}|\\;:"'<>,.?/]+/g

function slugify (str) {
  return str
    // Remove control characters
    .replace(rControl, '')
    // Replace special characters
    .replace(rSpecial, '-')
    // Remove continous separators
    .replace(/\-{2,}/g, '-')
    // Remove prefixing and trailing separtors
    .replace(/^\-+|\-+$/g, '')
    // ensure it doesn't start with a number (#121)
    .replace(/^(\d)/, '_$1')
    // lowercase
    .toLowerCase()
}