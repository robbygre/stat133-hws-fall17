# test script
library(testthat)

#source in functions to be tested
source('functions.R')

sink('~/stat133/stat133-hws-fall17/hw04/output/test-reporter.txt')
test_file('tests.R')
sink()

