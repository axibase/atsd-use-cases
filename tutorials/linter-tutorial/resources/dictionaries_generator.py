#!/usr/bin/env python3

import argparse
import contextlib
import json
import sys
try:
    import urllib.request as req
except ImportError:
    import urllib as req

PY3 = sys.version_info >= (3, 0)
str_type = str if PY3 else unicode

ORDINALS_PATTERN_TO_TEN = "(?:1st|2nd|3rd|[4-90]th)"

DEFAULT_DICTIONARY = {
    "days of week": ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],

    "months": ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],

    "measurement units": ["kg", "kW", "kWh", "GWh", "MWh", "lbs", "ms", "AF", "AFD", "GB", "MB", "Hz", "MHz", "nm", "mg", "pH"],

    "technologies": ["nginx", "Java", "JavaScript", "Hadoop", "Hbase", "Hbase-2", "Scala", "MATLAB", "OSISoft",
                     "Bing", "VMWare", "vCenter", "vSphere", "Xeon", "cAdvisor", "DataFrame", "cron", "cgroup[s]?",
                     "TSDB[s]?", "ATSD", "atsd", "Rssa", "MacOS", "Mesos", "GraphQL", "GitHub"],

    "technical abbreviations": ["AWS", "IAM", "EC2", "SNS", "ARN", "T2", "SCOM", "DWH",  "CMDB", "SSA", "CFS", "WPA",
                                "TDW", "AER",
                                "JVM", "JMX", "JMH", "LRU", "MQ", "W3C", "IO", "v?CPU[s]?", "VM[s]?", "GMT", "ARIMA",
                                "QA", "CI", "DevOps", "UI", "UX", "CA[s]?", "ETL", "UDF",
                                "RDF", "PDF", "XLS[X]?", "XML", "CSV", "TCV", "UDP", "JSONPath"],


    "numeric": [ORDINALS_PATTERN_TO_TEN, "\\d\\d+{}".format(ORDINALS_PATTERN_TO_TEN),
                "\\d{2}s", "\\d{4}s", "[Vv]\\d{1,}", "Q[1234]"]

}

EXTENDED_DEFAULT_DICTIONARY = {
    "airports": ["SFO", "LGA", "JFK"],

    "US state abbreviations": ["AK", "AL", "AR", "AZ", "CA", "CO", "CT", "DE", "FL", "GA",
                               "HI", "IA", "ID", "IL", "IN", "KS", "KY", "LA", "MA", "MD",
                               "ME", "MI", "MN", "MO", "MS", "MT", "NC", "ND", "NE", "NH",
                               "NJ", "NM", "NV", "NY", "OH", "OK", "OR", "PA", "RI", "SC",
                               "SD", "TN", "TX", "UT", "VA", "VT", "WA", "WI", "WV", "WY"],

    "economic indicators": ["GDP",  # Gross Domestic Product
                            "c?CPI",  # Core? Consumer Price Index
                            "c?PPI",  # Core? Producer Price Index
                            "MPV",  # Marginal Profit Value?
                            "PPV",  # Potential Profitability Value?
                            "LIBOR",  # London Inter-Bank Offered Rate
                            "DSR",  # Debt-service ratio
                            "EPU",  # Economic Policy Uncertainty
                            "AGI",  # Adjusted Gross Income
                            "CPIE",  # Experimental Consumer Price Index
                            "WPI",  # Wholesale Price Index
                            ],

    "state agencies, organizations, laws": ["EU",  # European Union
                                            "NSA",  # National Security Agency
                                            "CAA",  # Civil Aviation Authority
                                            "CDC",  # Center for Disease Control and Prevention
                                            "FEMA",  # Federal Emergency Management Agency
                                            "EPA",  # Environmental Protection Agency
                                            "FOMC",  # Federal Open Market Committee
                                            "ICHS",  # International Community Health Services
                                            "FCC",  # Federal Communications Commission
                                            "BLS",  # Bureau of Labor Statistics
                                            "IRS",  # Internal Revenue Service
                                            "BPD",  # Baltimore Police Department
                                            "MVA",  # Motor Vehicle Administration
                                            "NCHS",  # National Center for Health Statistics
                                            "USDA",  # US Department of Agriculture
                                            "MSC",  # Meteorological Satellite Center
                                            "JMA",  # Japan Meteorological Agency
                                            "CDWR",  # California Department of Water Resources
                                            "CDEC",  # California Data Exchange Center
                                            "ACSM",  # American College of Sports Medicine
                                            "AEI",  # American Enterprise Institute
                                            "NAICS",  # North American Industry Classification System
                                            "FRED",  # Federal Reserve Economic Data
                                            "OPEC",  # Organization of the Petroleum Exporting Countries
                                            "NAFTA",  # North American Free Trade Agreement
                                            "FICA",  # Federal Insurance Contribution Act
                                            "HIPAA",  # Health Insurance Portability and Accountability Act
                                            "NPT",  # Non-Proliferation Treaty
                                            ],

}


"""
The script converts human-readable dictionary files to regular expressions understood by
spellchecker-cli and yaspeller tools. As a result it creates two files in a working directory:
- .spelling (format recognized by spellchecker-cli)
- .yaspeller-dictionary.json (format recognized by yaspeller)
Optional arguments:
--mode. Can be "atsd", "legacy" or "default".
    "atsd" means that the script is running in atsd repository and it
           doesn't need to download base dictionary
    "legacy" means that current repo is not updated to new format, so a single .dictionary file should be used
    "default" downloads base dictionaries and merges their content with current repository dictionaries
    dictionaries
--names-dictionary filename of dictionary with case-sensitive patterns (default is ".dictionary-names")
--words-dictionary filename of dictionary with patterns with case-insensitive capital (default is ".dictionary-other")
--use-extended-dictionary include abbreviations for US states, airports, organizations which may not needed
"""

