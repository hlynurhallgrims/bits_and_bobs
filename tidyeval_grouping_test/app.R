#
# This is a (toy example) Shiny web app. You can run the application by visiting:
#    https://hlynur.shinyapps.io/tidyeval_grouping/
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

# Define UI for application that summarizes based on selected variables.
ui <- fluidPage(
  
  # Application title
  titlePanel("Some cars"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "vars_to_group_by", 
                  label = "Choose grouping variable", 
                  choices = names(mtcars[c(2, 8:11)]),
                  multiple = TRUE),
      
      actionButton("Calculate", "Calculate")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      textOutput("chosen_variables"),
      dataTableOutput("summaryTable")
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  # Reactives
  summary_frame <- eventReactive(input$Calculate, {
    use_vars <- input$vars_to_group_by %>% 
      syms()
    
    mtcars %>% 
      group_by(!!!use_vars) %>% 
      summarize(`Average MPG` = round(mean(mpg), 1))
  })
  
  
  
  #Outputs 
  output$chosen_variables <- renderText(
    input$vars_to_group_by
  )
  
  output$summaryTable <- renderDataTable({
    summary_frame()
    
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

