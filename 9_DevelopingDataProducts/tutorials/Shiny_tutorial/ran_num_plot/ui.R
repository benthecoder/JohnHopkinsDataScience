library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    # Application title
    titlePanel("Plot random numbers"),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            h1("Move the Slider!"),
            numericInput(
                "numeric",
                "How many random numbers should be plotted?",
                value = 1000,
                min = 1,
                max = 1000,
                step = 1
            ),
            sliderInput("sliderX", "Pick min and max X values",-100, 100, value =
                            c(-50, 50)),
            sliderInput("sliderY", "Pick min and max Y values",-100, 100, value =
                            c(-50, 50)),
            checkboxInput("show_xlab", "show/hide X axis labels", value = TRUE),
            checkboxInput("show_ylab", "show/hide Y axis labels", value = TRUE),
            checkboxInput("show_title", "show/hide title"),
        ),
        
        # Show a plot of the generated distribution
        mainPanel(h3("Graph of random points"),
                  plotOutput("plot1"))
    )
))
