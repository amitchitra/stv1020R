## Oppgaver før seminar 4

# Denne oppgaven er litt anderledes enn de andre oppgavene dere har fått før seminarer. Den er først og fremst ment 
# som trening i å løse problemer ved å tilegne seg nye ferdigheter i R på egenhånd. Dette er en ferdighet som ikke 
# trengs til prøven, men som kan være nyttig senere. Du kan derfor velge selv om du vil forsøke deg på oppgavene. 

### Oppgave 1:

# Lag et nytt datasett med utgangspunkt i `aidgrowth` datasettet fra seminar 3, der alle observasjoner som har
# missing-verdi på variablene `gdp_growth` og `aid` er fjernet.

# Hint: Du kan bruke denne koden som en del av en logisk test: `is.na(aidgrowth$gdp_growth)==F`


## Laster inn data
aidgrowth <- read.csv("https://raw.githubusercontent.com/langoergen/stv1020R/master/data/aidgrowth.csv",
                      stringsAsFactors = F)

## lager nytt datasett uten missing på aid og gdp_growth
preddata <- subset(aidgrowth, is.na(aidgrowth$gdp_growth)==F & is.na(aidgrowth$aid)==F)



### Oppgave 2:

#Finn ut hvordan du kan bruke funksjonen `predict()` på output fra `lm()` funksjonen 
# (se hjelpesider, og husk at googling er lov). Hent ut de predikerte verdiene til `gdp_growth` fra en bivariat 
# regresjonsmodell med `aid` som uavhengig variabel og `gdp_growth` som avhengig variabel, og lagre prediksjonene 
# som et objekt. Bruk datasettet du lagde i oppgave 1. 

#Hint: Du skal altså hente ut de verdiene som den bivariate regresjonsmodellen predikerer at observasjonene har på 
# `gdp_growth`fra regresjonsobjektet, ved hjelp av `predict()`.



# Koden under kan brukes til å lære mer om predict
#?predict
#?predict.lm

## Løsning:
m1 <- lm(gdp_growth ~ aid, data = preddata)
preds <- predict(m1)



### Oppgave 3:

#Finn ut hvordan du kan legge inn prediksjonene fra oppgave 2 i datasettet du opprettet i oppgave 1.

#Hint: `cbind()`


preddata <- cbind(preddata, preds)



### Oppgave 4 

# Lag først et histogram med prediksjonene av verdiene til `gdp_growth`, lag deretter et scatterplot mellom de 
# predikerte verdiene til `gdp_growth` (på x-aksen), og de faktiske verdiene til gdp_growth (på y-aksen).

library(ggplot2)
ggplot(preddata, aes(x = preds)) + geom_histogram()
ggplot(preddata, aes(x = preds, y = gdp_growth, col = aid)) + geom_point()
