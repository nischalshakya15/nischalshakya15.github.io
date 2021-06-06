remove(list = ls())

library('dplyr')
library('tidyr')
library('ggplot2')
library('forecast')
library('stats')

setwd('D:/works/nischalshakya15.github.io/thesis')

source('src/utils/utils.R')

df <- read.csv(file = 'data-sets/pc-sales.csv', sep = ',', dec = '.')

df_ts <- ts(df$Sales, start = 2005, end = 2012, frequency = 12)
df_model <- window(x = df_ts, stat = 2000, end = 2010)
df_test <- window(x = df_ts, start = 2011)

df_ets_auto <- ses(df_model, initial = "Simple")

