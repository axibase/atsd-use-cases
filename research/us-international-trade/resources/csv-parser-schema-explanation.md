# Description of Schema Based Parser

The below CSV file snippet shows the table structure to be parser by the CSV Parser in ATSD:

```csv
year,CTY_CODE,CTYNAME,IJAN,...,IDEC,IYR,EJAN,...,EDEC,EYR
1985,0001,OPEC,1733,...,2426,22801,1033,...,1186,12478
1986,0001,OPEC,2631,...,1327,19751,947,...,813,10844
1987,0001,OPEC,1344,...,1883,23952,739,...,1146,11057
```

Below is the table structure that is represented. The first line contains column headers:

| year | `CTY_CODE` | `CTYNAME` | `IJAN` | ... | `IDEC` | `IYR`   | `EJAN` | ... | `EDEC` | `EYR`   |
|------|----------|---------|------|-----|------|-------|------|-----|------|-------|
| 1985 | 0001     | OPEC    | 1733 | ... | 2426 | 22801 | 1033 | ... | 1186 | 12478 |
| 1986 | 0001     | OPEC    | 2631 | ... | 1327 | 19751 | 947  | ... | 813  | 10844 |
| 2016 | 0001     | OPEC    | 1344 | ... | 1883 | 23952 | 739  | ... | 1146 | 11057 |

Here is the CSV parser schema:

```javascript
select('#row=2-*')
    .select('#col=4-28')
    .filter(!cell(1,col).endsWith('YR'))
    .filter(cell(row,1) != 2016 || cell(1,col).substring(1) != 'DEC')
    .addSeries()
    .entity('usa')
    .metric('us-trade-' + (cell(1,col).startsWith('E')?'export':'import') )
    .tag('ctyname', cell(row, 3))
    .tag('cty_code', cell(row,2))
    .timestamp(cell(row,1)+'-'+cell(1,col).substring(1));
```

## Select Rows

```javascript
select('#row=2-*')
```

This method selects elements from the table based on the above expression.
In this case, `'#row=2-*'` means select all rows starting with row Index 2, ignoring the first row.

|  Index | 1   | 2    | 3    | 4    |5-14 | 15   | 16    | 17   |18-27|   28|  29   |
|------|------|------|------|------|-----|------|-------|------|-----|------|-------|
| **2** | 1985 | 0001 | OPEC | 1733 | ... | 2426 | 22801 | 1033 | ... | 1186 | 12478 |
| **3** | 1986 | 0001 | OPEC | 2631 | ... | 1327 | 19751 | 947  | ... | 813  | 10844 |
| **4** | 1987 | 0001 | OPEC | 1344 | ... | 1883 | 23952 | 739  | ... | 1146 | 11057 |

## Select Columns

```javascript
 select('#col=4-28')
```

This expression `'#col=4-28''` selects all columns with indexes from 4 to 28. After selection, the following cells are created:

|  Index | 4    |5-14 | 15   | 16    | 17   |18-27|   28 |
|:-------:|:-------:|:-----:|:------:|:-------:|:------:|:-----:|:------:|
| **2** |  1,733 | `...` | 2,426 | 22,801 | 1,033 | `...` | 1,186 |
| **3** |  2,631 | `...` | 1,327 | 19,751 | 947  | `...` | 813  |
| **4** |  1,344 | `...` | 1,883 | 23,952 | 739  | `...` | 1,146 |

## Filter Cells

Do not select columns that are contained in a column which describes summary values for the year. The columns end with the `YR` suffix.

```javascript
 filter(!cell(1,col).endsWith('YR'))
```

For filtering cells, use the `filter` command that takes a boolean condition as a parameter. The method checks every cell against this condition.

## Current Indexes: `row` and `col`

While iterating through cells, retrieve index values for columns and rows by using the `row` and `col` variables accordingly.

## `cell` Method

The `cell` method returns the value of the cell with listed row and column indexes.

For example, for the first iteration, retrieve the value of the cell that is contained in the first row and the fourth column. It has the value `IJAN`.

## Standard Javascript Methods

The cell method returns a value as a string. Use standard javascript call methods and properties from the [String](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String) class.
Use the [endsWith](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String) method to determine whether a string ends with the `YR` string or not.

## Filtering Cells

Discard the column with the header `IYR` from cells and work with following cells:

|  Index | 1   | 2    | 3    | 4    |5-14 | 15  | 17   |18-27|   28  |
|------|------|------|------|------|-----|------|------|-----|-------|
| **2** | 1985 | 0001 | OPEC | 1733 | ... | 2426 | 1033 | ... | 1186 |
| **3** | 1986 | 0001 | OPEC | 2631 | ... | 1327 | 947  | ... | 813  |
| **4** | 1987 | 0001 | OPEC | 1344 | ... | 1883 | 739  | ... | 1146 |

## Filter Last Missing Data

Discard data for December 2016. Use this filter:

```javascript
filter(cell(row,1) != 2016 || cell(1,col).substring(1) != 'DEC')
```

For example, in the first iteration check when this condition resolves to `true`:

```javascript
filter((1985 != 2016) || ('JAN' != 'DEC'))
```

## Add Series

Use the `addSeries()` method to add series for each of the cells.

```javascript
addSeries()
```

After filtering the correct cells, iterate through the cells and use the cell value as the `series` value. But first, specify the necessary series fields.

## Series Fields

## 1.  Entity

   Specify the entity with the `entity` method that takes the entity name as the string parameter.

```javascript
    entity('usa')
```

## 2.  Metric

   To specify the metric, use the `metric` command.

```javascript
    metric('us-trade-' + (cell(1,col).startsWith('E')?'export':'import') )
```

   Next, decide which metric to use for the series. The metric depends on the first letter in the column header. If the header starts with `'E'`,  use `'us-trade-export'`.
   Otherwise, the name of metric is `'us-trade-import'`.

## 3. Tags

   Specify tags by using the `tag` method which takes `key` and `value` of a tag as the parameter.

```javascript
        tag('ctyname', cell(row, 3))
        .tag('cty_code', cell(row,2))
```

   Using this method, tags are defined as `ctyname` and `cty_code`, respectively.

## 4. Timestamp

Choose the appropriate string that describes the time of the series sample,
which is parsed by a timestamp pattern. Accomplish this by using the `timestamp` method:

```javascript
   timestamp(cell(row,1)+'-'+cell(1,col).substring(1))
```

## Result

In this case, pass a string that is the result of concatenated values of the first column in the row and a substring of the current column header.

For example, the first iteration returns a series with these fields:

```ls
| Date                 | Metric          | Entity | Tags                             | Value |
|----------------------|-----------------|--------|----------------------------------|-------|
| 1985-01-01T00:00:00Z | us-trade-import | usa    | cty_code = 0001, ctyname = OPEC  | 1,733 |
```