find_by_column_name <- function(df, col_name, col_value) {
  return(
    df %>%
      filter(df[col_name] == col_value)
  )
}