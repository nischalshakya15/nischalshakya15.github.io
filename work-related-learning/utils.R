getUniqueAttribute <- function(columnName) {
  return (c(as.character(unique(columnName))))
}

sortInAscendingOrder <- function(df, columnName) {
  return (df %>% arrange(columnName))
}

findTopTen <- function (df, columnName, top = 10) {
  return (df %>% top_n(top, columnName))
}

plotBarGraph <- function(df, x, y, label, title, xlab, ylab) {
  ggplot(df, 
         aes(x = x, 
             y = y, label = label)) + 
             geom_bar(stat = 'identity',fill = 'steelblue', color = 'black', width = 0.5) + 
             geom_text(size = 3, vjust = -1) + 
             labs(title = title) + 
             xlab(xlab) + 
             ylab(ylab)
}