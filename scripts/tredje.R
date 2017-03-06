# Oppgaver tredje seminar
# (Datasett: religion.csv)
  # Hver rad er en respondent i en survey

 
# Åpne prosjektet for R-seminarene
# 0. Last inn data "religion.csv" fra github
religion <- read.csv("https://raw.githubusercontent.com/martigso/stv1020R/master/data/religion.csv")

# 1. Vis hvordan du avdekker verdiene til variabelen "alder". Hva er den substansielle meningen til verdiene på variabelen?
table(religion$alder)

# 2. Opprett "alder_aar" med utgangspunkt i "alder", men men trekk fra surveyåret 2008.
  # a. Sjekk at variabelen "alder_aar" ble opprettet riktig.

religion$alder_aar <- 2008 - religion$alder

# 3. Omkod variabelen "alder_aar", slik at den blir sentrert til median.


# 4. Vis hvordan du finner bivariate korrelasjoner mellom "alder_aar", "aksept_homofili", "aksept_abort" og "aksept_aktiv_dodshjelp".
  # Utelat respondenter med missing list-wise. 
  # a. Hvor mange respondenter bygger korrelasjonene på? 
  # b. Hva kan det indikere dersom noen korrelasjoner er positive og andre negative?
  # c. Endres den substansielle meningen til noen av korrelasjonene når du ekskluderer “pairwise”.

cor(religion[, c("alder_aar", "aksept_homofili", "aksept_abort", "aksept_aktiv_dodshjelp")], use = "complete.obs")

cor(religion[, c("alder_aar", "aksept_homofili", "aksept_abort", "aksept_aktiv_dodshjelp")], use = "pairwise.complete.obs")


# 5. Vis hvordan du oppretter en tellevariabel “nMiss” som viser hvor mange missing enheten har på til sammen: 
  # "aksept_homofili", "aksept_abort", "aksept_aktiv_dodshjelp" har. 
  # Sjekk frekvensfordelingen til «nMiss»

religion$nmiss <- apply(religion[, c("aksept_homofili", "aksept_abort", "aksept_aktiv_dodshjelp")], 1, function(x) length(which(is.na(x))))

# 6. Lag et spredningsdiagram med "ant_barn" på x-aksen, og "aksept_abort" på y-aksen. La punktene ha størrelse basert på «alder_aar»
  # a. Tegn regresjonslinjen inn i spredningsdiagrammet.
  # b. Tegn konfidensintervallet til regresjonslinjen
  # c. Gjør en bivariat regresjonsanalyse med "aksept_abort" som avhengig variabel og "ant_barn" som uavhengig variabel
    # Stemmer regresjonen med det plotet viser?

library(ggplot2)
# a:
ggplot(religion, aes(x = ant_barn, y = aksept_abort))+
  geom_point()

# b:
ggplot(religion, aes(x = ant_barn, y = aksept_abort))+
  geom_point()+
  geom_smooth(method = "lm")

# c:
reg <- lm(aksept_abort ~ ant_barn, data = religion)
summary(reg)

# 7. Lagre skriptet
