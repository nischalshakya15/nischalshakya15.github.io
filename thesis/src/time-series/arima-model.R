remove(list = ls())

library('dplyr')
library('forecast')

setwd('/home/nischal/repository/personal/nischalshakya15.github.io/thesis')

source('src/utils/utils.R')

df <- read.csv(file = 'data-sets/pc-sales.csv', sep = ',', dec = '.')
df_ts <- ts(df$Sales, start = 2000, end = 2010, frequency = 12)

plot(df_ts, main = 'Graph without forecasting', col.main = "darkgreen")

fit <- auto.arima(df_ts)
forecastedValues <- forecast(fit, 60)
print(forecastedValues)

plot(forecastedValues, main = "Graph with forecasting")

remove(list = ls())

library('dplyr')
library('forecast')

setwd('/home/nischal/repository/personal/nischalshakya15.github.io/thesis')
df <- read.csv(file = 'data-sets/pc-sales.csv')
df_ts <- ts(df$Sales, start = 2000, end = 2010, frequency = 12)

tsdisplay(df_ts)

lambda <- BoxCox.lambda(df_ts)
tsdata2 <- BoxCox(df$Sales, lambda = lambda)
tsdisplay(tsdata2)

## Detetct Seasonality
seasonplot(df$Sales)
monthplot(df$Sales)

# Detect the non-stationary data
library('tseries')
adf <- adf.test(df_ts)
kpss <- kpss.test(df_ts)
print(adf)
print(kpss)

a1 <- auto.arima(tsdata2, trace = TRUE, ic = 'aicc', approximation = FALSE)
finalModel <- arima(tsdata2, order = c(1, 0, 0), seasonal = list(order = c(1, 0, 0), period = 12))
summary(finalModel)

forecaseModel <- forecast(finalModel, 100)
plot(forecaseModel, main = "Graph with forecasting")
