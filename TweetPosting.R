

# Loading Library
library(tidyverse)
library(leaps)
library(skimr)
library(ggplot2)
library(dplyr)
library(stopwords)
library(ggwordcloud)
library(tidytext)


# Create API Database ElephanSQL ------------------------

library(RPostgreSQL)

drv <- dbDriver("PostgreSQL")

dbnames <- 'ugrcwdha'
pass <- '37hjgVJNTjCdx6ncq1A6NmoWhRExsrLi'
hosts <- 'topsy.db.elephantsql.com'

con <- dbConnect(drv,
                 dbname = dbnames, 
                 host = hosts,
                 port = 5432,
                 user = dbnames,
                 password = pass
)

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
  scale_size_area(max_size = 24) +
  theme_minimal()

## Saving Gambar
file <- tempfile( fileext = ".png")
ggsave(file, plot = wordcloud_img, device = "png", dpi = 144, width = 8, height = 8, units = "in" )

## Membuat Hashtag

hashtag <- c("ManajemenData","ManajemenDataStatistika", "github","rvest","rtweet", "ElephantSQL", "SQL", "bot", "opensource", "ggplot2","PostgreSQL","RPostgreSQL")


