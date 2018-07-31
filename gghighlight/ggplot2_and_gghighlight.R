install.packages("lubridate")
install.packages("ggplot2")
install.packages("ggmap")
install.packages("data.table")
install.packages("ggrepel")
install.packages("dplyr")
install.packages("magrittr")


library(lubridate)
library(ggplot2)
library(ggmap)
library(dplyr)
library(data.table)
library(ggrepel)
library(magrittr)


# Download the main crime incident dataset

incidents= fread('https://raw.githubusercontent.com/lgellis/MiscTutorial/master/ggmap/i2Sample.csv', stringsAsFactors = FALSE)
str(incidents) 
attach(incidents)

# Create some color variables for graphing later
custGrey = "#A9A9A9"

#add year to the incidents data frame
incidents$ymd <-mdy_hms(Event.Clearance.Date)
incidents$month <- lubridate::month(incidents$ymd)
incidents$year <- year(incidents$ymd)
incidents$wday <- lubridate::wday(incidents$ymd, label = TRUE)
incidents$hour <- hour(incidents$ymd)

#Create a more manageable data frame with only 2017 data
i2 <- incidents[year>=2017, ]

#Only include complete cases
i2[complete.cases(i2), ]

attach(i2)
head(i2)

#Group the data into a new data frame which has the count of events per month by subgroup

groupSummaries <- i2 %>%
  group_by(month, Event.Clearance.SubGroup) %>%
  summarize(N = length(Event.Clearance.SubGroup))

#View the new data set

head(groupSummaries, n=100)
attach(groupSummaries)

#Graph the data set through ggplot 2

ggplot(groupSummaries, aes(x=month, y=N, color=Event.Clearance.SubGroup) )+ 
  geom_line() +
  theme(legend.position="bottom",legend.text=element_text(size=7),
        legend.title = element_blank()) +
  scale_x_discrete(name ="Month", 
                   limits=c(3,6,9,12))

# Create a data frame with only events types that have had a peak of 95 calls in a month or more

groupSummariesF <- groupSummaries %>%
  group_by(Event.Clearance.SubGroup) %>% 
  filter(max(N) > 95) %>%
  ungroup()

head(groupSummariesF)

### The Old School Way: LAYERING ###

# Create a layered plot with one layer of grey data for the full data set and one layer of color data for the subset data set 

ggplot() +
  geom_line(aes(month, N, group = Event.Clearance.SubGroup), 
            data = groupSummaries, colour = alpha("grey", 0.7)) +
  geom_line(aes(month, N, group = Event.Clearance.SubGroup, colour = Event.Clearance.SubGroup), 
            data = groupSummariesF) +  
  scale_x_discrete(name ="Month", 
                   limits=c(3,6,9,12)) +
  theme(legend.position="bottom",legend.text=element_text(size=7),
        legend.title = element_blank())

### The New School Way: GGHIGHLIGHT ###

install.packages("gghighlight")
library(gghighlight)

ggplot(groupSummaries, aes(month, N, colour = Event.Clearance.SubGroup)) +
  geom_line() + 
  gghighlight(max(N) > 95,  label_key = Event.Clearance.SubGroup) +  
  scale_x_discrete(name ="Month", 
                   limits=c(3,6,9,12))

## Try a scatterplot chart

ggplot(groupSummaries, aes(month, N, colour = Event.Clearance.SubGroup, use_group_by=FALSE)) +
  geom_point() + 
  gghighlight(N > 200,  label_key = Event.Clearance.SubGroup) +  
  scale_x_discrete(name ="Month", 
                   limits=c(3,6,9,12))

## Try a histogram chart

ggplot(groupSummaries, aes(N, fill = Event.Clearance.SubGroup)) +
  geom_histogram() + 
  theme(legend.position="bottom",legend.text=element_text(size=7),
        legend.title = element_blank()) + 
  gghighlight(N > 100,  label_key = Event.Clearance.SubGroup, use_group_by = FALSE) +
  facet_wrap(~ Event.Clearance.SubGroup)


