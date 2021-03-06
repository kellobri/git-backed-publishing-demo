#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# shiny::runExample("11_timer")
#

library(shiny)

# Define UI for displaying current time ----
ui <- fluidPage(
    
    h2(textOutput("currentTime"))
    
)

# Define server logic to show current time, update every second ----
server <- function(input, output, session) {
    
    output$currentTime <- renderText({
        invalidateLater(1000, session)
        paste("The current time is now... ", Sys.time())
    })
    
}

# Create Shiny app ----
shinyApp(ui, server)