# Før seminar 4
Erlend Langørgen  
April 2, 2018  



## Oppgaver før seminar 4

Denne oppgaven er litt anderledes enn de andre oppgavene dere har fått før seminarer. Den er først og fremst ment som trening i å løse problemer ved å tilegne seg nye ferdigheter i R på egenhånd. Dette er en ferdighet som ikke trengs til prøven, men som kan være nyttig senere. Du kan derfor velge selv om du vil forsøke deg på oppgavene eller ikke.

### Oppgave 1:

Lag et nytt datasett med utgangspunkt i `aidgrowth` datasettet fra seminar 3, der alle observasjoner som har missing-verdi på variablene `gdp_growth` og `aid` er fjernet.

Hint: Du kan bruke denne koden som en del av en logisk test: `is.na(aidgrowth$gdp_growth)==F`

### Oppgave 2:

Finn ut hvordan du kan bruke funksjonen `predict()` på output fra `lm()` funksjonen (se hjelpesider, og husk at googling er lov). Hent ut de predikerte verdiene til `gdp_growth` fra en bivariat regresjonsmodell med `aid` som uavhengig variabel og `gdp_growth` som avhengig variabel, og lagre prediksjonene som et objekt. Bruk datasettet du lagde i oppgave 1. 

Hint: Du skal altså hente ut de verdiene som den bivariate regresjonsmodellen predikerer at observasjonene har på `gdp_growth`fra regresjonsobjektet, ved hjelp av `predict()`.

### Oppgave 3:

Finn ut hvordan du kan legge inn prediksjonene fra oppgave 2 i datasettet du opprettet i oppgave 1.

Hint: `cbind()`

### Oppgave 4 

Lag først et histogram med prediksjonene av verdiene til `gdp_growth`, lag deretter et scatterplot mellom de predikerte verdiene til `gdp_growth` (på x-aksen), og de faktiske verdiene til gdp_growth (på y-aksen).








