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
```

## Documentation
We use the [R igraph](http://igraph.org/r/) package to generate a graph representation of network. Each vertex of the graph represents an individual in the network, and the edge between two vertices represents physical contact between the individuals. 

<p align="center">
  <img src="graph.png" width="200", "An example of tree network"/>
</p>

We use an agent-based model to simulate an SIR-like infectious disease over discrete time points t = 1,...,15. The inividuals in the network can have one of the three statuses: S(susceptible), I(infected), R(recovered). <br />
At t = 1, <br />
- the network is initiated with a small subset of infected individuals, while the remaining individuals are susceptible. 


At t = 2,3,... <br />
- A suscpetible individual becomes infected with probability 1 - (1-p)^c, where p is the infection probability between an infected individual passes infection to a susceptible individual through edge connection over 1 time period, and c is the number of infected neighbors with edge 1 connection). <br />
- An infected individual become recovered after staying infected over the infection duration.<br />
- A recovered individual remains recovered.  










