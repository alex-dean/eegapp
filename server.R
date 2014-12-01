shinyServer(function(input, output) {
  
  output$text1 <- renderText({  
    paste("You have chosen a range from", input$range[1], "to", input$range[2])
  })
  
  output$text2 <- renderText({
    paste("You have chosen",input$var)
  })
  
  output$plot_inter <- renderPlot({
    x <- c(input$range[1]:input$range[2])
    percentile.min <- (input$range[1]/100)*2398 + 1
    percentile.max <- (input$range[2]/100)*2398 
    x.percentile <- percentile.min:percentile.max
    filename <- switch(input$var,
                   "Inter_001" = "eegdata_inter001.csv",
                   "Preict_001" = "eegdata_preict001.csv",
                   "Test_001" = "eegdata_test001.csv")
    data <- read.csv(paste("~/Documents/schoolwork/coursework - SEM1/PH251D-EpiR/eegapp/data/",filename, sep=""))
    data.range <- data[x.percentile,]
    print(str(data.range))
    z <- seq(from = 1, to = nrow(data.range), by = input$n)
    data.range2 <- data.range[z,]
    print(filename)
    
    i.plot<-ggplot(data = data.range2, aes(x = X, y = Dog_5_inter_001.V10)) + geom_line()
    p.plot<-ggplot(data = data.range2, aes(x = X, y = Dog_5_preict_001.V10)) + geom_line()
    t.plot<-ggplot(data = data.range2, aes(x = X, y = Dog_5_test_001.V10)) + geom_line()
    
    if (filename == "eegdata_inter001.csv") {i.plot} 
    else if (filename == "eegdata_preict001.csv") {p.plot}
    else if (filename == "eegdata_test001.csv") {t.plot}
  })
}
)
