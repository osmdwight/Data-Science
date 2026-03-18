#libraries
library(shiny)
library(ggplot2)
library(dplyr)


# UI

ui <- fluidPage(
  titlePanel("Iris Dataset Dashboard"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "species",
        label = "Select Species:",
        choices = c("All", unique(iris$Species)),
        selected = "All"
      )
    ),
    
    mainPanel(
      plotOutput("scatterPlot"),
      plotOutput("boxPlot"),
      plotOutput("histPlot")
    )
  )
)


# Server

server <- function(input, output) {
  
  filtered_data <- reactive({
    if (input$species == "All") {
      iris
    } else {
      iris %>% filter(Species == input$species)
    }
  })
  
  # Sepal.Length vs Sepal.Width
  output$scatterPlot <- renderPlot({
    ggplot(filtered_data(), aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
      geom_point(size = 3) +
      theme_minimal() +
      labs(title = "Sepal Length vs Sepal Width")
  })
  
  #  Petal.Length by Species
  output$boxPlot <- renderPlot({
    ggplot(filtered_data(), aes(x = Species, y = Petal.Length, fill = Species)) +
      geom_boxplot() +
      theme_minimal() +
      labs(title = "Petal Length by Species")
  })
  
  # Petal.Width distribution
  output$histPlot <- renderPlot({
    ggplot(filtered_data(), aes(x = Petal.Width, fill = Species)) +
      geom_histogram(binwidth = 0.1, alpha = 0.7, position = "identity") +
      theme_minimal() +
      labs(title = "Petal Width Distribution")
  })
}

# Run App

shinyApp(ui = ui, server = server)