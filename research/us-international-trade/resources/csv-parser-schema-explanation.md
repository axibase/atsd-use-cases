# Description of Schema Based Parser

The below CSV file snippet shows the table structure which our script will use for parsing:

```csv
year,CTY_CODE,CTYNAME,IJAN,...,IDEC,IYR,EJAN,...,EDEC,EYR
1985,0001,OPEC,1733,...,2426,22801,1033,...,1186,12478
1986,0001,OPEC,2631,...,1327,19751,947,...,813,10844
1987,0001,OPEC,1344,...,1883,23952,739,...,1146,11057
```

Below is the table structure that is represented. The first line is used for column headers:

| year | `CTY_CODE` | `CTYNAME` | `IJAN` | ... | `IDEC` | `IYR`   | `EJAN` | ... | `EDEC` | `EYR`   |
|------|----------|---------|------|-----|------|-------|------|-----|------|-------|
| 1985 | 0001     | OPEC    | 1733 | ... | 2426 | 22801 | 1033 | ... | 1186 | 12478 |
| 1986 | 0001     | OPEC    | 2631 | ... | 1327 | 19751 | 947  | ... | 813  | 10844 |
| 2016 | 0001     | OPEC    | 1344 | ... | 1883 | 23952 | 739  | ... | 1146 | 11057 |

Here is our CSV parser schema:

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
In this case, `'#row=2-*'`  means that we want to select all rows starting with row Index 2 (which will ignore the first row).

After execution, we will work with the table's cells:

|  Index | 1   | 2    | 3    | 4    |5-14 | 15   | 16    | 17   |18-27|   28|  29   |
|------|------|------|------|------|-----|------|-------|------|-----|------|-------|
| **2** | 1985 | 0001 | OPEC | 1733 | ... | 2426 | 22801 | 1033 | ... | 1186 | 12478 |
| **3** | 1986 | 0001 | OPEC | 2631 | ... | 1327 | 19751 | 947  | ... | 813  | 10844 |
| **4** | 1987 | 0001 | OPEC | 1344 | ... | 1883 | 23952 | 739  | ... | 1146 | 11057 |

## Select Columns

```javascript
 select('#col=4-28')
```

This expression `'#col=4-28''` means that we want select all columns with indexes from 4 to 28. After selection, we will work with the following cells:

|  Index | 4    |5-14 | 15   | 16    | 17   |18-27|   28 |
|-------|-------|-----|------|-------|------|-----|------|
| **2** |  1733 | ... | 2426 | 22801 | 1033 | ... | 1186 |
| **3** |  2631 | ... | 1327 | 19751 | 947  | ... | 813  |
| **4** |  1344 | ... | 1883 | 23952 | 739  | ... | 1146 |

## Filter Cells

We don't want to select columns that are contained in a column which describes summary values for the year. The columns end with the `YR` suffix.

```javascript
 filter(!cell(1,col).endsWith('YR'))
```

For filtering cells, we can use the `filter` command that takes a boolean condition as a parameter. The method goes through every cell and checks it for this condition.

Let us consider our instance.

## Current Indexes: `row` and `col`

When we are iterating through cells, we can retrieve index values for columns and rows by using the `row` and `col` variables accordingly.

## `cell` Method

The `cell` method returns the value of the cell with listed row and column indexes.

For example, for the first iteration, we will retrieve the value of the cell that is contained in the first row and the fourth column. It will have the value `IJAN`.

## Standard Javascript Methods

The cell method returns a value as a string, and we can use standard javascript call methods and properties from the [String](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String) class.
We will use the [endsWith](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String) method to determine whether a string ends with the `YR` string or not.

## Filtering Cells

We discard the column with the header `IYR` from our cells and we will work with following cells:

|  Index | 1   | 2    | 3    | 4    |5-14 | 15  | 17   |18-27|   28  |
|------|------|------|------|------|-----|------|------|-----|-------|
| **2** | 1985 | 0001 | OPEC | 1733 | ... | 2426 | 1033 | ... | 1186 |
| **3** | 1986 | 0001 | OPEC | 2631 | ... | 1327 | 947  | ... | 813  |
| **4** | 1987 | 0001 | OPEC | 1344 | ... | 1883 | 739  | ... | 1146 |

## Filter Last Missing Data

We want to discard data for December 2016. We will use this filter:

```javascript
filter(cell(row,1) != 2016 || cell(1,col).substring(1) != 'DEC')
```

For example, in the first iteration we will check when this condition resolves to true:

```javascript
filter((1985 != 2016) || ('JAN' != 'DEC'))
```

## Add Series

We will use the `addSeries()` method to add series for each of the cells.

```javascript
addSeries()
```

After filtering our cells, we will iterate through the cells and use the cell value as our `series` value. But first, we need to specify the necessary series fields.

## Series Fields

## 1.  Entity

   We should specify the entity with the `entity` method that takes the entity name as the string parameter.

```javascript
    entity('usa')
```

## 2.  Metric

   To specify the metric, we can use the `metric` command.

```javascript
    metric('us-trade-' + (cell(1,col).startsWith('E')?'export':'import') )
```

   Next, we decide which metric we will use for the series. Our metric depends on the first letter in the column header. If the header starts with 'E', we will use 'us-trade-export'.
   Otherwise, the name of metric will be 'us-trade-import'.

## 3. Tags

   We can specify tags by using the `tag` method which takes `key` and `value` of a tag as the parameter.

```javascript
        tag('ctyname', cell(row, 3))
        .tag('cty_code', cell(row,2))
```

   Using this method, we specified our tags as `ctyname` and `cty_code`, respectively.

## 4. Timestamp

We should choose the appropriate string that describes the time of our series sample,
which then will be parsed by a timestamp pattern. We accomplish this by using the `timestamp` method:

```javascript
   timestamp(cell(row,1)+'-'+cell(1,col).substring(1))
```

## Result

In our case, we can pass a string that is the result of concatenated values of the first column in the row and a substring of the current column's header.

For example, for our first iteration we get a series with these fields:

| Date                 | Metric          | Entity | Tags                             | Value |
|----------------------|-----------------|--------|----------------------------------|-------|
| 1985-01-01T00:00:00Z | us-trade-import | usa    | cty_code = 0001, ctyname = OPEC  | 1,733 |