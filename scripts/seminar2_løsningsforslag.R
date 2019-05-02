#################################
#### R seminar 2           ######
#################################



## Dette er et forslag til hvordan du kan organisere et R-script
## Emner gjennomgått i seminaret:

## 1. Organisering av arbeidet ditt i R
## 2. Laste inn datasett
## 3. Statistiske mål (univariat og bivariat)
## 4. Grafikk (plot, ggplot)
## 5. Tabulering
## 6. Lagre output (write.csv, script, ggsave)


## Forberedelser

## Fjerner objekter fra R:
rm(list=ls())

## Setter working directory
setwd("C:/Users/Navn/R/der/du/vil/jobbe/fra")

## Installerer pakker (fjerne '#' og kjør dersom en pakke ikke er installert)
# install.packages("ggplot2")
# install.packages("dplyr")
# install.packages("haven")

## Laster inn pakker:
library(ggplot2)
library(dplyr)
library(haven)

#################################
#### Oppgaver til seminaret #####
#################################


## Dagens oppgaver fokuserer på 3 former for deskriptiv statistikk:
# 1. Statistiske mål
# 2. Grafikk
# 3. Tabulering

## Forsøk å anvende alle de statistiske målene du har lært, samt indeksering, for å få økt forståelse 
## av sammenhengene vi ser på i oppgavene.

#### Oppgave 1 #####

# 1. Last inn `personstemmer.csv` som et objekt i R
#     - Bruk read.csv()-funksjonen
#     - Husk å sende R inn i data-mappen
#     - Du skal bruke dette datasettet i alle oppgavene i dagens seminar

# metode 1:
personst <- read.csv("https://raw.githubusercontent.com/langoergen/stv1020R/master/data/personstemmer.csv",
         stringsAsFactors = F)

# metode 2: (forutsetter at dere har lagret datasettet i working directory)
personst <- read.csv("personstemmer.csv", stringsAsFactors = F)

## Kommentar: Argumentet stringsAsFactors = F gjør at variabler med tekst blir lagre som 'character' ikke som 'factor'
## Dersom vi setter til TRUE (default), blir tekstvariabler lagret som 'factor' i datasett-objektet vårt.

#### Oppgave 2 #### 

# 2. Vis hvordan du får frem frekvensfordelingen til variabelen "parti" med et stolpediagram.
#    - Bruk ggplot
#    - Forsøk å legge til tittel, tema, og nye navn langs aksene.


ggplot(personst, aes(x = parti)) +
  geom_bar() + 
  ggtitle("Et stolpediagram") + 
  labs(x = "Parti med stor P") + 
  theme_bw()


## Kommentar: Grunnfunksjonen i ggplot2-pakken er ggplot. Første argumentet i ggplot er et datasett, her personst. 
## Deretter følger argumentet aes, der vi spesifiserer navn på de variablene fra datasettet vi ønsker å plotte.
## x = spesifiserer en variabel på x-aksen, y = spesifiserer en variabel på y - aksen. Det er også mulig å legge til
## flere variabler. Denne funksjonen alene tegner opp et tomt plot med definerte akser. Vi kan nå legge til et 
## geom_ layer i plottet vårt, her geom_bar(). Et geom_ layer spesifiserer hvordan vi ønsker å plotte en variabel. 
## Vi legger til nye layers med + og en ny funksjon, som geom_bar. Forsøk å kjøre gjennom plottet ved å legge til
## en linje om gangen for å forstå hva som skjer 
## (ggtitle legger til tittel, labs gir nye navn til akser, mens theme_bw spesifiserer et tema). 




#### Oppgave 3 #####
# 3. Vis hvordan du får frem gjennomsnitt, median, standardavvik, variasjonsbredde og kvartildifferanse for 
#    variabelen "medietreff". Kommenter fordelingen til variabelen kort. Lag deretter et histogram ved hjelp
#    av geom_histogram() og et distribusjonsplot med geom_density(). Pynt plottene. Kommenter fordelingen på nytt.

