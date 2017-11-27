#function: remove_missing()
#description: Takes a vector and returns the input vector without missing values
#input: a vector
#output: a vector w/o missing values

remove_missing = function(x) {
  remove = is.na(x)
  x[!is.na(x)]
}


#function to check for numeric vectors (helper function)
check_numeric = function(x){
  for (i in x){
    if (is.na(i)) {
      stop("Vector must be numeric")
    }
  }
}

#function: get_minimum()
#description: returns the minimum value of a numeric vector
#input: a vector
#output: Minimum value in input vector

get_minimum = function(x, na.rm = FALSE) {
  if (na.rm == TRUE ) {
    x <- remove_missing(x)
  }
  check_numeric(x)
  x <- sort(x)
  return (x[1])
}

#function: get_maximum()
#description: returns the maximum value of a numeric vector
#input: a vector
#output: maximum value in input vector

get_maximum = function(x, na.rm = FALSE) {
  if (na.rm == TRUE ) {
    x <- remove_missing(x)
  }
  check_numeric(x)
  x <- sort(x, decreasing = TRUE)
  return (x[1])
}

#function: get_range
#description: returns the range of a numeric vector
#input: a numeric vector
#output: the range of the vector

get_range = function(x, na.rm = FALSE) {
  if (na.rm == TRUE) {
    x <- remove_missing(x)
  }
  check_numeric(x)
  range <- get_maximum(x) - get_minimum(x)
  return (range)
}

#function: get_median()
#description: calculates median of numeric vector
#input: numeric vector
#output: median of input vector

get_median = function(x, na.rm = TRUE){
  if (na.rm == TRUE) {
    x <- remove_missing(x)
  }
  check_numeric
  x <- sort(x)
  if (length(x) %% 2 != 0) {
    median <- x[(length(x) +1) / 2]
  } else {
    median <- (x[length(x) / 2] + x[(length(x) + 2) / 2 ]) / 2
  }
  median
}

#function: get_average()
#description: get the average of a neumeric vector
#input: a numeric vector
#output: average of the input vector

get_average = function(x, na.rm = FALSE) {
  if (na.rm == TRUE) {
    x <- remove_missing(x)
  }
  check_numeric(x)
  total <- 0
  for (i in x) {
    total <-  total + i
  }
  average <- (total / length(x))
  return (average)
}

#function: get_stdev()
#description: returns the standared deviation of the values in a numeric vector
#input: a numeric vector
#output: standard deviation of input vector

get_stdev = function(x, na.rm = FALSE) {
  if (na.rm == TRUE) {
    x <- remove_missing(x)
  }
  ave <- get_average(x, na.rm == TRUE)
  count <- 0
  for (i in x) {
    count <- count + (i-ave)^2
  }
  stdev <- sqrt(count/(length(x) -1))
  return (stdev)
}


#function: get_quartile1()
#description: get the first quartile of a numeric vector
#input: numeric vector
#output: first quartile of input vector

get_quartile1 = function(x, na.rm = FALSE){
  if(na.rm == TRUE) {
    x <- remove_missing(x)
  }
  check_numeric(x)
  return(quantile(x, probs = 0.25))
}

#function: get_quartile3()
#description: get the third quartile of a numeric vector
#input: numeric vector
#output: third quartile of input vector

get_quartile3 = function(x, na.rm = FALSE){
  if(na.rm == TRUE) {
    x <- remove_missing(x)
  }
  check_numeric(x)
  return(quantile(x, probs = 0.75))
}

#function: count_missing()
#description: takes a numeric vector and counts the number of NA values
#input: numeric vector
#output: # of NA values in input vector

count_missing = function(x){
  count <- length(x) - length(remove_missing(x))
  return (count)
}

#function: summary_stats()
#description: takes a numeric vector and returns summary statistics
#input: numeric vector
#output: summary stats of the numeric vector

summary_stats <- function(x){
  summary <- list(minimum = get_minimum(x, na.rm = TRUE), 
                percent10 = quantile(x, prob = .1, na.rm = TRUE),
                quartile1 = get_quartile1(x, na.rm = TRUE),
                median = get_median(x, na.rm =TRUE),
                mean = get_average(x, na.rm = TRUE),
                quartile3 = get_quartile3(x, na.rm = TRUE),
                percent90 = quantile(x, prob = .9, na.rm = TRUE),
                maximum = get_maximum(x, na.rm = TRUE),
                range = get_range(x, na.rm = TRUE),
                stdev = get_stdev(x, na.rm = TRUE),
                missing = count_missing(x)
  )
  summary
}

#function: print_stats()
#description: prints summary stats in a nicer format
#input: a list of summary stats
#output: a nicer format of stats

print_stats = function(lst) {
  names <- names(lst)
  for (i in 1:length(lst)) {
    print(paste0(format(names[i], width = 9),":", sprintf("%.4f", lst[[i]])), quote = FALSE)
  }
}

#function: rescale100()
#description: takes numeric vector x, an xmin and xmax, and computes a rescaled vector from 0 to 100
#input: a numeric vector x, and an x min and x max
#output: a rescaled vector

rescale100 = function(x, xmin, xmax) {
  new_scale <- 100 * ((x - xmin) / (xmax - xmin))
  new_scale
}

#function: drop_lowest()
#description: takes a numeric vector of length n and returns a vector of length n - 1 by dropping the lowest value
#input: a numeric vector
#output: the input vector with the lowest value dropped 

drop_lowest = function(x) {
  x <- sort(x)
  x <- x[-1]
  x
}

#function: score_homework()
#description: takes a numeric vector of hw scores and computes a single hw value, optionally dropping the last one
#input: a numeric vector of hw scores
#output: a single, average hw score

score_homework = function(x, drop = FALSE){
  if (drop == TRUE){
    x <- drop_lowest(x)
  }
  get_average(x, na.rm = TRUE)
}

#function: score_quiz()
#description: takes a numeric vector of quiz scores and computes a single quiz value, optionally dropping the last one
#input: a numeric vector of quiz scores
#output: a single, average quiz score

score_quiz = function(x, drop = FALSE){
  if (drop == TRUE){
    x <- drop_lowest(x)
  }
  get_average(x, na.rm = TRUE)
}

#function: score_lab()
#description: takes a numeric value of lab attendance and returns the lab score
#input: a numeric value of lab attendance
#output: lab score

score_lab = function(x) {
  if (x >= 11){
    score <- 100
  } else if (x == 10) {
    score <- 80
  } else if (x == 9) {
    score <- 60
  } else if (x == 8) {
    score <- 40
  } else if (x == 7) {
    score <- 20
  } else {
    score <- 0
  }
  score
}

#Helper function for clean-data-scipt for getting grades
grader = function(x) {
  if (x < 50) {
    grade <- 'F'
  } else if (x < 60) {
    grade <- 'D'
  } else if (x < 70) {
    grade <- 'C-'
  } else if (x < 77.5) {
    grade <- 'C'
  } else if (x < 79.5) {
    grade <- 'C+' 
  } else if (x < 82) {
    grade <- 'B-'
  } else if (x < 86) {
    grade <- 'B'
  } else if (x < 88) {
    grade <- 'B+'
  } else if (x < 90) {
    grade <- 'A-'
  } else if (x < 95) {
    grade <-  'A'
  } else {
    grade <- 'A+'}
  return (grade)
}

