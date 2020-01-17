getFilterData <- function (data, filterColumn, filterValue) {
  return(filter(data, eval(parse(text = filterColumn)) == filterValue)) 
}