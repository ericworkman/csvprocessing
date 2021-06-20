# CSVProcessing

Process a CSV of records, doing some standard transforms/coercion/cleaning

## Running

```
ruby processor.rb input [output] [report]
```

By default, the output file is output.csv and the report file is report.txt.

## Testing

```
bundle
rspec
```

## Why

We need to consume csv files of patient records.
These records are need some cleaning, transforming, validation.
Output is a cleaned data set and a short report for stats about the processing.

## With more time

TBD
