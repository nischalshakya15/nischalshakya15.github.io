remove(list = ls())

library('dplyr')

library('ggplot2')

library('ggpubr')

library('fpc')

library('psych')

library('cluster')

source('utils.R')

setwd('/home/nischal/repository/personal/R/nischalshakya15.github.io/work-related-learning')

javaTwoDf <- read.csv('data-sets/re-modified/JavaProgrammingTwo.csv')

javaTwoDf <- mutateRank(javaTwoDf, javaTwoDf$Total)

# Start Get unique Grade and Rank
javaTwoGrades <- getUnique(javaTwoDf$Grade)
javaTwoRanks <- getUnique(javaTwoDf$Rank)
# End

# Start Replace empty value with M and Female with F
i <- 1
for (row in rownames(javaTwoDf)) {
  isFemale <- javaTwoDf[row, "Gender"]
  if (isFemale == "") {
    javaTwoDf$Gender[i] <- "M"
  } else {
    javaTwoDf$Gender[i] <- "F"
  }
  i <- i + 1
}
# End

# Start Plot bargraph showing total no of students on basics of Grade
javaTwoGradeWiseDf <- data.frame()
for (g in javaTwoGrades) {
  javaTwoGradeWiseDf <- rbind(javaTwoGradeWiseDf,
                              data.frame(
                                countGrade(javaTwoDf, g)
                              ))
}
javaTwoGradeWiseDf <- sortInAscendingOrder(javaTwoGradeWiseDf, javaTwoGradeWiseDf$n)
plotBarGraph(df = javaTwoGradeWiseDf, x = 'Grade', y = 'n',
             label = javaTwoGradeWiseDf$n, xlab = 'Grade', ylab = 'Number of Student')
# End

# Start Plot bargraph showing total no of students on basics of Rank
javaTwoRankWiseDf <- data.frame()
for (r in javaTwoRanks) {
  javaTwoRankWiseDf <- rbind(javaTwoRankWiseDf,
                             data.frame(
                               getCountRank(javaTwoDf, r)
                             ))
}
javaTwoRankWiseDf <- sortInAscendingOrder(javaTwoRankWiseDf, javaTwoRankWiseDf$n)
plotBarGraph(df = javaTwoRankWiseDf, x = 'Rank', y = 'n', label = javaTwoRankWiseDf$n, xlab = 'Rank', ylab = 'Number of student')
#End

# Start stack bar chart showing no of male and female on basics of Rank
javaTwoRankWiseGenderDf <- data.frame()

javaTwoRankWiseBarChartDf <- data.frame()

for (r in javaTwoRanks) {
  rankFilter <- javaTwoDf %>% filter(Rank == r)
  maleRankFilter <- rankFilter %>%
    filter(Gender == "M") %>%
    count(Gender)
  femaleRankFilter <- rankFilter %>%
    filter(Gender == "F") %>%
    count(Gender)
  if (length(femaleRankFilter$n) == 0) {
    femaleRankFilter <- data.frame(Gender = "F", n = 0)
  }
  if (length(maleRankFilter$n) == 0) {
    maleRankFilter <- data.frame(Gender = "M", n = 0)
  }
  javaTwoRankWiseGenderDf <- rbind(javaTwoRankWiseGenderDf,
                                   data.frame(
                                     Rank = r,
                                     Male = maleRankFilter,
                                     Female = femaleRankFilter
                                   ))
}

javaTwoRankWiseGenderDf <- javaTwoRankWiseGenderDf %>% select(-c(Male.Gender, Female.Gender))

for (r in javaTwoRanks) {
  filter <- javaTwoRankWiseGenderDf %>% filter(Rank == r)
  javaTwoRankWiseBarChartDf <- rbind(javaTwoRankWiseBarChartDf,
                                     data.frame(
                                       Rank = rep(r, 2),
                                       Gender = c(rep('Male', 1), rep('Female', 1)),
                                       NoOfStudent = c(filter$Male.n, filter$Female.n)
                                     ))
}

