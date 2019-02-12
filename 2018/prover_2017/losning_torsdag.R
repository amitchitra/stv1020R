rm(list = ls())

# Oppgave 1 
# Laster inn Trump twitter-data
trump_tweets <- read.csv("http://folk.uio.no/martigso/baaap/trump_tweets.csv", stringsAsFactors = FALSE)

# Oppgave 2
# Lager en ny variabel -- obama_mentioned -- som tar verdien 1 hvis Obama ble nevnt i en tweet, og 0 ellers
trump_tweets$obama_mentioned <- ifelse(grepl("Obama", trump_tweets$tekst), 1, 0)
table(trump_tweets$obama_mentioned)

# Oppgave 3
# Laster inn pakken ggplot2
# install.packages("ggplot2")
library(ggplot2)

# Lager et bar-plot over den dikotome variabelen "obama_mentioned"
ggplot(trump_tweets, aes(x = obama_mentioned)) +
  geom_bar()

# Målet kan vise seg problematisk i en evt regresjonsanalyse fordi det er litt få enheter som har verdien 1,
  # altså er det litt lite variasjon i målet

# Oppgave 4
# Lager en variabel -- pr_sentiment -- som viser proposjon sentiment av antall ord i hver tweet
trump_tweets$pr_sentiment <- (trump_tweets$positive_ord + trump_tweets$negative_ord) / trump_tweets$totalt_antall_ord

# Oppgave 5
# Lager et subset der alle tweets uten sentiment blir fjernet
trump_neg <- trump_tweets[which(trump_tweets$pr_sentiment > 0), ]

# Oppgave 6
# Lager et bivariat regresjonsplot av proposjon sentiment og antall personer som har trykket
  # "favorite" på twitter-meldingen
ggplot(trump_neg, aes(x = pr_sentiment, y = favoritter))+
  geom_smooth(method = "lm")

# Om vi også legger til punkter i plotet ser vi at det er mange uteliggere med ekstreme verdier, dette bør undersøkes
  # nærmere om man skal gjøre valide slutninger fra den bivariate regresjonen. Effekten viser seg også forsvinnende liten
  # i forhold til det første plottet, som forfører leseren til å tro at effekten er stor.

ggplot(trump_neg, aes(x = pr_sentiment, y = favoritter))+
  geom_smooth(method = "lm") +
  geom_point()

# Oppgave 7
# Oppretter et OLS-objekt med "favoritter" som avhengig variabel og proporsjon sentiment, om Obama blir nevnt og
  # tidspunkt for tweeten som uavhengige variabler.
reg <- lm(favoritter ~ pr_sentiment + factor(obama_mentioned) + factor(tidspunkt), data = trump_tweets)

# Viser resultatene
summary(reg)

# Effekten av nattlige tweets kan tolkes som følger:
  # Gitt modellen, kan vi forvente  584 flere "favoritter" når Trump tweeter på natten i forhold til når han tweeter på natten

# Oppgave 8
# Lager OLS-objekt med samme spesifikasjon som over, bare nå også kontrollert for fixed effects av år
reg2 <- lm(favoritter ~ pr_sentiment + factor(obama_mentioned) + factor(tidspunkt) + factor(aar), data = trump_tweets)

# Sjekker resultatene
summary(reg2)

# Vi kan nå se at, ved å kontrollere for tid, har forklart varians av Y (R2) gått fra 0.05% til 36.38%. Dette er en betydelig økning, 
  # og vi ser at estimatet for 2016 er veldig høyt. Trolig er dette forklart av eksponeringen og fokuset av Trumps twitter-bruker
  # under den Amerikanske valgkampen.


