###################################################
##### Løsningsforslag R-prøve 1 STV 1020 V18 ###### 
###################################################

##### Forberedelser: #####

## install.packages("car")
## install.packages("ggplot2")

library(car)
library(ggplot2)

rm(list = ls())
setwd() # sett working directory til mappen der labour.csv er lagret

###### Oppgave 1 ######
labour <- read.csv("labour.csv")

###### Oppgave 2 #####
summary(labour)  # alternativ 1
table(labour$lfp) # alternativ 2
# 428 deltar i arbeidsstyrken

##### Oppgave 3 #####
labour$lfp.d <- ifelse(labour$lfp=="yes", 1, 0)
table(labour$lfp.d, labour$lfp) # sjekk av omkoding, den er korrekt

##### Oppgave 4 #####
d1 <- subset(labour, labour$wc=="yes" & labour$k618<3)
d2 <- subset(labour, labour$wc=="no" & labour$k618>=3)
median(d1$inc) # 21.47
median(d2$inc) # 16.29

##### Oppgave 5 #####
cor.test(labour$lwg, labour$age) 
# korrelasjonen er 0.012, og ikke signifikant forskjellig fra 0.Korrelasjonen tilsier at eldre kvinner tjener mest.


##### Oppgave 6 #####
ggplot(labour, aes(x= hc, y = lwg)) + geom_boxplot()
# Det ser ut som om de som har menn som gikk på college har høyest forventet medianinntekt

##### Oppgave 7 #####
m1 <- lm(lwg ~ wc + k5 + k618 + age, data = labour)
summary(m1)
# Den forventede effekten av at kvinner har college-utdannelse på forventet inntekt er 0.4. Dette er en ganske solid effekt, da
sd(labour$lwg) # 0.59
# effekten nesten utgjør et standardavviks økning i forventet inntekt.

##### Oppgave 8 #####
ggplot(labour, aes( x = age, y = lwg, col = wc)) + geom_point() 

##### Oppgave 9 #####
m2 <- lm(lwg ~ wc + k5 + k618 + age + I(age^2), data = labour)
summary(m2)

# forventet effekt av å gå fra å være 30 til 50 år på inntekt:
(0.0573896*50 + -0.0006909*(50^2)) # forventet effekt av å være 50: 1.14223
(0.0573896*30 + -0.0006909*(30^2)) # forventet effekt av å være 30: 1.099878
1.14223 - 1.099878 # Den forventede effekten av å gå fra å være 30 til 50, er at inntekten din øker med 0.04

vif(m2)
# age og age kvadrert har høyest multikolinearitet
