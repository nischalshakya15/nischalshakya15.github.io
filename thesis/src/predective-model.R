remove(list = ls())

library('magrittr')
library('dplyr')
library('shiny')
library('shinythemes')
library('reader')

setwd('/home/nischal/repository/personal/nischalshakya15.github.io/thesis')

# Read data from csv file
data <- read.csv('data-sets/vgsales-12-4-2019.csv', stringsAsFactors = FALSE)

# Select only the required columns
df <- data %>%
  select(Name, Genre, Platform, Publisher, Developer, Total_Shipped,
         Global_Sales, NA_Sales, PAL_Sales, JP_Sales, Other_Sales, Year) %>%
  filter(data$Year %in% (2009:2017) & (data$Platform == 'PC' |
    data$Platform == 'PS4' |
    data$Platform == 'PS3' |
    data$Platform == 'PS2' |
    data$Platform == 'XOne' |
    data$Platform == 'XB')) %>%
  arrange(Year)
# Select the ranege from 2009 to 2014
df_2009_to_2014 <- df %>%
  filter(df$Year %in% (2009:2014))
# Select the range from 2015 to 2018
df_2015_to_2018 <- df %>%
  filter(df$Year %in% (2015:2017)) %>%
  arrange(Year)

# Define UI
ui <- fluidPage(theme = shinytheme('lumen'),
                titlePanel('Predictive Model using R'),
                fluidRow(
                  column(3, selectInput(inputId = 'type', label = strong('Select Year'),
                                        choices = unique(df$Year), selected = '2012')
                  ),
                  column(3, selectInput(inputId = 'genre', label = strong('Select Genre'),
                                        choices = unique(df$Genre), selected = 'Action')
                  ),
                  column(3, selectInput(inputId = 'platform', label = strong('Select Platform'),
                                        choices = unique(df$Platform), selected = 'PC')
                  )
                ),
                fluidRow(column(5, dataTableOutput(outputId = "table")))
)

# Define Server
server <- function(input, output) {
  output$table <- renderDataTable(df %>% filter(df$Year == input$type &
                                                  df$Genre == input$genre &
                                                  df$Platform == input$platform))
}

# Create Shiny object
shinyApp(ui = ui, server = server)