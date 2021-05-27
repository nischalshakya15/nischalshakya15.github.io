find_by_column_name <- function(df, col_name, col_value, arrange_col_name) {
  return(
    df
      %>%
      filter(df[col_name] == col_value)
      %>%
      arrange(arrange_col_name)
  )
}