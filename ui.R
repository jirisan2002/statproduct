library(shiny)
library(reshape)

shinyUI(fluidPage(
    titlePanel("User Data Analysis"),
      
    sidebarLayout(
        sidebarPanel(
            h4("1. Select data"),
            fileInput("dataFile", "Choose a Data File (csv file)", accept = 
                c("text/csv", "text/plain", ".csv")),
            h5("Check if the data has header:"),
            checkboxInput("header", "Header", TRUE),
            h5("Select the type of separator and quotes"),
            radioButtons("sep", "separator", 
                c("Comma" = ",", "Semicolon" =";", "Tab" = "\t"), ","),
            radioButtons("quote", "Quote", 
                c('None'='', 'Double Quote'='""', 'Single Quote'="''"), '""'),
            h4("2.  Select the plot type"),
            selectInput("graph", "Choose a graph type", 
                choices = c("boxplot", "bargraph"),
                selected = "boxplot"),
            h4("3.  Select Statiscal Test to be performed"),
            selectInput("test", "Choose a statistical test", 
                choices = c("t-test", "ANOVA"),
                selected = "t-test")    
        ),
           
        mainPanel(
            tabsetPanel(
               tabPanel(h4("About This App"),
                     h4("Guide for usig this app"),
                     h5("This app is designed to analyze user's data"),
                     h5("Data type you can use: excel .csv, simple text file"),
                     h4("How to use this app:"),
                     h5("1. Select your data"),
                     p("(1) click the choose file tab to select your data file"),
                     p("(2) choose separator by clicking one of the separator buttons"),
                     p("(3) then choose the quote type used in the file"),
                     p("================================================"),
                     h4("To test this: make the data frame and data file like this"), 
                     
                     pre("    P <- round(rnorm(25, 8, 2.5), 2)
    A <- round(rnorm(25, 10, 3), 2)
    B <- round(rnorm(25, 11, 3.5), 2)
    AB <- round(rnorm(25, 14, 3.5), 2)
    combo <- data.frame(P, A, B, AB)
    write.csv(combo, <filename.csv>, row.names = FALSE)"), 
                     h5("Then, upload the .csv file using the choose file button"),
                     h4("2. Selecting Pot Type"),
                     p("After you select the data file, select the plot type
                       you want to use to visualize your data"),
                     h4("3. Selecting a statistical test"),
                     p("By clicking the selection button choose t-test or ANOVA"), 
                     h4("To view the final analysis, click each tab on the right side")
               ),
               tabPanel(h4("My Data"),tableOutput("contents")),
               tabPanel(h4("Presentation"), verbatimTextOutput("summary"), br(), br(), 
                        plotOutput("plot")),
               tabPanel(h4("Stat Test"), verbatimTextOutput("testResult"))
            )
        )
    )
))
