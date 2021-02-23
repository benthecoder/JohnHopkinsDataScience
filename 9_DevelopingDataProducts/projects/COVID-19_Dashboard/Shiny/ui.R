# load libraries
library(shiny)
library(shinythemes)
library(shinydashboard)
library(plotly)
library(COVID19)

# Define UI for application
ui <- fluidPage(
    titlePanel("Simple COVID-19 Dashboard"),
    
    theme = shinytheme("flatly"),
    sidebarLayout(
        sidebarPanel(
            
            p("Below are some selections you can make to change the plot, 
              by default, the top 6 countries with the highest confirmed cases 
              are plotted"),
            br(),
            
            selectInput(
                "country",
                label = "Select the countries you want for the plot",
                multiple = TRUE,
                choices = unique(covid19()$administrative_area_level_1),
                selected = c("United States", 
                             "India", 
                             "Brazil", 
                             "Russia",
                             "United Kingdom",
                             "France")
            ),
            
            
            selectInput(
                "type",
                label = "Select the Type of cases (Confirmed, Tests, etc.)",
                choices = c(
                    "confirmed",
                    "tests",
                    "recovered",
                    "deaths",
                    "vaccines"
                )
            ),
            
            selectInput(
                "level",
                label = "Select level - Country, Region or City",
                choices = c(
                    "Country" = 1,
                    "Region" = 2,
                    "City" = 3
                ),
                selected = 1
            ),
            
            dateRangeInput(
                "date",
                label = "Select the range of Date for the data",
                start = "2020-01-01"
            )
        ),
        
        mainPanel(
            h3("Plot"),
            plotlyOutput("covid19plot")
        )
    )
)