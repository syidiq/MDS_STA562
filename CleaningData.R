
Cleaning_Data <- function(con, twitter_token) {

query1 <- paste0('
                 SELECT user_id, text, date 
                 FROM "public"."Tweet_Top1Tren" 
                 WHERE date= ', "'",Sys.Date(),"'")


df_tweet <- dbGetQuery(con, query1)


#Get dataText
text1 <- df_tweet$text

# Set the text to lowercase
text2 <- tolower(text1)

#Pembersihan Data

text3 <- text2
text3 <- gsub("@\\w+", "", text3)
text3 <- gsub("@\\w+", "", text3)
text3 <- gsub("https?://.+", "", text3)
text3 <- gsub("\\d+\\w*\\d*", "", text3)
text3 <- gsub("#\\w+", "", text3)
text3 <- gsub("[^\x01-\x7F]", "", text3)
text3 <- gsub("[[:punct:]]", " ", text3)

text3 <- gsub("\n", " ", text3)
text3 <- gsub("^\\s+", "", text3)
text3 <- gsub("\\s+$", "", text3)
text3 <- gsub("[ |\t]+", " ", text3)
head(text3)

  
# Set Stopwords
stpword_id <- stopwords::stopwords("id", source = "nltk")
stpword_en <- stopwords::stopwords("en", source = "nltk")
stpword <- matrix(c(stpword_id,stpword_en),ncol=1)
colnames(stpword) <- 'word'
stpword_all <- data.frame(stpword)

# Parsing text dan clean stopword

text_df <- tibble(user_id = df_tweet$user_id, date = df_tweet$date, text = text3)

text_split <- text_df %>% unnest_tokens(word, text) %>% anti_join(stpword_all, by="word")
head(text_split)

## Membuat Table untuk siap di buat wordcloud
dbWriteTable(conn = con, 
             name = "Tweet_text_split", 
             value = text_split, 
             append = TRUE, 
             row.names = TRUE, 
             overwrite=FALSE)

}
