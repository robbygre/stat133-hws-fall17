#function: remove_missing()
#description: Takes a vector and returns the input vector without missing values
#input: a vector
#output: a vector w/o missing values

remove_missing = function(x) {
  remove = is.na(x)
  x[!is.na(x)]
}

#function: get_minimum()
#description: returns the minimum value of a numeric vector
#input: a vector
#output: Minimum value in input vector

get_minimum = function(x, na.rm = FALSE) {
  if (na.rm == TRUE ) {
    x <- remove_missing(x)
  }
  for (i in x){
    if (!is.numeric(i)) {
      stop("Vector must be numeric")
    }
  }
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
  for (i in x){
    if (!is.numeric(i)) {
      stop("Vector must be numeric")
    }
  }
  x <- sort(x, decreasing = TRUE)
  return (x[1])
}

#function: get_range
#description: returns the range of a numeric vector
#input: a numeric vector
#output: the range of the vector

get_range = function(x, na)



