library(shiny)

## setwd("c:/r/")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  #renderPrint(input$startingPrice)
  
  output$MainPlotContainer <- renderPlot({
    
    GetPrice <- reactive({ input$startingPrice }) 
    GetDrift <- reactive({ input$driftRate }) 
    GetVolatility <- reactive({ input$volatilityRate }) 
    
    price <- GetPrice()
    drift <- GetDrift() # 0.03#input$driftRate
    volatility <- GetVolatility() # 0.12#input$volatilityRate
    
    daysCount <- 255
    numberIterations <- 100
    
    P <- matrix(price, 110, daysCount)
    av <- rep(0,daysCount)
    avg <- rep(0,daysCount)
    minv <- rep(0,daysCount)
    maxv <- rep(0,daysCount )
    plotter <- rep(price ,daysCount )
    plotter[1] <- price * 1.5
    plotter[2] <- price * 0.7
    
    
    ## Price = Price * (1 + @DRIFT / 255 + 2 * (RAND()-0.5) * @VOLATILITY * SQRT (1./255) )
    for (d in 1:daysCount ) {
      for (i in 1:numberIterations ) {
        if (d>1) 
          P[i,d] = P[i,d-1] * (1 + drift/daysCount+ (runif(1, 0, 1) - 0.5) * volatility * sqrt(1/daysCount))
      }
      av[d]<-median(P[,d])
      avg[d]<-mean(P[,d])
      minv[d]<-min(P[,d])
      maxv[d]<-max(P[,d])
    }
    
    
    
    plot (plotter, xlab="Day", ylab="Price [$]", sub="Simulated price for 255 working days ahead")
    lines (avg)
    lines (av) 
    lines (minv)
    lines (minv)
    for (i in 1:numberIterations)#daysCount)
    {
        if (i %% 5 == 0) { 
          lines(P[i,])
          #lines(P[i,seq(1,daysCount,1)])
        }
    }
    
  })
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  
#  output$distPlot <- renderPlot({
#    x    <- faithful[, 2]  # Old Faithful Geyser data
#    bins <- seq(min(x), max(x), length.out = input$bins + 1)
#    
#    # draw the histogram with the specified number of bins
#    hist(x, breaks = bins, col = 'darkgray', border = 'white')
#  })
})