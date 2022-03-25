

Scraping_Data <- function(con, twitter_token) {

# Scrapiing Data Tren

## get list trends indonesia
indo_trends <- get_trends("Indonesia")

indo_trends_1 <- indo_trends %>% select(trend,
                                        url,
                                        tweet_volume,
                                        place,
                                        as_of,
                                        created_at) %>% mutate(
                                          date = Sys.Date()
                                        )
head(indo_trends_1)
## Membuat Table List Top 1 Tren by Day
dbWriteTable(conn = con, 
             name = "Top1Tren_byDay", 
             value = indo_trends_1[1,], 
             append = TRUE, 
             row.names = TRUE, 
             overwrite=FALSE)


## Mengambil Tweet Tren teratas

Tweets = search_tweets(indo_trends_1$trend[1], n=100, type = 'mixed', include_rts = F)

Tweets_v1 <- Tweets %>% select(user_id, 
                               created_at, 
                               screen_name, 
                               text, 
                               source, 
                               favorite_count,
                               retweet_count,
                               status_url) %>% mutate(
                                 trend = indo_trends_1$trend[1],
                                 date = Sys.Date())

head(Tweets_v1)

## Membuat Table List Tweet pada Top 1 Trend by Day
dbWriteTable(conn = con, 
             name = "Tweet_Top1Tren", 
             value = Tweets_v1, 
             append = TRUE, 
             row.names = TRUE, 
             overwrite=FALSE)

}