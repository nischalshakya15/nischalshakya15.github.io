remove(list = ls())

library('dplyr')

library('ggplot2')

library('ggpubr')

library('fpc')

library('psych')

library('cluster')

source('utils.R')

setwd('/home/nischal/repository/personal/R/nischalshakya15.github.io/work-related-learning')

# Start read
javaOneDf <- read.csv('data-sets/re-modified/JavaProgrammingOne.csv')
# End

javaOneDf <- mutateRank(javaOneDf, javaOneDf$Total)

# Start Get unique Grade and Rank
javaOneUniqueGrades <- getUnique(javaOneDf$Grade)
javaOneRanks <- getUnique(javaOneDf$Rank)
# End

# Start plot bargraph showing total no of student on basics of Grade
javaOneDfCount <- data.frame()
for (g in javaOneUniqueGrades) {
  javaOneDfCount <- rbind(javaOneDfCount,
                          data.frame(
                            countGrade(javaOneDf, g)
                          ))
}
javaOneDfCount <- sortInAscendingOrder(javaOneDfCount, javaOneDfCount$n)
plotBarGraph(df = javaOneDfCount, x = 'Grade', y = 'n',
             label = javaOneDfCount$n, xlab = 'Grade', ylab = 'Number of Student')
# End

# Start plot bargraph showing total no of students on basics of Rank
javaOneRankWiseDf <- data.frame()
for (r in javaOneRanks) {
  javaOneRankWiseDf <- rbind(javaOneRankWiseDf,
                             data.frame(
                               getCountRank(javaOneDf, r)
                             ))
}
javaOneRankWiseDf <- sortInAscendingOrder(javaOneRankWiseDf, javaOneRankWiseDf$n)
plotBarGraph(df = javaOneRankWiseDf, x = 'Rank', y = 'n', label = javaOneRankWiseDf$n, xlab = 'Rank', ylab = 'Number of student')
# End

# Start plot stackbar chart showing no of males and female on basics of Rank
javaOneRankWiseGenderDf <- data.frame()
javaOneRankWiseBarChartDf <- data.frame()
for (r in javaOneRanks) {
  rankFilter <- javaOneDf %>% filter(Rank == r)
  femaleRankFilter <- rankFilter %>%
    filter(Gender == "F") %>%
    count(Gender)
  if (length(femaleRankFilter$n) == 0) {
    femaleRankFilter <- data.frame(Gender = "F", n = 0)
  }
  javaOneRankWiseGenderDf <- rbind(javaOneRankWiseGenderDf,
                                   data.frame(
                                     Rank = r,
                                     Male = rankFilter %>%
                                       filter(Gender == "M") %>%
                                       count(Gender),
                                     Female = femaleRankFilter
                                   ))
}

javaOneRankWiseGenderDf <- javaOneRankWiseGenderDf %>% select(-c(Male.Gender, Female.Gender))

for (r in javaOneRanks) {
  filter <- javaOneRankWiseGenderDf %>% filter(Rank == r)
  javaOneRankWiseBarChartDf <- rbind(javaOneRankWiseBarChartDf,
                                     data.frame(
                                       Rank = rep(r, 2),
                                       Gender = c(rep('Male', 1), rep('Female', 1)),
                                       NoOfStudent = c(filter$Male.n, filter$Female.n)
                                     ))
}

plotStackBar(javaJavaProgrammingTwo showing total number of male and female on basics of Rank, fig.cap='Fig 7:- JavaProgrammingOne Student on basics of Rank', fig.align='center', echo = FALSEOneRankWiseBarChartDf, x = 'Rank', y = 'NoOfStudent',
             fill = 'Gender', color = 'Gender', palette = 'uchiago',
             label = javaOneRankWiseBarChartDf$NoOfStudent, xlab = 'Rank', ylab = 'No of student')
# End

# Start pick up two student from each rank
twoExcellentStudent <- javaOneDf %>%
  filter(Rank == 'Excellent') %>%
  top_n(2, Total)

twoVeryGoodStudent <- bind_rows(javaOneDf %>%
                                  filter(Rank == 'Very Good' & Gender == 'M') %>%
                                  top_n(1, Total),
                                javaOneDf %>%
                                  filter(Rank == 'Very Good' & Gender == 'F') %>%
                                  top_n(1, Total)
)

twoGoodStudent <- bind_rows(javaOneDf %>%
                              filter(Rank == 'Good' & Gender == 'M') %>%
                              top_n(1, Total),
                            javaOneDf %>%
                              filter(Rank == 'Good' & Gender == 'F') %>%
                              top_n(1, Total))

twoStatisfactoryStudent <- bind_rows(javaOneDf %>%
                                       filter(Rank == 'Statisfactory' & Gender == 'M') %>%
                                       top_n(1, Total),
                                     javaOneDf %>%
                                       filter(Rank == 'Statisfactory' & Gender == 'F') %>%
                                       top_n(1, Total))
# End

# Start Gathering General Information
general <- bind_rows(twoExcellentStudent, twoVeryGoodStudent, twoGoodStudent, twoStatisfactoryStudent)
general <- general %>% select(Name, Gender, Assignment.Marks.Obtained, Mid.Term.Fifteen.Percent.Marks.Obtained, Lab.Test.Fifteen.Percent.Marks.Obtained, Final.Exam.Forty.Percent.Marks, Total, Rank)
# End

# K means Clustering Algorithm Start
javaOneCluster <- javaOneDf %>% select(Name, Total, Rank)

javaOneCluster <- convertRankIntoNumber(javaOneCluster, javaOneCluster$Total)

headTail(javaOneCluster)

plotJitter(df = javaOneCluster, x = javaOneCluster$Total, y = javaOneCluster$Rank, pch = javaOneCluster$Name)

javaOneClusterNum <- javaOneCluster[c('Total', 'Rank')]

javaOnePamk <- pamk(javaOneClusterNum, krange = 2:5, metric = 'manhattan')
plot(javaOnePamk$crit)
lines(javaOnePamk$crit)

javaOnePam <- pam(x = javaOneClusterNum, k = 6, metric = 'manhattan')

javaOnePamCluster <- rep('NA', length(javaOneCluster$Total))

javaOnePamCluster[javaOnePam$clustering == 1] <- 'Cluster 1'
javaOnePamCluster[javaOnePam$clustering == 2] <- 'Cluster 2'
javaOnePamCluster[javaOnePam$clustering == 3] <- 'Cluster 3'
javaOnePamCluster[javaOnePam$clustering == 4] <- 'Cluster 4'
javaOnePamCluster[javaOnePam$clustering == 5] <- 'Cluster 5'
javaOnePamCluster[javaOnePam$clustering == 6] <- 'Cluster 6'

javaOneCluster$Cluster <- javaOnePamCluster

javaOneCluster$Cluster <- factor(javaOneCluster$Cluster, levels = c('Cluster 1', 'Cluster 2', 'Cluster 3', 'Cluster 4', 'Cluster 5', 'Cluster 6'))

ggplot(javaOneCluster,
       aes(x = Rank,
           y = Total,
           color = Cluster)) +
  geom_point(size = 3) +
  xlab('Rank') +
  ylab('Total') +
  geom_jitter(width = 0.4, height = 0.4) +
  theme_bw()
#End