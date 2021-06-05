remove(list = ls())

library('dplyr')
library('tidyr')
library('ggplot2')
library('forecast')
library('stats')

setwd('/home/nischal/repository/personal/nischalshakya15.github.io/thesis')

source('src/utils/utils.R')

df <- read.csv(file = 'data-sets/pc-sales.csv', sep = ',', dec = '.')

ggplot(df, aes(x = as.Date(Month), y = Sales)) +
  xlab('Year') +
  ylab('Sales in Millions') +
  geom_line() +
  scale_x_date(date_labels = "%Y", date_breaks = "1 year") +
  theme_classic()

df_ts <- ts(df$Sales, start = 2005, end = 2012, frequency = 12)
sales_genre_stl <- stl(df_ts, s.window = 'period')
plot(sales_genre_stl)

df$year <- substring(df$Month, 0, 4)
df$month_num <- substring(df$Month, 6, 7)
year_pal <- sequential(color = "darkturquoise", percentage = 5, what = "value")
ggplot(df, aes(x = month_num, y = Sales, group = year)) +
  xlab('Month') +
  ylab('Sales in Millions') +
  geom_line(aes(colour = year)) +
  theme_classic() +
  scale_color_manual(values = year_pal)

df_model <- window(x = df_ts, stat = 2000, end = 2010)
df_test <- window(x = df_ts, start = 2011)

# Creating model object for each type of ets model
df_ets_auto <- ets(df_model)
df_ets_mmm <- ets(df_model, model = 'MMM')
df_ets_zzz <- ets(df_model, model = 'ZZZ')
df_ets_mmm_damped <- ets(df_model, model = 'MMM', damped = TRUE)

# Creating forecast model object
df_ets_fc <- forecast(df_ets_auto, h = 60)
df_ets_mmm_fc <- forecast(df_ets_mmm, h = 60)
df_ets_zzz_fc <- forecast(df_ets_zzz, h = 60)
df_ets_mmm_damped_fc <- forecast(df_ets_mmm_damped, h = 60)

# Convert the forcast object to data frames
df_ets_fc_forecast <- cbind("Year" = rownames(as.data.frame(df_ets_fc)), as.data.frame(df_ets_fc))
names(df_ets_fc_forecast) <- gsub(" ", "_", names(df_ets_fc_forecast))  # Removing whitespace from column names
df_ets_fc_forecast$Year <- as.Date(paste0("01-", df_ets_fc_forecast$Year), format = "%d-%b %Y")
df_ets_fc_forecast$Model <- rep("ets")

df_mmm_fc_forecast <- cbind("Year" = rownames(as.data.frame(df_ets_mmm_fc)), as.data.frame(df_ets_mmm_fc))
names(df_mmm_fc_forecast) <- gsub(" ", "_", names(df_mmm_fc_forecast))  # Removing whitespace from column names
df_mmm_fc_forecast$Year <- as.Date(paste0("01-", df_mmm_fc_forecast$Year), format = "%d-%b %Y")
df_mmm_fc_forecast$Model <- rep("mmm")

df_zzz_fc_forecast <- cbind("Year" = rownames(as.data.frame(df_ets_zzz_fc)), as.data.frame(df_ets_zzz_fc))
names(df_zzz_fc_forecast) <- gsub(" ", "_", names(df_zzz_fc_forecast))  # Removing whitespace from column names
df_zzz_fc_forecast$Year <- as.Date(paste0("01-", df_zzz_fc_forecast$Year), format = "%d-%b %Y")
df_zzz_fc_forecast$Model <- rep("zzz")

df_mmm_damped_fc_forecast <- cbind("Year" = rownames(as.data.frame(df_ets_mmm_damped_fc)), as.data.frame(df_ets_mmm_damped_fc))
names(df_mmm_damped_fc_forecast) <- gsub(" ", "_", names(df_mmm_damped_fc_forecast))  # Removing whitespace from column names
df_mmm_damped_fc_forecast$Year <- as.Date(paste0("01-", df_mmm_damped_fc_forecast$Year), format = "%d-%b %Y")
df_mmm_damped_fc_forecast$Model <- rep("ets_mmm_damped")

forecast_all <- rbind(df_ets_fc_forecast, df_mmm_fc_forecast, df_zzz_fc_forecast, df_mmm_damped_fc_forecast)

ggplot() +
  geom_line(data = df, aes(x = as.Date(Month), y = Sales)) +  # Plotting original data
  geom_line(data = df_mmm_damped_fc_forecast, aes(x = as.Date(Year), y = as.numeric(Point_Forecast), colour = Model))

accuracy(df_ets_fc, df_test)
accuracy(df_ets_mmm_fc, df_test)
accuracy(df_ets_zzz_fc, df_test)
accuracy(df_ets_mmm_damped_fc, df_test)