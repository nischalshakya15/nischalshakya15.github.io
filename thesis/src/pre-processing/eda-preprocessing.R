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

df_vg_sales <- read.csv(file = 'data-sets/vgsales-processed.csv', sep = ',', dec = '.')

unique_year <- unique(df_vg_sales$Year)
df_sales_region <- data.frame()

# vg_sales_region_wise
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

df_sales_region_csv <- df_sales_region %>% arrange(Year)
write_to_csv(df_sales_region, 'data-sets/vg_sales_region_year_wise.csv')
# End vg_sales_region_wise

# vg_sales_platform_wise
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

df_sales_platform_wise <- df_cross_platform_release_generic %>% arrange(Year)
write_to_csv(df_sales_platform_wise, '../../data-sets/vg_sales_platform_year_wise.csv')
# End vg_sales_platform_wise

# vg_sales_genre_wise and vg_sales_genre_year_wise
unique_genre <- unique(df_vg_sales$Genre)
df_sales_genre <- data.frame()
df_sales_genre_year <- data.frame()

for (g in unique_genre) {
  df_genre <- find_by_column_name(df_vg_sales, col_name = 'Genre', col_value = g, arrange_col_name = 'Year')

  df_genre_sales <- df_genre %>%
    group_by(Genre) %>%
    summarize(Total_Sales = sum(Total_Sales))

  df_sales_genre <- rbind(df_sales_genre, data.frame(
    Sales = df_genre_sales$Total_Sales,
    Genre = g)
  )

  df_genre_year <- df_genre %>%
    group_by(Year) %>%
    summarize(Total_Sales = sum(Total_Sales))

  df_sales_genre_year <- rbind(df_sales_genre_year, data.frame(
    Year = df_genre_year$Year,
    Genre = g,
    Sales = df_genre_year$Total_Sales
  ))
}

df_sales_genre_wise <- df_sales_genre %>% arrange(Genre)
df_sales_genre_wise_year_wise <- df_sales_genre_year %>% arrange(Year)
write_to_csv(df_sales_genre_wise, 'data-sets/vg_sales_genre_wise.csv')
write_to_csv(df_sales_genre_wise_year_wise, 'data-sets/vg_sales_genre_year_wise.csv')
#End  vg_sales_genre_wise and vg_sales_genre_year_wise


# Start vg_sales_platform_wise
df_sales_platform <- data.frame()

for (p in unique(df_vg_sales$Platform)) {
  df_platform <- find_by_column_name(df_vg_sales, col_name = 'Platform', col_value = p, arrange_col_name = 'Year')

  df_platform_sales <- df_platform %>%
    group_by(Platform) %>%
    summarize(Total_Sales = sum(Total_Sales))

  df_sales_platform <- rbind(df_sales_platform, data.frame(
    Sales = df_platform_sales$Total_Sales,
    Platform = p)
  )
}

df_sales_platform_wise <- df_sales_platform %>% arrange(Platform)
write_to_csv(df_sales_platform_wise, 'data-sets/vg_sales_platform_wise.csv')

vg_pc_ps2_xbox <- read.csv('data-sets/vgsales-pc-ps2-xbox.csv', sep = ',', dec = '.')
vg_pc_ps3_xbox <- read.csv('data-sets/vgsales-pc-ps3-xbox.csv', sep = ',', dec = '.')
vg_pc_ps4_xbox <- read.csv('data-sets/vgsales-pc-ps4-xbox-one.csv', sep = ',', dec = '.')

vg_sales_genre_platform_year_wise <- data.frame()
df <- data.frame()

for (y in vg_pc_ps2_xbox$Genre) {
  res.df <- vg_pc_ps2_xbox %>%
    filter(Genre == y)
  for (year in res.df$Year) {

  }
}
