remove(list = ls())

library('magrittr')
library('dplyr')
library('shiny')
library('shinythemes')
library('reader')
library('tidyr')

setwd('/home/nischal/repository/personal/nischalshakya15.github.io/thesis')

# Read data from csv file
data <- read.csv(file = '../data-sets/vgsales-processed.csv', sep = ',', dec = '.', stringsAsFactors = FALSE)

find_by_platform <- function(df, platform) {
  return(
    df %>%
      filter(df$Platform == platform)
  )
}

df_pc <- find_by_platform(processed_df, 'PC')

df_xbox <- processed_df %>%
  filter(Platform == 'XB') %>%
  group_by(Name)

df_ps2 <- processed_df %>%
  filter(Platform == 'PS2') %>%
  group_by(Name)

df_pc_semi_join <- df_pc %>%
  semi_join(
    df_ps2, by = 'Name'
  ) %>%
  semi_join(
    df_xbox, by = 'Name'
  )

df_ps2_semi_join <- df_ps2 %>%
  semi_join(
    df_pc, by = 'Name'
  ) %>%
  semi_join(
    df_xbox, by = 'Name'
  )

df_xbox_semi_join <- df_xbox %>%
  semi_join(
    df_pc, by = 'Name'
  ) %>%
  semi_join(
    df_ps2, by = 'Name'
  )

df_merged <- do.call("rbind", list(df_pc_semi_join,
                                   df_xbox_semi_join,
                                   df_ps2_semi_join))

df_new <- df_merged %>% arrange(Name)

# Define UI
ui <- fluidPage(theme = shinytheme('lumen'),
                titlePanel('Predictive Model using R'),
                fluidRow(
                  column(3, align = 'left', offset = 1, selectInput(inputId = 'type', label = strong('Select Year'),
                                                                    choices = unique(processed_df$Year), selected = '2001')
                  ),
                  # column(3, selectInput(inputId = 'genre', label = strong('Select Genre'),
                  #                       choices = unique(processed_df$Genre), selected = 'Action')
                  # ),
                  column(3, selectInput(inputId = 'platform', label = strong('Select Platform'),
                                        choices = unique(processed_df$Platform), selected = 'PC')
                  )

                ),
                fluidRow(column(8, align = 'center', offset = 0, dataTableOutput(outputId = "table"))),

                fluidRow(
                  column(3, selectInput(inputId = 'platform_pc', label = strong('Select Platform'),
                                        choices = unique(processed_df$Platform), selected = 'PC')
                  ),
                  column(3, selectInput(inputId = 'platform_microsoft', label = strong('Select Microsoft Platform'),
                                        choices = unique(processed_df$Platform), selected = 'XOne')
                  ),
                  column(3, selectInput(inputId = 'platform_sony', label = strong('Select Sony Platform'),
                                        choices = unique(processed_df$Platform), selected = 'PS2')
                  )
                ),
                fluidRow(column(12, dataTableOutput(outputId = "common_observation_table")))
)

# Define Server
server <- function(input, output) {
  output$table <- renderDataTable(find_by_platform(processed_df, input$platform),
                                  options = list(pageLength = 10, autoWidth = TRUE))

  output$common_observation_table <- renderDataTable(df_pc %>%
                                                       inner_join(
                                                         (
                                                           find_by_platform(processed_df, input$platform_microsoft)
                                                         ), by = 'Name'
                                                       ) %>%
                                                       inner_join(
                                                         (
                                                           find_by_platform(processed_df, input$platform_sony)
                                                         ), by = 'Name'
                                                       ) %>%
                                                       group_by(Name) %>%
                                                       arrange(Year),
                                                     options = list(pageLength = 10, autoWidth = TRUE))

}

# Create Shiny object
shinyApp(ui = ui, server = server)