remove(list = ls())

library('dplyr')

library('ggplot2')

library('ggpubr')

library('fpc')

library('psych')

library('cluster')

source('utils.R')

setwd('/home/nischal/repository/personal/R/nischalshakya15.github.io/work-related-learning')

javaWebDf <- read.csv('data-sets/re-modified/JavaWebProgramming.csv')

javaWebDf <- mutateRank(javaWebDf, javaWebDf$Total)

# Start Get unique Grade and Rank
javaWebGrades <- getUnique(javaWebDf$Grade)
javaWebRanks <- getUnique(javaWebDf$Rank)
# End

# Start Replace empty value with M and Female with F
i <- 1
for (row in rownames(javaWebDf)) {
  isFemale <- javaWebDf[row, "Gender"]
  if (isFemale == "") {
    javaWebDf$Gender[i] <- "M"
  } else {
    javaWebDf$Gender[i] <- "F"
  }
  i <- i + 1
}
# End

# Start Plot bargraph showing total no of students on basics of Grade
javaWebGradeWiseDf <- data.frame()
for (g in javaWebGrades) {
  javaWebGradeWiseDf <- rbind(javaWebGradeWiseDf,
                              data.frame(
                                countGrade(javaWebDf, g)
                              ))
}
javaWebGradeWiseDf <- sortInAscendingOrder(javaWebGradeWiseDf, javaWebGradeWiseDf$n)
plotBarGraph(df = javaWebGradeWiseDf, x = 'Grade', y = 'n',
             label = javaWebGradeWiseDf$n, xlab = 'Grade', ylab = 'Number of Student')
# End

# Start Plot bargraph showing total no of students on basics of rank
javaWebRankWiseDf <- data.frame()
for (r in javaWebRanks) {
  javaWebRankWiseDf <- rbind(javaWebRankWiseDf,
                             data.frame(
                               getCountRank(javaWebDf, r)
                             ))
}
javaWebRankWiseDf <- sortInAscendingOrder(javaWebRankWiseDf, javaWebRankWiseDf$n)
plotBarGraph(df = javaWebRankWiseDf, x = 'Rank', y = 'n', label = javaWebRankWiseDf$n, xlab = 'Rank', ylab = 'Number of student')
#End

# Start stack bar chart showing no of male and female on basics of Rank
javaWebRankWiseGenderDf <- data.frame()

javaWebRankWiseBarChartDf <- data.frame()

for (r in javaWebRanks) {
  rankFilter <- javaWebDf %>% filter(Rank == r)
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
  javaWebRankWiseGenderDf <- rbind(javaWebRankWiseGenderDf,
                                   data.frame(
                                     Rank = r,
                                     Male = maleRankFilter,
                                     Female = femaleRankFilter
                                   ))
}

javaWebRankWiseGenderDf <- javaWebRankWiseGenderDf %>% select(-c(Male.Gender, Female.Gender))

for (r in javaWebRanks) {
  filter <- javaWebRankWiseGenderDf %>% filter(Rank == r)
  javaWebRankWiseBarChartDf <- rbind(javaWebRankWiseBarChartDf,
                                     data.frame(
                                       Rank = rep(r, 2),
                                       Gender = c(rep('Male', 1), rep('Female', 1)),
                                       NoOfStudent = c(filter$Male.n, filter$Female.n)
                                     ))
}

plotStackBar(javaWebRankWiseBarChartDf, x = 'Rank', y = 'NoOfStudent',
             fill = 'Gender', color = 'Gender', palette = 'uchiago',
             label = javaWebRankWiseBarChartDf$NoOfStudent, xlab = 'Rank', ylab = 'No of student')

# End

# Start Pick up two student from each Rank
javaWebTwoExcellentStudent <- javaWebDf %>%
  filter(Rank == 'Excellent') %>%
  top_n(2, Total)

javaWebTwoVeryGoodStudent <- bind_rows(javaWebDf %>%
                                  filter(Rank == 'Very Good' & Gender == 'M') %>%
                                  top_n(1, Total),
                                       javaWebDf %>%
                                  filter(Rank == 'Very Good' & Gender == 'F') %>%
                                  top_n(1, Total)
)

javaWebTwoGoodStudent <- bind_rows(javaWebDf %>%
                              filter(Rank == 'Good' & Gender == 'M') %>%
                              top_n(1, Total),
                                   javaWebDf %>%
                              filter(Rank == 'Good' & Gender == 'F') %>%
                              top_n(1, Total))

javaWebTwoStatisfactoryStudent <- bind_rows(javaWebDf %>%
                                       filter(Rank == 'Statisfactory' & Gender == 'M') %>%
                                       top_n(1, Total),
                                            javaWebDf %>%
                                       filter(Rank == 'Statisfactory' & Gender == 'F') %>%
                                       top_n(1, Total))
# End

# Start Gathering General Information
javaWebStudents <- bind_rows(javaWebTwoExcellentStudent, javaWebTwoVeryGoodStudent, javaWebTwoGoodStudent, javaWebTwoStatisfactoryStudent)
javaWebStudents <- javaWebStudents %>% select(Name, Gender, Assignment.Marks.Obtained, Mid.Term.Twenty.Percent.Marks, Lab.Test.Marks.Obtained, Final.Exam.Forty.Percent.Marks, Total, Rank)
# En# End

# K means Clustering Algorithm Start
df.cluster <- javaWebDf %>% select(Name, Total, Rank)

df.cluster <- convertRankIntoNumber(df.cluster, df.cluster$Total)

headTail(df.cluster)

plotJitter(df = df.cluster, x = df.cluster$Total, y = df.cluster$Rank, pch = df.cluster$Name)

dfCluser.num <- df.cluster[c('Total', 'Rank')]

pamk <- pamk(dfCluser.num, krange = 2:5, metric = 'manhattan')
plot(pamk$crit)
lines(pamk$crit)


pam <- pam(x = dfCluser.num, k = 6, metric = 'manhattan')

pam.clust <- rep('NA', length(df.cluster$Total))

pam.clust[pam$clustering == 1] <- 'Cluster 1'
pam.clust[pam$clustering == 2] <- 'Cluster 2'
pam.clust[pam$clustering == 3] <- 'Cluster 3'
pam.clust[pam$clustering == 4] <- 'Cluster 4'
pam.clust[pam$clustering == 5] <- 'Cluster 5'
pam.clust[pam$clustering == 6] <- 'Cluster 6'

df.cluster$Cluster <- pam.clust

df.cluster$Cluster <- factor(df.cluster$Cluster, levels = c('Cluster 1', 'Cluster 2', 'Cluster 3', 'Cluster 4', 'Cluster 5', 'Cluster 6'))

ggplot(df.cluster,
       aes(x = Rank,
           y = Total,
           color = Cluster)) +
  geom_point(size = 3) +
  xlab('Rank') +
  ylab('Total') +
  geom_jitter(width = 0.4, height = 0.4) +
  theme_bw()

# End