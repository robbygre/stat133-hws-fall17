# Title: Function Tests
# Stat 133 Fall 2017
# Author: Robby Grewal

library(testthat)


#create some vectors for test purposes

vec1 <- c(1, 2, 3, 4, 4, 7)
vec2 <- c(1, 2, NA, 3, 4, 4, NA, 7)
vec3 <- c (1, 4, 5, 7, NA, 8, 8)

#Function 1 Tests

context("remove_missing")
test_that("remove_missing removes NA values from a numeric vector", {
  expect_that(length(remove_missing(vec2)), equals(6))
  expect_that(length(remove_missing(vec2)), equals(length(vec1)))
  expect_is(remove_missing(vec3), "numeric")
  expect_that(remove_missing(vec1), equals(vec1))
})


#Function 2 Tests

context("get_minimum")
test_that("get_minimum returns the minimum value of a numeric vector", {
  expect_equal(get_minimum(vec1), 1)
  expect_equal(get_minimum(vec2, na.rm = TRUE), 1)
  expect_equal(length(get_minimum(vec1)), 1)
  expect_equal(get_minimum(vec1, na.rm = TRUE), min(vec1))
})

#Function 3 Tests

context("get_maximum")
test_that("get_maximum returns the maximum value of a numeric vector", {
  expect_equal(get_maximum(vec1), 7)
  expect_equal(get_maximum(vec2, na.rm = TRUE), 7)
  expect_equal(length(get_maximum(vec3, na.rm = TRUE)), 1)
  expect_equal(get_maximum(vec1, na.rm = TRUE), max(vec1))
})

#Function 4 Tests

context("get_range")
test_that("get_range returns the range of values of the input vector", {
  
})













