###################################################
##### Løsningsforslag R-prøve 2 STV 1020 V18 ###### 
###################################################

##### Forberedelser: #####

## install.packages("car")
## install.packages("ggplot2")
## install.packages("dplyr")

library(car)
library(ggplot2)
library(dplyr)


rm(list = ls())
setwd() # sett working directory til mappen der pinochet.csv er lagret
##### Oppgave 1 #####

pinochet <- read.csv("pinochet.csv")

##### Oppgave 2 #####
table(is.na(pinochet$vote)) # alternativ 1
summary(pinochet$vote) # alternativ 2
# Det er 168 missing på vote-variabelen

##### Oppgave 3 ######
ggplot(pinochet, aes(x= income)) + geom_histogram(bins = 100)

##### Oppgave 4 ######
pinochet$decided_vote <- ifelse(pinochet$vote == "Y", 1, NA)
pinochet$decided_vote <- ifelse(pinochet$vote == "N", 0, pinochet$decided_vote)
table(pinochet$decided_vote, pinochet$vote) # tabellen viser at omkodingen ble riktig

##### Oppgave 5 ######
names(pinochet)
cor(pinochet[,c("age", "income", "statusquo")], use = "complete.obs")

cor.test(pinochet$age, pinochet$income, na.rm = T) 
# Korrelasjonen er negativ, men ikke signikant forskjellig fra med 0.05-signifikansnivå (p-verdi er 0.099)

##### Oppgave 6 #####
m1 <- lm(statusquo ~ age + income + education + sex, data = pinochet)
summary(m1)

## Den forvented effekten av en enhetsøkning i alder på statusquo er en økning i statusquo på 0.004492
## Selv om effekten er signifikant forskjellig fra 0, er den ikke veldig substansielt betydningsfull, da
sd(pinochet$statusquo, na.rm = T) # sd er 1
## mens en økning i alder på 20 år vil bare gi en økning i statusquo på 0.08 .

##### Oppgave 7 ######
ggplot(pinochet, aes(x = age, y = statusquo)) + 
  geom_point()+
  geom_smooth(method = "lm")


##### Oppgave 8 #######
pinochet$income_log <- log(pinochet$income)
m2 <- lm(statusquo ~ age + income_log + education + sex, data = pinochet)
summary(m2)
## Effekten av inntekt er tilnærmet lik effekten i oppgave 6

##### Oppgave 9 #######

# dplyr:

# Kunne også brukt na.omit, og opprettet reg_data direkte, men får da bare 5 var i datasett
pinochet$reg_miss <- pinochet %>%
  select(statusquo, age, income, education, sex) %>%
  complete.cases() 
  
reg_data <- pinochet %>%
  filter(reg_miss == T)

  
# Vanlig indeksering:
regdata <- pinochet[complete.cases(pinochet[,c("statusquo", "age", "income", "education", "sex")]),]
regdata$resids <- resid(m2)
qqPlot(m2) # fra car, plot() fungerer også
## Restleddene er ikke normalfordelte.

#### Oppgave 10 ####


pinochet$no <- ifelse(pinochet$vote == "N", 1, 0)

pinochet %>%
  group_by(region, sex, education) %>%
  summarise(status = mean(statusquo, na.rm = T),
            votes = sum(no, na.rm = T)/length(no))




