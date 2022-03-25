
Tweet_Posting <- function(con, twitter_token) {

# Mengabil data

query1 <- '
SELECT A.user_id, A.word, A.date, B.trend, C.tweet_volume
FROM "public"."Tweet_text_split" AS A 
LEFT JOIN "public"."Tweet_Top1Tren" AS B 
  ON A.user_id = B.user_id and A.date = B.date
LEFT JOIN "public"."Top1Tren_byDay" AS C
  ON B.trend = C.trend and B.date = C.date
'

df_tweet2 <- dbGetQuery(con, query1)
head(df_tweet2)

# Pivot Tabulasi Data
words <- df_tweet2 %>% count(word, sort=TRUE) 
words


# Ploting

wordcloud_img <- ggplot(
  words,
  aes(
    label = word, size = n,
    color = factor(sample.int(10, nrow(words), replace = TRUE))
  )
) +
  geom_text_wordcloud_area() +
  scale_size_area(max_size = 30) +
  theme_minimal()

# Saving Gambar
file <- tempfile( fileext = ".png")
ggsave(file, plot = wordcloud_img, device = "png", dpi = 144, width = 8, height = 8, units = "in" )

# Membuat Hashtag

hashtag <- c("ManajemenData","ManajemenDataStatistika", "github", "ElephantSQL", "SQL", "bot", "opensource", "PostgreSQL")


# Membuat Pesan Detailstatus

trends <- df_tweet2 %>% filter(date==Sys.Date())

status_details <- paste0( "#BotTweet_STA562","\n",
                          "ini rangkuman word" , "\n",
                          trends$trend[1]," yang menjadi Top 1 Trend Indonesia tanggal ", 
                          Sys.Date(), " dengan jumlah tweet sebanyak : ", trends$tweet_volume[1], " Tweet ",
                          "\n",
                          "\n",
                          paste0("#",hashtag, collapse=" ")
)

status_details


## Posting to Twitter

rtweet::post_tweet(
  status = status_details,
  media = file
)

}
