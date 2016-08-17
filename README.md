# A shiny app to simulate infectious disease in a network 

This is a shiny app for visualizing the spread of SIR-like infectious disease in a network. 

The app allows you to customize the network and disease dynamic. The underlying algorithm uses an agent based model to simulate the disease progression. The app displays an animation of disease progression in the network, and summary plots of the S-I-R compartment size over time. 

## Screenshots


<p align="center">
  <img src="screenshot1.png" width="700"/>
  <img src="screenshot2.png" width="700"/>
</p>

## Usage

You will need RStudio and internet connection to run the app. Click [here](https://www.rstudio.com/home/) to install RStudio.

To launch the app, open RStudio and run the following code. 

```R
# install shiny package if not done
# install.packages("shiny")

library(shiny)

runGitHub("shiny-SimNetwork","alisonswu")

