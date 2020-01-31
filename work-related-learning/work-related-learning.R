remove(list = ls())

library('dplyr')

library('ggplot2')

source('./utils.R')

setwd('/home/nischal/nischalshakya15.github.io/work-related-learning')

df <- read.csv('data-sets/2018/Jan/JavaProgrammingOne.csv')

colnames(df)

#Rename columns 
df <- df %>% rename(Tutorial.Full.Marks = Full.Marks, Tutorial.Marks.Obtained = Marks.Obtained,
                    Group.Project.Full.Marks = Full.Marks.1, Group.Project.Obtained.Marks = Marks.Obtained.1,
                    Assignment.Full.Marks = Full.Marks.2, Assignment.Marks.Obtained = Marks.Obtained.2,
                    Mid.Term.Full.Marks = Full.Marks.3, Mid.Term.Marks.Obtained = Marks.Obtained.3, Mid.Term.FifteenPercent.Marks = Marks.Obtained.4,
                    Lab.Test.Full.Marks = Full.Marks.4, Lab.Test.Marks.Obtained = Marks.Obtained.5, Lab.Test.FifteenPercent.Marks = Marks.Obtained.6,
                    FinalExam.Full.Marks = Full.Marks.5, Final.Exam.Marks.Obtained = Marks.Obtained.7, Final.Exam.FortyPercent.Marks = Marks.Obtained..40.)

colnames(df)

# Since Tutorials and Group Project are not used while calculating Internal marks we can exclude it from datasets
df <- select(df, -c(Tutorial.Full.Marks, Tutorial.Marks.Obtained, Group.Project.Full.Marks, Group.Project.Obtained.Marks))

uniqueGrades <- getUniqueAttribute(df$Grade)

gradeDf <- data.frame()

for (u in uniqueGrades) {
  gradeDf <- rbind(gradeDf, 
                   data.frame(
                     NoOfStudent = df %>% filter(Grade == u) %>% count(Grade)
                   ))
}

gradeDf <- sortInAscendingOrder(gradeDf, gradeDf$NoOfStudent.n)

plotBarGraph(df = gradeDf, x = gradeDf$NoOfStudent.Grade, y = gradeDf$NoOfStudent.n, label = gradeDf$NoOfStudent.n, 
             title = 'No of student on basics of grade',
             xlab = 'Grade', ylab = 'Total No of Student')

newdf <- findTopTen(df, df$Grade.Point)
