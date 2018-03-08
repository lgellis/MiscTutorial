
# Base code from -https://www.computerworld.com/article/3175623/data-analytics/mapping-in-r-just-got-a-whole-lot-easier.html

install.packages("tmap")
install.packages("tmaptools")
install.packages("data.table")
library(data.table)
library("tmap")
library("tmaptools")

#Download the shape files from:
#Replace the path with the path to your shape file
eurGeoMap <- read_shape("/iwd2018/NUTS_2013_01M_SH/Data/NUTS_RG_01M_2013.shp", as.sf = TRUE, stringsAsFactors = FALSE)

#Download the equality data directly from GH.
#Equality data sourced from: https://data.europa.eu
eurEquality= fread('https://raw.githubusercontent.com/lgellis/MiscTutorial/master/IWD_2018/2015_equalityIndex.csv')
eurGeoMap$country <-substr(eurGeoMap$NUTS_ID, 1, 2)
eurGeoMap$country
eurEqualityMap <- append_data(eurGeoMap, eurEquality, key.shp = "country", key.data = "Country")

tmap_mode("view")
tm_shape(eurEqualityMap) + tm_polygons("Index", id = "country") 