plotStackBar(javaTwoRankWiseBarChartDf, x = 'Rank', y = 'NoOfStudent',
             fill = 'Gender', color = 'Gender', palette = 'uchiago',
             label = javaTwoRankWiseBarChartDf$NoOfStudent, xlab = 'Rank', ylab = 'No of student')

# End

# Start Pick up two student from each Rank
javaTwoTwoExcellentStudent <- javaTwoDf %>%
  filter(Rank == 'Excellent') %>%
  top_n(2, Total)

javaTwoTwoVeryGoodStudent <- bind_rows(javaTwoDf %>%
                                  filter(Rank == 'Very Good' & Gender == 'M') %>%
                                  top_n(1, Total),
                                       javaTwoDf %>%
                                  filter(Rank == 'Very Good' & Gender == 'F') %>%
                                  top_n(1, Total)
)

javaTwoTwoGoodStudent <- bind_rows(javaTwoDf %>%
                              filter(Rank == 'Good' & Gender == 'M') %>%
                              top_n(1, Total),
                                   javaTwoDf %>%
                              filter(Rank == 'Good' & Gender == 'F') %>%
                              top_n(1, Total))

javaTwoTwoStatisfactoryStudent <- bind_rows(javaTwoDf %>%
                                       filter(Rank == 'Statisfactory' & Gender == 'M') %>%
                                       top_n(1, Total),
                                            javaTwoDf %>%
                                       filter(Rank == 'Statisfactory' & Gender == 'F') %>%
                                       top_n(1, Total))
# End

# Start Gathering General Information
javaTwoStudents <- bind_rows(javaTwoTwoExcellentStudent, javaTwoTwoVeryGoodStudent, javaTwoTwoGoodStudent, javaTwoTwoStatisfactoryStudent)
javaTwoStudents <- javaTwoStudents %>% select(Name, Gender, Assignment.Marks.Obtained, Mid.Term.Fifteen.Percent.Marks, Lab.Test.Marks.Obtained, Final.Exam.FortyPercent.Marks, Total, Rank)
# End

# K means Clustering Algorithm Start
javaTwoCluster <- javaTwoDf %>% select(Name, Total, Rank)

javaTwoCluster <- convertRankIntoNumber(javaTwoCluster, javaTwoCluster$Total)

headTail(javaTwoCluster)

plotJitter(df = javaTwoCluster, x = javaTwoCluster$Total, y = javaTwoCluster$Rank, pch = javaTwoCluster$Name)

javaOneClusterNum <- javaTwoCluster[c('Total', 'Rank')]

javaOnePamk <- pamk(javaOneClusterNum, krange = 2:5, metric = 'manhattan')
plot(javaOnePamk$crit)
lines(javaOnePamk$crit)

javaTwoPam <- pam(x = javaOneClusterNum, k = 6, metric = 'manhattan')

javaTwoPamCluster <- rep('NA', length(javaTwoCluster$Total))

javaTwoPamCluster[javaTwoPam$clustering == 1] <- 'Cluster 1'
javaTwoPamCluster[javaTwoPam$clustering == 2] <- 'Cluster 2'
javaTwoPamCluster[javaTwoPam$clustering == 3] <- 'Cluster 3'
javaTwoPamCluster[javaTwoPam$clustering == 4] <- 'Cluster 4'
javaTwoPamCluster[javaTwoPam$clustering == 5] <- 'Cluster 5'
javaTwoPamCluster[javaTwoPam$clustering == 6] <- 'Cluster 6'

javaTwoCluster$Cluster <- javaTwoPamCluster

javaTwoCluster$Cluster <- factor(javaTwoCluster$Cluster, levels = c('Cluster 1', 'Cluster 2', 'Cluster 3', 'Cluster 4', 'Cluster 5', 'Cluster 6'))

ggplot(javaTwoCluster,
       aes(x = Rank,
           y = Total,
           color = Cluster)) +
  geom_point(size = 3) +
  xlab('Rank') +
  ylab('Total') +
  geom_jitter(width = 0.4, height = 0.4) +
  theme_bw()
#End