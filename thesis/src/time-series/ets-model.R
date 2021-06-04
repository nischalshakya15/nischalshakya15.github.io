remove(list = ls())

library('magrittr')
library('dplyr')
library('reader')
library('tidyr')
library('ggplot2')
library('RColorBrewer')
library('lubridate')
library('forecast')
library('stats')

setwd('/home/nischal/repository/personal/nischalshakya15.github.io/thesis')

source('src/utils/utils.R')

sales_genre_year_df <- read.csv(file = 'data-sets/pc-sales.csv', sep = ',', dec = '.')

ggplot(sales_genre_year_df, aes(x = as.Date(Month), y = Sales)) +
  geom_line() +
  scale_x_date(date_labels = "%Y", date_breaks = "1 year") +
  theme_classic()

sales_genre_ts <- ts(sales_genre_year_df$Sales, start = 2000, end = 2012, frequency = 12)
sales_genre_stl <- stl(sales_genre_ts, s.window = 'period')
plot(sales_genre_stl)

sales_genre_model <- window(x = sales_genre_ts, stat = 2000, end = 2010)
sales_genre_test <- window(x = sales_genre_ts, start = 2009)

sales_genre_auto <- ets(sales_genre_model)
sales_genre_ets_fc <- forecast(sales_genre_auto, h = 100)

sales_genre_fc_df <- cbind("Year" = rownames(as.data.frame(sales_genre_ets_fc)), as.data.frame(sales_genre_ets_fc))
names(sales_genre_fc_df) <- gsub(" ", "_", names(sales_genre_fc_df))  # Removing whitespace from column names
sales_genre_fc_df$Year <- as.Date(paste0("01-", sales_genre_fc_df$Year), format = "%d-%b %Y")
sales_genre_fc_df$Model <- rep("ets")


ggplot() +
  geom_line(data = sales_genre_year_df, aes(x = as.Date(Month), y = Sales)) +  # Plotting original data
  geom_line(data = sales_genre_fc_df, aes(x = as.Date(Year), y = as.numeric(Point_Forecast), colour = Model, group = 1))

accuracy(sales_genre_ets_fc, sales_genre_test)