remove(list = ls())

library('dplyr')
library('forecast')
library('ggplot2')

setwd('D:/works/nischalshakya15.github.io/thesis')

source('src/utils/utils.R')

df <- read.csv(file = 'data-sets/pc-sales.csv', sep = ',', dec = '.')
df_ts <- ts(df$Sales, start = 2000, frequency = 12)

df_model <- window(x = df_ts, start = 2000, end = 2010)
df_test <- window(x = df_ts, start = 2011)

a2 <- auto.arima(df_model, D = 1, trace = TRUE, ic = 'aic', approximation = FALSE)
forecastedValues <- forecast(a2, 60)
print(forecastedValues)

df_arima_forecast <- cbind("Year" = rownames(as.data.frame(forecastedValues)), as.data.frame(forecastedValues))
names(df_arima_forecast) <- gsub(" ", "_", names(df_arima_forecast))  # Removing whitespace from column names
df_arima_forecast$Year <- as.Date(paste0("01-", df_arima_forecast$Year), format = "%d-%b %Y")

print(df_arima_forecast)

ggplot() +
  geom_line(data = df, aes(x = as.Date(Month), y = Sales, xlab = 'Year')) +  # Plotting original data
  geom_line(data = df_arima_forecast, aes(x = as.Date(Year), y = as.numeric(Point_Forecast)), color = 'blue')

accuracy(forecastedValues, df_test)