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
# install.packages(ggplot2)
# install.packages(dplyr)
# install.packages(haven)

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


#### Oppgave 2 #### 

# 2. Vis hvordan du får frem frekvensfordelingen til variabelen "parti" med et stolpediagram.
#    - Bruk ggplot
#    - Forsøk å legge til tittel, tema, og nye navn langs aksene.



#### Oppgave 3 #####
# 3. Vis hvordan du får frem gjennomsnitt, median, standardavvik, variasjonsbredde og kvartildifferanse for 
#    variabelen "medietreff". Kommenter fordelingen til variabelen kort. Lag deretter et histogram ved hjelp
#    av geom_histogram() og et distribusjonsplot med geom_density(). Pynt plottene. Kommenter fordelingen på nytt.


#### Oppgave 4 ####
# 4. Gjør det samme som i forrige oppgave, men se på variabelen personstemmer i stedet. Kommenter


#### Oppgave 5 ####
# 5. Vis hvordan du undersøker korrelasjonen mellom «medietreff» og «personstemmer» med Pearson's R. 
#    - Hva forteller en korrelasjonstest om styrken og retningen på sammenhengen? 



#### Oppgave 6 ####
# 6. Vis hvordan du lager et scatterplot mellom medietreff og personstemmer ved hjelp av ggplot() og geom_point().
#    - Legg deretter til argumentet geom_smooth(method = "lm") til spredningsplottet. Denne linjen viser korrelasjonen
#    - Bruk plottet til å kommentere slutningen vi gjorde med korrelasjonstesten


#### Oppgave 7 #####
# 7. Lag en tabell som viser hvor mange enheter som har høyere verdi på personstemmer enn summen av gj.snitt
#    og standardavvik for variabelen. Gjør det samme for variabelen medietreff
#    - Bruk en logisk test inne i table-argumentet


#### Oppgave 8 ####
# 8. Vis hvordan du velger ut de enhetene som har lavere verdi enn gjennomsnitt + standardavvik på medietreff og
#    personstemmer. Lag et nytt datasett bestående av disse enhetene.
#    - Du kan kombinere koden fra forrige oppgave med which()
#    - Du kan dele opp denne oppgaven i flere linjer kode. Du kan også bruke &, som betyr også i R.
#    - Det finnes svært mange måter å løse denne oppgaven på. Du kan f.eks. bruke funksjonen subset i stedet for [].

#### Oppgave 9 ####
# 9. Gjenta oppgave 5 og oppgave 6 for det nye datasettet. Kommenter resultatene, er sammenhengen robust?



#### Bonus: ####
# Dersom du får tid til overs, forsøk å løse oppgave 8 ved å bruke funksjonen ifelse() i stedet for which()
?ifelse


