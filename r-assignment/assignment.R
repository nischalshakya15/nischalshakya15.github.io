# Clearing enviroment variables
remove(list=ls())
# Using library dplyr for data manupulation
library('dplyr')
# Using library ggplot2 
library('ggplot2')

source('./utils.R')

# Set current working directory 
setwd('/home/nischal/nischalshakya15.github.io/r-assignment')

# Load data from csv file into data frame
data <- read.csv('input.csv', sep = ',', header = TRUE, stringsAsFactors = FALSE)

# Remove Zone Bagmati and Development Region beacuse it is redudant
data <- select(data, -c(Zone, Development.Region, School.Number, School.Code, ENGLISH, NEPALI, MATHS, SCIENCE, SOCIAL.STUDIES, HEALTH.POPULATION.AND.ENVIRONMENT))

# Calculate fail percentage
data <- data %>% mutate('FAIL.PERCENTAGE' = 100 - data$PASS.PERCENT)

# Get total number of student
data <- data %>% mutate('TOTAL.NO.OF.STUDENT' = data$PASS + data$FAIL)
 
# Get information about data type used in csv
str(data)

summary(data)

# Get unique districts from data frame
districts <- c(unique(data$District))
 
# Initialize an empty data frame 
totalNoOfStudentDataFrame <- data.frame()

hundredPercentPassPercentDataFrame <- data.frame()

failPercentDataFrame <- data.frame()
zeroDistinctionFailPercentDataFrame <- data.frame()
distinctionFailPercentDataFrame <- data.frame()
totalGradeOfZeroDistinctionFailPercentDataFrame <- data.frame()
totalGradeOfDistinctionFailPercentDataFrame <- data.frame()
totalGradeOfZeroDistinctionBarChartDf <- data.frame()
totalGradeOfDistinctionFailPercentBarChartDf <- data.frame()

schoolGradeOfHundredPassPercentWithDistinctionDataFrame <- data.frame()
schoolGradeOfHundredPassPercentWithoutDistinctionDataFrame <- data.frame()

