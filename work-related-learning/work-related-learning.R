remove(list = ls())

library('dplyr')

library('ggplot2')

source('./utils.R')

setwd('/home/nischal/nischalshakya15.github.io/work-related-learning')

dfJan <- read.csv('data-sets/2018/Jan/JavaProgrammingOne1stSem.csv')

colnames(dfJan)

#Rename columns 
dfJan <- dfJan %>% rename(Tutorial.Full.Marks = Full.Marks, Tutorial.Marks.Obtained = Marks.Obtained,
                    Group.Project.Full.Marks = Full.Marks.1, Group.Project.Obtained.Marks = Marks.Obtained.1,
                    Assignment.Full.Marks = Full.Marks.2, Assignment.Marks.Obtained = Marks.Obtained.2,
                    Mid.Term.Full.Marks = Full.Marks.3, Mid.Term.Marks.Obtained = Marks.Obtained.3, Mid.Term.FifteenPercent.Marks = Marks.Obtained.4,
                    Lab.Test.Full.Marks = Full.Marks.4, Lab.Test.Marks.Obtained = Marks.Obtained.5, Lab.Test.FifteenPercent.Marks = Marks.Obtained.6,
                    FinalExam.Full.Marks = Full.Marks.5, Final.Exam.Marks.Obtained = Marks.Obtained.7, Final.Exam.FortyPercent.Marks = Marks.Obtained..40.)

colnames(dfJan)

# Since Tutorials and Group Project are not used while calculating Internal marks we can exclude it from datasets
dfJan <- select(dfJan, -c(Tutorial.Full.Marks, Tutorial.Marks.Obtained, Group.Project.Full.Marks, Group.Project.Obtained.Marks))

uniqueGrades <- getUniqueAttribute(dfJan$Grade)

gradedfJan <- data.frame()

for (u in uniqueGrades) {
  gradedfJan <- rbind(gradedfJan, 
                   data.frame(
                     NoOfStudent = dfJan %>% filter(Grade == u) %>% count(Grade)
                   ))
}

gradedfJan <- sortInAscendingOrder(gradedfJan, gradedfJan$NoOfStudent.n)

plotBarGraph(df = gradedfJan, x = gradedfJan$NoOfStudent.Grade, y = gradedfJan$NoOfStudent.n, label = gradedfJan$NoOfStudent.n, 
             title = 'No of student on basics of grade',
             xlab = 'Grade', ylab = 'Total No of Student')

topTendfJan <- findTopTen(dfJan, dfJan$Grade.Point)

summary(dfJan$Total.Marks)

sd(dfJan$Total.Marks)


# 2nd semster student 
dfJan2ndSem <- read.csv('data-sets/2018/Jan/JavaProgrammingOne2ndSem.csv')

dfJan2ndSem <- dfJan2ndSem %>% rename(Tutorial.Full.Marks = Full.Marks, Tutorial.Marks.Obtained = Marks.Obtained,
                                      Group.Project.Full.Marks = Full.Marks.1, Group.Project.Obtained.Marks = Marks.Obtained.1,
                                      Assignment.Marks.Obtained = Marks.Obtained.2,
                                      Mid.Term.Full.Marks = Full.Marks.2, Mid.Term.Marks.Obtained = Marks.Obtained.3, Mid.Term.FifteenPercent.Marks = Marks.Obtained.4,
                                      Lab.Test.Full.Marks = Full.Marks.3, Lab.Test.Marks.Obtained = Marks.Obtained.5, Lab.Test.FifteenPercent.Marks = Marks.Obtained.6,
                                      FinalExam.Full.Marks = Full.Marks.4, Final.Exam.Marks.Obtained = Marks.Obtained.7, Final.Exam.FortyPercent.Marks = Marks.Obtained..40.)

colnames(dfJan2ndSem)

dfJan2ndSem <- select(dfJan2ndSem, -c(Tutorial.Full.Marks, Tutorial.Marks.Obtained, Group.Project.Full.Marks, Group.Project.Obtained.Marks))

uniqueGradeJan2ndSem <- getUniqueAttribute(dfJan2ndSem$Grade)

print(uniqueGradeJan2ndSem)

gradedfJan2ndSem <- data.frame()

for (u in uniqueGradeJan2ndSem) {
  gradedfJan2ndSem <- rbind(gradedfJan2ndSem, 
                      data.frame(
                        NoOfStudent = dfJan2ndSem %>% filter(Grade == u) %>% count(Grade)
                      ))
}

gradedfJan2ndSem <- sortInAscendingOrder(gradedfJan2ndSem, gradedfJan2ndSem$NoOfStudent.n)

plotBarGraph(df = gradedfJan2ndSem, x = gradedfJan2ndSem$NoOfStudent.Grade, y = gradedfJan2ndSem$NoOfStudent.n, label = gradedfJan2ndSem$NoOfStudent.n, 
             title = 'No of student on basics of grade',
             xlab = 'Grade', ylab = 'Total No of Student')

topTendfJan <- findTopTen(dfJan2ndSem, dfJan2ndSem$Grade.Point)

summary(dfJan2ndSem$Total)

sd(dfJan2ndSem$Total)