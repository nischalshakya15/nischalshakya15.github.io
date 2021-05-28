remove(list = ls())

library('magrittr')
library('dplyr')
library('shiny')
library('shinythemes')
library('reader')
library('tidyr')
library('ggplot2')
library('viridis')

setwd('/home/nischal/repository/personal/nischalshakya15.github.io/thesis')

source('src/utils/utils.R')

df_vg_sales <- read.csv(file = 'data-sets/vgsales-processed.csv', sep = ',', dec = '.')

# Get the basic information about the data
head(df_vg_sales, 10)

# Plot the scatter plot Year vs Sales
ggplot(df_vg_sales, aes(x = Year, y = Total_Sales)) +
  geom_point(aes(colour = factor(Year))) +
  stat_smooth(method = 'lm', col = '#C42126', se = FALSE, size = 1) +
  labs(title = 'Year vs Sales', x = 'Years', y = 'Sales In Millions')


#Plot the scatter plot Genre vs Sales
ggplot(df_vg_sales, aes(x = Genre, y = Total_Sales)) +
  geom_point(aes(colour = factor(Genre))) +
  stat_smooth(method = 'lm', col = '#C42126', se = FALSE, size = 1) +
  labs(title = 'Genre vs Sales', x = 'Genre', y = 'Sales In Millions')

#Plot the scatter plot Platform vs Sales
ggplot(df_vg_sales, aes(x = Platform, y = Total_Sales)) +
  geom_point(aes(colour = factor(Platform))) +
  stat_smooth(method = 'lm', col = '#C42126', se = FALSE, size = 1) +
  labs(title = 'Platform vs Sales', x = 'Genre', y = 'Sales In Millions')

# Research QUestion 1 : Do the sales vary in different regions ?
unique_year <- unique(df_vg_sales$Year)
df_sales_region <- data.frame()

for (y in unique_year) {
  selected_sales_region <- find_by_column_name(df = df_vg_sales, col_name = 'Year', col_value = y, arrange_col_name = 'Year')
  df_sales_region <- rbind(df_sales_region, data.frame(
    Year = rep(y, 4),
    Region = c('Japan', 'North America', 'Europe', 'Other Sales'),
    Sales = c(get_col_sums(df = selected_sales_region, col_name = 'JP_Sales'),
              get_col_sums(df = selected_sales_region, col_name = 'NA_Sales'),
              get_col_sums(df = selected_sales_region, col_name = 'PAL_Sales'),
              get_col_sums(df = selected_sales_region, col_name = 'Other_Sales')
    )
  ))
}

# Line graph showing sales may vary in different region
ggplot(df_sales_region, aes(x = Year, y = Sales, group = Region, color = Region)) +
  geom_line() +
  geom_point() +
  scale_color_viridis(discrete = TRUE)

# End of Research Question 1 : Do the sales vary in different region

# Research Question 2 : Why the cross platform release matter when it comes to the sales of video games?
unique_platform <- unique(df_vg_sales$Platform)
df_cross_platform_release_generic <- data.frame()

for (p in unique_platform) {
  df_cross_platform <- find_by_column_name(df = df_vg_sales, col_name = 'Platform', col_value = p, arrange_col_name = 'Year')
  df_sales_platform <- df_cross_platform %>%
    group_by(Year) %>%
    summarize(Total_Sales = sum(Total_Sales))
  df_cross_platform_release_generic <- rbind(df_cross_platform_release_generic, data.frame(
    Year = df_sales_platform$Year,
    Sales = df_sales_platform$Total_Sales,
    Platform = p
  ))
}

ggplot(df_cross_platform_release_generic, aes(x = Year, y = Sales, group = Platform, color = Platform)) +
  geom_line() +
  geom_point() +
  scale_color_viridis(discrete = TRUE)

unique_genre <- unique(df_vg_sales$Genre)
df_sales_genre <- data.frame()

for (g in unique_genre) {
  df_genre <- find_by_column_name(df_vg_sales, col_name = 'Genre', col_value = g, arrange_col_name = 'Year')

  df_genre_sales <- df_genre %>%
    group_by(Genre) %>%
    summarize(Total_Sales = sum(Total_Sales))

  df_sales_genre <- rbind(df_sales_genre, data.frame(
    Sales = df_genre_sales$Total_Sales,
    Genre = g)
  )
}

plotBarGraph(df_sales_genre %>% arrange(Genre),
             x = 'Genre', y = 'Sales',
             xlab = 'Genre', ylab = 'Sales in Millions',
             label = df_sales_genre$Sales, x_text_rotate = 45)

df_sales_platform <- data.frame()

for (p in unique_platform) {
  df_platform <- find_by_column_name(df_vg_sales, col_name = 'Platform', col_value = p, arrange_col_name = 'Year')

  df_platform_sales <- df_platform %>%
    group_by(Platform) %>%
    summarize(Total_Sales = sum(Total_Sales))

  df_sales_platform <- rbind(df_sales_platform, data.frame(
    Sales = df_platform_sales$Total_Sales,
    Platform = p)
  )
}

plotBarGraph(df_sales_platform %>%
               arrange(Sales),
             x = 'Platform', y = 'Sales',
             xlab = 'Platform', ylab = 'Sales in Millions',
             label = df_sales_platform$Sales)

df_pc_ps2_xbox <- read.csv('data-sets/vgsales-pc-ps4-xbox-one.csv', sep = ',', dec = '.')

df_genres <- unique(df_pc_ps2_xbox$Genre)

df_action <- find_by_column_name(df_pc_ps2_xbox, col_name = 'Genre', col_value = 'Action', arrange_col_name = 'Year')

ggplot(df_action, aes(fill = Platform, y = Total_Sales, x = Platform)) +
  geom_bar(position = "dodge", stat = "identity") +
  theme(legend.position = "none") +
  facet_wrap(~Name) +
  geom_text(aes(label=Total_Sales), position=position_dodge(width=0.9), vjust=-0.25) +
  ylab("Sales In Millions")

# End of research question 2 : Whay the cross platform release matter when it comes to the sales of video games ?