#     Author : Alison Sihan Wu 
#              Department of Statistics, North Carolina State University
#      Email : swu11@ncsu.edu 
#     GitHub : https://github.com/alisonswu/shiny-SimNetwork

# ui.R
library(shiny)

alignCenter <- function(el) {
    htmltools::tagAppendAttributes(el,
        style="margin-left:auto;margin-right:auto;"
    )
}

shinyUI(fluidPage(
  titlePanel("Simulate SIR-like Infectious Disease in a Network"),
  
  sidebarLayout(
    sidebarPanel(width = 3,
        h4("Step 1: Network Setup"), 
        selectInput("network_type", 
            label = "network type", 
            choices = list("Scale Free", "Small World", "Binary Tree","Lattice"), 
            selected = "Lattice"),
      
        numericInput("network_size", 
            label = "population size", 
            min = 2, max = 100, step = 5,
            value = 100),
        
        br(),

      
        h4("Step 2: Disease Dynamic"),  
        numericInput("init_infected", 
            label = "number of initial infections", 
            min = 0, max = 100, step = 1, 
            value = 5),
    
        sliderInput("infection_prob", 
            label = "infection probability",
            min = 0, max = 1, value = 0.5),
    
        selectInput("infection_period", 
            label = "infection duration", 
            choices = list(1,2,3,4), 
            selected = 3),
        
        br(),
        
        h4("Step 3: Click Button to Simulate"),
        actionButton("go", "simulate")
    ),
     
      mainPanel("",
          tabsetPanel(
        
              tabPanel("Network Visualization", 
              h4(textOutput("text1"),align = "center"),
                  
              plotOutput("plot3"),
                  
              alignCenter(
                      sliderInput("t", "time: t", 
                          min=1, max=15, value=1,  step=1, width = "60%", animate=animationOptions(loop=TRUE))
                  ),
                  
              h6("click to start/stop animation",align = "right")    
                  ),
              
                  
              tabPanel("SIR Plots", 
                  splitLayout(cellWidths = c("50%", "50%"), 
                      plotOutput("plot1"), plotOutput("plot2"))
                  )
                  
              )
              
          )
         
      )
    
  )

)


