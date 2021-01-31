# Define server logic
server <- function(input, output) {
    output$covid19plot <- renderPlotly({
        if (!is.null(input$country)) {
            x <- covid19(
                    country = input$country,
                    level = input$level,
                    start = input$date[1],
                    end = input$date[2]
                )
            color <- paste0("administrative_area_level_", input$level)
            plot_ly(x = x[["date"]],
                    y = x[[input$type]],
                    color = x[[color]],
                    type = 'scatter',
                    mode = 'lines')
            
        }
    })
    
}
