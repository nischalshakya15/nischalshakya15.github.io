getUnique <- function(columnName) {
  return (c(as.character(unique(columnName))))
}

countGrade <- function(df, value) {
  return (
    df %>% filter(Grade == value) %>% count(Grade)  
  )
}

getCountRanK <- function(df, value){
  return (
    df %>% filter(RanK == value) %>% count(Range)  
  )
}

mutateRank <- function(df, columnName) {
  return (df %>% mutate(Rank = case_when(columnName < 40 ~ 'Statisfactory',
                                          columnName > 40 & columnName < 60 ~ 'Good',
                                          columnName >= 60 & columnName < 80 ~ 'Very Good',
                                          columnName >= 80 & columnName< 95 ~ 'Excellent'))
  )
}

sortInAscendingOrder <- function(df, columnName) {
  return (df %>% arrange(columnName))
}

findTop <- function (df, columnName, top = 10) {
  return (df %>% top_n(top, columnName))
}

findTopStudent <- function(df, value, columnName){
  return (df %>% filter(df$Range == as.character(value)) %>% top_n(4, columnName))
}

plotBarGraph <- function(df, x, y, label, xlab, ylab) {
  ggbarplot(df, x = x, y = y, label = label, width = 0.3,
            fill = x, color = x, palette = "jco", xlab = xlab, ylab = ylab)
}

plotStackBar <- function(df, x, y, fill, color, label, xlab, ylab, palette){
  ggbarplot(df, x = x, y = y,
            fill = fill, color = color, width = 0.6,
            palette = palette,
            label = label,
            position = position_dodge(0.7),
            xlab = xlab,
            ylab = ylab)
}

plotJitter <- function(df, x, y, pch){
  plot(jitter(x) ~ jitter(y),
       data = df,
       pch=as.character(pch))
}