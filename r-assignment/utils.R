getFilterData <- function (data, filterColumn, filterValue) {
  return(filter(data, eval(parse(text = filterColumn)) == filterValue)) 
}

getUniqueAttribute <- function(data, columnName) {
  return (c(unique(data$columnName)))
}