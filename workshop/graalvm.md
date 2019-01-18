# GraalVM

## Contents

* [Overview](#overview)
* [Preparation](#preparation)
* [Graal Compiler](#graal-compiler)
    * [What is Graal](#what-is-graal)
    * [Simple Graal Benchmark](#simple-graal-benchmark)
* [GraalVM and Truffle](#graalvm-and-truffle)
    * [JavaScript](#javascript)
    * [Polyglot](#polyglot)
* [Going Native](#going-native)
    * [Native Image](#native-image)
    * [Native Library](#native-library)
    * [Disadvantages](#disadvantages)
    * [Limitations](#limitations)
* [Summary](#summary)
* [Sources](#sources)


## Overview

This is a smoothie talk about experimental technologies.

## Preparation

The examples in the tutorial are tested under `GraalVM 1.0.0 RC10` which can be downloaded from [GitHub](https://github.com/oracle/graal/releases/tag/vm-1.0.0-rc10).

To prepare GraalVM under MacOS, execute:

```bash
wget https://github.com/oracle/graal/releases/download/vm-1.0.0-rc10/graalvm-ce-1.0.0-rc10-macos-amd64.tar.gz
tar -xzf graalvm-ce-1.0.0-rc10-macos-amd64.tar.gz
cd graalvm-ce-1.0.0-rc10/Contents/Home/
export GRAAL_HOME=`pwd`
```

## Graal Compiler

### What is Graal

JVM Compiler Interface (JVMCI) was introduced in [JEP 243: Java-Level JVM Compiler Interface](http://openjdk.java.net/jeps/243) and appeared in Java 9. 
Once enabled, it is used instead of C2 (server compiler).

Differentiate the terms Graal and GraalVM. 

Graal is currently the only compiler that implements JVMCI and is delivered with Java 9+.
To enable it, JVM must be provided with the options:

```
-XX:+UnlockExperimentalVMOptions -XX:+EnableJVMCI -XX:+UseJVMCICompiler
```

I recommend to watch [Chris Thalinger's speech about using GraalVM with Java 9](https://www.youtube.com/watch?v=OPOHmQORG6M) 
where he answers how to compile Graal from source and use the new version instead of default one, 
how fast the Graal-compiled Scala code was compared to C2-compiled, how using Graal affects the startup time and consumed memory, and how much money did it save for Twitter.

### Simple Graal Benchmark

```java
@Benchmark
public String findNearestNumber() {
    return NumberFormat.getInstance().format(
        Arrays.stream(numbers.split(" "))
                .filter(str -> !str.isEmpty())
                .map(Double::valueOf)
                .min((a, b) -> Double.compare(Math.abs(a), Math.abs(b)) == 0 ? 
                        Double.compare(b, a) :
                        Double.compare(Math.abs(a), Math.abs(b)))
                .orElse(0.0));
}
```

```csv
# VM version: JDK 1.8.0_192, OpenJDK 64-Bit Server VM, 25.192-b12
Benchmark                                                           (numbers)  Mode  Cnt     Score     Error   Units
NearestNumber.findNearestNumber                                       <empty>  avgt   15     0.819 ±   0.049   us/op
NearestNumber.findNearestNumber:·gc.alloc.rate                        <empty>  avgt   15  1791.192 ± 103.286  MB/sec
NearestNumber.findNearestNumber:·gc.alloc.rate.norm                   <empty>  avgt   15  1792.000 ±   0.001    B/op
NearestNumber.findNearestNumber:·gc.churn.PS_Eden_Space               <empty>  avgt   15  1796.311 ± 104.959  MB/sec
NearestNumber.findNearestNumber:·gc.churn.PS_Eden_Space.norm          <empty>  avgt   15  1797.228 ±  27.111    B/op
NearestNumber.findNearestNumber:·gc.churn.PS_Survivor_Space           <empty>  avgt   15     0.198 ±   0.027  MB/sec
NearestNumber.findNearestNumber:·gc.churn.PS_Survivor_Space.norm      <empty>  avgt   15     0.200 ±   0.034    B/op
NearestNumber.findNearestNumber:·gc.count                             <empty>  avgt   15   638.000            counts
NearestNumber.findNearestNumber:·gc.time                              <empty>  avgt   15   384.000                ms
NearestNumber.findNearestNumber                                   <non-empty>  avgt   15     1.954 ±   0.016   us/op
NearestNumber.findNearestNumber:·gc.alloc.rate                    <non-empty>  avgt   15  1651.862 ±  13.873  MB/sec
NearestNumber.findNearestNumber:·gc.alloc.rate.norm               <non-empty>  avgt   15  3952.000 ±   0.001    B/op
NearestNumber.findNearestNumber:·gc.churn.PS_Eden_Space           <non-empty>  avgt   15  1652.736 ±  30.250  MB/sec
NearestNumber.findNearestNumber:·gc.churn.PS_Eden_Space.norm      <non-empty>  avgt   15  3953.943 ±  51.354    B/op
NearestNumber.findNearestNumber:·gc.churn.PS_Survivor_Space       <non-empty>  avgt   15     0.228 ±   0.057  MB/sec
NearestNumber.findNearestNumber:·gc.churn.PS_Survivor_Space.norm  <non-empty>  avgt   15     0.545 ±   0.138    B/op
NearestNumber.findNearestNumber:·gc.count                         <non-empty>  avgt   15   642.000            counts
NearestNumber.findNearestNumber:·gc.time                          <non-empty>  avgt   15   369.000                ms
```

```csv
# VM version: JDK 1.8.0_192, GraalVM 1.0.0-rc10, 25.192-b12-jvmci-0.53
Benchmark                                                           (numbers)  Mode  Cnt     Score     Error   Units
NearestNumber.findNearestNumber                                       <empty>  avgt   15     0.717 ±   0.074   us/op
NearestNumber.findNearestNumber:·gc.alloc.rate                        <empty>  avgt   15  2033.042 ± 189.486  MB/sec
NearestNumber.findNearestNumber:·gc.alloc.rate.norm                   <empty>  avgt   15  1769.908 ±   4.302    B/op
NearestNumber.findNearestNumber:·gc.churn.PS_Eden_Space               <empty>  avgt   15  2014.463 ± 229.477  MB/sec
NearestNumber.findNearestNumber:·gc.churn.PS_Eden_Space.norm          <empty>  avgt   15  1752.613 ±  88.686    B/op
NearestNumber.findNearestNumber:·gc.churn.PS_Survivor_Space           <empty>  avgt   15     0.369 ±   0.549  MB/sec
NearestNumber.findNearestNumber:·gc.churn.PS_Survivor_Space.norm      <empty>  avgt   15     0.335 ±   0.493    B/op
NearestNumber.findNearestNumber:·gc.count                             <empty>  avgt   15   118.000            counts
NearestNumber.findNearestNumber:·gc.time                              <empty>  avgt   15   193.000                ms
NearestNumber.findNearestNumber                                   <non-empty>  avgt   15     1.746 ±   0.088   us/op
NearestNumber.findNearestNumber:·gc.alloc.rate                    <non-empty>  avgt   15  1722.392 ±  72.005  MB/sec
NearestNumber.findNearestNumber:·gc.alloc.rate.norm               <non-empty>  avgt   15  3675.706 ±  35.419    B/op
NearestNumber.findNearestNumber:·gc.churn.PS_Eden_Space           <non-empty>  avgt   15  1692.519 ± 142.698  MB/sec
NearestNumber.findNearestNumber:·gc.churn.PS_Eden_Space.norm      <non-empty>  avgt   15  3612.979 ± 277.378    B/op
NearestNumber.findNearestNumber:·gc.churn.PS_Survivor_Space       <non-empty>  avgt   15     0.346 ±   0.509  MB/sec
NearestNumber.findNearestNumber:·gc.churn.PS_Survivor_Space.norm  <non-empty>  avgt   15     0.752 ±   1.106    B/op
NearestNumber.findNearestNumber:·gc.count                         <non-empty>  avgt   15   105.000            counts
NearestNumber.findNearestNumber:·gc.time                          <non-empty>  avgt   15   161.000                ms
```

The numbers show a significant performance gain and lower normalized allocation rate due to partial escape analysis described in the [paper](http://www.ssw.uni-linz.ac.at/Research/Papers/Stadler14/Stadler2014-CGO-PEA.pdf).

## GraalVM and Truffle

![](./images/microservices.jpg)

GraalVM is a Hotspot JVM (currently 1.8.0_192) with implements JVMCI and has Graal compiler enabled by default. 
It also delivers Truffle, a framework for implementing interpreters, and some language implementations, e.g. `node`, and package tools, e.g. `npm`.
New languages can be installed using `gu` utility.

```
$GRAALVM_HOME/bin/gu install python
```

### JavaScript

JavaScript is the language shipped with GraalVM without additional setup. Compared to Nashorn engine, Truffle implementation supports modern standards and a lot faster.

Well-known tools can already be run under TruffleJS.

```
$GRAALVM_HOME/bin/npm install leftpad
```

[ECMAScript Features Compatibility Table](https://kangax.github.io/compat-table/es6/)

### Polyglot

Add the following dependency to work with Truffle from IDEA.

```xml
 <dependency>
    <groupId>org.graalvm.truffle</groupId>
    <artifactId>truffle-api</artifactId>
    <version>1.0.0-rc10</version>
</dependency>
```

```java
final Context context = Context.create();
final Function<List<Number>, Number> f = context.eval(language, code).as(Function.class);
executeTests(f);
```

TODO integrate into ATSD, measure performance and memory footprint.

## Going Native

![](./images/dogger_container.jpg)

`native-image` tool compiles Java bytecode (class file or jar archive) into native code which contains a minimalistic Java runtime called `SubstrateVM`.

The examples below demonstrate how to compile the code aimed to manipulate with dates using [ATSD Date and Time Patterns](https://axibase.com/docs/atsd/shared/time-pattern.html#date-and-time-patterns).
The parser and formatter implementation is available in the following maven artifact.

```xml
<dependency>
    <groupId>com.axibase</groupId>
    <artifactId>dates-formatter</artifactId>
    <version>1.0-SNAPSHOT</version>
</dependency>
```

### Native Image

Example 1. Create a command-line utility that prints current time in the format specified in the command argument.

```java
import com.axibase.DateTimeFormatterManager;

public class CurrentTime {
    public static void main(String[] args) {
        if (args.length < 1) {
            System.err.println("Time format pattern must be provided as argument");
            System.exit(1);
        }
        System.out.println(DateTimeFormatterManager.createFormatter(args[0]).print(System.currentTimeMillis()));
    }
}
```

```
$ $GRAALVM/bin/native-image --no-server -cp current_time.jar CurrentTime
[currenttime:16716]    classlist:   1,904.96 ms
[currenttime:16716]        (cap):   1,378.29 ms
[currenttime:16716]        setup:   2,619.53 ms
[currenttime:16716]   (typeflow):   6,395.36 ms
[currenttime:16716]    (objects):   4,234.92 ms
[currenttime:16716]   (features):     142.76 ms
[currenttime:16716]     analysis:  10,931.10 ms
[currenttime:16716]     universe:     287.02 ms
[currenttime:16716]      (parse):     984.54 ms
[currenttime:16716]     (inline):   2,073.15 ms
[currenttime:16716]    (compile):   8,662.43 ms
[currenttime:16716]      compile:  12,368.01 ms
[currenttime:16716]        image:   1,460.05 ms
[currenttime:16716]        write:     428.42 ms
[currenttime:16716]      [total]:  30,076.54 ms
$ du -h currenttime 
6.9M    currenttime
$ /usr/bin/time -l java -jar current_time.jar tivoli
1190116160603351
        0.35 real         0.30 user         0.06 sys
  41893888  maximum resident set size
         0  average shared memory size
         0  average unshared data size
         0  average unshared stack size
      9484  page reclaims
      2184  page faults
         0  swaps
         0  block input operations
         0  block output operations
         0  messages sent
         0  messages received
         1  signals received
       119  voluntary context switches
      1228  involuntary context switches
$ /usr/bin/time -l ./currenttime tivoli
1190116160622379
        0.00 real         0.00 user         0.00 sys
   8806400  maximum resident set size
         0  average shared memory size
         0  average unshared data size
         0  average unshared stack size
      2171  page reclaims
         0  page faults
         0  swaps
         0  block input operations
         0  block output operations
         0  messages sent
         0  messages received
         0  signals received
         0  voluntary context switches
         5  involuntary context switches
```

### Native Library

Example 2. Create a shared library exposing a function that, given date string, date format and time zone, returns same date as Unix milliseconds.
If the date cannot be parsed, return Long.MIN_VALUE

```java
import com.axibase.DateTimeFormatterManager;
import org.graalvm.nativeimage.IsolateThread;
import org.graalvm.nativeimage.c.function.CEntryPoint;
import org.graalvm.nativeimage.c.type.CCharPointer;
import org.graalvm.nativeimage.c.type.CTypeConversion;
import java.time.ZoneId;

public class DateParser {
    @CEntryPoint(name = "parse_date")
    public static long parse(IsolateThread isolateThread, CCharPointer datetime, CCharPointer format, CCharPointer timeZone) {
        try {
            return DateTimeFormatterManager.createFormatter(CTypeConversion.toJavaString(format))
                    .parseMillis(CTypeConversion.toJavaString(datetime), ZoneId.of(CTypeConversion.toJavaString(timeZone)));
        } catch (Exception e) {
            e.printStackTrace();
            return Long.MIN_VALUE;
        }
    }
}
```

```c
#include <stdlib.h>
#include <stdio.h>

#include "graal_isolate.h"
#include "libatsddateparser.h"

int main(int argc, char **argv) {
  graal_isolate_t *isolate = NULL;
  graal_isolatethread_t *thread = NULL;

  if (graal_create_isolate(NULL, &isolate, &thread) != 0 || thread == NULL) {
    fprintf(stderr, "initialization error\n");
    return 1;
  }
  long long int millis = parse_date(thread, (char *)"2019-01-20", (char *)"yyyy-MM-dd", (char *)"UTC");
  printf("%llu\n", millis);

  return 0;
}
```

```bash
$ $GRAALVM_HOME/bin/native-image --no-server -cp date_parser.jar -H:Kind=SHARED_LIBRARY -H:Name=libatsddateparser
[libatsddateparser:19366]    classlist:   1,860.84 ms
[libatsddateparser:19366]        (cap):   1,122.36 ms
[libatsddateparser:19366]        setup:   2,469.94 ms
[libatsddateparser:19366]   (typeflow):   6,245.58 ms
[libatsddateparser:19366]    (objects):   4,031.05 ms
[libatsddateparser:19366]   (features):     168.16 ms
[libatsddateparser:19366]     analysis:  10,607.91 ms
[libatsddateparser:19366]     universe:     224.28 ms
[libatsddateparser:19366]      (parse):   1,171.44 ms
[libatsddateparser:19366]     (inline):   1,665.87 ms
[libatsddateparser:19366]    (compile):   7,707.30 ms
[libatsddateparser:19366]      compile:  11,071.02 ms
[libatsddateparser:19366]        image:   1,048.75 ms
[libatsddateparser:19366]        write:     333.91 ms
[libatsddateparser:19366]      [total]:  27,691.12 ms
$ du -h libatsddateparser.dylib 
7.1M    libatsddateparser.dylib
```

Generated header `libatsddateparser.h

```c
#ifndef __LIBATSDDATEPARSER_H
#define __LIBATSDDATEPARSER_H

#include <graal_isolate.h>


#if defined(__cplusplus)
extern "C" {
#endif

long long int parse_date(graal_isolatethread_t*, char*, char*, char*);

#if defined(__cplusplus)
}
#endif
#endif
```

```bash
$ clang -I. -L. -latsddateparser example.c -o example
$ /usr/bin/time -l ./example
1547942400000
      0.00 real         0.00 user         0.00 sys
 9011200  maximum resident set size
       0  average shared memory size
       0  average unshared data size
       0  average unshared stack size
    2221  page reclaims
       0  page faults
       0  swaps
       0  block input operations
       0  block output operations
       0  messages sent
       0  messages received
       0  signals received
       0  voluntary context switches
       1  involuntary context switches
```

### Disadvantages

- Hard to configure: any application bigger than "Hello, World" can take tens of compilation attempts using trial and error method.
- Compilation is slow: 28 seconds for a simple application exposing a single function.
- The tool is highly voracios: 4 GB of memory were taken during compilation of the application above.

### Limitations

1. AOT compilation relies on close-world assumption: all used classes must be distinguished at compile-time. It means, the code testing if some
library exists in the classpath won't work, but the problem can be solved by [substitutions](https://medium.com/graalvm/instant-netty-startup-using-graalvm-native-image-generation-ed6f14ff7692).
Substitution mechanism allows to provide SubstrateVM with better specialized (non-reflective) piece of code using annotations or JSON configuration.
2. Reflection usage is limited: constant class loading (`Class.forName("com.axibase.Example")) is resolved automatically, but field or method access need
[configuration](https://github.com/oracle/graal/blob/master/substratevm/REFLECTION.md).
3. Static fields are initialized at compile time.
4. Java management and debugging interfaces (JVMTI, JMX) are not supported.

## Summary

Graal compiler and GraalVM have a high potential to be the next big thing by solving painful problems for microservice shepherds:
integration of services written in different languages (by using Polyglot VM) and fast deployment (by precompiling native images).

![](./images/graalvm.jpg)

## Sources

1. [GraalVM website](https://graalvm.org)
2. [GraalVM Github](https://github.com/oracle/graal)
3. [JEP 243: Java-Level JVM Compiler Interface](https://openjdk.java.net/jeps/243)
4. ["Graal: how to use the new JVM JIT compiler in real life" Christian Thalinger](https://www.youtube.com/watch?v=OPOHmQORG6M)
6. ["Under the hood of GraalVM JIT optimizations" Aleksandar Prokopec](https://medium.com/graalvm/under-the-hood-of-graalvm-jit-optimizations-d6e931394797)
6. ["Understanding How Graal Works - a Java JIT Compiler Written in Java" Chris Seaton](https://chrisseaton.com/truffleruby/jokerconf17/)
7. ["Partial Escape Analysis and Scalar Replacement for Java" Lukas Stadler, Thomas Würthinger, Hanspeter Mössenböck](http://www.ssw.uni-linz.ac.at/Research/Papers/Stadler14/Stadler2014-CGO-PEA.pdf)
8. [ECMAScript Compatibility Table](https://kangax.github.io/compat-table/es6/)
9. ["Instant Netty Startup using GraalVM Native Image Generation" Codrut Stancu](https://medium.com/graalvm/instant-netty-startup-using-graalvm-native-image-generation-ed6f14ff7692)
