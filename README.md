This is a shiny app for visualizing the spread of infectious disease in a network. You will need Rstudio installed on your local machine to run the app.

To use the app:

1. Download ui.R, server.R, helpers.R to a local folder called SimNetwork.

2. Open Rstudio and set working directory to the parent directory of SimNetwork in:  
      Session - set working directory - choose directory.

3. Install required packages by running the following R code: 
      install.packages("shiny");
      install.packages("reshape");
      install.packages("reshape2");
      install.packages("igraph");
      install.packages("ggplot2")

4. Launch app by running R code:

      runApp("SimNetwork")
