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

ggBarGraph(df = javaOneDfCount, x = 'Grade', y = 'n',
           label = 'n', xlab = 'Grade', ylab = 'Number of Student')

javaOneDfCount <- sortInAscendingOrder(javaOneDfCount, javaOneDfCount$n)

ggBarGraph(df = javaOneDfCount, x = 'Grade', y = 'n',
           label = 'n', xlab = 'Grade', ylab = 'Number of Student')

ranges <- getUnique(df$Range)

javaOneRangeWiseDf <- data.frame()

for (r in ranges) {
  javaOneRangeWiseDf <- rbind(javaOneRangeWiseDf,
                              data.frame(
                                getCountRange(df, r)
                              ))
}

javaOneRangeWiseDf <- sortInAscendingOrder(javaOneRangeWiseDf, javaOneRangeWiseDf$n)

ggBarGraph(df = javaOneRangeWiseDf, x = 'Range', y  = 'n', label = 'n', xlab = 'Range', ylab = 'Number of student')

javaOneRangeWiseGenderDf <- data.frame()

javaOneRangeWiseBarChartDf <- data.frame()

for (r in ranges) {
  filter <- df %>% filter(Range == r)
  javaOneRangeWiseGenderDf <- rbind(javaOneRangeWiseGenderDf,
                                    data.frame(
                                      Range = r,
                                      Male = filter %>% filter(Gender == 'M') %>% count(Gender),
                                      Female = filter %>% filter(Gender == 'F') %>% count(Gender)
                                    ))
}

javaOneRangeWiseGenderDf <- javaOneRangeWiseGenderDf %>% select(-c(Male.Gender, Female.Gender))

for (r in ranges) {
  filter <- javaOneRangeWiseGenderDf %>% filter(Range == r) 
  javaOneRangeWiseBarChartDf  <- rbind(javaOneRangeWiseBarChartDf,
                                       data.frame(
                                         Range = c(rep(r, 2)),
                                         Gender = c(rep('Male', 1), rep('Female', 1)),
                                         NoOfStudent = c(filter$Male.n, filter$Female.n)
                                       ))
}

stackBar(javaOneRangeWiseBarChartDf, x = 'Range', y = 'NoOfStudent',
         fill = 'Gender', color = 'Gender', palette = 'uchiago',
         label = 'NoOfStudent', xlab = 'Range', ylab = 'No of student')


topFiveStudents <- findTop(df, df$Grade.Point, top = 4)

topFiveStudents <- sortInAscendingOrder(topFiveStudents, topFiveStudents$Grade.Point) 

topFiveStudents <- topFiveStudents %>% select(Name, Gender, Assignment.Marks.Obtained, 
                                     Mid.Term.Fifteen.Percent.Marks.Obtained,
                                     Lab.Test.Fifteen.Percent.Marks.Obtained,
                                     Internal.Marks, Final.Exam.Forty.Percent.Marks, Total, Grade, Range)

topFourVeryGoodStudent <- df %>% filter(Range == 'Very Good') %>% top_n(4, Total)
print(topFourVeryGoodStudent)

topFourGoodStudent <- df %>% filter(Range == 'Good') %>% top_n(4, Total)
print(topFourGoodStudent)

topFourStatisfactoryStudent <- df %>% filter(Range == 'Statisfactory') %>% top_n(4, Total)
print(topFourStatisfactoryStudent)






