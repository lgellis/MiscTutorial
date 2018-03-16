########## Pre-Steps ########## 

# 1) Create a photo and convert to svg with any tool.  I used: http://pngtosvg.com/
# 2) Convert the svg to csv data coordinates: https://spotify.github.io/coordinator/
# 3) Save the csv on DSX or post online as I did  

########## Import Packages ########## 
install.packages("data.table")
install.packages("ggplot2")

########## Load Packages ########## 

library(data.table)
library(ggplot2)

########## Import Data ########## 

df= fread('https://raw.githubusercontent.com/lgellis/MiscTutorial/master/files/think_image_coords_final.csv', stringsAsFactors = FALSE)

# alternative 1 
# df= fread('https://raw.githubusercontent.com/lgellis/MiscTutorial/master/files/lmd-loves-cloud.csv', stringsAsFactors = FALSE)

# alternative 2 
# df= fread('https://raw.githubusercontent.com/lgellis/MiscTutorial/master/files/ibm_think_tile.csv' , stringsAsFactors = FALSE)


#Ensure it loads and attach the column names
summary(df)
dim(df)
attach(df)

########## Plot the Data ########## 

# Basic scatter plot
p <-ggplot(df, aes(x=x, y=y)) +
  geom_point(colour = '#006699', size = 0.05) 
p

#flip the scale
p <-p +  scale_y_reverse() 
p

#make it pretty
p +  
  theme(panel.background = element_rect(fill = 'white')) +
  theme(axis.line=element_blank(),
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        legend.position="none",
        panel.background=element_blank(),
        panel.border=element_blank(),
        panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        plot.background=element_blank())


