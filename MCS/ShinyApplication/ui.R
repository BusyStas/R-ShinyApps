library(shiny)
shinyUI(pageWithSidebar( 
    headerPanel("Monte Carlo Simulation"),
    sidebarPanel(
      sliderInput("startingPrice", "Starting price", value=200, min=0, max=1000, step=1),
      sliderInput("driftRate", "Drift", value=0.03, min=0, max=0.5, step=.005),
      sliderInput("volatilityRate", "Volatility", value=0.12, min=0, max=0.5, step=.005),
      submitButton("Submit")
    ),
    mainPanel(
      plotOutput('MainPlotContainer')
    )
))