for (d in districts) {
  
  filterDistrict <- filter(data, District == d)
  

  totalNoOfStudentDataFrame <- rbind(totalNoOfStudentDataFrame, data.frame(District = d,
      
                                                                           Distinction = filterDistrict %>% select(DISTINCTION) %>% sum(),
                                                                           FirstDivision = filterDistrict %>% select(FIRST.DIVISION) %>% sum(),
                                                                           SecondDivision = filterDistrict %>% select(SECOND.DIVISION) %>% sum(),
                                                                           ThirdDivision = filterDistrict %>% select(THIRD.DIVISION) %>% sum(),
                                                                           Pass = filterDistrict %>% select(PASS) %>% sum(),
                                                                           Fail = filterDistrict %>% select(FAIL) %>% sum(),
                                                                           Total = filterDistrict %>% select(PASS,FAIL) %>% sum()))
  
  hundredPercentPassPercentDataFrame <- rbind(hundredPercentPassPercentDataFrame, 
                                              filter(data, District == d & FAIL == 0 & PASS.PERCENT == max(PASS.PERCENT)))
  
  failPercentDataFrame <- rbind(failPercentDataFrame, filter(data, District == d & FAIL != 0 & FAIL.PERCENTAGE != 0.0))
  
  
  zeroDistinctionFailPercentDataFrame <- rbind(zeroDistinctionFailPercentDataFrame, filter(failPercentDataFrame, District == d & DISTINCTION == 0))
  
  filterDistrictOfZeroDistinctionFailPercentDataFrame <- filter(zeroDistinctionFailPercentDataFrame, District == d)
  
  totalGradeOfZeroDistinctionFailPercentDataFrame <- rbind(totalGradeOfZeroDistinctionFailPercentDataFrame,
                                                           data.frame(
                                                             District = d, 
                                                             Distinction = filterDistrictOfZeroDistinctionFailPercentDataFrame %>% select(DISTINCTION) %>% sum(),
                                                             FirstDivision = filterDistrictOfZeroDistinctionFailPercentDataFrame %>% select(FIRST.DIVISION) %>% sum(),
                                                             SecondDivision = filterDistrictOfZeroDistinctionFailPercentDataFrame %>% select(SECOND.DIVISION) %>% sum(),
                                                             ThirdDivision = filterDistrictOfZeroDistinctionFailPercentDataFrame %>% select(THIRD.DIVISION) %>% sum(),
                                                             Total = filterDistrictOfZeroDistinctionFailPercentDataFrame %>% select(DISTINCTION,FIRST.DIVISION,SECOND.DIVISION,THIRD.DIVISION) %>% sum()))
  
  totalGradeOfZeroDistinctionBarChartDf <- rbind(totalGradeOfZeroDistinctionBarChartDf,
                                                                   data.frame(
                                                                     District = c(rep(d, 3)),
                                                                     Grade = c(rep("FirstDivision", 1), rep("SecondDivision", 1), rep("ThirdDivision",1)),
                                                                     NoOfStudent = c(filterDistrictOfZeroDistinctionFailPercentDataFrame %>% select(FIRST.DIVISION) %>% sum(), 
                                                                                     filterDistrictOfZeroDistinctionFailPercentDataFrame %>% select(SECOND.DIVISION) %>% sum(),
                                                                                     filterDistrictOfZeroDistinctionFailPercentDataFrame %>% select(THIRD.DIVISION) %>% sum()
                                                                     )
                                                                   ))
  
  distinctionFailPercentDataFrame <- rbind(distinctionFailPercentDataFrame, filter(failPercentDataFrame, District == d & DISTINCTION != 0))
  
  filterDistrictOfDistinctionFailPercentDataFrame <- filter(distinctionFailPercentDataFrame, District == d)
  
  totalGradeOfDistinctionFailPercentDataFrame <- rbind(totalGradeOfDistinctionFailPercentDataFrame, 
                                                       data.frame(
                                                         District = d, 
                                                         Distinction = filterDistrictOfDistinctionFailPercentDataFrame %>% select(DISTINCTION) %>% sum(),
                                                         FirstDivision = filterDistrictOfDistinctionFailPercentDataFrame %>% select(FIRST.DIVISION) %>% sum(),
                                                         SecondDivision = filterDistrictOfDistinctionFailPercentDataFrame %>% select(SECOND.DIVISION) %>% sum(),
                                                         ThirdDivision = filterDistrictOfDistinctionFailPercentDataFrame %>% select(THIRD.DIVISION) %>% sum(),
                                                         Total = filterDistrictOfDistinctionFailPercentDataFrame %>% select(DISTINCTION,FIRST.DIVISION,SECOND.DIVISION,THIRD.DIVISION) %>% sum()))
  
  totalGradeOfDistinctionFailPercentBarChartDf  <- rbind(totalGradeOfDistinctionFailPercentBarChartDf,
                                                         data.frame(
                                                           District = c(rep(d, 4)),
                                                           Grade = c(rep("Distinction", 1), rep("FirstDivision", 1), rep("SecondDivison",1), rep("ThirdDivision",1)),
                                                           NoOfStudent = c(filterDistrictOfDistinctionFailPercentDataFrame %>% select(DISTINCTION) %>% sum(), 
                                                                           filterDistrictOfDistinctionFailPercentDataFrame %>% select(FIRST.DIVISION) %>% sum(),
                                                                           filterDistrictOfDistinctionFailPercentDataFrame %>% select(SECOND.DIVISION) %>% sum(),
                                                                           filterDistrictOfDistinctionFailPercentDataFrame %>% select(THIRD.DIVISION) %>% sum())
                                                         ))
    
  schoolGradeOfHundredPassPercentWithoutDistinctionDataFrame <- rbind(schoolGradeOfHundredPassPercentWithoutDistinctionDataFrame, 
                                                                   filter(hundredPercentPassPercentDataFrame, District == d & DISTINCTION == 0))
  
  schoolGradeOfHundredPassPercentWithDistinctionDataFrame <- rbind(schoolGradeOfHundredPassPercentWithDistinctionDataFrame,
                                                                      filter(hundredPercentPassPercentDataFrame, District == d & DISTINCTION != 0))
}

# Plot bar graph showing total no of student in each district
ggplot(totalNoOfStudentDataFrame, aes(x = District, y = Total, label = Total)) + geom_bar(stat = 'identity', fill = "darkred", color = 'black') + geom_text(size = 3, vjust = -1) + labs(title = 'Total no of student in each district') + xlab('Districts') + ylab('Total No of Student')

# Count no of school on basics of district
countNoofSchoolOnBasiscOfDistrict <- count(data, data$District)

# load countNoOfSchoolOnBasicsOfDistrict in donut dataframe
donut <- data.frame(
  District=countNoofSchoolOnBasiscOfDistrict$`data$District`,
  Count=countNoofSchoolOnBasiscOfDistrict$n
)

# Compute percentages
donut$fraction <- donut$Count / sum(donut$Count)

# Compute the cumulative percentages (top of each rectangle)
donut$ymax <- cumsum(donut$fraction)

# Compute the bottom of each rectangle
donut$ymin <- c(0, head(donut$ymax, n=-1))

# Compute label position
donut$labelPosition <- (donut$ymax + donut$ymin) / 2

# Compute a good label
donut$label <- paste0(donut$Count)

