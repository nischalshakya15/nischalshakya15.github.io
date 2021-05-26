remove(list = ls())

library('magrittr')
library('dplyr')
library('shiny')
library('shinythemes')
library('reader')
library('tidyr')

setwd('/home/nischal/repository/personal/nischalshakya15.github.io/thesis')

source('utils/utils.R')

# Set the working directory

# Read data from csv file
data <- read.csv(file = 'data-sets/vgsales-processed.csv', sep = ',', dec = '.', stringsAsFactors = FALSE)

find_by_column_name <- function(df, col_name, col_value) {
  return(
    df %>%
      filter(df[col_name] == col_value)
  )
}