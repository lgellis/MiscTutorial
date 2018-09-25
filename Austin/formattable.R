#Great Resources on the formattable package
#https://cran.r-project.org/web/packages/formattable/README.html
#https://github.com/renkun-ken/formattable/issues/51
#http://bioinfo.iric.ca/create-a-nice-looking-table-using-r/ (shows you how to create a number of formats yourself)
#http://www.glyphicons.com/

#Data Source
#https://data.austintexas.gov/City-Government/Imagine-Austin-Indicators/apwj-7zty

install.packages("data.table")
install.packages("dplyr")
install.packages("formattable")
install.packages("tidyr")

#Load the libraries
library(data.table)
library(dplyr)
library(formattable)
library(tidyr)

#Set a few color variables to make our table more visually appealing
customGreen0 = "#DeF7E9"
customGreen = "#71CA97"
customRed = "#ff7f7f"

#Download the Austin indicator data set
#Original data set from: https://data.austintexas.gov/City-Government/Imagine-Austin-Indicators/apwj-7zty/data

austinData= fread('https://raw.githubusercontent.com/lgellis/MiscTutorial/master/Austin/Imagine_Austin_Indicators.csv', data.table=FALSE, header = TRUE, stringsAsFactors = FALSE)

head(austinData)
attach(austinData)

#Modify the data set

i1 <- austinData %>%
  filter(`Indicator Name` %in% 
           c('Prevalence of Obesity', 'Prevalence of Tobacco Use', 
             'Prevalence of Cardiovascular Disease', 'Prevalence of Diabetes')) %>%
  select(c(`Indicator Name`, `2011`, `2012`, `2013`, `2014`, `2015`, `2016`)) %>%
  mutate (Average = round(rowMeans(
    cbind(`2011`, `2012`, `2013`, `2014`, `2015`, `2016`), na.rm=T),2), 
    `Improvement` = round((`2011`-`2016`)/`2011`*100,2))
i1

#0) Throw it in the formattable function
formattable(i1)


#1)  First Data Table

formattable(i1, 
            align =c("l","c","c","c","c", "c", "c", "c", "r"), 
            list(`Indicator Name` = formatter(
              "span", style = ~ style(color = "grey",font.weight = "bold")) 
))


#2) Add the color mapping for all 2011 to 2016.
formattable(i1, align =c("l","c","c","c","c", "c", "c", "c", "r"), list(
  `Indicator Name` = formatter("span", style = ~ style(color = "grey",font.weight = "bold")), 
  `2011`= color_tile(customGreen, customGreen0),
  `2012`= color_tile(customGreen, customGreen0),
  `2013`= color_tile(customGreen, customGreen0),
  `2014`= color_tile(customGreen, customGreen0),
  `2015`= color_tile(customGreen, customGreen0),
  `2016`= color_tile(customGreen, customGreen0)
))


#3) Add the color bar to the average column

formattable(i1, align =c("l","c","c","c","c", "c", "c", "c", "r"), list(
  `Indicator Name` = formatter("span", style = ~ style(color = "grey",font.weight = "bold")), 
  `2011`= color_tile(customGreen, customGreen0),
  `2012`= color_tile(customGreen, customGreen0),
  `2013`= color_tile(customGreen, customGreen0),
  `2014`= color_tile(customGreen, customGreen0),
  `2015`= color_tile(customGreen, customGreen0),
  `2016`= color_tile(customGreen, customGreen0),
  `Average` = color_bar(customRed)
))


#4) Add sign formatter to improvement over time

#Create your own formatter as the examples given:
#The one below is using the base of sign_formatter from the vignette:  https://cran.r-project.org/web/packages/formattable/vignettes/formattable-data-frame.html
#just a slight modification to have our color scheme and bolding
#Bioinfo.irc.ca has some great examples too: http://bioinfo.iric.ca/create-a-nice-looking-table-using-r/

improvement_formatter <- 
  formatter("span", 
            style = x ~ style(
              font.weight = "bold", 
              color = ifelse(x > 0, customGreen, ifelse(x < 0, customRed, "black"))))



formattable(i1, align =c("l","c","c","c","c", "c", "c", "c", "r"), list(
  `Indicator Name` = 
    formatter("span", style = ~ style(color = "grey",font.weight = "bold")), 
  `2011`= color_tile(customGreen, customGreen0),
  `2012`= color_tile(customGreen, customGreen0),
  `2013`= color_tile(customGreen, customGreen0),
  `2014`= color_tile(customGreen, customGreen0),
  `2015`= color_tile(customGreen, customGreen0),
  `2016`= color_tile(customGreen, customGreen0),
  `Average` = color_bar(customRed),
  `Improvement` = improvement_formatter
))



#5) For improvement formatter add icons

# Up and down arrow with greater than comparison from the vignette

improvement_formatter <- formatter("span", 
                                   style = x ~ style(font.weight = "bold", 
                                                     color = ifelse(x > 0, customGreen, ifelse(x < 0, customRed, "black"))), 
                                   x ~ icontext(ifelse(x>0, "arrow-up", "arrow-down"), x)
                                   )


formattable(i1, align =c("l","c","c","c","c", "c", "c", "c", "r"), list(
  `Indicator Name` = formatter("span", style = ~ style(color = "grey",font.weight = "bold")), 
  `2011`= color_tile(customGreen, customGreen0),
  `2012`= color_tile(customGreen, customGreen0),
  `2013`= color_tile(customGreen, customGreen0),
  `2014`= color_tile(customGreen, customGreen0),
  `2015`= color_tile(customGreen, customGreen0),
  `2016`= color_tile(customGreen, customGreen0),
  `Average` = color_bar(customRed),
  `Improvement` = improvement_formatter
))

