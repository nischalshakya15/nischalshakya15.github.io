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

plotBarGraph(df = javaOneDfCount, x = 'Grade', y = 'n',
             label = 'n', xlab = 'Grade', ylab = 'Number of Student')

df <- mutateRank(df, df$Total)
ranks <- getUnique(df$Rank)
javaOneRankWiseDf <- data.frame()

for (r in ranks) {
  javaOneRankWiseDf <- rbind(javaOneRankWiseDf,
                             data.frame(
                               getCountRank(df, r)
                             ))
}

javaOneRankWiseDf <- sortInAscendingOrder(javaOneRankWiseDf, javaOneRankWiseDf$n)

plotBarGraph(df = javaOneRankWiseDf, x = 'Rank', y  = 'n', label = 'n', xlab = 'Rank', ylab = 'Number of student')
javaOneRankWiseGenderDf <- data.frame()

javaOneRankWiseBarChartDf <- data.frame()

for (r in ranks) {
  filter <- df %>% filter(Rank == r)
  javaOneRankWiseGenderDf <- rbind(javaOneRankWiseGenderDf,
                                   data.frame(
                                     Rank = r,
                                     Male = filter %>% filter(Gender == 'M') %>% count(Gender),
                                     Female = filter %>% filter(Gender == 'F') %>% count(Gender)
                                   ))
}

javaOneRankWiseGenderDf <- javaOneRankWiseGenderDf %>% select(-c(Male.Gender, Female.Gender))

for (r in ranks) {
  filter <- javaOneRankWiseGenderDf %>% filter(Rank == r) 
  javaOneRankWiseBarChartDf  <- rbind(javaOneRankWiseBarChartDf,
                                      data.frame(
                                        Rank = c(rep(r, 2)),
                                        Gender = c(rep('Male', 1), rep('Female', 1)),
                                        NoOfStudent = c(filter$Male.n, filter$Female.n)
                                      ))
}

plotStackBar(javaOneRankWiseBarChartDf, x = 'Rank', y = 'NoOfStudent',
             fill = 'Gender', color = 'Gender', palette = 'uchiago',
             label = 'NoOfStudent', xlab = 'Rank', ylab = 'No of student')


twoExcellentStudent <- df %>% filter(Rank == 'Excellent') %>% top_n(2, Total)

twoVeryGoodStudent <- bind_rows(df %>% filter(Rank == 'Very Good' & Gender == 'M') %>% top_n(1, Total),
                                df %>% filter(Rank == 'Very Good' & Gender == 'F') %>% top_n(1, Total)
) 

twoGoodStudent <- bind_rows(df %>% filter(Rank == 'Good' & Gender == 'M') %>% top_n(1, Total),
                            df %>% filter(Rank == 'Good' & Gender == 'F') %>% top_n(1, Total))

twoStatisfactoryStudent <- bind_rows(df %>% filter(Rank == 'Statisfactory' & Gender == 'M') %>% top_n(1, Total),
                                     df %>% filter(Rank == 'Statisfactory' & Gender == 'F') %>% top_n(1, Total))

general <- bind_rows(twoExcellentStudent, twoVeryGoodStudent, twoGoodStudent, twoStatisfactoryStudent)

general <- general %>% select(Name, Gender, Assignment.Marks.Obtained, Mid.Term.Fifteen.Percent.Marks.Obtained, Lab.Test.Fifteen.Percent.Marks.Obtained, Final.Exam.Forty.Percent.Marks, Total, Rank)
