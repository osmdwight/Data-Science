library(shiny)
library(ggplot2)
library(dplyr)
library(readr)
 
housing <- read_csv("housing.csv")
 
 
ui <- fluidPage(
  titlePanel("Housing Dashboard"),
  sidebarLayout(
    sidebarPanel(
      helpText("California Housing Data Visualizations")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Ocean Proximity Count",
                 plotOutput("proximityPlot")),
        tabPanel("Population vs Households",
                 plotOutput("popHousePlot")),
        tabPanel("Rooms vs Bedrooms",
                 plotOutput("roomsBedroomsPlot"))
      )
    )
  )
)
 
server <- function(input, output) {
  # 1. Count of homes by ocean proximity
  output$proximityPlot <- renderPlot({
    housing %>%
      group_by(ocean_proximity) %>%
      summarise(count = n()) %>%
      ggplot(aes(x = ocean_proximity, y = count, fill = ocean_proximity)) +
      geom_bar(stat = "identity") +
      theme_minimal() +
      labs(title = "Number of Homes by Ocean Proximity",
           x = "Ocean Proximity",
           y = "Count") +
      theme(legend.position = "none")
  })
  # 2. Population vs Households
  output$popHousePlot <- renderPlot({
    ggplot(housing, aes(x = population, y = households)) +
      geom_point(alpha = 0.5, color = "blue") +
      theme_minimal() +
      labs(title = "Population vs Households",
           x = "Population",
           y = "Households")
  })
  # 3. Total Rooms vs Total Bedrooms
  output$roomsBedroomsPlot <- renderPlot({
    ggplot(housing, aes(x = total_rooms, y = total_bedrooms)) +
      geom_point(alpha = 0.5, color = "darkgreen") +
      theme_minimal() +
      labs(title = "Total Rooms vs Total Bedrooms",
           x = "Total Rooms",
           y = "Total Bedrooms")
  })
}
 
shinyApp(ui = ui, server = server)