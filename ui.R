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
        h5("Step 1: Choose Network", style = "color:#0099cc"), 
        selectInput("network_type", 
            label = "network type", 
            choices = list("Scale Free", "Small World", "Binary Tree","Lattice"), 
            selected = "Lattice"),
      
        numericInput("network_size", 
            label = "population size", 
            min = 2, max = 100, step = 5,
            value = 100),
        
        br(),

      
        h5("Step 2: Choose Disease Dynamic", style = "color: #0099cc"),  
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
        
        h5("Step 3: Click Button to Simulate",style = "color:#0099cc"),
        actionButton("go", "simulate")
    ),
     
      mainPanel(width = 9,
          tabsetPanel(
        
              tabPanel("Network Visualization", 
              h4(textOutput("text1"),align = "center"),
                  
              plotOutput("plot3", width = "100%"),
                  
              alignCenter(
                      sliderInput("t", "time: t", 
                          min=1, max=15, value=1,  step=1, width = "60%", animate=animationOptions(loop=TRUE))
                  ),
              
                  
              h5("Step 4: Click to start/pause animation",
                  align = "right", style = "color:#0099cc")
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


