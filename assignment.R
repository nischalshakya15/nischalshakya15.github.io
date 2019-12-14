# Clearing enviroment variables
remove(list=ls())
# Using library dplyr for data manupulation
library('dplyr')
# Using library ggplot2 
library('ggplot2')

# Set current working directory 
setwd('/home/nischalshakya/data-analysis-assignment')

# Load data from csv file into data frame
data <- read.csv('input.csv', sep = ',', header = TRUE, stringsAsFactors = FALSE)

# Remove Zone Bagmati and Development Region beacuse it is redudant
data <- select(data, -c(Zone, Development.Region))

# Calculate fail percentage
data <- data %>% mutate('FAIL.PERCENTAGE' = 100 - data$PASS.PERCENT)

# Get information about data type used in csv
str(data)

# Get unique districts from data frame
districts <- c(unique(data$District))

# Initialize an empty data frame 
distinctionDataFrame <- data.frame();
hundredPercentPassPercentDataFrame <- data.frame();
totalNoOfStudentDataFrame <- data.frame();

for (d in districts) {
  
  filterDistrict <- filter(data, District == d)
  
  row = data.frame(District = d,
                   Pass = filterDistrict %>% select(PASS) %>% sum(),
                   Fail = filterDistrict %>% select(FAIL) %>% sum(),
                   Total = filterDistrict %>% select(PASS,FAIL) %>% sum())
  
  totalNoOfStudentDataFrame <- rbind(totalNoOfStudentDataFrame, row)

  distinctionDataFrame <- rbind(distinctionDataFrame, filter(data, District == d & DISTINCTION == max(DISTINCTION)))
  
  hundredPercentPassPercentDataFrame <- rbind(hundredPercentPassPercentDataFrame, filter(data, District == d & FAIL == 0 & PASS.PERCENT == max(PASS.PERCENT)))
}

# Generating bar graph showing total no of student in each district
ggplot(totalNoOfStudentDataFrame, aes(x = District, y = Total, label = Total)) + geom_bar(stat = 'identity', fill = 'steelblue', color = 'black') + geom_text(size = 3, vjust = -1) + labs(title = 'Total no of student in each district') + xlab('Districts') + ylab('Total No of Student')

# Count no of school on basics of district
countNoofSchoolOnBasiscOfDistrict <- count(data, data$District)

# Generating pie-chart
ggplot(countNoofSchoolOnBasiscOfDistrict, aes(x="", y=countNoofSchoolOnBasiscOfDistrict$n, fill=countNoofSchoolOnBasiscOfDistrict$`data$District`)) +
  geom_bar(stat="identity", width=1, color="white") +
  coord_polar("y", start=0) + theme_void()

# Count no of school on basics of geographical region
countNoofSchoolOnBasiscOfGeographicalRegion <- count(data, data$Geographical.Region)
# Generating bar graph showing total no of student on basics of geographical region 
ggplot(countNoofSchoolOnBasiscOfGeographicalRegion, aes(x = countNoofSchoolOnBasiscOfGeographicalRegion$`data$Geographical.Region`, y = countNoofSchoolOnBasiscOfGeographicalRegion$n, label = countNoofSchoolOnBasiscOfGeographicalRegion$n)) + geom_bar(stat = 'identity', fill = 'steelblue', color = 'black', width = 0.3) + geom_text(size = 3, vjust = -1) + labs(title = 'Total no of student in each district') + xlab('Geographical region') + ylab('Total No of Student')

# Count no of school having 100% pass result
noOfSchoolWithHundredPercentPass <- count(hundredPercentPassPercentDataFrame, hundredPercentPassPercentDataFrame$District)
# Generating bar graph showing total no of school with 100% pass result 
ggplot(noOfSchoolWithHundredPercentPass, aes(x = noOfSchoolWithHundredPercentPass$`hundredPercentPassPercentDataFrame$District`, y = noOfSchoolWithHundredPercentPass$n, label = noOfSchoolWithHundredPercentPass$n)) + geom_bar(stat = 'identity', fill = 'steelblue', color = 'black', width = 0.5) + geom_text(size = 3, vjust = -1) + labs(title = 'Total no of school with 100% pass result') + xlab('District') + ylab('Total No of School')

