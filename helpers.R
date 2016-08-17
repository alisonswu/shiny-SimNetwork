library(igraph)
library(reshape)
library(ggplot2)
library(reshape2)

# simulate agent based SIR model 
simulate_network <- function(network_type = "Scale Free",network_size = 25,init_infected = 5,infection_prob = 0.6, infection_period = 2, time = 15){
    status_list = list()
    # generate a network
    set.seed(123)
    # graph_type = c("lattice", "scale-free")
    # g = graph.lattice(length=round(sqrt(size)),dim=2)
    if(network_type == "Scale Free"){
        g = barabasi.game(network_size, directed = FALSE)
        layout = layout_with_fr(g)
    }else if(network_type == "Binary Tree"){
        g = make_tree(network_size, children = 2, mode = "undirected")
        layout = layout_with_fr(g)
    }else if(network_type == "Small World"){
        g = sample_smallworld(1, network_size, 3, 0.8, loops = FALSE, multiple = FALSE)
        layout = layout_with_fr(g)
    }else{
        len = round(sqrt(network_size))
        g = make_lattice(c(len,len))
        layout=as.matrix(expand.grid(1:len-1, 1:len-1))
        
    }
    
    # assign initial infection status 
    t = 1
    V(g)$infected_time = 0
    init_infection = sample(V(g),init_infected)
    V(g)[-init_infection]$status = "S"
    V(g)[init_infection]$status = "I"
    V(g)$infected_time = V(g)$infected_time + (V(g)$status =="I")
    status_list[[t]] = V(g)$status 
    
    # make the infection contingent
    for(i in 1:(time-1)){
        t = t+1 
        infected = which(V(g)$status == "I") # get infected individuals 
        if(sum(infected) == 0){}
        else{
            neighbor = neighborhood(g,1,infected) # find their neighbors
            neighbor = data.frame(table(unlist(neighbor))) 
            neighbor$Var1 = as.numeric(as.character(neighbor$Var1))
            # a data frame of susceptible individual with infected neighbor, number of  infected neighbors
            neighbor = subset(neighbor,  (V(g)[neighbor[,1]]$status == "S")) 
            neighbor$prob_inf = 1-(1-infection_prob)^neighbor$Freq 
            # determine who is infected at time t+1 
            neighbor$infected = neighbor$prob_inf > runif(nrow(neighbor))
            new_infected = neighbor$Var1[which(neighbor$infected == TRUE)]
            V(g)[new_infected]$status = "I"
            # recover infected individuals with enough infected period 
            V(g)[which( (V(g)$infected_time == infection_period) & (V(g)$status == "I"))]$status = "R"
            # update
            V(g)$infected_time = V(g)$infected_time + (V(g)$status =="I")
        }
        status_list[[t]] = V(g)$status 
    }   
    set.seed(123)
    #layout = layout.spring(g)
    return(list(g,status_list, layout, network_type))
    
}


# plot network
plot_network <- function(sim, t){
    
    colors = as.character(factor(sim[[2]][[t]],levels = c('S','I','R'), labels = c("chartreuse3","indianred1","gold")))
    set.seed(5)
    plot(sim[[1]], layout = sim[[3]],edge.arrow.size=.5,  vertex.color=colors, vertex.label=NA, vertex.size= 7)   #, main = paste(sim[[4]],"Network, t =", t)) 
    legend(x = 1.4, y = 0,inset=c(0,0), c("Susceptible","Infected", "Recovered"), pch=21, pt.bg=c("chartreuse3","indianred1","gold"), bty="n", pt.cex=1.5)
    
}


# summary plot 1 
plot_summary1 <- function(sim){
    SIR_df = factor(levels = c('S','I','R'))
    for( i in 1:length(sim[[2]])){
        SIR_df = rbind(SIR_df, table(factor(sim[[2]][[i]], levels = c('S','I','R'))))}
    SIR_df = data.frame(SIR_df)
    SIR_df$t = 1:length(sim[[2]])
    SIR_long = melt(SIR_df, id = "t")
    SIR_long$status = factor(SIR_long$variable,levels = c('S','I','R'))
    
    # line 
    ggplot(data = SIR_long,aes(x=t,y=value,colour=status),alpha= 0.7)+
        geom_line(size = 1)+geom_point()+
        scale_x_continuous(name = "t", breaks =1:nrow(SIR_df))+
        ylab('population')+
        scale_color_manual(values=c("chartreuse3","indianred1","gold"))+
        theme_bw() 
    
}

# summary plot 2
plot_summary2 <- function(sim){
    SIR_df = factor(levels = c('S','I','R'))
    for( i in 1:length(sim[[2]])){
        SIR_df = rbind(SIR_df, table(factor(sim[[2]][[i]], levels = c('S','I','R'))))}
    SIR_df = data.frame(SIR_df)
    SIR_df$t = 1:length(sim[[2]])
    SIR_long = melt(SIR_df, id = "t")
    SIR_long$status = factor(SIR_long$variable,levels = c('S','I','R'))
    
    # line 
    ggplot(SIR_long,aes(x=t,y=value))+
        geom_area( aes(colour = status, fill= status),position = 'stack', alpha= 0.7) +
        scale_fill_manual(values = c("chartreuse3","indianred1","gold"))+
        scale_color_manual(values=c("chartreuse3","indianred1","gold"))+
        scale_x_continuous(name = "t", breaks = 1:nrow(SIR_df))+
        ylab('population')+
        theme_bw()
    
}
