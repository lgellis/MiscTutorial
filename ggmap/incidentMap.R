
#Useful background Articles on ggmaps
# a) https://journal.r-project.org/archive/2013-1/kahle-wickham.pdf
# b) quick guide: https://www.nceas.ucsb.edu/~frazier/RSpatialGuides/ggmap/ggmapCheatsheet.pdf

####################  Import and Install Packages  #################### 

install.packages("lubridate")
install.packages("ggplot2")
install.packages("ggmap")
install.packages("data.table")
install.packages("ggrepel")


library(lubridate)
library(ggplot2)
library(ggmap)
library(data.table)
library(ggrepel)
####################  Import Data and Create Sample #################### 

#1) Download the main data set with the crime data
#https://catalog.data.gov/dataset/seattle-police-department-911-incident-response-52779

incidents <-read.table("https://data.seattle.gov/api/views/3k2p-39jp/rows.csv?accessType=DOWNLOAD", head=TRUE, sep=",", fill=TRUE, stringsAsFactors=F)

#Create sample I'll upload to github in case this data set becomes unavailable.  
#i2Sample <- incidents[sample(1:nrow(incidents), 50000, replace=FALSE),]
#write.csv(i2Sample, "i2Sample.csv")

#If the above data set is unavailable please use this code
df= fread('https://raw.githubusercontent.com/lgellis/MiscTutorial/master/ggmap/i2Sample.csv', stringsAsFactors = FALSE)
incidents <- df

#2) Download the extra data set with the most dangerous Seattle cities as per:
# https://housely.com/dangerous-neighborhoods-seattle/

n <- fread('https://raw.githubusercontent.com/lgellis/MiscTutorial/master/ggmap/n.csv', stringsAsFactors = FALSE)

# Look at the data sets
dim(incidents)
head(incidents)
attach(incidents)

dim(n)
head(n)
attach(n)

col1 = "#011f4b"
col2 = "#6497b1"
col3 = "#b3cde0"
col4 = "#CC0000"

####################  Transform  #################### 
#add year to the incidents data frame
incidents$ymd <-mdy_hms(Event.Clearance.Date)
incidents$year <- year(incidents$ymd)

unique(incidents$year)
#Create a more manageable data frame with only 2017 and 2018 data
i2 <- incidents[year>=2017 & year<=2018, ]

#Only include complete cases
i2[complete.cases(i2), ]

#create a display label to the n data frame (dangerous neighbourhoods)
n$label <-paste(Rank, Location, sep="-")

attach(i2)
attach(n)

head(i2)
head(n)

####################  Maps #################### 

##1) Create a map with all of the crime locations plotted.

p <- ggmap(get_googlemap(center = c(lon = -122.335167, lat = 47.608013),
                    zoom = 11, scale = 2,
                    maptype ='terrain',
                    color = 'color'))
p + geom_point(aes(x = Longitude, y = Latitude,  colour = Initial.Type.Group), data = incidents, size = 0.5) + 
  theme(legend.position="bottom")
        
##2) Deal with the heavy population by using alpha to make the points transparent.
#Stick to one color as the colors are going to get faded out with alpha anyway
#therefore no need for a legend

p +   geom_point(aes(x = Longitude, y = Latitude), colour = col1, data = incidents, alpha=0.05, size = 0.5) + 
  theme(legend.position="none")


# #3) Do the same as above but do big points on the graph for icons,
# but use the shape to identify the "most dangerous" neighbourhoods.
# Need to use the factor version + scale_shape_manual to get more than 6 default shapes

n$Neighbourhood <- factor(n$Location)
p + geom_point(aes(x = Longitude, y = Latitude), colour = col1, data = incidents, alpha=0.05, size = 0.5) + 
  theme(legend.position="bottom")  +
  geom_point(aes(x = x, y = y, shape=Neighbourhood, stroke = 2), colour=col4, data = n, size =3) + 
  scale_shape_manual(values=1:nlevels(n$Neighbourhood)) 

## 4) Don't use shapes, instead use labels.  Need to use geom_label_repel,
# since there are multiple layers using different data sets.

