# Sample Code

This sample code (sample.R) is written in R and calculates the isotopic pattern using the elemental composition. 

## Prerequisites

The code requires the R package 'data.table' and 'testthat' to be installed

## Input

The code takes as input the number of carbon atoms, hydrogen atoms, nitrogen atoms and number of isotope positions wanted. The input file is 'Input.txt' which is an ASCII tab delimited text file with atoms of carbon, hydrogen, nitrogen and number of isotopes in that order.

## Output

The output is written to 'output.txt' which has the isotope position, abundance and relative abundance

## Unit Tests

The unit tests for this code is in 'test_script.R' and can be performed by running

```r
test_file("test_script.R")
```