##OR
#Thumbs up comparing to max value

improvement_formatter <- formatter("span", 
                                   style = x ~ style(font.weight = "bold", 
                                                     color = ifelse(x > 0, customGreen, ifelse(x < 0, customRed, "black"))), 
                                   x ~ icontext(ifelse(x == max(x), "thumbs-up", ""), x)
)


formattable(i1, align =c("l","c","c","c","c", "c", "c", "c", "r"), list(
  `Indicator Name` = formatter("span", style = ~ style(color = "grey",font.weight = "bold")), 
  `2011`= color_tile(customGreen, customGreen0),
  `2012`= color_tile(customGreen, customGreen0),
  `2013`= color_tile(customGreen, customGreen0),
  `2014`= color_tile(customGreen, customGreen0),
  `2015`= color_tile(customGreen, customGreen0),
  `2016`= color_tile(customGreen, customGreen0),
  `Average` = color_bar(customRed),
  `Improvement` = improvement_formatter
))
                                   
#6) Add a star to the max value.  Use  if/else value = max(value)


improvement_formatter <- formatter("span", 
                                   style = x ~ style(font.weight = "bold", 
                                                     color = ifelse(x > 0, customGreen, ifelse(x < 0, customRed, "black"))), 
                                   x ~ icontext(ifelse(x == max(x), "thumbs-up", ""), x)
)

## Based on Name

formattable(i1, align =c("l","c","c","c","c", "c", "c", "c", "r"), list(
  `Indicator Name` = formatter("span",
                     style = x ~ style(color = "gray"),
                     x ~ icontext(ifelse(x == "Prevalence of Tobacco Use", "star", ""), x)), 
  `2011`= color_tile(customGreen, customGreen0),
  `2012`= color_tile(customGreen, customGreen0),
  `2013`= color_tile(customGreen, customGreen0),
  `2014`= color_tile(customGreen, customGreen0),
  `2015`= color_tile(customGreen, customGreen0),
  `2016`= color_tile(customGreen, customGreen0),
  `Average` = color_bar(customRed),
  `Improvement` = improvement_formatter
))


##7)  Compare column to column

#Drop the rest and show just 2015 and 2016

i2 <- austinData %>%
  filter(`Indicator Name` %in% c('Prevalence of Obesity', 'Prevalence of Tobacco Use', 'Prevalence of Cardiovascular Disease', 'Prevalence of Diabetes')) %>%
  select(c(`Indicator Name`, `2015`, `2016`)) 

head(i2)

## Again the x is removed b/c you need to reference two column values, so you need to list them explicitly

formattable(i2, align =c("l","c","c"), list(
  `Indicator Name` = formatter("span",
                               style = ~ style(color = "gray")), 
  `2016`= formatter("span", style = ~ style(color = ifelse(`2016` >`2015`, "red", "green")),
                    ~ icontext(ifelse(`2016` >`2015`,"arrow-up", "arrow-down"), `2016`))

))

##8) Extras

formattable(i1, align =c("l","c","c","c","c", "c", "c", "c", "r"), list(
  `Indicator Name` = formatter("span",
                               style = ~ style(color = "gray"),
                               ~ icontext(ifelse(`Improvement` > 0, "star", ""), `Indicator Name`)), 
  `2011`= color_tile(customGreen, customGreen0),
  `2012`= color_tile(customGreen, customGreen0),
  `2013`= color_tile(customGreen, customGreen0),
  `2014`= color_tile(customGreen, customGreen0),
  `2015`= color_tile(customGreen, customGreen0),
  `2016`= color_tile(customGreen, customGreen0),
  `Average` = color_bar(customRed),
  `Improvement` = improvement_formatter
))

### Compare to an external value

max = max(i1$Improvement)

formattable(i1, align =c("l","c","c","c","c", "c", "c", "c", "r"), list(
  `Indicator Name` = formatter("span",
                               style = ~ style(color = "gray"),
                               ~ icontext(ifelse(`Improvement` == max, "star", ""), `Indicator Name`)), 
  `2011`= color_tile(customGreen, customGreen0),
  `2012`= color_tile(customGreen, customGreen0),
  `2013`= color_tile(customGreen, customGreen0),
  `2014`= color_tile(customGreen, customGreen0),
  `2015`= color_tile(customGreen, customGreen0),
  `2016`= color_tile(customGreen, customGreen0),
  `Average` = color_bar(customRed),
  `Improvement` = improvement_formatter
))


#### Make animation

## Help from here: https://cran.r-project.org/web/packages/magick/vignettes/intro.html#installing_magick

install.packages("magick")
library(magick)

#Read in images

d0 <- image_scale(image_read("i_datatable0.png"), "x150")
d1 <- image_scale(image_read("i_datatable1.png"), "x150")
d2 <- image_scale(image_read("i_datatable2.png"), "x150")
d3 <- image_scale(image_read("i_datatable3.png"), "x150")
d4 <- image_scale(image_read("i_datatable4.png"), "x150")
d5 <- image_scale(image_read("i_datatable5.png"), "x150")
d6 <- image_scale(image_read("i_datatable6.png"), "x150")
d7 <- image_scale(image_read("i_datatable7.png"), "x150")


#Image transition with no morph
i <- image_animate(c(d0, d1, d2, d3,d4, d5, d6, d7,d7), fps = 1)
image_write(i, "formattable.gif")
i

#Image transition with morph
frames <- image_morph(c(dt1, dt2, dt3,dt4, dt6, dt7), frames = 15)
ia1 <- image_animate(frames)
image_write(ia1, "datatable.gif")