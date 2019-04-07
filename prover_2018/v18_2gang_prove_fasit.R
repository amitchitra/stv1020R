#########################################
### Løsningsforslag v18_2gang_prove #####
#########################################

#### Forberedelser:

rm(list = ls())

# Pakker - fjern # foran install.pacakges hvis du ikke har installert pakken
#install.packages("dplyr")
#install.packages("ggplot2")

library(dplyr)
library(ggplot2)

#### Oppgave 1 ####

beer <- read.csv("https://raw.githubusercontent.com/langoergen/stv1020R/master/data/beer.csv",
                 stringsAsFactors = F)
load("data/beer.Rdata")

#### Oppgave 2 ####

str(beer) # Viser klassen til alle variablene i datasettet

#### Oppgave 3 ####

ggplot(beer, aes(x = beertax, y = mrall)) + 
  geom_point() +
  geom_smooth(method = "lm")

#### Oppgave 4 ####

# Med dplyr:

beer2 <- beer %>% 
  select(year, mrall, beertax, vmiles, unrate, perinc)

# Med [,]-indeksering

beer3 <- beer[,c("year", "mrall", "beertax", "vmiles", "unrate", "perinc")]

cor(beer2)
cor.test(beer2$beertax, beer2$mrall)

# Positiv korrelasjon, statistisk signifikant forskjellig fra 0 (svært lav p-verdi)


#### Oppgave 5 ####

# dplyr
beer1982 <- beer %>%
  filter(year == 1982) 

beer1988 <- beer %>%
  filter(year == 1988)

# subset:

beer1982 <- subset(beer, year==1982)
beer1988 <- subset(beer, year==1988)

summary(beer1982)
summary(beer1988) # Gir informasjonen oppgaven ber om, skriv kort kommentar!


#### Oppgave 6 ####

table(beer$jaild, beer$comserd)

beer$punishment <- ifelse(beer$jaild == "no" & beer$comserd == "no", 0, 1)

# test av omkoding:
table(beer$jaild, beer$comserd, beer$punishment)


#### Oppgave 7 ####

m1 <- lm(mrall ~ beertax + vmiles +  unrate + perinc, data = beer)
summary(m1)

# Koeffisienten til beertax er bare svakt statistisk signifikant (p-verdi 0.067),
# men koeffisienten indikerer at den forventede effekten av økt beertax
# er flere dødsfall i trafikken


# Substansiell tolkning:

summary(beer$mrall) # rundt 2 i snitt - min like under 1, maks over 4

m1$coefficients[2]
(max(beer$beertax)- min(beer$beertax))*m1$coefficients[2] # maksimal effekt
sd(beer$beertax)*m1$coefficients[2] # "typisk effekt"

# Effekten er ikke så enorm, i en stat med millioner av innbyggere 
# kan det bli mange menneskeliv, så politikere (og jeg) vil nok tenke at 
# effekten er substansielt sterk, selv om den forklarer lite av variansen
# til avh. var (dere trenger ikke tolke like grundig som jeg gjør her)

#### Oppgave 8 ####

beer$state_fac <- as.factor(beer$state)

ggplot(beer, aes(x = state_fac, y = mrall)) + geom_boxplot()

# Store variasjoner mellom stater

#### Oppgave 9 ####

summary(m2 <-lm(mrall ~  beertax + vmiles + unrate + perinc + state, data = beer))
