find_by_column_name <- function(df, col_name, col_value, arrange_col_name) {
  return(
    df
      %>%
      filter(df[col_name] == col_value)
      %>%
      arrange(arrange_col_name)
  )
}

semi_join_df_by <- function(df, df_one, df_two, by) {
  return(df %>%
           semi_join(
             df_one, by = by
           ) %>%
           semi_join(
             df_two, by = by
           ))
}

write_to_csv <- function(df, file) {
  return(
    write.csv(df, file = file)
  )
}