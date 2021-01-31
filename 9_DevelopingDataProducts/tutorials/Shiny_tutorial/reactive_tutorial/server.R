library(shiny)

shinyServer(function(input, output) {
    # define spline term
    mtcars$mpgsp <- ifelse(mtcars$mpg - 20 > 0, mtcars$mpg - 20, 0)
    
    # build models
    model1 <- lm(hp ~ mpg, data = mtcars)
    model2 <- lm(hp ~ mpgsp + mpg, data = mtcars)
    
    # reactive variables
    model1pred <- reactive({
        mpgInput <- input$sliderMPG
        predict(model1, newdata = data.frame(mpg = mpgInput))
    })
    
    model2pred <- reactive({
        mpgInput <- input$sliderMPG
        predict(model2, newdata = data.frame(
            mpg = mpgInput,
            mpgsp = ifelse(mpgInput - 20 > 0,
                           mpgInput - 20, 0)
        ))
    })
    
    model <- reactive({
        brushed_data <- brushedPoints(mtcars,
                                      input$brush1,
                                      xvar = "mpg",
                                      yvar = "hp")
        if (nrow(brushed_data) < 2) {
            return(NULL)
        }
        lm(hp ~ mpg, data = brushed_data)
    })
    
    # render plot
    output$plot1 <- renderPlot({
        mpgInput <- input$sliderMPG
        
        plot(
            mtcars$mpg,
            mtcars$hp,
            xlab = "Miles per Gallon",
            ylab = "Horsepower",
            bty = "n",
            pch = 16,
            xlim = c(10, 35),
            ylim = c(50, 350)
        )
        
        if (input$showModel1) {
            abline(model1, col = "red", lwd = 2)
        }
        if (input$showModel2) {
            model2lines <- predict(model2, newdata = data.frame(
                mpg = 10:35,
                mpgsp = ifelse(10:35 - 20 > 0, 10:35 - 20, 0)
            ))
            lines(10:35,
                  model2lines,
                  col = "blue",
                  lwd = 2)
        }
        legend(
            25,
            250,
            c("Model 1 Prediction", "Model 2 Prediction"),
            pch = 16,
            col = c("red", "blue"),
            bty = "n",
            cex = 1.2
        )
        points(
            mpgInput,
            model1pred(),
            col = "red",
            pch = 16,
            cex = 2
        )
        points(
            mpgInput,
            model2pred(),
            col = "red",
            pch = 16,
            cex = 2
        )
    })
    
    # output prediction text
    output$pred1 <- renderText ({
        model1pred()
    })
    output$pred2 <- renderText ({
        model2pred()
    })
    
    output$plot2 <- renderPlot ({
        plot(
            mtcars$mpg,
            mtcars$hp,
            xlab = "mpg",
            ylab = "hp",
            main = "Tree Measurements",
            cex = 1.5,
            pch = 16,
            bty = "n"
        )
        if (!is.null(model())) {
            abline(model(), col = "blue", lwd = 2)
        }
    })
})
