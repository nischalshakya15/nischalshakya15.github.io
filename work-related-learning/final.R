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

common <- intersect(javaProgrammingOneDf$Name, javaTwoDf$Name)

print(common)

javaTwoDf[javaTwoDf$Name %in% javaProgrammingOneDf$Name,]


print(javaProgrammingOneDf)