p + geom_point(aes(x = Longitude, y = Latitude), colour = col1, data = incidents, alpha=0.05, size = 0.5) + 
  theme(legend.position="bottom")  +
  geom_point(aes(x = x, y = y, stroke = 2), colour=col4, data = n, size =1.5) + 
  geom_label_repel(
    aes(x, y, label = label),
    data=n,
    box.padding = 0.2, point.padding = 0.3,
    segment.color = 'grey50') +
  theme_classic(base_size = 9)



## 5) View in a density Plot
p + stat_density2d(
    aes(x = Longitude, y = Latitude, fill = ..level.., alpha = 0.1),
    size = 0.01, bins = 30, data = i2,
    geom = "polygon"
  ) +
  geom_point(aes(x = x, y = y, stroke = 2), colour=col4, data = n, size =1.5) + 
  geom_label_repel(
    aes(x, y, label = label),
    data=n,
    box.padding = 0.2, point.padding = 0.3,
    segment.color = 'grey50') +
  theme_classic(base_size = 9)



## 6) Density with  alpha set to level
## have to make a lot of bins given the difference in volumes
p + stat_density2d(
    aes(x = Longitude, y = Latitude, fill = ..level.., alpha = ..level..),
    size = 0.1, bins = 30, data = i2,
    geom = "polygon"
  ) +
  geom_point(aes(x = x, y = y, stroke = 2), colour=col4, data = n, size =1.5) + 
  geom_label_repel(
    aes(x, y, label = label),
    data=n,
    box.padding = 0.2, point.padding = 0.3,
    segment.color = 'grey50') +
  theme_classic(base_size = 9)


#7)  Add geom_density to put in grid lines
p + stat_density2d(
    aes(x = Longitude, y = Latitude, fill = ..level.., alpha = ..level..),
    size = 0.1, bins = 30, data = i2,
    geom = "polygon"
  ) +
  geom_density2d(data = i2, 
               aes(x = Longitude, y = Latitude), size = 0.3) +
  geom_point(aes(x = x, y = y, stroke = 2), colour=col4, data = n, size =1.5) + 
  geom_label_repel(
    aes(x, y, label = label),
    data=n,
    box.padding = 0.2, point.padding = 0.3,
    segment.color = 'grey50') +
  theme_classic(base_size = 9)


# 8)  Check the subset of top 4

i2Sub <-filter(i2, Event.Clearance.Group %in% c('TRAFFIC RELATED CALLS', 'DISTURBANCES', 'SUSPICIOUS CIRCUMSTANCES', 'MOTOR VEHICLE COLLISION INVESTIGATION'))
dim(i2Sub)
attach(i2Sub)

# Geompoint facet wrap
p +  geom_point(aes(x = Longitude, y = Latitude,  colour = Event.Clearance.Group), data = i2Sub, alpha=0.1, size = 2) + 
  theme(legend.position="bottom") +
  facet_wrap(~ Event.Clearance.Group, nrow=2)  


#9) Density chart with graph lines and facet wrap

p + stat_density2d(
    aes(x = Longitude, y = Latitude, fill = ..level.., alpha = ..level..),
    size = 0.2, bins = 30, data = i2Sub,
    geom = "polygon"
  ) +
  geom_density2d(data = i2Sub, 
                 aes(x = Longitude, y = Latitude), size = 0.3) +
  facet_wrap(~ Event.Clearance.Group, nrow=2)

#10) Switch the background in ggmap, 
#use maptype = roadmap, terrain, hybrid, satelitte

p + stat_density2d(
    aes(x = Longitude, y = Latitude, fill = ..level.., alpha = ..level..),
    size = 0.2, bins = 30, data = i2Sub,
    geom = "polygon"
  ) +
  geom_density2d(data = i2Sub, 
                 aes(x = Longitude, y = Latitude), size = 0.3) +
  scale_fill_gradient(low =  col3, high= col1) 


# 11) Use qmap to change the chart provider to stamen - do maptype = "watercolor", "terrain-lines'

qmap('Seattle, Washington', zoom = 11, source = "stamen", maptype = "terrain-lines") +
  stat_density2d(
    aes(x = Longitude, y = Latitude, fill = ..level.., alpha = ..level..),
    size = 0.2, bins = 30, data = i2Sub,
    geom = "polygon"
  ) +
  geom_density2d(data = i2Sub, 
                 aes(x = Longitude, y = Latitude), size = 0.3) +
  scale_fill_gradient(low = "light blue", high= "dark blue") 


