remove(list = ls())

library('magrittr')
library('dplyr')
library('tidyr')

setwd('/home/nischal/repository/personal/nischalshakya15.github.io/thesis')

# Read data from csv file
data <- read.csv(file = 'data-sets/vgsales-12-4-2019.csv', sep = ',', dec = '.', stringsAsFactors = FALSE)

df <- data %>%
  select(Name, Genre, Platform, Global_Sales, NA_Sales, JP_Sales, PAL_Sales, Other_Sales, Year) %>%
  filter(
    data$Year %in% (2000:2020) &
      !is.na(data$Global_Sales) &
      data$Global_Sales != 0.00 &
      (
        data$Platform == 'PC' |
          data$Platform == 'PS2' |
          data$Platform == 'PS3' |
          data$Platform == 'PS4' |
          data$Platform == 'XOne' |
          data$Platform == 'XB'
      )
  ) %>%
  dplyr::mutate(PAL_Sales = replace_na(PAL_Sales, 0)) %>%
  dplyr::mutate(NA_Sales = replace_na(NA_Sales, 0)) %>%
  dplyr::mutate(Other_Sales = replace_na(Other_Sales, 0)) %>%
  dplyr::mutate(JP_Sales = replace_na(JP_Sales, 0)) %>%
  dplyr::mutate(Total_Sales = PAL_Sales + NA_Sales + JP_Sales + Other_Sales) %>%
  dplyr::mutate(across(is.numeric, ~round(., 2))) %>%
  arrange(Year)

df_where_global_sales_not_equal_to_all_sales <- df %>%
  filter(Global_Sales != Total_Sales)

df_where_global_sales_equal_to_all_sales <- df %>%
  filter(Global_Sales == Total_Sales)

df_where_global_sales_greater_than_all_sales <- df_where_global_sales_not_equal_to_all_sales %>%
  filter(Global_Sales > Total_Sales) %>%
  dplyr::mutate(JP_Sales = replace(JP_Sales, Global_Sales > Total_Sales, Global_Sales - Total_Sales))

df_where_global_sales_less_than_all_sales <- df_where_global_sales_not_equal_to_all_sales %>%
  filter(Global_Sales < Total_Sales) %>%
  dplyr::mutate(JP_Sales = replace(JP_Sales, Global_Sales < Total_Sales, Total_Sales - Global_Sales))

processed_df <- do.call("rbind", list(df_where_global_sales_less_than_all_sales,
                                      df_where_global_sales_equal_to_all_sales,
                                      df_where_global_sales_greater_than_all_sales))

write.csv(processed_df, "/data-sets/vgsales-processed.csv")

# Set the working directory
setwd('/home/nischal/repository/personal/nischalshakya15.github.io/thesis')

source('../utils/utils.R')

# Read data from csv file
data <- read.csv(file = '/data-sets/vgsales-processed.csv', sep = ',', dec = '..', stringsAsFactors = FALSE)

df_pc <- find_by_column_name(data, col_name = 'Platform', col_value = 'PC', arrange_col_name = 'Year')

df_xbox <- find_by_column_name(data, col_name = 'Platform', col_value = 'XB', arrange_col_name = 'Year')

df_ps2 <- find_by_column_name(data, col_name = 'Platform', col_value = 'PS2', arrange_col_name = 'Year')

df_pc_semi_join <- semi_join_df_by(df = df_pc, df_one = df_xbox, df_two = df_ps2, by = 'Name')

df_ps2_semi_join <- semi_join_df_by(df = df_ps2, df_one = df_pc, df_two = df_xbox, by = 'Name')

df_xbox_semi_join <- semi_join_df_by(df = df_xbox, df_one = df_pc, df_two = df_ps2, by = 'Name')

df_pc_ps2_xbox_semi_join <- do.call('rbind', list(df_pc_semi_join, df_ps2_semi_join, df_xbox_semi_join))

df_pc_ps2_xbox <- df_pc_ps2_xbox_semi_join %>% arrange(Name)

write.csv(file = '/data-sets/vgsales-pc-ps2-xbox.csv', df_pc_ps2_xbox)

df_ps3 <- find_by_column_name(data, col_name = 'Platform', col_value = 'PS3', arrange_col_name = 'Year')

df_pc_one_semi_join <- semi_join_df_by(df = df_pc, df_one = df_xbox, df_two = df_ps3, by = 'Name')

df_ps3_semi_join <- semi_join_df_by(df = df_ps3, df_one = df_pc, df_two = df_xbox, by = 'Name')

df_xbox_one_semi_join <- semi_join_df_by(df = df_xbox, df_one = df_pc, df_two = df_ps3, by = 'Name')

df_pc_ps3_xbox_semi_join <- do.call('rbind', list(df_pc_one_semi_join, df_ps3_semi_join, df_xbox_one_semi_join))

df_pc_ps3_xbox <- df_pc_ps3_xbox_semi_join %>% arrange(Name)

write_to_csv(df = df_pc_ps3_xbox, file = '/data-sets/vgsales-pc-ps3-xbox.csv')

df_xbox_one <- find_by_column_name(data, col_name = 'Platform', col_value = 'XOne', arrange_col_name = 'Year')

df_ps4 <- find_by_column_name(data, col_name = 'Platform', col_value = 'PS4', arrange_col_name = 'Year')

df_pc_two_semi_join <- semi_join_df_by(df = df_pc, df_one = df_xbox_one, df_two = df_ps4, by = 'Name')

df_ps4_semi_join <- semi_join_df_by(df = df_ps4, df_one = df_pc, df_two = df_xbox_one, by = 'Name')

df_xbox_one_semi_join <- semi_join_df_by(df = df_xbox_one, df_one = df_pc, df_two = df_ps4, by = 'Name')

df_pc_ps3_xbox_semi_join <- do.call('rbind', list(df_pc_two_semi_join, df_ps4_semi_join, df_xbox_one_semi_join))

df_pc_ps4_xbox_one <- df_pc_ps3_xbox_semi_join %>% arrange(Name)

write_to_csv(df = df_pc_ps4_xbox_one, file = '/data-sets/vgsales-pc-ps4-xbox-one.csv')
