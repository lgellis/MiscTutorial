######## Extra material and guides ########

# https://cran.r-project.org/web/packages/magick/vignettes/intro.html
# https://www.danielphadley.com/ggplot-logo/

######## Set Up Work ########

#Install necessary packages
install.packages("ggplot2")
install.packages("magrittr")
install.packages("magick")
install.packages("devtools") 
install.packages("curl")
install.packages("data.table")
install.packages("lubridate")
install.packages("devtools") 
library(devtools)
install_github("johannesbjork/LaCroixColoR")

#Load necessary packages
library(LaCroixColoR)
library(ggplot2)
library(magick)
library(magrittr)
library(curl)
library(data.table)
library(lubridate)

#Bring in the nasdaq  data from Nasdaq.com for the LaCroix parent company: National Beverage Corp
#https://www.nasdaq.com/symbol/fizz/historical

df= fread('https://raw.githubusercontent.com/lgellis/MiscTutorial/master/lacroix/FIZZ_Stock.csv')
attach(df)
df$mdy <-mdy(df$date)
df$month <- month(df$mdy, label = TRUE)
df$year <- as.factor(year(df$mdy))
df$wday <- wday(df$mdy, label = TRUE)
head(df)
attach(df)


######## Image One - The LaCroix Curve ########

# Create base plot
fizz <-ggplot(data=df, aes(x=mdy, y=close, color=year)) + 
  geom_point() + 
  ggtitle("FIZZ Stock (LaCroix Parent Company)") + 
  scale_color_manual(values=lacroix_palette("PeachPear",type = "continuous", n=11)) +
  labs(x = "Date", y="Closing Stock Price")

ggsave(fizz, file="fizz.png", width = 5, height = 4, dpi = 100)
plot <- image_read("fizz.png")
plot

#Bring in the gif - scale and rotate
laCroixAnimation <- image_read("https://media.giphy.com/media/h7ZuxGCxXTRMQ/giphy.gif") %>%
  image_scale("150") %>%
  image_rotate(-30)
laCroixAnimation

# Combine the plot and animation
# Set the Background image
background <- image_background(image_scale(plot, "500"), "white", flatten = TRUE)
# Combine and flatten frames
frames <- image_composite(background, laCroixAnimation, offset = "+150+120")
# Turn frames into animation
animation <- image_animate(frames, fps = 5)
print(animation)

#Save gif
image_write(animation, "laCroixImage1.gif")


######## Image Two - Climbing the Mountain! ########

#Use base plot previously created
#Bring in the gif - scale and rotate
laCroixAnimation <- image_read("https://media.giphy.com/media/l378xFKDBZO9Y5VUk/giphy.gif") %>%
  image_scale("300") %>%
  image_rotate(10)
laCroixAnimation
# Combine the plot and animation
# Background image
background <- image_background(image_scale(plot, "500"), "white", flatten = TRUE)
# Combine and flatten frames
frames <- image_composite(background, laCroixAnimation, offset = "+100+50")
# Turn frames into animation
animation <- image_animate(frames, fps = 5)
print(animation)

#Save gif
image_write(animation, "laCroixImage2.gif")

######## Image Three - Sad Decline ########

#Use base plot previously created
#Bring in the gif - scale
laCroixAnimation <- image_read("https://media.giphy.com/media/xUA7bfJ4OF11xXe4Fy/giphy.gif") %>%
  image_scale("80")
laCroixAnimation

# Background image
background <- image_background(image_scale(plot, "500"), "white", flatten = TRUE)
# Combine and flatten frames
frames <- image_composite(background, laCroixAnimation, offset = "+360+150")
# Turn frames into animation
animation <- image_animate(frames, fps = 10)
print(animation)

#Save gif
image_write(animation, "laCroixImage3.gif")

######## Other GIFs to Consider ########

# -girl -  https://media.giphy.com/media/3o6vXX2ppxY2MLFuTe/giphy.gif
# can - https://media.giphy.com/media/26vIfDdMIMR46bvQA/giphy.gif
#fun guy - https://media.giphy.com/media/h7ZuxGCxXTRMQ/giphy.gif

######## Other Fun Packages to Consider ########

# Create Memes -  https://cran.r-project.org/web/packages/meme/vignettes/meme.html




