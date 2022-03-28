# MDS_STA562
Ini adalah Twitter Bot yang memposting data Top 1 Tren Indonesia. Prosesnya dimulai dari scraping 100 tweet pada Top 1 trending di Indonesia lalu di simpah ke @ElephantSQL dengan menghasilkan dua database yaitu "Tweet_Top1Tren" dan "Top1Tren_byDay", yang dilakukan pada Script ["ScrapingData.R"]. Lalu dilakukan cleaning data text tweet dan di lakukan spliting data agar siap untuk di analisis disimpan di @ElephantSQL menghasilkan database "Tweet_text_split", yang dilakukan pada sricpt ["CleaningData.R"]. Selanjutnya data dianalisis (melakukan tabulasi dan visualisasi) dan diposting ke twitter yang terdiri dari topik Top 1 Tren Indonesia, tanggal, jumlah tweet, plot word-frequency, dan hastag, yang dilakukan pada script ["TweetPosting.R"]. Proses ini dilakukan secara otomatis setiap jam 12 siang dan 11 malam yang dimana ketiga scrpit tersbukan akan dijalankan secara berururtan olej script ["Deploy_v1.R"]. Hasilnya dapat dilihat melalui akun twitter @MsaStat.

Semua ini dikerjakna oleh:

G1501211009 Muhammad Syidiq Abdjanur

G1501211032 Madania Tetiani Agusta

G1501211068 Wa Ode Rona Freya

Berikut ER Databse pada ElephantSQL
![Screenshot 2022-03-28 193046](https://user-images.githubusercontent.com/41407658/160400038-dfe83534-2aee-4646-a0e0-36c02214b649.png)
