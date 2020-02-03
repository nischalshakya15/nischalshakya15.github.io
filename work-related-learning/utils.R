getUnique <- function(columnName) {
  return (c(as.character(unique(columnName))))
}

countGrade <- function(df, value) {
  return (
    df %>% filter(Grade == value) %>% count(Grade)  
  )
}

getCountRange <- function(df, value){
  return (
    df %>% filter(Range == value) %>% count(Range)  
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

ggBarGraph <- function(df, x, y, label, xlab, ylab) {
  ggbarplot(df, x = x, y = y, label = label, width = 0.3,
            fill = x, color = x, palette = "jco", xlab = xlab, ylab = ylab)
}

mutateRange <- function(df, columnName) {
  return (df %>% mutate(Range = case_when(columnName < 40 ~ 'Statisfactory',
                                          columnName > 40 & columnName < 60 ~ 'Good',
                                          columnName >= 60 & columnName < 80 ~ 'Very Good',
                                          columnName >= 80 & columnName< 95 ~ 'Excellent'))
          )
}

plotJitter <- function(df, x, y, pch){
  plot(jitter(x) ~ jitter(y),
       data = df,
       pch=as.character(pch))
}