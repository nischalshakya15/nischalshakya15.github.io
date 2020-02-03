remove(list = ls())

library('dplyr')

library('ggplot2')

library('ggpubr')

source('./utils.R')

setwd('/home/nischal/nischalshakya15.github.io/work-related-learning')

df <- read.csv('data-sets/re-modified/JavaProgrammingOne.csv')

df <- mutateRange(df, df$Total)

uniqueGrades <- getUnique(df$Grade)

javaOneDfCount <- data.frame()

for (g in uniqueGrades) {
  javaOneDfCount = rbind(javaOneDfCount, 
                         data.frame(
                          countGrade(df, g)
                         ))
}

javaOneDfCount <- sortInAscendingOrder(javaOneDfCount, javaOneDfCount$n)

plotBarGraph(df = javaOneDfCount, x = javaOneDfCount$Grade, 
             y = javaOneDfCount$n, label = javaOneDfCount$n, 
             title = 'No of student on basics of grade',
             xlab = 'Grade', ylab = 'Total No of Student')

javaOneRangeWiseDf <- data.frame()

for (r in getUnique(df$Range)) {
  javaOneRangeWiseDf <- rbind(javaOneRangeWiseDf,
                              data.frame(
                                getCountRange(df, r)
                              ))
}

javaOneRangeWiseDf <- sortInAscendingOrder(javaOneRangeWiseDf, javaOneRangeWiseDf$n)

javaOneRangeWiseGenderDf <- data.frame()

for (r in getUnique(df$Range)) {
  filter <- df %>% filter(Range == r)
  javaOneRangeWiseGenderDf <- rbind(javaOneRangeWiseGenderDf,
                                    data.frame(
                                      Range = r,
                                      Male = filter %>% filter(Gender == 'M') %>% count(Gender),
                                      Female = filter %>% filter(Gender == 'F') %>% count(Gender)
                                    ))
  
}

javaOneRangeWiseGenderDf <- javaOneRangeWiseGenderDf %>% select(-c(Male.Gender, Female.Gender))

print(javaOneRangeWiseGenderDf)

ggBarGraph(df = javaOneRangeWiseDf, x = 'Range', y  = 'n', label = 'n', xlab = 'Range', ylab = 'Total no of student')



