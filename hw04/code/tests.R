# Title: Function Tests
# Stat 133 Fall 2017
# Author: Robby Grewal

library(testthat)


#create some vectors for test purposes

vec1 <- c(1, 2, 3, 4, 4, 7)
vec2 <- c(1, 2, NA, 3, 4, 4, NA, 7)
vec3 <- c(1, 4, 5, 7, NA, 8, 8)
vec4 <- c(1, 2, 3, 4, 5)

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
  expect_equal(get_range(vec1), 6)
  expect_error(get_range(vec3), "Vector must be numeric")
  expect_equal(get_range(vec3, na.rm = TRUE), 7)
  expect_equal(length(get_range(vec2, na.rm = TRUE)), 1)
})

#Function 5 Tests

context("get_median")
test_that("get_median gives the median value of a numeric vector", {
  expect_equal(get_median(vec1, na.rm = TRUE), get_median(vec2, na.rm = TRUE))
  expect_equal(get_median(vec1, na.rm = TRUE), 3.5)
  expect_equal(get_median(vec4, na.rm = TRUE), 3)
  expect_equal(get_median(vec2, na.rm = TRUE), 3.5)
})


#Function 6 Tests

context("get_average")
test_that("get_average returns the average value of a numeric vector", {
  expect_equal(get_average(vec1, na.rm = TRUE), get_average(vec2, na.rm = TRUE))
  expect_equal(get_average(vec1), 3.5)
  expect_equal(get_average(vec2, na.rm = TRUE), 3.5)
  expect_equal(get_average(vec4, na.rm = TRUE), 3)
})

#Function 7 Tests

context("get_stdev")
test_that("get_stdev returns the standard deviation of a numeric vector", {
  expect_equal(get_stdev(vec1), sd(vec1))
  expect_equal(get_stdev(vec2, na.rm = TRUE), sd(vec1))
  expect_equal(get_stdev(vec4), sd(vec4))
  expect_equal(get_stdev(vec3, na.rm = TRUE), sd(c(1, 4, 5, 7, 8, 8)))
})

#Function 8 Tests

context("get_quartile1")
test_that("get_quartile1 returns the first quartile of the values in a numeric vector", {
  expect_equal(get_quartile1(vec1), quantile(c(1, 2, 3, 4, 4, 7), probs = .25))
  expect_equal(get_quartile1(vec1), get_quartile1(vec2, na.rm = TRUE))
  expect_equivalent(get_quartile1(vec4), quantile(c(1, 2, 3, 4, 5), probs = 0.25))
  expect_error(get_quartile1(vec2), "Vector must be numeric")
})

#Function 9 Tests

context("get_quartile3")
test_that("get_quartile3 returns the third quartile of the values in a numeric vector", {
  expect_equal(get_quartile3(vec1), quantile(c(1, 2, 3, 4, 4, 7), probs = .75))
  expect_equal(get_quartile3(vec1), get_quartile3(vec2, na.rm = TRUE))
  expect_equal(get_quartile3(vec4), quantile(c(1, 2, 3, 4, 5), probs = 0.75))
  expect_error(get_quartile3(vec2), "Vector must be numeric")
})

#Function 10 Tests

context("count_missing")
test_that("count_missing returns the number of NA values in a vector", {
  expect_equal(count_missing(vec1), 0)
  expect_equal(count_missing(vec2), 2)
  expect_equal(length(count_missing(vec2)), 1)
  expect_equal(count_missing(vec3), 1)
})

#Function 11 Tests

context("summary_stats")
test_that("summary_stats returns the summary stats of a numeric vector", {
  expect_is(summary_stats(vec1), "list")
  expect_equivalent(summary_stats(vec1)[1], min(vec1))
  expect_equivalent(summary_stats(vec1)[4], median(vec1))
  expect_equal(summary_stats(vec2)[1], summary_stats(vec1)[1])
})

#Function 12 Tests

context("rescale100")
test_that("rescale100 rescales a vector to a 1 to 100 scale", {
  expect_equal(length(rescale100(vec1, 0, 50)), length(vec1))
  expect_equal(rescale100(vec1, 0, 100), c(1, 2, 3, 4, 4, 7))
  expect_equal(rescale100(vec4, 0, 20), c(5, 10, 15, 20, 25))
  expect_equal(rescale100(vec1, 0, 10), rescale100(remove_missing(vec2), 0, 10))
})


#Function 13 Tests

context("drop_lowest")
test_that("drop_lowest drops the lowest value in a vector", {
  expect_equal(drop_lowest(c(1, 1, 2)), c(1, 2))
  expect_equal(drop_lowest(vec1), c(2, 3, 4, 4, 7))
  expect_equal(length(drop_lowest(vec1)) + 1, length(vec1))
  expect_equal(drop_lowest(vec4), c(2, 3, 4, 5))
})


#Function 14 Tests

context("score_homework")
test_that("score_homework takes a vector of HW scores and returns an average value, 
          optionally dropping the lowest value", {
            expect_equal(score_homework(vec4), 3)
            expect_equal(score_homework(vec4, drop = TRUE), get_average(c(2,3,4,5)))
            expect_equal(length(score_homework(vec1)), 1)
            expect_is(score_homework(vec4), "numeric")
          })


#Function 15 tests

context("score_quiz")
test_that("score_quiz takes a vector of scores and returns an average value, 
          optionally dropping the lowest value", {
            expect_equal(score_quiz(vec4), 3)
            expect_equal(length(score_quiz(vec4)), 1)
            expect_equal(score_quiz(vec4, drop = TRUE), get_average(c(2, 3, 4, 5)))
            expect_equal(length(score_quiz(vec1)), 1)
            expect_is(score_homework(vec2), "numeric")
            })

#Function 16 Tests 

context("score_lab")
test_that("score lab returns the score based on the attendance input", {
  expect_equal(score_lab(12),100)
  expect_equal(score_lab(9),60)
  expect_equal(score_lab(7),20)
  expect_equal(score_lab(3),0)
})


