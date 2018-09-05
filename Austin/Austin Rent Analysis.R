
#Install and Load Packages

install.packages("ggplot2")
install.packages("data.table")
install.packages("tidyr")

library(ggplot2)
library(data.table)
library(tidyr)

#Download the Austin indicator data set
#Original data set from: https://data.austintexas.gov/City-Government/Imagine-Austin-Indicators/apwj-7zty/data

austinData= fread('https://raw.githubusercontent.com/lgellis/MiscTutorial/master/Austin/Imagine_Austin_Indicators.csv', data.table=FALSE, stringsAsFactors = FALSE)

#Attach the column names
attach(austinData)


#Filter to include only Median Gross Rent
aD2 <- austinData[`Indicator Name` == "Median Gross Rent", ]

#Use gather function of tidyr for easier line graph plotting
aD2 <- aD2 %>% 
  gather(year, value, '2007':'2017') 

#Create a line graph

p <- ggplot(aD2, aes(x=year, y=value, group=1)) +
  geom_line() +
  labs(x = "Median Gross Rent in Austin",
       y = "Year") +
  theme_bw() +
  theme_minimal()

p

#Export the new filtered and gathered data set
write.csv(aD2,'aD2.csv')

#Export the graph
p + ggsave("aD2Plot.pdf")

###Export code for notebooks

#export to csv
write.csv(aD2,"aD2Data.csv")
project$save_data('aD2Data.csv',"aD2Data.csv", overwrite=TRUE)


#Export the graph
p + ggsave("aD2LineGraph.pdf")
project$save_data('aD2LineGraph.pdf',"aD2LineGraph.pdf",overwrite=TRUE)


