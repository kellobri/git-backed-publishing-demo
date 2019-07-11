#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Application title
    titlePanel("Old Faithful Geyser Data"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectInput(inputId = "n_breaks",
                        label = "Number of bins in histogram (approximate):",
                        choices = c(10, 20, 35, 50),
                        selected = 20),
            
            checkboxInput(inputId = "individual_obs",
                          label = strong("Show individual observations"),
                          value = FALSE),
            
            checkboxInput(inputId = "density",
                          label = strong("Show density estimate"),
                          value = FALSE)
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput(outputId = "main_plot", height = "300px"),
            conditionalPanel(condition = "input.density == true",
                             sliderInput(inputId = "bw_adjust",
                                         label = "Bandwidth adjustment:",
                                         min = 0.2, max = 2, value = 1, step = 0.2)
            )
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    output$main_plot <- renderPlot({
        
        hist(faithful$eruptions,
             probability = TRUE,
             breaks = as.numeric(input$n_breaks),
             xlab = "Duration (minutes)",
             main = "Geyser eruption duration")
        
        if (input$individual_obs) {
            rug(faithful$eruptions)
        }
        
        if (input$density) {
            dens <- density(faithful$eruptions,
                            adjust = input$bw_adjust)
            lines(dens, col = "blue")
        }
        
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