# Create donut 
ggplot(donut, aes(ymax=ymax, ymin=ymin, xmax=4, xmin=3, fill=District)) +
  geom_rect() +
  geom_text( x=3.5, aes(y=labelPosition, label=label), size=3) + # x here controls label position (inner / outer)
  scale_fill_brewer(palette=3) +
  scale_color_brewer(palette=3) +
  coord_polar(theta="y") +
  xlim(c(1, 4)) +
  theme_void() +
  theme(legend.position = "right")

# Count no of school on basics of geographical region
countNoofSchoolOnBasiscOfGeographicalRegion <- count(data, data$Geographical.Region)
# Plot bar graph showing total no of student on basics of geographical region 
ggplot(countNoofSchoolOnBasiscOfGeographicalRegion, aes(x = countNoofSchoolOnBasiscOfGeographicalRegion$`data$Geographical.Region`, y = countNoofSchoolOnBasiscOfGeographicalRegion$n, label = countNoofSchoolOnBasiscOfGeographicalRegion$n)) + geom_bar(stat = 'identity', fill = 'steelblue', color = 'black', width = 0.3) + geom_text(size = 3, vjust = -1) + labs(title = 'Total no of student in each district') + xlab('Geographical region') + ylab('Total No of Student')

# Count no of school having 100% pass result
noOfSchoolWithHundredPercentPass <- count(hundredPercentPassPercentDataFrame, hundredPercentPassPercentDataFrame$District)
# Plot bar graph showing total no of school with 100% pass result 
ggplot(noOfSchoolWithHundredPercentPass, aes(x = noOfSchoolWithHundredPercentPass$`hundredPercentPassPercentDataFrame$District`, 
                                         y = noOfSchoolWithHundredPercentPass$n, label = noOfSchoolWithHundredPercentPass$n)) + 
                                         geom_bar(stat = 'identity',fill = 'steelblue', color = 'black', width = 0.5) + 
                                         geom_text(size = 3, vjust = -1) + 
                                         labs(title = 'Total no of school with 100% pass result') + 
                                         xlab('District') + 
                                         ylab('Total No of School')

# Count no of student scoring Distinction, 1st Division, 2nd Division and 3rd Division within 100% pass result
# Initialize an empty data frame 
totalGradeOfHundredPassPercentWithDistinction <- data.frame()
totalGradeOfHundredPassPercentWithDistinctionBarchartDf <- data.frame()

# Filtering unique district of hundred pass percent with distinction 
districtsHundredPassPercentWithDistinction <- c(unique(schoolGradeOfHundredPassPercentWithDistinctionDataFrame$District))

for (d in districtsHundredPassPercentWithDistinction) {
  
  filterDistrict <- filter(schoolGradeOfHundredPassPercentWithDistinctionDataFrame, District == d)
  
  totalGradeOfHundredPassPercentWithDistinction <- rbind(totalGradeOfHundredPassPercentWithDistinction, 
                                                         data.frame(
                                                           District = d, 
                                                           Distinction = filterDistrict %>% select(DISTINCTION) %>% sum(),
                                                           FirstDivision = filterDistrict %>% select(FIRST.DIVISION) %>% sum(),
                                                           SecondDivision = filterDistrict %>% select(SECOND.DIVISION) %>% sum(),
                                                           ThirdDivision = filterDistrict %>% select(THIRD.DIVISION) %>% sum(),
                                                           Total = filterDistrict %>% select(DISTINCTION,FIRST.DIVISION,SECOND.DIVISION,THIRD.DIVISION) %>% sum()))
  
  totalGradeOfHundredPassPercentWithDistinctionBarchartDf <- rbind(totalGradeOfHundredPassPercentWithDistinctionBarchartDf,
                                                                   data.frame(
                                                                     District = c(rep(d, 3)),
                                                                     Grade = c(rep("Distinction", 1), rep("FirstDivision", 1), rep("SecondDivison",1)),
                                                                     NoOfStudent = c(filterDistrict %>% select(DISTINCTION) %>% sum(), 
                                                                                     filterDistrict %>% select(FIRST.DIVISION) %>% sum(),
                                                                                     filterDistrict %>% select(SECOND.DIVISION) %>% sum()
                                                                     )
                                                                   ))
  
}

# Plot grouped barchart showing no of student in grade with 100% pass result without district kathmandu
ggplot(filter(totalGradeOfHundredPassPercentWithDistinctionBarchartDf, District != 'Kathmandu'), 
       aes(fill=Grade, 
           y=NoOfStudent, 
           x=District,
           label=NoOfStudent)) + 
  geom_bar(position='dodge', stat='identity') +
  xlab('District') + 
  ylab('Total No of Student')

