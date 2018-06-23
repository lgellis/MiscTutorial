#twitter - https://cran.r-project.org/web/packages/rtweet/vignettes/intro.html


### Twitter Tips
# Follow steps here to set up twitter account - https://github.com/mkearney/rtweet
# twitter app -#token - https://apps.twitter.com/app/new
# - make sure to uncheck "Enable Callback Locking (It is recommended to enable callback locking to ensure apps cannot overwrite the callback url)"

### Other Documentation

#Tidy text - https://www.tidytextmining.com/tidytext.html
#Wordcloud2 - https://cran.r-project.org/web/packages/wordcloud2/vignettes/wordcloud.html
#How to download a file from a URL - http://rfunction.com/archives/2222

install.packages("rtweet")
install.packages("tidytext")
install.packages("dplyr")
install.packages("stringr")
require(devtools)
install_github("lchiffon/wordcloud2")

library(tidytext)
library(dplyr)
library(stringr)
library(rtweet)
library(wordcloud2)

#Create twitter token
#replace with your values
create_token(
  app = "PLACE YOUR APP NAME HERE",
  consumer_key = "PLACE YOUR CONSUMER KEY HERE",
  consumer_secret = "PLACE YOUR CONSUMER SECRET HERE")

############# Handmaiden's Tale Tweets #############

#Grab tweets - note: reduce to 1000 if it's slow
?search_tweets
hmt <- search_tweets(
  "#HandmaidsTale", n = 2000, include_rts = FALSE
)

#Look at tweets
head(hmt)
dim(hmt)
hmt$text

#Unnest the words - code via Tidy Text

hmtTable <- hmt %>% 
  unnest_tokens(word, text)

#remove stop words - aka typically very common words such as "the", "of" etc

data(stop_words)

hmtTable <- hmtTable %>%
  anti_join(stop_words)

#do a word count

hmtTable <- hmtTable %>%
  count(word, sort = TRUE) 
hmtTable 

#Remove other nonsense words
hmtTable <-hmtTable %>%
  filter(!word %in% c('t.co', 'https', 'handmaidstale', "handmaid's", 'season', 'episode', 'de', 'handmaidsonhulu',  'tvtime', 
                      'watched', 'watching', 'watch', 'la', "it's", 'el', 'en', 'tv',
                      'je', 'ep', 'week', 'amp'))


#wordcloud2
wordcloud2(hmtTable, size=0.7)

#Visualize
#Create Palette
redPalette <- c("#5c1010", "#6f0000", "#560d0d", "#c30101", "#940000")
redPalette


#Download images for plotting
url = "https://raw.githubusercontent.com/lgellis/MiscTutorial/master/twitter_wordcloud/handmaiden.jpeg"
handmaiden <- "handmaiden.jpg"
download.file(url, handmaiden) # download file
url = "https://raw.githubusercontent.com/lgellis/MiscTutorial/master/twitter_wordcloud/resistance.jpeg"
resistance <- "resistance.jpeg"
download.file(url, resistance) # download file


#plots
wordcloud2(hmtTable, size=1.6, figPath = handmaiden, color=rep_len( redPalette, nrow(hmtTable) ) )
wordcloud2(hmtTable, size=1.6, figPath = resistance, color=rep_len( redPalette, nrow(hmtTable) ) )
wordcloud2(hmtTable, size=1.6, figPath = resistance, color="#B20000")

#extras
wordcloud2(hmtTable, size=0.7, color=rep_len( redPalette, nrow(hmtTable) ))
#use a letter or word
letterCloud(hmtTable, word = "HMT", size = 3)


############# West World Tweets #############

rt <- search_tweets(
  "#westworld", n = 2000, include_rts = FALSE
)


#unnest the words

westWorld <- rt %>% 
  unnest_tokens(word, text)

dim(westWorld)

westWorld$word

#remove stop words - aka typically very common words such as "the", "of" etc

data(stop_words)

westWorld <- westWorld %>%
  anti_join(stop_words)

dim(westWorld)

#do a word count

westWorld <- westWorld %>%
  count(word, sort = TRUE) 
westWorld 

#remove other nonsense

westWorld <-westWorld %>%
  filter(!word %in% c('t.co', 'https', 'westworld', 'episode', 'season', 'westworldhbo', 
                      'de', 'la', '2', 'tvtime', 'watched', 'da', 'con', 'eu', 'se', 'es', 'da'))
westWorld


#Visualize

greyPalette <- c("#2B2B2B", "#373D3F", #333333", "#303030", "#404040", "#484848", "#505050", "#606060", 
                 #444444", "#555555", "#666666", "#777777", "#888888", "#999999")
greyPalette

wordcloud2(westWorld, size=0.6, shape = "star", color=rep_len( greyPalette, nrow(summary4) ))
?wordcloud2

#download maze
url <- "https://raw.githubusercontent.com/lgellis/MiscTutorial/master/twitter_wordcloud/wwmaze2.jpg"
wwMaze <- "wwmaze2.jpg"
download.file(url, wwMaze) # download file

#download the WW logo
url = "https://raw.githubusercontent.com/lgellis/MiscTutorial/master/twitter_wordcloud/wwlogowithname.jpg"
wwLogo <- "wwlogowithname.jpg"
download.file(url, wwLogo) # download file

#wordclouds
wordcloud2(westWorld, size=2.6, figPath = wwMaze, color="black")
wordcloud2(westWorld, size=2.6, figPath = wwLogo, color=rep_len( greyPalette, nrow(westWorld) ) )
wordcloud2(westWorld, size=1.6, figPath = wwLogo, color="black" )


############# Summer of Data Science #############

rt <- search_tweets(
  "#SoDS18", n = 5000, include_rts = FALSE
)


#unnest the words

sods <- rt %>% 
  unnest_tokens(word, text)

dim(sods)

sods$word

#remove stop words - aka typically very common words such as "the", "of" etc

data(stop_words)

sods <- sods %>%
  anti_join(stop_words)

dim(sods)

#do a word count

sods <- sods %>%
  count(word, sort = TRUE) 
sods 

#remove other nonsense

sods <-sods %>%
  filter(!word %in% c('t.co', 'https'))
sods


#Visualize
wordcloud2(sods)
letterCloud(sods, word = "#SoDS18", size = 2)

#download the sods18 logo
url = "https://raw.githubusercontent.com/lgellis/MiscTutorial/master/twitter_wordcloud/sunglasses.jpg"
sun <- "sunglasses.jpg"
download.file(url, sun) 

#wordclouds
wordcloud2(sods)
#not working
wordcloud2(sods, size=2.6, figPath = sun)


