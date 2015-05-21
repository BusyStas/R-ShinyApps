library(shiny)
shinyUI(pageWithSidebar( 
    headerPanel("Monte Carlo Simulation"),
    sidebarPanel(
      sliderInput("startingPrice", "Starting stock price", value=200, min=0, max=1000, step=1),
      sliderInput("driftRate", "Drift", value=0.13, min=0, max=0.5, step=.005),
      sliderInput("volatilityRate", "Volatility", value=0.32, min=0, max=0.5, step=.005),
      submitButton("Submit")
    ),
    mainPanel(
      p("This application does 100 simmulations of random moves 
          of a stock give a starting price, drift and volatility.
        Drift defines normal expected growth rate.
        Volatility defines how variable are changes in price over time.
        Please wait several seconds when you run it for the first time.
        "),
      plotOutput('MainPlotContainer')
    )
))