# Plot grouped barchart showing no of student in grade with 100% pass result without district Nuwakot and Dhading
ggplot(filter(totalGradeOfHundredPassPercentWithDistinctionBarchartDf, District != 'Nuwakot' & District != 'Dhading'), 
       aes(fill=Grade, 
           y=NoOfStudent, 
           x=District,
           label=NoOfStudent)) + 
  geom_bar(position='dodge', stat='identity') +
  xlab('District') + 
  ylab('Total No of Student')


# Initialize an empty dataframe 
totalGradeOfHundredPassPercentWithoutDistinction <- data.frame()
totalGradeOfHundredPassPercentWithoutDistinctionBarchartDf <- data.frame()
# Filtering unique district of hundred pass percent without distinction 
districtsHundredPassPercentWithoutDistinction <- c(unique(schoolGradeOfHundredPassPercentWithoutDistinctionDataFrame$District))

for (d in districtsHundredPassPercentWithoutDistinction) {
  
  filterDistrict <- filter(schoolGradeOfHundredPassPercentWithoutDistinctionDataFrame, District == d)
  
  totalGradeOfHundredPassPercentWithoutDistinction <- rbind(totalGradeOfHundredPassPercentWithoutDistinction, data.frame(
                                                                           District = d, 
                                                                           Distinction = filterDistrict %>% select(DISTINCTION) %>% sum(),
                                                                           FirstDivision = filterDistrict %>% select(FIRST.DIVISION) %>% sum(),
                                                                           SecondDivision = filterDistrict %>% select(SECOND.DIVISION) %>% sum(),
                                                                           ThirdDivision = filterDistrict %>% select(THIRD.DIVISION) %>% sum(),
                                                                           Total = filterDistrict %>% select(DISTINCTION,FIRST.DIVISION,SECOND.DIVISION,THIRD.DIVISION) %>% sum()))
  
  totalGradeOfHundredPassPercentWithoutDistinctionBarchartDf <- rbind(totalGradeOfHundredPassPercentWithoutDistinctionBarchartDf,
                                                                   data.frame(
                                                                     District = c(rep(d, 4)),
                                                                     Grade = c(rep("Distinction", 1), rep("FirstDivision", 1), rep("SecondDivison",1), rep("ThirdDivision",1)),
                                                                     NoOfStudent = c(filterDistrict %>% select(DISTINCTION) %>% sum(), 
                                                                                     filterDistrict %>% select(FIRST.DIVISION) %>% sum(),
                                                                                     filterDistrict %>% select(SECOND.DIVISION) %>% sum(),
                                                                                     filterDistrict %>% select(THIRD.DIVISION) %>% sum())
                                                                   )
  )
}

# Plot grouped barchart showing no of student in grade with 100% pass result without district kathmandu
ggplot(totalGradeOfHundredPassPercentWithoutDistinctionBarchartDf, 
       aes(fill=Grade, 
           y=NoOfStudent, 
           x=District,
           label=NoOfStudent)) + 
  
  geom_bar(position='dodge', stat='identity') +
  xlab('District') + 
  ylab('Total No of Student')

# Since, in hundred pass percent data set it is natural that the school having highest number of student is the school scoring the highest pass rate. As well as, since
# total no of student is not same in every school so we can't compare the grade 

# Initialize an empty data frame for school having highest number of student 
passSchoolWithMaxStudentDataFrame <- data.frame()

for (d in districts) {
  filterDistrict <- filter(hundredPercentPassPercentDataFrame, District == d)
  
  passSchoolWithMaxStudentDataFrame <- rbind(passSchoolWithMaxStudentDataFrame, filterDistrict %>% filter(TOTAL.NO.OF.STUDENT == max(TOTAL.NO.OF.STUDENT)))
}

# Plot grouped barchart showing no of student in grade having fail percentage with distinction
ggplot(totalGradeOfDistinctionFailPercentBarChartDf, 
       aes(fill=Grade, 
           y=NoOfStudent, 
           x=District,
           label=NoOfStudent)) + 
  geom_bar(position='dodge', stat='identity') +
  xlab('District') + 
  ylab('Total No of Student')

# Plot grouped barchart showing no of student in grade having fail percentage without distinction
ggplot(totalGradeOfZeroDistinctionBarChartDf, 
       aes(fill=Grade, 
           y=NoOfStudent, 
           x=District,
           label=NoOfStudent)) + 
  geom_bar(position='dodge', stat='identity') +
  xlab('District') + 
  ylab('Total No of Student')

failSchoolWithMaxStudentDataFrame <- data.frame()

for (d in districts) {
  filterDistrict <- filter(distinctionFailPercentDataFrame, District == d)
  
  failSchoolWithMaxStudentDataFrame <- rbind(failSchoolWithMaxStudentDataFrame, filterDistrict %>% select(District, Name.of.School, PASS, FAIL) %>% filter(PASS == max(PASS)))
}

arrange(failSchoolWithMaxStudentDataFrame, PASS)

