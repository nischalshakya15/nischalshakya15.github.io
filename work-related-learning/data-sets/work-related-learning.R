remove(list = ls())

library('dplyr')

library('ggplot2')

source('./utils.R')

setwd('/home/nischal/nischalshakya15.github.io/work-related-learning')

# R code for Java Programming One
javaProgrammingOneDf <- read.csv('data-sets/JavaProgrammingOne.csv')

colnames(javaProgrammingOneDf)

# Give meaning ful row names
javaProgrammingOneDf <- javaProgrammingOneDf %>% rename(
                        Tutorial.Full.Marks = Full.Marks, Tutorial.Marks.Obtained = Marks.Obtained,
                        Group.Project.Full.Marks = Full.Marks.1, Group.Project.Obtained.Marks = Marks.Obtained.1,
                        Assignment.Full.Marks = Full.Marks.2, Assignment.Marks.Obtained = Marks.Obtained.2,
                        Mid.Term.Full.Marks = Full.Marks.3, Mid.Term.Marks.Obtained = Marks.Obtained.3, Mid.Term.FifteenPercent.Marks = Marks.Obtained.4,
                        Lab.Test.Full.Marks = Full.Marks.4, Lab.Test.Marks.Obtained = Marks.Obtained.5, Lab.Test.FifteenPercent.Marks = Marks.Obtained.6,
                        FinalExam.Full.Marks = Full.Marks.5, Final.Exam.Marks.Obtained = Marks.Obtained.7, Final.Exam.FortyPercent.Marks = Marks.Obtained..40.)

colnames(javaProgrammingOneDf)

# Since, tutorial marks and group project marks is not used for final calculation of internal marks we can drop it from dataframe 
javaProgrammingOneDf <- select(javaProgrammingOneDf, -c(Tutorial.Full.Marks, Tutorial.Marks.Obtained, Group.Project.Full.Marks, Group.Project.Obtained.Marks))

# filter unique grade
uniqueGradeJavaProgrammingOne <- getUniqueAttribute(javaProgrammingOneDf$Grade)

print(uniqueGradeJavaProgrammingOne)

javaProgrammingOneCountDf <- data.frame()

str(javaProgrammingOneDf)

for (u in uniqueGradeJavaProgrammingOne) {
  javaProgrammingOneCountDf <- rbind(javaProgrammingOneCountDf, 
                      data.frame(
                        NoOfStudent = javaProgrammingOneDf %>% filter(Grade == u) %>% count(Grade)
                      ))
}

#Sort the count in ascending order on basics of grade 
javaProgrammingOneCountDf <- sortInAscendingOrder(javaProgrammingOneCountDf, javaProgrammingOneCountDf$NoOfStudent.n)

plotBarGraph(df = javaProgrammingOneCountDf, x = javaProgrammingOneCountDf$NoOfStudent.Grade, 
             y = javaProgrammingOneCountDf$NoOfStudent.n, label = javaProgrammingOneCountDf$NoOfStudent.n, 
             title = 'No of student on basics of grade',
             xlab = 'Grade', ylab = 'Total No of Student')

# find top 5 student
javaProgrammingOneTopFive <- findTopTen(javaProgrammingOneDf, javaProgrammingOneDf$Grade.Point, top = 5)

# Sort on basics of grade point
javaProgrammingOneTopFive <- sortInAscendingOrder(javaProgrammingOneTopFive, javaProgrammingOneTopFive$Grade.Point)

# Total number of student attending exam
totalStudentInJavaOne <- javaProgrammingOneCountDf %>% select(NoOfStudent.n) %>% sum()

print(totalStudentInJavaOne)

# Genearate summary 
summary(javaProgrammingOneDf$Total)

# Find out standard deviation 
sd(javaProgrammingOneDf$Total)
# R code for java programming one ends 

# R code for java programming two 
javaTwoDf <- read.csv('data-sets/JavaProgrammingTwo.csv')

colnames(javaTwoDf)

javaTwoDf <- javaTwoDf %>% rename(
             Mid.Term.Full.Marks = Full.Marks, Mid.Term.Marks.Obtained = Score, Mid.Term.Fifteen.Percent.Marks = Marks.Obtained..15..,
             Lab.Test.Full.Marks = Full.Marks.1, Lab.Test.Marks.Obtained = Marks.Obtained..15...1,
             Assignment.Full.Marks = Full.Marks.2, Assignment.Marks.Obtained = Marks.Obtained..25..,
             Tutorial.Full.Marks = Full.Marks.3, Tutorial.Marks.Obtained = Marks.Obtained..5..,
             Internal.Marks = Internal.Marks..60.., 
             Final.Exam.Full.Marks = Full.Marks.4, Final.Exam.Marks.Obtained = Score.1, Final.Exam.FortyPercent.Marks = Marks.Obtained..40..,
             Total = Total..100.., 
             Grade = Grade.after.40..rule
)

