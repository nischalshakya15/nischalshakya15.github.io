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

get_col_sums <- function(df, col_name) {
  return(
    sum(df[col_name])
  )
}

plotBarGraph <- function(df, x, y, label = '', xlab, ylab) {
  mycolors <- colorRampPalette(brewer.pal(8, 'Set2'))(20)
  ggbarplot(df, x = x, y = y, label = label, width = 0.5, palette = mycolors,
            fill = x, color = x, xlab = xlab, ylab = ylab)
}

write_to_csv <- function(df, file) {
  return(
    write.csv(df, file = file)
  )
}