remove(list = ls())

library('magrittr')
library('dplyr')
library('reader')
library('tidyr')
library('ggplot2')
library('RColorBrewer')
library('lubridate')
library('shiny')
library('shinythemes')
library('forecast')

setwd('/home/nischal/repository/personal/nischalshakya15.github.io/thesis')

source('src/utils/utils.R')

df <- read.csv(file = 'data-sets/vg_sales_genre_year_wise.csv', sep = ',', dec = '.')

ggplot(df %>% filter(Genre == 'Action'), aes(x = Year, y = Sales, group = Genre, color = Genre)) +
  geom_line() +
  geom_point(shape = 21, color = 'black', fill = "#69b3a2", size = 2) +
  geom_smooth(method = 'loess', se = FALSE, span = 0.6) +
  scale_color_brewer(palette = 'Dark2')

yearly_genre_sales_df <- ts(df %>%
                              filter(Genre == 'Strategy') %>%
                              select(Year, Sales), start = 2000, end = 2020, frequency = 1)

ui <- fluidPage(
  titlePanel('Predictive Model Using R'),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = 'Genre', label = strong('Genre'),
                  choices = unique(df$Genre), selected = 'Action'
      )
    ),
    mainPanel(
      plotOutput(outputId = 'ScatterChart')
    )
  )
)

server <- function(input, output) {
  output$ScatterChart <- renderPlot({
    ggplot(df %>% filter(Genre == input$Genre), aes(x = Year, y = Sales, group = Genre, color = Genre)) +
      geom_line() +
      geom_point(shape = 21, color = 'black', fill = "#69b3a2", size = 2) +
      scale_color_brewer(palette = 'Dark2')
  })
}

shinyApp(ui, server)