# Practical Java Performance: Date Formatting Optimization

## Table of Contents

* [Introduction](#introduction)
* [JMH: Ultimate Java Benchmarking Tool](#jmh:-ultimate-java-benchmarking-tool)
  * [Date Formatters Performance Comparison](#date-formatters-performance-comparison)
* [The Formatters Used by ATSD](#the-formatters-used-by-atsd)
* [New at the Zoo: ATSD DatetimeProcessor](#new-at-the-zoo:-atsd-datetimeprocessor)
* Supported Patterns
  * [Implementation](#implementation)
  * [Caching](#caching)
  * [Breaking Good](#breaking-good)
  * [Performance](#performance)
* [Slides](#slides)
* [References](#references)

## Introduction

One does not simply measure JVM code performance. A performance engineer must take into consideration multiple features
that affect the resulting numbers. Some of them are:

* Interpreting and compiled modes ([implementation details](http://hg.openjdk.java.net/jdk8u/jdk8u/hotspot/file/2b2511bd3cc8/src/share/vm/runtime/advancedThresholdPolicy.hpp#l34)).
* Preemptive compiler optimizations based on collected profiling information.
* Other optimizations such as: constant folding, loop unrolling, dead code elimination.

## JMH: Ultimate Java Benchmarking Tool

[JMH](http://openjdk.java.net/projects/code-tools/jmh/) (Java Microbenchmarking Harness) is a Java harness for building, running, and analysing
nano/micro/milli/macro benchmarks written in Java and other languages targetting the JVM.

To use this tool, create a maven project from archetype.

```sh
mvn archetype:generate \
          -DinteractiveMode=false \
          -DarchetypeGroupId=org.openjdk.jmh \
          -DarchetypeArtifactId=jmh-java-benchmark-archetype \
          -DgroupId=com.github.raipc \
          -DartifactId=benchmark \
          -Dversion=1.0
```

A sample JMH benchmark looks like this:

```java
@State(Scope.Benchmark)
@BenchmarkMode(Mode.AverageTime)
@OutputTimeUnit(TimeUnit.NANOSECONDS)
public class CharIsDigitBenchmark {
    @Param(value = {"+7(955)123-45-67", "79551234567"} )
    private String input;

    @Benchmark
    public String writeDigitsCharacter() {
        final int length = input.length();
        final StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            char ch = input.charAt(i);
            if (Character.isDigit(ch)) {
                sb.append(ch);
            }
        }
        return sb.toString();
    }

    @Benchmark
    public String writeDigitsString() {
        final String digits = "0123456789";
        final int length = input.length();
        final StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            String ch = input.substring(i, i+1);
            if (digits.contains(ch)) {
                sb.append(ch);
            }
        }
        return sb.toString();
    }
}
```

Here, each instrumented method is annotated with `@Benchmark` annotation.

The `@State` annotation is used to mark the class that will contain benchmark state.
It may be either the same class as the one containing benchmarked methods, or a separate class (
in this case the state object is provided to benchmark method as method parameter).

`@Param` annotation is used to mark a parameterized field. The initialization values can be provided
as annotation parameter or using command line parameter `-p {param-name}={param-value}`.

It's worth learning the principles of writing a good JMH benchmark by learning the [examples](http://hg.openjdk.java.net/code-tools/jmh/file/tip/jmh-samples/src/main/java/org/openjdk/jmh/samples/).

### Date Formatters Performance Comparison

The date formatters benchmarks can be found on [Github](https://github.com/raipc/benchmarks/blob/master/src/main/java/com/github/raipc/BetterIso8601Benchmarks.java).

To run the benchmarks, build and run the project.

```sh
mvn clean package
java -jar target/benchmarks.jar
```

```csv
Benchmark                       Mode      Cnt        Score    Error   Units
parseCustomCurrentATSD        sample  3722617      504.680 ±  8.328   ns/op
parseJoda                     sample  2381165      934.201 ± 15.333   ns/op
parseOptimized                sample  2845261      142.150 ±  4.712   ns/op
printJodaIso8601              sample  3662844      509.362 ±  8.079   ns/op
printWithCustomPrinterIsoOpt  sample  2369326      271.344 ± 10.401   ns/op
```

[Chart](https://apps.axibase.com/chartlab/51e517df/2/)

## The Formatters Used by ATSD

ATSD used different date parsing and formatting libraries to cover all use cases.
The following table clarifies which ATSD subsystem used which date formatting library.

**ATSD Subsystem** | **Date Formatter**
-----|-----
Data API | `joda.time` for parsing, custom formatter for printing
SQL | `Apache Commons`
Rule Engine | `joda.time`
Forecasts | `SimpleDateFormat`
CSV Parser | `SimpleDateFormat`
UI | `SimpleDateFormat`

The formatters support different patterns, hence all of them need to be documented and the difference should be emphasized.

## New at the Zoo: ATSD DatetimeProcessor

Introducing of yet-another-date-formatter is dictated by the will to improve maintainability by reducing number of
supported libraries, date patterns, documentation notes. After analyzing common use cases, the following API was created.

```java
public interface DatetimeProcessor {
    long parseMillis(String datetime);

    long parseMillis(String datetime, @NotNull ZoneId zoneId);

    ZonedDateTime parse(String datetime);

    ZonedDateTime parse(String datetime, @NotNull ZoneId zoneId);

    String print(long timestamp);

    String print(long timestamp, @NotNull ZoneId zoneId);
}
```

`DatetimeProcessor API` use cases:

```java
DatetimeProcessor fmt = DateTimeFormatterManager.createFormatter(pattern); // for multiple usage of custom format
String datetime = TimeUtils.formatDateTime(millis, pattern, zoneId); // for single usage of custom format
String datetime = TimeUtils.formatDateTime(millis, pattern);
long timestamp = TimeUtils.parseMillis(timestamp, pattern);

long timestamp = TimeUtils.parseWithDefaultParser(datetime); // for tests or best-effort parsing

long timestamp = parseISO8601(String date);
String datetime = formatISO8601(long time);
String datetime = formatISO8601millis(long time);
String datetime = formatLocalNoTimezone(long time);
String datetime = formatLocalMillisNoTz(long time);
```

### Supported Patterns

DatetimeProcessor supports Java 8 `DateTimeFormatter` patterns with several differences:

* No need to escape `T` literal
* `u` pattern is translated to `ccccc` (day of week starting from Monday)
* `Z` pattern is translated to `XX` (`RFC822` offset, `Z` for zulu)
* `ZZ` pattern is translated to `XXX` (`ISO8601` offset, `Z` for zulu)
* `ZZZ` pattern is translated to `VV` (Zone ID)

### Implementation

`DatetimeProcessor` interface is implemented by three classes.
`DatetimeProcessorIso8601` and `DatetimeProcessorLocal` represent highly-optimized date processors for
ISO pattern (`yyyy-MM-ddTHH:mm:ss[.SSSSSSSSS][Z]`) and local time pattern (`yyyy-MM-dd HH:mm:ss[.SSSSSSSSS][Z]`).
`DatetimeProcessorCustom` is a wrapper for `java.time.format.DateTimeFormatter` objects. Formatting strictly delegates
to default implementation. Parsing operation is performed in semi-manual way: after resolving step is performed
(it includes validating, combining and simplifying the various fields into more useful ones), the date object is
constructed manually by providing default field values if needed.

By design, `DatetimeProcessor` objects must not be constructed manually. Instead, `DateTimeFormatterManager.createFormatter(pattern)`
factory method must be used. This method is responsible for:

1) Trying to get the `DatetimeProcessor` for the specified `pattern` from [cache](#caching).
2) In case of cache-miss, normalizing the pattern.
3) Inserting the most appropriate `DatetimeProcessor` implementation to cache.

### Caching

Caching date formatters is not an innovative idea: previously used libraries used this approach under the hood.

`joda.time` cached formatters using `ConcurrentHashMap` limited by 5000 items.
`Apache Commons` used unlimited `ConcurrentHashMap` cache.
`DatetimeProcessor` objects are cached in the managed LRU cache `dateTimeFormatters` limited by `cache.formatters.maximum.size` property
(defaults to `100`) which can be cleared on demand on **Settings > Cache Management** form.

`DatetimeProcessor` caching method advantages:

1) Defense from cache pollution.
2) Cache replacement policy (LRU) demonstrates higher throughput in worst scenarios (when many formatters are used).
3) Size is controlled by the user.

### Breaking Good

Here is an example of cache pollution attack:

```sql
SELECT *, date_format(time, CONCAT('''time: ''', 'yyyy-MM-dd HH:mm:ss', ''', value: ', value, '''')) AS "time_and_value"
FROM "mpstat.cpu_busy"
LIMIT 500000
```

The above query now affects only formatting of dates with a dynamic pattern (when `DatetimeProcessor` is returned by `DateTimeFormatterManager`).
It does not affect the performance of date formatting in Data API or other subsystems.

Better query:

```sql
SELECT *, CONCAT('time: ', date_format(time, 'yyyy-MM-dd HH:mm:ss'), ', value: ', value) AS "time_and_value"
FROM "mpstat.cpu_busy"
LIMIT 500000
```

### Performance

[ChartLab](https://apps.axibase.com/chartlab/972babb9/16/)

Some performance considerations:

* Use `JSR-310` `ZoneOffset` instead of `TimeZone` to parse zone offsets. It gives free `RFC822` offsets support.
* Manipulate datetime units using `OffsetDateTime` instead of `Calendar`.
* Optimize `parseInt` function with limited characters support.
* Implement `sizeInDigits` function using divide-and-conquer approach.
* Use [JVM intrinsics](https://gist.github.com/apangin/7a9b7062a4bd0cd41fcc) if possible.

## Slides

[Part 1](https://github.com/raipc/slides/perf-presentation)

[Part 2](https://github.com/raipc/slides/time-presentation)

## References

[JMH home page](http://openjdk.java.net/projects/code-tools/jmh/)

[Aleksey Shipilev's Talk about Java Benchmarking](https://www.youtube.com/watch?v=8pMfUopQ9Es)

[Tagir Valeev's Talk about JIT Optimizations](https://www.youtube.com/watch?v=obMArSvmhx4&t=3156s)

[`SimpleDateFormat` Pattern Reference](https://docs.oracle.com/javase/8/docs/api/java/text/SimpleDateFormat.html)

[Joda Time Documentation](http://www.joda.org/joda-time/userguide.html)

[`DateTimeFormatter` Pattern Reference](https://docs.oracle.com/javase/8/docs/api/java/time/format/DateTimeFormatter.html)

[ATSD Date Format Pattern Reference](https://axibase.com/docs/atsd/shared/time-pattern.html)