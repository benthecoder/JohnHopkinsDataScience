library(shiny)

shinyUI(fluidPage(
    # Application title
    titlePanel("Predict Horsepower from MPG"),
    
    sidebarLayout(
        sidebarPanel(
            sliderInput(
                "sliderMPG",
                "What is the MPG of the car?",
                min = 10,
                max = 35,
                value = 20
            ),
            checkboxInput("showModel1", "Show/Hide model 1", value = TRUE),
            checkboxInput("showModel2", "Show/Hide model 2", value = TRUE),
            # submitButton("Submit") # delayed reactivity
        ),
        
        mainPanel(tabsetPanel(
            type = "tabs",
            tabPanel("plot", plotOutput("plot1")),
            tabPanel(
                "prediction",
                h3("predicted Horsepower from Model 1:"),
                textOutput("pred1"),
                h3("predicted Horsepower from Model 2:"),
                textOutput("pred2")
            ),
            tabPanel("Interactive plot",
                     plotOutput("plot2", brush = brushOpts(id = "brush1")))
        ))
    )
))
