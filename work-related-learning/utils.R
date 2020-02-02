getUnique <- function(columnName) {
  return (c(as.character(unique(columnName))))
}

countGrade <- function(df, value) {
  return (
    df %>% filter(Grade == value) %>% count(Grade)  
  )
  
}

sortInAscendingOrder <- function(df, columnName) {
  return (df %>% arrange(columnName))
}

findTop <- function (df, columnName, top = 10) {
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

mutateRange <- function(df, columnName) {
  return (df %>% mutate(Range = case_when(columnName < 40 ~ 'Very Low',
                                          columnName > 40 & columnName < 60 ~ 'Low',
                                          columnName >= 60 & columnName < 80 ~ 'High',
                                          columnName >= 80 & columnName< 95 ~ 'Very High'))
          )
}

plotJitter <- function(df, x, y, pch){
  plot(jitter(x) ~ jitter(y),
       data = df,
       pch=as.character(pch))
}