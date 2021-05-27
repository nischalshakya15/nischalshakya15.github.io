remove(list = ls())

library('magrittr')
library('dplyr')
library('shiny')
library('shinythemes')
library('reader')
library('tidyr')
library('ggplot2')

setwd('/home/nischal/repository/personal/nischalshakya15.github.io/thesis')

source('src/utils/utils.R')

df_vg_sales <- read.csv(file = 'data-sets/vgsales-processed.csv', sep = ',', dec = '.')

# Get the basic information about the data
head(df_vg_sales, 10)

# Plot the scatter plot
ggplot(df_vg_sales, aes(x = Year, y = Total_Sales)) +
  geom_point(aes(colour = factor(Year))) +
  stat_smooth(method = 'lm', col = '#C42126', se = FALSE, size = 1) +
  labs(title = 'Year vs Sales', x = 'Years', y = 'Sales In Millions')
