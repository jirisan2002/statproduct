library(shiny)
library(datasets)
library(reshape)

shinyServer(function(input, output){
  
  
    inFile <- reactive({
         inFile <- input$dataFile
    })

    output$contents <- renderTable({  
        file <- inFile()
        if(is.null(file)){return(NULL)}
        read.table(file$datapath, header=input$header, sep=input$sep, 
                  quote=input$quote)
    })
    
    output$summary <- renderPrint({
      file <- inFile()
      if(!is.null(file)){
           df <- read.table(file$datapath, header=input$header, sep=input$sep, 
                          quote=input$quote)
           summary(df)
      }
    })
    output$plot <- renderPlot({
         file <- inFile()
         if(!is.null(file)){
              df <- read.table(file$datapath, header=input$header, sep=input$sep, 
                          quote=input$quote)
              if(input$graph == "boxplot"){
                   boxplot(df)
              } else if(input$graph == "bargraph"){
                   barplot(apply(df, 2, mean))
              }        
         }
    })
    
    output$testResult <- renderPrint({
         file <- inFile()
         if(!is.null(file)){
              df <- read.table(file$datapath, header=input$header, sep=input$sep, 
                          quote=input$quote)
              
              if(input$test == "ANOVA"){
                   melted <- melt(df)
                   print(anova(lm(value ~ variable, data = melted)))
                   h5("--------------------------------------------------")
                   TukeyHSD(aov(value ~ variable, data = melted)) 
              } else if(input$test == "t-test"){
                   melted <- melt(df)
                   pairwise.t.test(melted$value, melted$variable, paired = F, 
                                   alternative = "two.sided")
              }
         }
    })   
})