summary(personst$medietreff) # gir alle tall vi trenger, bortsett fra standardavvik
sd(personst$medietreff) # gir standardavvik

## mean = 383.9
## median = 19.0
## standardavvik = 1908.455
## Variasjonsbredde = 258383
## kvartildifferanse = 130

# install.packages("ggthemes")
library(ggthemes) # Denne pakken inneholder flere tema, som gjør det lett å pynte plot.

ggplot(personst, aes(x = medietreff)) + 
  geom_histogram(bins = 100) +
  theme_tufte() +
  ggtitle("Histogram for medietreff")

ggplot(personst, aes(x = medietreff)) + 
  geom_density() +
  theme_tufte() +
  ggtitle("Fordelingen til medietreff")

## Variabelen er ekstremt skjevfordelt, de fleste enhetene har ingen eller få medietreff, 
## men noen få har ekstremt mange.



#### Oppgave 4 ####
# 4. Gjør det samme som i forrige oppgave, men se på variabelen personstemmer i stedet. Kommenter

summary(personst$personstemmer)
sd(personst$personstemmer)

ggplot(personst, aes(x = personstemmer)) + 
  geom_histogram(bins = 100) +
  theme_tufte() +
  ggtitle("Histogram for personstemmer")

ggplot(personst, aes(x = personstemmer)) + 
  geom_density() +
  theme_tufte() +
  ggtitle("Fordelingen til personstemmer")

## Variabelen er ekstremt skjevfordelt, de fleste enhetene har ingen eller få personstemmer, 
## men noen få enheter har ekstremt mange.

#### Oppgave 5 ####
# 5. Vis hvordan du undersøker korrelasjonen mellom «medietreff» og «personstemmer» med Pearson's R. 
#    - Hva forteller en korrelasjonstest om styrken og retningen på sammenhengen? 

cor(personst$personstemmer, personst$medietreff) # korrelasjon
cor.test(personst$personstemmer, personst$medietreff) # korrelasjon + t-test av korrelasjonen (H0 er korrelasjon = 0)

## Korrelasjonen er sterkt positiv (0.65), og signifikant forskjellig fra 0 (p.verdi < 0.001). 
## kommentar: p-value < 2.2e-16 betyr at du må legge til 16 0-er før 2.2. P-verdien er altså svært lav.


#### Oppgave 6 ####
# 6. Vis hvordan du lager et scatterplot mellom medietreff og personstemmer ved hjelp av ggplot() og geom_point().
#    - Legg deretter til argumentet geom_smooth(method = "lm") til spredningsplottet. Denne linjen viser korrelasjonen
#    - Bruk plottet til å kommentere slutningen vi gjorde med korrelasjonstesten

ggplot(personst, aes(x = medietreff, y = personstemmer)) + 
  geom_point() + 
  theme_tufte()

# med linje, legg merke til at det er mulig å legge flere geom layers over hverandre!
ggplot(personst, aes(x = medietreff, y = personstemmer)) + 
  geom_point() + 
  geom_smooth(method = "lm") +
  theme_tufte()

## Vi ser at det er noen ekstremverdier på variablene, de fleste har få personstemmer og medietreff. 
## Derfor har vi ikke det mest robuste grunnlaget for å trekke slutninger om sammenhengen mellom medietreff og 
## personstemmer for alle typer enheter, vi har kun mye informasjon om dem med få medietreff/personstemmer.
## Se gjerne på den matematiske definisjonen av korrelasjon, og tenk gjennom hva som skjer når korrelasjonen
## mellom disse to variablene beregnes!


#### Oppgave 7 #####
# 7. Lag en tabell som viser hvor mange enheter som har høyere verdi på personstemmer enn summen av gj.snitt
#    og standardavvik for variabelen. Gjør det samme for variabelen medietreff
#    - Bruk en logisk test inne i table-argumentet

