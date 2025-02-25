#### #### #### #### #### #### #### #### 

# Removes all previously created variables.
# https://youtu.be/D_CNmYkGRUc?si=PJJbZY0GBtVsB4dB&t=91
rm(list=ls())
gc()

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

#install.packages("stringr")
#install.packages("dplyr")
#install.packages("ggplot2")
#install.packages("lubridate")
#install.packages("tidyr")
#install.packages("osmdata")
#install.packages("sf")
#install.packages("ggmap")
#install.packages("httr2")
#install.packages("ggraph")
#install.packages("igraph")
#install.packages("tidyverse")
#install.packages("tidygraph")

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

library(stringr)
library(dplyr)
library(ggplot2)
library(lubridate)
library(tidyr)
library(osmdata)
library(sf)
library(ggmap)
library(httr2)
library(igraph)
library(ggraph)
library(tidyverse)
library(tidygraph)

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

setwd("D:/WGU/D498/D498/")
getwd()

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

load("bikeshare_main_df.RData")


#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

plot_hierarchical_edge_bundling <- subset(bikeshare_main_df, select = c(location, start.station, end.station ))

View(plot_hierarchical_edge_bundling)

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

#gc()

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

cities = c("chicago", "new york city", "washington")

for (city in cities) {
  
  city_pheb_df <- plot_hierarchical_edge_bundling %>%
    filter(location == city) 
  
  edge_data <- city_pheb_df %>%
    count(start.station, end.station, name = "count")

  edge_data_circle <- edge_data %>%
    arrange(desc(count)) %>%
    top_n(75)  
    
  edge_data_fr <- edge_data %>%
    arrange(desc(count)) %>%
    top_n(125)



  g_circle <- tbl_graph(
    nodes = data.frame(name = unique(c(edge_data_circle$start.station, edge_data_circle$end.station))),  # Unique locations
    edges = edge_data_circle,  
    directed = TRUE
  )

  g_fr <- tbl_graph(
    nodes = data.frame(name = unique(c(edge_data_fr$start.station, edge_data_fr$end.station))),  # Unique locations
    edges = edge_data_fr,
    directed = TRUE  
  )

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
  
  

  ggraph(g_circle, layout = 'circle') + 
    geom_edge_arc(aes(alpha = count / max(count)), edge_colour = "blue", show.legend = FALSE) +  
    geom_node_point(size = 3, color = "red") +  
    geom_node_text(aes(label = name), vjust = -1) +  
    #coord_fixed(expand = TRUE) +
    #scale_x_continuous(expand = expansion(mult = 0.5)) +  
    #scale_y_continuous(expand = expansion(mult = 0.5)) +
    theme_void() 
  
  ggsave_circle_file_name = paste(city, "circlegraph_most_used_routes.pdf", sep="_")
  
  ggsave(file = ggsave_circle_file_name, units = "in", width = 6, height = 7)
  
  
  
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
  
  
  ggraph(g_fr, layout = "fr") +  
    geom_edge_link(aes(alpha = count / max(count)), color = "blue") +  
    geom_node_point(size = 3, color = "red") +  
    geom_node_text(aes(label = name), vjust = -1) + 
    #scale_x_continuous(expand = expansion(mult = 0.5)) +  
    #scale_y_continuous(expand = expansion(mult = 0.5)) +
    theme_void()

  ggsave_fr_file_name = paste(city, "_frgraph_must_used_routes.pdf", sep="_")
  
  ggsave(file = ggsave_fr_file_name, units = "in", width = 6, height = 7)
  

}

  
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

cites = c("chicago", "new york city", "washington")

for (city in cities) {
  stats_edge_data <- plot_hierarchical_edge_bundling %>%
    group_by(location, start.station, end.station) %>%
    summarise(count = n(), .groups = "drop")

}

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 