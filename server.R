#     Author : Alison Sihan Wu 
#              Department of Statistics, North Carolina State University
#      Email : swu11@ncsu.edu 
#     GitHub : https://github.com/alisonswu/shiny-SimNetwork
        
# server.R
library(shiny)
source("helpers.R")
shinyServer(function(input, output) {
    # sim <- reactive({
    #     simulate_network(network_size = input$network_size,
    #         init_infected = input$init_infected,
    #         infection_prob = input$infection_prob, 
    #         infection_period = input$infection_period, 
    #         time = 12)
    # })
    
    sim <- eventReactive(input$go, {
        simulate_network(input$network_type,network_size = input$network_size,
            init_infected = input$init_infected,
            infection_prob = input$infection_prob, 
            infection_period = input$infection_period, 
            time = 15)
    })
    
    output$plot1 <- renderPlot({
            plot_summary1(sim())
     })
    
    output$plot2 <- renderPlot({
             plot_summary2(sim())
    })
    
    output$plot3<- renderPlot({
        plot_network(sim(), input$t)
    })
    
    output$text1 <- renderText({ 
        paste(input$network_type, "Network at t =", input$t)
    })
    
  
})
