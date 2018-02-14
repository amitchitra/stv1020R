# Du har fått i oppgave å analysere reaksjoner på Donal Trumps statuser gjennom valgkampen i 2016.
# Dataene du får du fra http://folk.uio.no/martigso/stv1020/testprove/trump_face.csv .
# Variabelbeskrivelse finnes i egen fil på fronter

# 0. Last inn data "trump_face.csv" 
trump <- read.csv("http://folk.uio.no/martigso/stv1020/testprove/trump_face.csv", stringsAsFactors = FALSE)
head(trump)

# 1. Opprett en ny variabel, "clinton_mentioned", som tar verdien 1 hvis variabelen "status_message" inneholder ordet "Clinton", og 0 ellers.
  # Hvor mange statuser ble Clinton nevnt i?
  # Hint: Se oppgave 2a fra seminar 4
trump$clinton_mentioned <- ifelse(grepl("Clinton", trump$status_message), 1, 0)
table(trump$clinton_mentioned)

# 2. Opprett to variabler som viser..
  # a. Prosent likes ("num_likes") av alle reaksjoner ("num_reactions")
trump$prop_likes <- (trump$num_likes / trump$num_reactions) * 100
  
  # b. Prosent sinte reaksjoner ("num_angrys") av alle reaksjoner ("num_reactions")
trump$prop_angry <- (trump$num_angrys / trump$num_reactions) * 100

# 3. Lag et boxplot som viser proporsjonen likes (fra oppgave 2) på y aksen og tidspunkt statusen ble delt på x-aksen ("time_of_day")
  
library(ggplot2)

ggplot(trump, aes(x = time_of_day, y = prop_likes)) +
  geom_boxplot() +
  theme_bw() +
  labs(x = "Tidspunkt status publisert", y = "Prosent likes")
  
  # a. Hvilket tidspunkt viser boxblotet lavest median på?
by(trump$prop_likes, trump$time_of_day, summary)

# 4. Lag et subset av data (nytt datasett), der bare statuser som er publisert på natten ("night") er med
night <- trump[which(trump$time_of_day == "night"), ]

  # a. Lag en korrelasjonsmatrise fra det originale datasettet (fra oppgave 1) mellom variablene fra oppgave 2 (prosent likes og angry), 
      # antall negative ord ("negative_words") og antall postive ord ("negative_words"). 
      # Slett enheter list-wise.
cor(trump[, c("prop_likes", "prop_angry", "positive_words", "negative_words")], use = "complete.obs")

  # b. Lag samme korrelasjonsmatrise som over, men på det nye datasettet med bare nattlige statuser
    # Slett enheter list-wise.
cor(night[, c("prop_likes", "prop_angry", "positive_words", "negative_words")], use = "complete.obs")

  # c. Signifikanstest en av korrelasjonene med begge datasettene. Kommenter kort resultatene.
cor.test(trump$prop_angry, trump$positive_words)
cor.test(night$prop_angry, night$positive_words)

# 5. Lag en regresjon fra det komplette datasettet, med antal sinte reaksjoner ("num_angrys") som avhengig variabel og
  # "positive_words" , "negative_words", om Clinton er nevnt, og dummysett av "time_of_day" som uavhengige variabler
angry_reg <- lm(num_angrys ~ positive_words + negative_words + clinton_mentioned + factor(time_of_day), data = trump)
  
  # a. Hvor mange flere sinte reaksjoner kan vi forvente Trump får om han nevner Clinton i statusen sin?
summary(angry_reg)

  # b. Sjekk om forutsettningen om normalfordelte restledd er oppfylt. Kommenter resultatet kort.
plot(density(resid(angry_reg)))

# 6. Gjør samme regresjon som oppgave 5, men nå med prosent sinte reaksjoner som avhengig variabel.
angry_reg2 <- lm(prop_angry ~ positive_words + negative_words + clinton_mentioned + factor(time_of_day), data = trump)
  
  # a. Sjekk om forutsettningen om normalfordelte restledd er oppfylt. Kommenter forskjellen fra oppgave 5a
plot(density(resid(angry_reg2)))
