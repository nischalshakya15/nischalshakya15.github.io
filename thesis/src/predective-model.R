remove(list = ls())

library('magrittr')
library('dplyr')
library('shiny')
library('shinythemes')
library('reader')
library('tidyr')

setwd('/home/nischal/repository/personal/nischalshakya15.github.io/thesis')

# Read data from csv file
data <- read.csv(file = 'data-sets/vgsales-12-4-2019.csv', sep = ',', dec = '.', stringsAsFactors = FALSE)

df <- data %>%
  select(Name, Genre, Platform, Publisher, Developer,
         Global_Sales, NA_Sales, JP_Sales, PAL_Sales, Other_Sales, Year) %>%
  filter(
    data$Year %in% (2000:2020) &
      !is.na(data$Global_Sales) &
      data$Global_Sales != 0.00 &
      (
        data$Platform == 'PC' |
          data$Platform == 'PS2' |
          data$Platform == 'PS3' |
          data$Platform == 'PS4' |
          data$Platform == 'XOne' |
          data$Platform == 'XB'
      )
  ) %>%
  dplyr::mutate(PAL_Sales = replace_na(PAL_Sales, 0)) %>%
  dplyr::mutate(NA_Sales = replace_na(NA_Sales, 0)) %>%
  dplyr::mutate(Other_Sales = replace_na(Other_Sales, 0)) %>%
  dplyr::mutate(JP_Sales = replace_na(JP_Sales, 0)) %>%
  dplyr::mutate(Total_Sales = PAL_Sales + NA_Sales + JP_Sales + Other_Sales) %>%
  dplyr::mutate(across(is.numeric, ~round(., 2))) %>%
  arrange(Year)

df_where_global_sales_not_equal_to_all_sales <- df %>%
  filter(Global_Sales != Total_Sales)

df_where_global_sales_equal_to_all_sales <- df %>%
  filter(Global_Sales == Total_Sales)

df_where_global_sales_greater_than_all_sales <- df_where_global_sales_not_equal_to_all_sales %>%
  filter(Global_Sales > Total_Sales) %>%
  dplyr::mutate(JP_Sales = replace(JP_Sales, Global_Sales > Total_Sales, Global_Sales - Total_Sales))

df_where_global_sales_less_than_all_sales <- df_where_global_sales_not_equal_to_all_sales %>%
  filter(Global_Sales < Total_Sales) %>%
  dplyr::mutate(JP_Sales = replace(JP_Sales, Global_Sales < Total_Sales, Total_Sales - Global_Sales))

processed_df <- do.call("rbind", list(df_where_global_sales_less_than_all_sales,
                                      df_where_global_sales_equal_to_all_sales,
                                      df_where_global_sales_greater_than_all_sales))

# Define UI
ui <- fluidPage(theme = shinytheme('lumen'),
                titlePanel('Predictive Model using R'),
                fluidRow(
                  column(3, align = 'left', offset = 1, selectInput(inputId = 'type', label = strong('Select Year'),
                                                                    choices = unique(processed_df$Year), selected = '2001')
                  ),
                  column(3, selectInput(inputId = 'genre', label = strong('Select Genre'),
                                        choices = unique(processed_df$Genre), selected = 'Action')
                  ),
                  column(3, selectInput(inputId = 'platform', label = strong('Select Platform'),
                                        choices = unique(processed_df$Platform), selected = 'PC')
                  )

                ),
                fluidRow(column(8, align = 'center', offset = 0, dataTableOutput(outputId = "table")))
)

# Define Server
server <- function(input, output) {
  output$table <- renderDataTable(processed_df %>% filter(Year == input$type &
                                                            Genre == input$genre &
                                                            Platform == input$platform),
                                  options = list(pageLength = 10, autoWidth = TRUE))
}

# Create Shiny object
shinyApp(ui = ui, server = server)