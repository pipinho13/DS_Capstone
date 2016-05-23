#--------------------------------------------------
# R UI Code for the Capstone Project Shiny App
#--------------------------------------------------
####https://github.com/RaheemIqbal1/CapstoneProjectSW
suppressWarnings(library(shiny))

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Next Word Prediction Tool"),
  
 
  
  fluidRow(
    br(),
    p("This Next Word Preiction Tool is based on the simple Katz's Back-off Algorithm which is based on n-grams.For this project I have used up to 4-grams and the data train obtained from Blogs, Twitter and News."),
      
     p("The table represents the probability of the next word.The two plots below are WordCloud Plots. The first one shows the most popular predicted words, and the second one represents the most popular phrases based on user's input"),
    
    p("*I have skipped the apostrophes. So the 'you've been' will appear as 'youve been'")
      ),
 
  br(),
  br(),
  
  fluidRow(HTML("<strong>Enter a sentence and then press the \"Predict Next Word\" button to predict the next word</strong>") ),
  fluidRow( p("\n") ),
  
  # Sidebar layout
  sidebarLayout(
    
    sidebarPanel(
      textInput("inputString", "Enter a sentence here",value = ""),
      submitButton("Predict Next Word")
    ),
    
    mainPanel(
      h4("Predicted Next Word"),
      verbatimTextOutput("prediction"),
      textOutput('text1'),
      textOutput('text2'),
      h4("Table Of Probabilities"),
      tableOutput("view"),
      fluidRow(
        splitLayout(cellWidths = c("50%", "50%"), plotOutput("plot"), plotOutput("plot2"))
      )
      ###plotOutput("plot"),
      ##plotOutput("plot2")
      
    )
  )
    ))