# logisk test:
personst$personstemmer > mean(personst$personstemmer) + sd(personst$personstemmer)
# setter logisk test inn i tabell:
table(personst$personstemmer > mean(personst$personstemmer) + sd(personst$personstemmer))

## tilsvarende for medietreff:
personst$medietreff > mean(personst$medietreff) + sd(personst$medietreff)
# setter logisk test inn i tabell:
table(personst$medietreff > mean(personst$medietreff) + sd(personst$medietreff))

# svært få enheter som har verdi på variablene over et standardavvik høyere enn gjennomsnittet.

#### Oppgave 8 ####
# 8. Vis hvordan du velger ut de enhetene som har lavere verdi enn gjennomsnitt + standardavvik på medietreff og
#    personstemmer. Lag et nytt datasett bestående av disse enhetene.
#    - Du kan kombinere koden fra forrige oppgave med which()
#    - Du kan dele opp denne oppgaven i flere linjer kode. Du kan også bruke &, som betyr også i R.
#    - Det finnes svært mange måter å løse denne oppgaven på. Du kan f.eks. bruke funksjonen subset i stedet for [].
#    - Dersom du har tid til overs, forsøk å løse oppgave 8 ved å bruke funksjonen ifelse() i stedet for which()

# logiske tester: motsatt av forrige oppgave
personst$medietreff < mean(personst$medietreff) + sd(personst$medietreff)
personst$personstemmer < mean(personst$personstemmer) + sd(personst$personstemmer)

# velger enhetene som har lavere verdi enn summen av gjennomsnitt og standardavvik:
which(personst$medietreff < mean(personst$medietreff) + sd(personst$medietreff) &
      personst$personstemmer < mean(personst$personstemmer) + sd(personst$personstemmer))
# & lar oss kombinere flere logiske tester

## indekserer enehetene som består logisk test:
personst[which(personst$medietreff < mean(personst$medietreff) + sd(personst$medietreff) &
                 personst$personstemmer < mean(personst$personstemmer) + sd(personst$personstemmer)),]

## Lager nytt datasett med enhetene:
nydata <- personst[which(personst$medietreff < mean(personst$medietreff) + sd(personst$medietreff) &
                 personst$personstemmer < mean(personst$personstemmer) + sd(personst$personstemmer)),]

## Alternativ fremgangsmåte med pakken dplyr (%>% fungerer som + i ggplot):
#install.packages("dplyr)
library(dplyr)

nydata <- personst %>%
  filter(medietreff < sd(medietreff) + mean(medietreff) &
         personstemmer < sd(personstemmer) + mean(personstemmer))


## ifelse og dplyr

personst$filtrering <- ifelse(personst$medietreff < sd(personst$medietreff) + mean(personst$medietreff), 1, 0)
personst$filtrering2 <- ifelse(personst$personstemmer < sd(personst$personstemmer) + mean(personst$personstemmer), 1, 0)

personst %>%
  filter(filtrering==1 & filtrering2==1)

#### Oppgave 9 ####
# 9. Gjenta oppgave 5 og oppgave 6 for det nye datasettet. Kommenter resultatene, er sammenhengen robust?

cor(nydata$medietreff, nydata$personstemmer)
cor.test(nydata$medietreff, nydata$personstemmer)

# korrelasjon signifikant forskjellig fra 0 og positiv, men mye svakere enn i sted (da var den 0.65)

ggplot(nydata, aes(x = medietreff, y = personstemmer)) + 
  geom_point() + 
  theme_tufte()

# med linje, legg merke til at det er mulig å legge flere geom layers over hverandre!
ggplot(nydata, aes(x = medietreff, y = personstemmer)) + 
  geom_point() + 
  geom_smooth(method = "lm") +
  theme_tufte()

