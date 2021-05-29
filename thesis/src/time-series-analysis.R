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

sales_genre_year_df <- read.csv(file = 'data-sets/vg_sales_genre_year_wise.csv', sep = ',', dec = '.')

df_test <- sales_genre_year_df

year_unique_df <- unique(df_test$Year)
df <- data.frame()

for (y in year_unique_df) {
  date.end.month <- seq(as.Date(paste(y + 1, '01', '02', sep = '-')), length = 1, by = 'year') - 2
  df <- rbind(df, df_test %>%
    filter(Year == y) %>%
    dplyr::mutate(Year = date.end.month))
}

df_action <- df_test %>%
  filter(Genre == 'Action') %>%
  select(Year, Sales)

sales_genre_ts <- ts(df_action$Sales, start = 2000, end = 2009, frequency = 1)
sales_genre_stl <- stl(sales_genre_ts, s.window = 'period')
plot(sales_genre_stl)

sales_genre_model <- window(x = sales_genre_ts, stat = 2000, end = 2005)
sales_genre_test <- window(x = sales_genre_ts, start = 2006)

sales_genre_auto <- ets(sales_genre_model)
sales_genre_ets_fc <- forecast(sales_genre_auto, h = 10)

sales_genre_fc_df <- cbind("Year" = rownames(as.data.frame(sales_genre_ets_fc)), as.data.frame(sales_genre_ets_fc))
names(sales_genre_fc_df) <- gsub(" ", "_", names(sales_genre_fc_df))  # Removing whitespace from column names
sales_genre_fc_df$Year <- sales_genre_fc_df$Year
sales_genre_fc_df$Model <- rep("ets")


ggplot() +
  geom_line(data = df_action, aes(x = Year, y = Sales)) +  # Plotting original data
  geom_line(data = sales_genre_fc_df, aes(x = as.numeric(Year), y = as.numeric(Point_Forecast), colour = Model, group = 1))

accuracy(sales_genre_ets_fc, sales_genre_test)