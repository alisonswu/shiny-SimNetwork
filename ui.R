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
            selected = "Scale Free"),
      
        numericInput("network_size", 
            label = "population size", 
            min = 2, max = 100, step = 5,
            value = 20),
        
        br(),

      
        h4("Step 2: Disease Dynamic"),  
        numericInput("init_infected", 
            label = "number of initial infections", 
            min = 0, max = 100, step = 1, 
            value = 2),
    
        sliderInput("infection_prob", 
            label = "infection probability",
            min = 0, max = 1, value = 0.5),
    
        selectInput("infection_period", 
            label = "infection duration", 
            choices = list(1,2,3,4), 
            selected = 2),
        
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
                      sliderInput("t", "time", 
                      min=1, max=15, value=1,  step=1, width = "200%", loop = TRUE,
                      animate=TRUE)
                  )),
              tabPanel("SIR Plots", 
                  splitLayout(cellWidths = c("50%", "50%"), 
                      plotOutput("plot1"), plotOutput("plot2"))
                  )
                  
              )
              
          )
         
      )
    
  )

)


