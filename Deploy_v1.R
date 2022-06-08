
# Loading Library
library(tidyverse)
library(leaps)
library(skimr)
library(ggplot2)
library(dplyr)
library(stopwords)
library(ggwordcloud)
library(tidytext)
library(rstudioapi)
library(RColorBrewer)


# Create Twitter token API ------------------------------------

library(rtweet)

API_Key <- Sys.getenv("TWITTER_API_KEY")
API_Key_Secret <- Sys.getenv("TWITTER_API_KEY_SECRET")
Access_Token <- Sys.getenv("TWITTER_ACCESS_TOKEN")
Access_Token_Secret <- Sys.getenv("TWITTER_ACCESS_TOKEN_SECRET")



twitter_token <- rtweet::create_token(
  app = 'msa_v3',
  consumer_key = API_Key,
  consumer_secret = API_Key_Secret,
  access_token = Access_Token,
  access_secret = Access_Token_Secret
)



# Create API Database ElephanSQL ------------------------

library(RPostgreSQL)

drv <- dbDriver("PostgreSQL")

dbnames <- Sys.getenv("DB_DBNAMES")
pass <- Sys.getenv("DB_PASS")
hosts <- Sys.getenv("DB_HOSTS")

con <- dbConnect(drv,
                 dbname = dbnames, 
                 host = hosts,
                 port = 5432,
                 user = dbnames,
                 password = pass
)


## batas ==================================================================
 
#pht = getSourceEditorContext()$path
#pht = gsub("/Deploy_v1.R", "", pht)

setwd(getwd())
source('ScrapingData.R')
source('CleaningData.R')
source('TweetPosting.R')

Scraping_Data(con, twitter_token)
Cleaning_Data(con, twitter_token)
Tweet_Posting(con, twitter_token)

on.exit(dbDisconnect(con))
