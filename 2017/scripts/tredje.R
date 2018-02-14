# Oppgaver tredje seminar
# (Datasett: religion.csv)
# Hver rad er en respondent i en survey


# Åpne prosjektet for R-seminarene
# 0. Last inn data "religion.csv" fra github
religion <- read.csv("https://raw.githubusercontent.com/martigso/stv1020R/master/data/religion.csv")
head(religion)


# 1. Vis hvordan du avdekker verdiene til variabelen "alder". Hva er den substansielle meningen til verdiene på variabelen?
table(religion$alder)

# 2. Opprett "alder_aar" med utgangspunkt i "alder", men men trekk fra surveyåret 2008.
# a. Sjekk at variabelen "alder_aar" ble opprettet riktig.
religion$alder_aar <- 2008 - religion$alder

# 3. Omkod variabelen "alder_aar", slik at den blir sentrert til median.
religion$alder_aar_sent <- religion$alder_aar - median(religion$alder_aar) 
table(religion$alder_aar, religion$alder_aar_sent)

# 4. Vis hvordan du finner bivariate korrelasjoner mellom "alder_aar", "aksept_homofili", "aksept_abort" og "aksept_aktiv_dodshjelp".
# Utelat respondenter med missing list-wise. 
# a. Hvor mange respondenter bygger korrelasjonene på? 
# b. Hva kan det indikere dersom noen korrelasjoner er positive og andre negative?
# c. Endres den substansielle meningen til noen av korrelasjonene når du ekskluderer “pairwise”.

cor(religion[, c("alder_aar", "aksept_homofili", "aksept_abort", "aksept_aktiv_dodshjelp")], use = "complete.obs")

cor.test(religion$alder_aar, religion$aksept_aktiv_dodshjelp, conf.level = 0.99)
?cor.test

cor(religion[, c("alder_aar", "aksept_homofili", "aksept_abort", "aksept_aktiv_dodshjelp")], use = "pairwise.complete.obs")

# install.packages(psych)
library(psych)
cor_mat <- corr.test(religion[, c("alder_aar", "aksept_homofili", "aksept_abort", "aksept_aktiv_dodshjelp")])
print(cor_mat, short = FALSE)

# 5. Vis hvordan du oppretter en tellevariabel “nMiss” som viser hvor mange missing enheten har på til sammen: 
# "aksept_homofili", "aksept_abort", "aksept_aktiv_dodshjelp" har. 
# Sjekk frekvensfordelingen til «nMiss»

religion$nmiss <- apply(religion[, c("aksept_homofili", "aksept_abort", "aksept_aktiv_dodshjelp")], 1, function(x) length(which(is.na(x))))

religion$miss1 <- ifelse(is.na(religion$aksept_homofili) == TRUE, 1, 0)
religion$miss2 <- ifelse(is.na(religion$aksept_abort) == TRUE, 1, 0)
religion$miss3 <- ifelse(is.na(religion$aksept_aktiv_dodshjelp) == TRUE, 1, 0)

religion$nmiss2 <- religion$miss1 + religion$miss2 + religion$miss3


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
class(reg)
summary(reg)

summary(lm(aksept_abort ~ ant_barn + alder_aar, data = religion))
summary(lm(aksept_abort ~ ant_barn + alder_aar_sent, data = religion))
# 7. Lagre skriptet