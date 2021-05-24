remove(list = ls())

library('magrittr')
library('dplyr')
library('shiny')
library('shinythemes')
library('reader')

setwd('/home/nischal/repository/personal/nischalshakya15.github.io/thesis')

# Read data from csv file
data <- read.csv('data-sets/vgsales-12-4-2019.csv', stringsAsFactors = FALSE)

df <- data %>%
  select(Name, Genre, Platform, Publisher, Developer,
         Global_Sales, NA_Sales, JP_Sales, PAL_Sales, Other_Sales, Year) %>%
  filter(
    data$Year %in% (2000:2020) &
      !is.na(data$Global_Sales) & data$Global_Sales != 0.00 &
      (data$Platform == 'PC' |
        data$Platform == 'PS2' |
        data$Platform == 'PS3' |
        data$Platform == 'PS4' |
        data$Platform == 'XOne' |
        data$Platform == 'XB')) %>%
  arrange(Year)

# Define UI
ui <- fluidPage(theme = shinytheme('lumen'),
                titlePanel('Predictive Model using R'),
                fluidRow(
                  column(3, align = 'left', offset = 1, selectInput(inputId = 'type', label = strong('Select Year'),
                                                                    choices = unique(df$Year), selected = '2001')
                  ),
                  column(3, selectInput(inputId = 'genre', label = strong('Select Genre'),
                                        choices = unique(df$Genre), selected = 'Action')
                  ),
                  column(3, selectInput(inputId = 'platform', label = strong('Select Platform'),
                                        choices = unique(df$Platform), selected = 'PC')
                  )

                ),
                fluidRow(column(8, align = 'center', offset = 0, dataTableOutput(outputId = "table")))
)

# Define Server
server <- function(input, output) {
  output$table <- renderDataTable(df %>% filter(df$Year == input$type &
                                                  df$Genre == input$genre &
                                                  df$Platform == input$platform),
                                  options = list(pageLength = 10, autoWidth = TRUE))
}

# Create Shiny object
shinyApp(ui = ui, server = server)