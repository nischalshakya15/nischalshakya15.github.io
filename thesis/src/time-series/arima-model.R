remove(list = ls())

library('magrittr')
library('dplyr')
library('reader')
library('tidyr')
library('ggplot2')
library('RColorBrewer')
library('lubridate')
library('shiny')
library('shinythemes')
library('forecast')

setwd('/home/nischal/repository/personal/nischalshakya15.github.io/thesis')

source('src/utils/utils.R')

df <- read.csv(file = 'data-sets/vg_sales_platform_year_wise.csv', sep = ',', dec = '.')

df <- df %>%
  filter(Platform == 'PC') %>%
  select(Year, Sales)

plot(df, main = 'Graph without forecasting')

df_ts <- ts(df$Sales, start = 2000, end = 2005, frequency = 1)

fit <- auto.arima(df_ts)

forecastedValues <- forecast(fit, 10)
print(forecastedValues)

plot(forecastedValues, main = "Graph with forecasting")