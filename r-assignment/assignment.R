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
data <- select(data, -c(Zone, Development.Region))
 
districtWiseData <- getFilterData(data = data, filterColumn = 'District', filterValue = 'Nuwakot')

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

# Plot bar graph showing total no of student in each district
ggplot(totalNoOfStudentDataFrame, aes(x = District, y = Total, label = Total)) + geom_bar(stat = 'identity', fill = 'steelblue', color = 'black') + geom_text(size = 3, vjust = -1) + labs(title = 'Total no of student in each district') + xlab('Districts') + ylab('Total No of Student')

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
ggplot(noOfSchoolWithHundredPercentPass, aes(x = noOfSchoolWithHundredPercentPass$`hundredPercentPassPercentDataFrame$District`, y = noOfSchoolWithHundredPercentPass$n, label = noOfSchoolWithHundredPercentPass$n)) + geom_bar(stat = 'identity', fill = 'steelblue', color = 'black', width = 0.5) + geom_text(size = 3, vjust = -1) + labs(title = 'Total no of school with 100% pass result') + xlab('District') + ylab('Total No of School')


