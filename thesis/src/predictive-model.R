remove(list = ls())

library('magrittr')
library('dplyr')
library('shiny')
library('shinythemes')
library('reader')
library('tidyr')

# Set the working directory
setwd('/home/nischal/repository/personal/nischalshakya15.github.io/thesis')

source('src/utils/utils.R')

# Read data from csv file
data <- read.csv(file = 'data-sets/vgsales-processed.csv', sep = ',', dec = '.', stringsAsFactors = FALSE)

df <- find_by_column_name(data, 'Platform', 'PS2', 'Year')