## Kommentar: vi har zoomet inn på hjørnet nede til venstre i de tidligere plottene.
## Vi ser fortsatt en positiv sammenheng, men legg merke til at mange enheter har 0 medietreff og mange personstemmer
## Dette viser at ekstremverdiene til variablene personstemmer og medietreff hadde svært stor innflytelse på 
## verdien vi beregnet for pearsons R. Se nærmere på funksjonen for pearsons R for å forstå hva som skjer.



#### Oppgave 10 ####
# 10. Opprett en dummyvariabel som tar verdien 1 for kvinnelige ap-politikere. Lag deretter en tabell som viser hvor
#     mange kvinnelige og mannlige ap-politikere som har mer enn 500 medietreff. 
#     Gjør tilsvarende sammeligning for høyre (h).
#     - Du kan bruke både which og ifelse, eller lage nytt datasett for å lage tabell, bruk av ny dummy er ikke påkrevd. 
#     - Kvinner har verdien 1 på variabelen kjonn. 
#     - Dersom ø'en i variabelnavnet kjonn er lest inn feil, fiks dette med colnames(personst)[8] <-  "kjonn"

names(personst) # vi er interessert i variablene kjonn og parti
table(personst$parti) # vi er interessert i enheter med verdien ap
table(personst$kjonn) # kvinner har verdien 1 på dummy-variabelen for kjonn, menn har verdien 0

# logiske test:
table(personst$parti == "ap" & personst$kjonn == 1) 
# tabellen lar oss se hvor mange enheter som skal ha verdien 1 på dummy-variabelen vi oppretter


## Fremgangsmåte 1: bruker which
which(personst$parti == "ap" & personst$kjonn == 1) 

# kaller den nye variabelen apkvinne, setter alle verdier til 0
personst$apkvinne <- 0

table(personst$apkvinne) # ser at alle enheter har verdien 0

## Kode for å indeksere apkvinner
personst[which(personst$parti == "ap" & personst$kjonn == 1), "apkvinne"] 

## Vi kan bruke assigment operatoren til å endre verdien til apkvinner
personst[which(personst$parti == "ap" & personst$kjonn == 1), "apkvinne"] <- 1
table(personst$apkvinne) # Vi ser at koden virket

## Fremgangsmåte 2: bruker ifelse()

## Forklaring av syntaks til ifelse():
# ifelse("logisk test", output hvis TRUE, output hvis FALSE)

ifelse(personst$parti == "ap" & personst$kjonn == 1, 1, 0) # koden returnerer 1 og 0
table(ifelse(personst$parti == "ap" & personst$kjonn == 1, 1, 0)) # koden returnerer forventet antall apkvinner (1ere)

# Logisk test av at de to fremgangsmåtene returnerer samme resultat:
table(ifelse(personst$parti == "ap" & personst$kjonn == 1, 1, 0) == personst$apkvinne) # fremgangsmåtene gir samme resultat!

# overskriver variabel:
personst$apkvinne <- ifelse(personst$parti == "ap" & personst$kjonn == 1, 1, 0)


## For dem som synes dplyr er kult, er det mulig å bruke funksjonen mutate() sammen med ifelse()
names(personst)
personst <- personst %>%
  mutate(apkvinne = ifelse(parti == "ap" & kjonn == 1, 1, 0))

# I dette eksempelet er det ikke et stort poeng å bruke dplyr.
# Dersom vi imidlertid skulle kodet om mange variabler samtidig, 
# ville det vært et større poeng, la meg illustrere:


personst <- personst %>%
  mutate(apkvinne = ifelse(parti == "ap" & kjonn == 1, 1, 0),
         apmann = ifelse(parti == "ap" & kjonn == 0, 1, 0) 
         )

# Man kan kode om mange variabler inne i mutate, det gir god organisering
# og kortere kode ved mange omkodinger.


