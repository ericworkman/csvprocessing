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

## With more time or to followup on

1. American date formats and short years. Looks like Date.parse and Date.strptime don't handle this well
1. Is the POSIX short year assumption correct? Should 69-99 -> 19xx?
1. Fix Transforms tests based on above.
1. Assumed the input will always have headers. This may not be true.
1. Member ID appears to be 6 digits. Chose to leave it alone as it could be anything without further knowledge.
1. Assumed the output needs the +1 + 10 digit phone number.
1. Did not validate effective, expiry, or dob against each other. Would want to followup on rules.
1. Move some file validation around and do more to validate input file exists.
1. Complete another pass of the CSVProcessor tests. There should be more to test there with the output, saving files,
   and headers.

I tried to keep the idea that individual components are separated.
I wanted an entry point that could go to any number of strategies, eg CSVProcessor, ExcelProcessor, etc.
These strategies would use the same building blocks as possible -- but this isn't always right.

With large enough files, my approach of fully opening the file and storing valid rows in an array will consume
large amounts of memory, so there are some changes to make there with more time.
I think this work is easy to extend with the separation of concerns, but there might be a tripping hazard with the CSV
library always applying all converters to all fields.
That would depend on how similar some data fields.

