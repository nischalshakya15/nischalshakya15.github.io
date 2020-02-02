remove(list = ls())

library('dplyr')

library('ggplot2')

source('./utils.R')

setwd('/home/nischal/nischalshakya15.github.io/work-related-learning')

df <- read.csv('data-sets/re-modified/JavaProgrammingOne.csv')

df <- mutateRange(df, df$Total)

uniqueGrades <- getUnique(df$Grade)

javaOneDfCount <- data.frame()

for (g in uniqueGrades) {
  javaOneDfCount = rbind(javaOneDfCount, 
                         data.frame(
                           df %>% filter(Grade == g) %>% count(Grade)
                         ))
}

javaOneDfCount <- sortInAscendingOrder(javaOneDfCount, javaOneDfCount$n)

plotBarGraph(df = javaOneDfCount, x = javaOneDfCount$Grade, 
             y = javaOneDfCount$n, label = javaOneDfCount$n, 
             title = 'No of student on basics of grade',
             xlab = 'Grade', ylab = 'Total No of Student')