#### Oppgave 11 (Bonusoppgave for spesielt interesserte) ####
# 11. Lag 4 nye datasett, et for dem som har parti == "ap", "krf", "sv" og "h".   
# Lag deretter din egen funksjon som returnerer verdien TRUE dersom det
# er sant at en høyere andel menn enn kvinner har blitt kummulert, FALSE hvis ikke.
# Anvend denne funksjonen på de fire datasettene du nettopp opprettet.
# Husk fra seminar 1: du oppretter en funksjon med:
# funksjonsnavn <- function(argumentnavn) {
# "det din funksjon skal gjøre her"
#}
# Løs oppgaven ved å først skrive kode for å test om det menn har høyere gj.snitt
# enn kvinner, jobb deretter med å flytte koden inn i en funksjon.


# Oppretter datasett
ap <- personst %>%
  filter(parti == "ap")
krf <- personst %>%
  filter(parti == "krf")
sv <- personst %>%
  filter(parti == "sv")
h <- personst %>%
  filter(parti == "h")


# Hvordan teste om en større andel menn har blitt kummulert?
# Vi må indeksere oss frem til menn og kvinner, deretter beregne andeler kummulerte, før vi sammenligner
apmenn <- ap %>%
  filter(kjonn==0)
# andel - dette kan gjøres penere, men her bruker jeg omtrent bare kode dere
# har lært så langt

# dummy for om du er kummulert eller ikke
apmenn$kumm_d <- ifelse(apmenn$kummulert == "Ja", 1, 0) 

sum(apmenn$kumm_d) # antall kummulerte apmenn

sum(apmenn$kumm_d)/nrow(apmenn) # antall kummulerte delt på totalt antall

# nrow teller antall observasjoner i et datasett

# samme for kvinner
apkvinner <- ap %>%
  filter(kjonn==1)

apkvinner$kumm_d <- ifelse(apkvinner$kummulert == "Ja", 1, 0) 

sum(apkvinner$kumm_d) # antall kummulerte apkvinner

sum(apkvinner$kumm_d)/nrow(apkvinner) # antall

## Sammenligning:

sum(apmenn$kumm_d)/nrow(apmenn)>sum(apkvinner$kumm_d)/nrow(apkvinner)


## Lager funksjon - nøkkelen er å se at alt er 
## copy-paste for hvert datasett, bortsett fra navn på datasett.
## Dermed må vi spesifisere datasettnavn som et funksjonsargument,
## ellers kan vi bare putte resten av koden over rett inn i en funksjon:

mannsdominans <- function(parti){
  
  menn <- parti %>%
    filter(kjonn==0)
  # andel - dette kan gjøres penere, men her bruker jeg omtrent bare kode dere
  # har lært så langt
  
  # dummy for om du er kummulert eller ikke
  menn$kumm_d <- ifelse(menn$kummulert == "Ja", 1, 0) 
  
  sum(menn$kumm_d) # antall kummulerte apmenn
  
  sum(menn$kumm_d)/nrow(menn) # antall kummulerte delt på totalt antall
  
  # nrow teller antall observasjoner i et datasett
  
  # samme for kvinner
  kvinner <- parti %>%
    filter(kjonn==1)
  
  kvinner$kumm_d <- ifelse(kvinner$kummulert == "Ja", 1, 0) 
  
  sum(kvinner$kumm_d) # antall kummulerte apkvinner
  
  sum(kvinner$kumm_d)/nrow(kvinner) # antall
  
  ## Sammenligning:
  
  sum(menn$kumm_d)/nrow(menn)>sum(kvinner$kumm_d)/nrow(kvinner)
}
mannsdominans(h)
mannsdominans(sv)
mannsdominans(krf)
mannsdominans(ap)

# Dersom du har kommet så langt, kan du forsøke å videreutvikle funksjonen,
# slik at den lar seg anvende for alle partier i datasettet personst
# Hint: sett inn koden for å opprette partibaserte datasett i starten
# av funksjonen.

