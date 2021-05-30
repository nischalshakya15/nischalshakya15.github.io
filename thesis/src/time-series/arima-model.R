remove(list = ls())

library('magrittr')
library('dplyr')
library('reader')
library('tidyr')
library('ggplot2')
library('RColorBrewer')
library('lubridate')
library('forecast')

setwd('/home/nischal/repository/personal/nischalshakya15.github.io/thesis')

source('src/utils/utils.R')

df <- read.csv(file = 'data-sets/pc-sales.csv', sep = ',', dec = '.')

plot(sales_genre_year_df, main = 'Graph without forecasting')

df_ts <- ts(df$Sales, start = 2000, end = 2010, frequency = 12)

fit <- auto.arima(df_ts)

forecastedValues <- forecast(fit, 60)
print(forecastedValues)

plot(forecastedValues, main = "Graph with forecasting")