BASE_DICTIONARY_LOCATION = "https://raw.githubusercontent.com/axibase/atsd/master/"
DEFAULT_NAMES_DICTIONARY_FILENAME = ".dictionary-names"
DEFAULT_OTHER_DICTIONARY_FILENAME = ".dictionary-other"
DEFAULT_LEGACY_DICTIONARY_FILENAME = ".dictionary"
DEFAULT_PLAIN_DICTIONARY_DESTINATION = ".spelling"
DEFAULT_JSON_DICTIONARY_DESTINATION = ".yaspeller-dictionary.json"


def add_default_dictionary(words, dictionary):
    for lst in dictionary.values():
        for item in lst:
            words.add(str_type("\\b{}\\b".format(item)))


def wrap_pattern(pattern):
    """
    wraps the pattern to word boundaries.
    punctuation marks are checked to reduce number of false-positive matches in spellchecker-cli
    :param pattern: original regex
    :return: modified regex pattern
    """
    if pattern.startswith('['):  # allow possessives for names
        tail = str_type("[.,:?!)]*?")
    else:
        tail = str_type("(?:'s)?[.,:?!)]*?")
    if all(ord(c) < 128 for c in pattern):  # word boundary works incorrectly with unicode characters
        return str_type("\\b{}\\b{}").format(pattern, tail)
    return pattern + tail


def to_case_insensitive_regex(pattern):
    first_letter = pattern[0]
    if first_letter.isalpha():
        return wrap_pattern(str_type("[{}{}]{}").format(first_letter.upper(), first_letter.lower(), pattern[1:]))
    else:
        return wrap_pattern(pattern)


def convert_dictionary(file_provider, transformer_func, result):
    try:
        with file_provider() as f:
            for line in f:
                line = line.strip()
                if len(line) > 0:
                    if not isinstance(line, str_type):
                        line = line.decode('utf-8')
                    result.add(transformer_func(line))
    except (OSError, IOError) as exc:
        sys.stderr.write(str_type(exc) + "\n")


def download_file(filename):
    urlopen = req.urlopen(BASE_DICTIONARY_LOCATION + filename)
    if urlopen.code >= 400:
        urlopen.close()
        raise IOError("Response code: {}".format(urlopen.code))
    return contextlib.closing(urlopen)


def validate_arguments():
    parser = argparse.ArgumentParser(description='Spellchecking dictionaries converter.')
    parser.add_argument('--mode', '-m', type=str,
                        help="mode: atsd (don't download additional dictionaries), "
                             "legacy (load single .dictionary file from current repo), "
                             "default (download .dictionary-names, .dictionary-other from atsd repository, "
                             "merge with similar files in current repo)",
                        default="default")
    parser.add_argument('--names-dictionary', '-nd', type=str,
                        help='Names dictionary filename, first letter in each word in file stays unchanged',
                        default=DEFAULT_NAMES_DICTIONARY_FILENAME)
    parser.add_argument('--words-dictionary', '-d', type=str,
                        help='Other dictionary filename',
                        default=DEFAULT_OTHER_DICTIONARY_FILENAME)
    parser.add_argument('--use-extended-dictionary', '-ed', type=bool,
                        help='Include abbreviations for US states, airports, organizations into the dictionary',
                        default=False)
    arguments = parser.parse_args()

    if DEFAULT_PLAIN_DICTIONARY_DESTINATION in (arguments.names_dictionary, arguments.words_dictionary):
        sys.stderr("Source dictionary filename must not be equal to {}\n".format(DEFAULT_PLAIN_DICTIONARY_DESTINATION))
        exit(1)
    return arguments


def write(destination, string):
    result = string if PY3 else string.encode('utf-8')
    destination.write(result)


if __name__ == '__main__':
    args = validate_arguments()
    patterns = set()
    add_default_dictionary(patterns, DEFAULT_DICTIONARY)
    if args.use_extended_dictionary:
        add_default_dictionary(patterns, EXTENDED_DEFAULT_DICTIONARY)
    if args.mode.lower() != "atsd":
        convert_dictionary(lambda: download_file(DEFAULT_NAMES_DICTIONARY_FILENAME), wrap_pattern, patterns)
        convert_dictionary(lambda: download_file(DEFAULT_OTHER_DICTIONARY_FILENAME), to_case_insensitive_regex, patterns)
    if args.mode.lower() == "legacy":
        convert_dictionary(lambda: open(DEFAULT_LEGACY_DICTIONARY_FILENAME), to_case_insensitive_regex, patterns)
    else:
        convert_dictionary(lambda: open(args.names_dictionary), wrap_pattern, patterns)
        convert_dictionary(lambda: open(args.words_dictionary), to_case_insensitive_regex, patterns)
    sorted_dictionary = list(sorted(patterns))

    with open(DEFAULT_PLAIN_DICTIONARY_DESTINATION, 'w') as out:
        write(out, '\n'.join(sorted_dictionary))

    with open(DEFAULT_JSON_DICTIONARY_DESTINATION, 'w') as out:
        write(out, json.dumps(sorted_dictionary))