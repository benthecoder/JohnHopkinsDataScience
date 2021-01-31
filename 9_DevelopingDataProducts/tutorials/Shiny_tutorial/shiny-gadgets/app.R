library(shiny)
library(miniUI)

multipleNumbers <- function(num1, num2) {
    ui <- miniPage(
        gadgetTitleBar("Multiply Two numbers"),
        miniContentPanel(
            selectInput("num1", "First Number", choices = num1),
            selectInput("num2", "SecondNUmber", choices = num2)
        )
        
    )
    server <- function(input, output, session) {
        observeEvent(input$done, {
            num1 <- as.numeric(input$num1)
            num2 <- as.numeric(input$num2)
            stopApp(num1 * num2)
        })
    }
    runGadget(ui, server)
}