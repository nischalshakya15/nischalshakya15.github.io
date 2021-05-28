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

setwd('/home/nischal/repository/personal/nischalshakya15.github.io/thesis')

source('src/utils/utils.R')

vg_sales_df <- read.csv(file = 'data-sets/vgsales-processed.csv', sep = ',', dec = '.')
sales_genre_year_df <- read.csv(file = 'data-sets/vg_sales_genre_year_wise.csv', sep = ',', dec = '.')

class(sales_genre_year_df$Year)

year_unique_df <- unique(vg_sales_df$Year)

df <- data.frame()

for (y in year_unique_df) {
  date.end.month <- seq(as.Date(paste(y + 1, '01', '02', sep = '-')), length = 1, by = 'year') - 2
  df <- rbind(df, sales_genre_year_df %>%
    filter(Year == y) %>%
    dplyr::mutate(Year = date.end.month))
}

ggplot(df %>% filter(Genre == 'Action'), aes(x = Year, y = Sales, group = Genre, color = Genre)) +
  geom_line() +
  geom_point(shape = 21, color = 'black', fill = "#69b3a2", size = 2) +
  geom_smooth(method = 'loess', se = FALSE, span = 0.6) +
  scale_color_brewer(palette = 'Dark2')

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
  ),
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
      geom_smooth(method = 'loess', se = FALSE, span = 0.6) +
      scale_color_brewer(palette = 'Dark2')
  })
}

shinyApp(ui, server)