remove(list = ls())

library('magrittr')
library('dplyr')
library('shiny')
library('shinythemes')
library('reader')
library('tidyr')
library('ggplot2')
library('viridis')
library('RColorBrewer')

setwd('/home/nischal/repository/personal/nischalshakya15.github.io/thesis')

source('src/utils/utils.R')

df_vg_sales <- read.csv(file = 'data-sets/vgsales-processed.csv', sep = ',', dec = '.')

# Get the basic information about the data
head(df_vg_sales, 10)

# Plot the scatter plot Year vs Sales
png('Year vs Sales')
ggplot(df_vg_sales, aes(x = Year, y = Total_Sales)) +
  geom_point(aes(colour = factor(Year))) +
  stat_smooth(method = 'lm', col = '#C42126', se = FALSE, size = 1) +
  labs(title = 'Year vs Sales', x = 'Years', y = 'Sales In Millions')
dev.off()

#Plot the scatter plot Genre vs Sales
png('Genre Vs Sales')
ggplot(df_vg_sales, aes(x = Genre, y = Total_Sales)) +
  geom_point(aes(colour = factor(Genre))) +
  stat_smooth(method = 'lm', col = '#C42126', se = FALSE, size = 1) +
  labs(title = 'Genre vs Sales', x = 'Genre', y = 'Sales In Millions')
dev.off()

#Plot the scatter plot Platform vs Sales
png('Platform vs Sales')
ggplot(df_vg_sales, aes(x = Platform, y = Total_Sales)) +
  geom_point(aes(colour = factor(Platform))) +
  stat_smooth(method = 'lm', col = '#C42126', se = FALSE, size = 1) +
  labs(title = 'Platform vs Sales', x = 'Genre', y = 'Sales In Millions')
dev.off()

# Research QUestion 1 : Do the sales vary in different regions ?

df_sales_region <- read.csv(file = 'data-sets/eda-data/vg_sales_region_year_wise.csv', sep = ',', dec = '.')
png('Sales vs Regions')
# Line graph showing sales may vary in different region
ggplot(df_sales_region, aes(x = Year, y = Sales, group = Region, color = Region)) +
  geom_line() +
  geom_point(shape = 21, color = 'black', fill = "#69b3a2", size = 2) +
  scale_color_brewer(palette = 'Dark2')
dev.off()

# End of Research Question 1 : Do the sales vary in different region

# Research Question 2 : Why the cross platform release matter when it comes to the sales of video games?
df_cross_platform_release_generic <- read.csv(file = 'data-sets/eda-data/vg_sales_platform_year_wise.csv', sep = ',', dec = '.')
png('Cross Platform release')
ggplot(df_cross_platform_release_generic, aes(x = Year, y = Sales, group = Platform, color = Platform)) +
  geom_line() +
  geom_point(shape = 21, color = 'black', fill = "#69b3a2", size = 2) +
  scale_color_brewer(palette = 'Dark2')
dev.off()

c25 <- colorRampPalette(c("dodgerblue2", "#E31A1C", "green4", "#6A3D9A", "#FF7F00", "black", "gold1", "skyblue2", "palegreen2",
                          "#FDBF6F", "gray70", "maroon", "orchid1", "darkturquoise", "darkorange4", "brown"))

png('Sales Genre Year')
df_sales_genre_year <- read.csv(file = 'data-sets/eda-data/vg_sales_genre_year_wise.csv', sep = ',', dec = '.')

ggplot(df_sales_genre_year, aes(x = Year, y = Sales, group = Genre, color = Genre)) +
  geom_line() +
  geom_point(shape = 21, color = 'black', fill = "#69b3a2", size = 2) +
  scale_fill_manual(values = c25)
dev.off()

df_sales_genre <- read.csv(file = 'data-sets/eda-data/vg_sales_genre_wise.csv', sep = ',', dec = '.')

png('bargraph sales genre')
plotBarGraph(df_sales_genre %>% arrange(Genre),
             x = 'Genre', y = 'Sales',
             xlab = 'Genre', ylab = 'Sales in Millions',
             label = df_sales_genre$Sales, x_text_rotate = 45)
dev.off()

png('bargraph sales platform')
df_sales_platform <- read.csv(file = 'data-sets/eda-data/vg_sales_platform_wise.csv', sep = ',', dec = '.')

plotBarGraph(df_sales_platform %>%
               arrange(Sales),
             x = 'Platform', y = 'Sales',
             xlab = 'Platform', ylab = 'Sales in Millions',
             label = df_sales_platform$Sales)
dev.off()

df_pc_ps2_xbox <- read.csv('data-sets/vgsales-pc-ps4-xbox-one.csv', sep = ',', dec = '.')

df_genres <- unique(df_pc_ps2_xbox$Genre)

df_action <- find_by_column_name(df_pc_ps2_xbox, col_name = 'Genre', col_value = 'Action', arrange_col_name = 'Year')

png('corss platform relase')
ggplot(df_action, aes(fill = Platform, y = Total_Sales, x = Platform)) +
  geom_bar(position = "dodge", stat = "identity") +
  theme(legend.position = "none") +
  facet_wrap(~Name) +
  geom_text(aes(label = Total_Sales), position = position_dodge(width = 0.9), vjust = -0.25) +
  ylab("Sales In Millions")
dev.off()
# End of research question 2 : Whay the cross platform release matter when it comes to the sales of video games ?