colnames(javaTwoDf)

# filter unique grade
uniqueGradeJavaTwo <- getUniqueAttribute(javaTwoDf$Grade)

print(uniqueGradeJavaTwo)

javaTwoCountDf <- data.frame()

str(javaTwoDf)

for (u in uniqueGradeJavaTwo) {
  javaTwoCountDf <- rbind(javaTwoCountDf, 
                                     data.frame(
                                       NoOfStudent = javaTwoDf %>% filter(Grade == u) %>% count(Grade)
                                     ))
}

#Sort the count in ascending order on basics of grade 
javaTwoCountDf <- sortInAscendingOrder(javaTwoCountDf, javaTwoCountDf$NoOfStudent.n)

plotBarGraph(df = javaTwoCountDf, x = javaTwoCountDf$NoOfStudent.Grade, 
             y = javaTwoCountDf$NoOfStudent.n, label = javaTwoCountDf$NoOfStudent.n, 
             title = 'No of student on basics of grade',
             xlab = 'Grade', ylab = 'Total No of Student')

# find top 5 student
javaTwoTopFive <- findTopTen(javaTwoDf, javaTwoDf$Grade.Point, top = 5)

# Sort on basics of grade point
javaTwoTopFive <- sortInAscendingOrder(javaTwoTopFive, javaTwoTopFive$Grade.Point)

# Total number of student attending exam
totalStudentInJavaTwo <- javaTwoCountDf %>% select(NoOfStudent.n) %>% sum()

print(totalStudentInJavaTwo)

# Genearate summary 
summary(javaTwoDf$Total)

# Find out standard deviation 
sd(javaTwoDf$Total)

# load csv file into data frame
javaWebDf <- read.csv('data-sets/JavaWebProgramming.csv')

colnames(javaWebDf)

javaWebDf <- javaWebDf %>% rename(
             Mid.Term.Full.Marks = Full.Marks, Mid.Term.Marks.Obtained = Score, Mid.Term.Twenty.Percent.Marks = Marks.Obtained..20..,
             Individual.Assignment.Full.Marks = Full.Marks.1, Individual.Assignment.Marks.Obtained = Assignment.Score..20.,  
             Group.Assignment.Full.Marks = Full.Marks.2, Group.Assignment.Marks.Obtained = Group.Proj..Score..20.,
             Internal.Marks = Internal.Marks..60..,
             Final.Exam.Full.Marks = Full.Marks.3, Final.Exam.Marks.Obtained = Score.1, Final.Exam.FortyPercent.Marks=Marks.Obtained..40..,
             Total = Total..100.., 
             Grade = Grade.after.40..rule
)

colnames(javaWebDf)

# filter unique grade
uniqueGradeJavaWeb <- getUniqueAttribute(javaWebDf$Grade)

print(uniqueGradeJavaWeb)

javaWebCountDf <- data.frame()

str(javaWebDf)

for (u in uniqueGradeJavaWeb) {
  javaWebCountDf <- rbind(javaWebCountDf, 
                          data.frame(
                            NoOfStudent = javaWebDf %>% filter(Grade == u) %>% count(Grade)
                          ))
}

#Sort the count in ascending order on basics of grade 
javaWebCountDf <- sortInAscendingOrder(javaWebCountDf, javaWebCountDf$NoOfStudent.n)

plotBarGraph(df = javaWebCountDf, x = javaWebCountDf$NoOfStudent.Grade, 
             y = javaWebCountDf$NoOfStudent.n, label = javaWebCountDf$NoOfStudent.n, 
             title = 'No of student on basics of grade',
             xlab = 'Grade', ylab = 'Total No of Student')

# find top 5 student
javaWebTopFive <- findTopTen(javaWebDf, javaWebDf$Grade.Point, top = 5)

# Sort on basics of grade point
javaWebTopFive <- sortInAscendingOrder(javaWebTopFive, javaWebTopFive$Grade.Point)

# Total number of student attending exam
totalStudentInJavaWeb <- javaWebCountDf %>% select(NoOfStudent.n) %>% sum()

print(totalStudentInJavaWeb)

# Genearate summary 
summary(javaWebDf$Total)

# Find out standard deviation 
sd(javaWebDf$Total)