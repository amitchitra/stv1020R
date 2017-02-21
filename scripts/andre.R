#####################
#### Seminar 1.5 ####
#####################

# Gjenomgang av de leverte skriptene fra forrige gang.

###################
#### Seminar 2 ####
###################

# 0. Få tak i data og lagre data
#     a. Lag prosjekt i R-studio -> rullegardin helt oppe til høyre
#     b. Last ned personstemmer.csv fra https://github.com/martigso/stv1020R/data
#        (God mappestruktur er viktig: lag en egen mappe for data!)

# 1. Last inn `personstemmer.csv` i R
#     a. Bruk read.csv()-funksjonen
#     b. Husk å sende R inn i data-mappen
personst <- read.csv("data/personstemmer.csv", stringsAsFactors = FALSE)
head(personst)
str(personst)
# View(personst)

# 2. Vis hvordan du får frem frekvensfordelingen til «parti» med et stolpediagram.

# Installerer pakken "ggplot2"
# install.packages("ggplot2")

# Laster inn pakken ggplot2
library(ggplot2)

# Lager enkelt barplot av parti
ggplot(personst, aes(x = parti))+
  geom_bar()

# Legger på farge på søyler og forenklet tema
ggplot(personst, aes(x = parti))+
  geom_bar(fill = "darkblue")+
  theme_classic()

# Endrer teksten på x- og y-aksen
ggplot(personst, aes(x = parti))+
  geom_bar(fill = "darkblue")+
  theme_classic()+
  labs(x = "Parti", y = "Antall kandidater")


# 3. Vis hvordan du får frem gjennomsnitt, median, standardavvik, skjevhet og kurtose til «mediatreff».

# Gjennomsnitt og median
summary(personst$medietreff)
  # Stort avvik mellom gjennomsnitt og median -- trolig veldig skjevfordelt

# Standardavvik
sd(personst$medietreff)
  # Standardavviket er også veldig høyt -- høyere enn 3.kvartil

# Installerer pakken "moments", som inneholder funksjoner for kurtose og skjevhet
# install.packages("moments")
library(moments)

# Skjevhet
skewness(personst$medietreff)
  # Variabelen er, som forventet, veldig høyreskjev

# Kurtose
kurtosis(personst$medietreff)
  #Fordelingen til variabelen er også veldig spiss

# Bonus
ggplot(personst, aes(x = medietreff)) +
  geom_density() +
  theme_classic()
  # Dette viser godt at variabelen er skjev og spiss

# 4. Opprett variabelen «media» med utgangspunkt i variabelen «mediatreff», slik at:
#     a. media = 0: Hvis mediatreff er lavere enn sin median
#     b. media = 1: Hvis mediatreff er høyere eller lik sin median 
#     c. Kontroller at «media» ble korrekt opprettet

# To (av 100) måter å gjøre dette på:

# 1. bruke which

personst$media <- NA # Lager først en "tom" variabel
head(personst$media)

personst$media[which(personst$medietreff < median(personst$medietreff))] <- 0 # Setter verdien 0 til de som har mindre enn median
personst$media[which(personst$medietreff >= median(personst$medietreff))] <- 1 # Setter verdien 1 til de som har mer eller lik median

table(personst$medietreff, personst$media) # Sjekker at resultatet ble riktig


# 2. bruke ifelse
?ifelse
# Hvis medietreff er mindren enn median av medietreff skal "media" ha verdien 0, alle andre skal ha 0
personst$media <- ifelse(personst$medietreff < median(personst$medietreff), 0, 1)

table(personst$medietreff, personst$media) # Sjekker at resultatet ble riktig

# 5. Lag et boxplot av «personstemmer» og «valgt».
ggplot(personst, aes(x = valgt, y = personstemmer))+
  geom_boxplot()+
  theme_bw()
  # Som vi kan forvente, er resultatet at de som ble valgt har mer personstemmer enn de som ikke ble valgt og de som ble vara

# Bonus: Hva skjer her?
ggplot(personst[which(personst$parti == "ap" | personst$parti == "frp"), ], aes(x = parti, y = personstemmer))+
  geom_boxplot()+
  theme_bw()

# 6. Lag en ny variabel «valgt2», der «Vara» fra variabelen «valgt» er definert som missing.
#     a. Kontroller at variabelen ble korrekt opprettet.

# Setter alle som ble vara til missing, og resten til sin opprinnelige verdi
personst$valgt2 <- ifelse(personst$valgt == "Vara", NA, personst$valgt)

table(personst$valgt, personst$valgt2, useNA = "always") # Sjekker at det ble riktig (OBS! `useNA = "always"` viktig her)

# 7. Vis hvordan du undersøker korrelasjonen mellom «medietreff» og «personstemmer» med Pearson's R. 
#     a. Hva forteller testen om styrken og retningen på sammenhengen? 

# Beregner Pearson's R
cor(personst$personstemmer, personst$medietreff) 
  # Veldig høy korrelasjon; dess flere ganger en kandidat har vært i media, dess mer personstemmer vil kandidaten få

# Evt. også med konfidensintervall
cor.test(personst$personstemmer, personst$medietreff)
  # Sammenhengen er også signifikant på 5% nivå

# Bonus: Hvorfor er dette veldig dårlige slutninger?
ggplot(personst, aes(x = medietreff, y = personstemmer))+
  geom_smooth(method = "lm")
 
ggplot(personst, aes(x = medietreff, y = personstemmer))+
  geom_smooth(method = "lm")+
  geom_point()

# 8. Lagre scriptet og det modifiserte survey-datasettet.