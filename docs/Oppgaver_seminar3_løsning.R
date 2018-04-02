##########################################
## Løsningsforslag oppgaver Seminar 3  ###
##########################################



## Oppgaver 3. R-seminar

#Du skal lage et fint og ryddig R-script med svar på oppgavene! Vi skal se på sammenhengen mellom vekst #(`gdp_growth`), bistand (`aid`), og makroøkonomisk politikk (`policy`). Du kan løse oppgavene i den rekkefølgen du #vil, oppgavene er ment som en hjelp til å utforske hypotesen. Du kan også utforske data på andre måter enn jeg ber #om i oppgavene. Jeg vil imidlertid be om at dere forsøker på oppgave 2, 6, og 7 i løpet av seminaret.

####################
### Oppgave 1:  ####
####################

#Last inn `aidgrowth.csv` eller `aidgrowth.Rdata` i R (inneholder samme datasett). Datasettene ligger på github for #STV 1020 i data mappen. Du kan lagre filene i working directory, eller laste direkte inn fra url. Vi skal jobbe med #dette datasettet i hele dagens seminar.

setwd() # sett working directory til mappen der du har lagret data
aidgrowth <- read.csv("aidgrowth.csv", stringsAsFactors = F)
aidgrowth <- load("aidgrowth.Rdata")

#######################
### Oppgave 2:  #######
#######################

#Lag et scatterplot mellom bistand (`aid`) og økonomisk vekst (`gdp_growth`). Tegn deretter regresjonslinjen for den 
#bivariate regresjonen mellom bistand og vekst med argumentet `geom_smooth(method = "lm")`.

#install.packages("ggplot2") # kjør dersom pakken ikke er installert.

library(ggplot2)
ggplot(aidgrowth, aes(x = aid, y = gdp_growth)) +
  geom_point() +
  geom_smooth(method = "lm")


#Gjør deretter en hypotese-test der du sjekker om korrelasjonen mellom variablene er signifikant. 

cor.test(aidgrowth$aid, aidgrowth$gdp_growth) # negativ, signifikant korrelasjon


#Kjør til slutt den bivariate regresjonen som du tegnet inn i plottet. 
summary(m1 <- lm(gdp_growth ~ aid, data = aidgrowth))

#####################
### Oppgave 3:  #####
#####################

#Se nærmere på univariat deskrpitiv statistikk for `policy`, `aid` og `growth`. Du bør i hvertfall se nærmere på 
#standardavvik, maksimums- og minimumsverdier, samt ulike mål for sentraltendens.

sd(aidgrowth$policy, na.rm = T)
summary(aidgrowth$policy)

sd(aidgrowth$gdp_growth, na.rm = T)
summary(aidgrowth$gdp_growth)

sd(aidgrowth$aid)
summary(aidgrowth$aid)

#Lag deretter histogram for de tre variablene. Kommenter til slutt fordelingen til variablene.

library(ggthemes)

ggplot(aidgrowth, aes(x = policy)) +
  geom_histogram() +
  theme_tufte()

ggplot(aidgrowth, aes(x = aid)) +
  geom_histogram() +
  theme_tufte()

ggplot(aidgrowth, aes(x = gdp_growth)) +
  geom_histogram() +
  theme_tufte()

## Variabelen policy har to større grupper av observasjoner, en med policy rundt 1, og en gruppe rundt 3.
## Det er noen observasjoner som har høyere og lavere verdier enn dette. Standardavviket ville trolig blitt betydelig
## lavere uten disse uteliggerne.

## Variabelen aid er venstreskjev, de færreste få mye bistand. Det er noen få land som får bistand 
## Verdt mer enn 5 prosent av landets BNP.

## Variabelen gdp_growth ligner på en normalfordeling, men har "tykkere haler" (flere positive og negative outliers)
## enn en normalfordeling.



### Oppgave 4: 

#Gjenta oppgave 2 for sammenhengen mellom `policy` og `gdp_growth`, og `aid` og `policy`. Kommenter plottene. 


### Policy og gdp_growth
library(ggplot2)
ggplot(aidgrowth, aes(x = policy, y = gdp_growth)) +
  geom_point() +
  geom_smooth(method = "lm")

# positiv sammenheng, ser tydelig de to gruppene av policy-verdier

#Gjør deretter en hypotese-test der du sjekker om korrelasjonen mellom variablene er signifikant. 

cor.test(aidgrowth$policy, aidgrowth$gdp_growth) # negativ, signifikant korrelasjon


#Kjør til slutt den bivariate regresjonen som du tegnet inn i plottet. 
summary(m2 <- lm(gdp_growth ~ policy, data = aidgrowth))

### Aid og policy

library(ggplot2)
ggplot(aidgrowth, aes(x = aid, y = policy)) +
  geom_point() +
  geom_smooth(method = "lm")

# Svakt negativ sammenheng, mye usikkerhet.

#Gjør deretter en hypotese-test der du sjekker om korrelasjonen mellom variablene er signifikant. 

cor.test(aidgrowth$aid, aidgrowth$policy) # negativ, signifikant korrelasjon


#Kjør til slutt den bivariate regresjonen som du tegnet inn i plottet. 
summary(m3 <- lm(policy ~ aid, data = aidgrowth))





### Oppgave 5:

#Fjern de fem observasjonene med høyest verdi på `gdp_growth`, og de fem observasjonene med høyest verdi på `aid`. 
#Gjennomfør oppgave 2 på nytt.

## Denne oppgaven kan løses iterativt ved hjelp av indeksering av to tabeller:

table(aidgrowth$aid)
table(aidgrowth$gdp_growth)

# Vi utnytter at de fem høyeste verdiene kommer sist i tabellen, samt det vi vet om indeksering:

# Må sjekke lengde på tabellene (dersom flere observasjoner har lik verdi vil tabell være kortere enn datasett):
# funksjonen str()gir også denne informasjonen
length(table(aidgrowth$gdp_growth))
length(table(aidgrowth$aid))

# Indekserer de 5 høyeste verdiene, og sjekker om mer enn 1 observasjon har noen av disse verdiene:
table(aidgrowth$aid)[(331-4):331]
table(aidgrowth$gdp_growth)[(325-4):325]

# Velger den laveste av verdiene vi indekserte over til logisk test av om observasjoner er blant de fem observasjonene
# med høyest verdi:
table(7.778758 > aidgrowth$aid)  # test for aid
table(9.5358124 > aidgrowth$gdp_growth) # test for gdp_growth

# Vi kan bruke den logiske testen i ulike typer funksjoner, her er to løsninger:

nydata <- subset(aidgrowth, aidgrowth$aid < 7.778758 & aidgrowth$gdp_growth < 9.5358124)
nydata2 <- aidgrowth[(aidgrowth$aid < 7.778758 & aidgrowth$gdp_growth < 9.5358124),]

# Merk at datasettene ha ulik lengde. Forklaringen er at subset() har som default argument at missing skal fjernes:
table(is.na(nydata2$gdp_growth))
table((is.na(nydata$gdp_growth)))

## Det finnes mange andre måter å løse oppgaven på, jeg har valgt en fremgangsmåte som bruker funksjoner dere kjenner.
## Nå er vi klare til å løse oppgave 2 på nytt med nye data:

ggplot(nydata, aes(x = aid, y = gdp_growth)) +
  geom_point() +
  geom_smooth(method = "lm")


#Gjør deretter en hypotese-test der du sjekker om korrelasjonen mellom variablene er signifikant. 

cor.test(nydata$aid, nydata$gdp_growth) # negativ, signifikant korrelasjon


#Kjør til slutt den bivariate regresjonen som du tegnet inn i plottet. 
summary(m1b <- lm(gdp_growth ~ aid, data = nydata)) 
# Navngivning av modeller: Jeg følger en konvensjon der så lenge avh.var er konstant, endres ikke grunnbokstav 
# mellom modeller (her m). Nye variabler gir nytt nummer (m1, m2 osv.), mens andre endringer til en modell, som 
# fjerning av observasjoner gir en ekstra bokstav til en modell (m1 blir m1b)

summary(m1)
summary(m1b) 
# Vi ser at den negative sammenhengen mellom bistand og vekst ble mye sterkere nå vi fjernet de 5 ekstremobservasjonene. 
# La oss se hva dette kan skyldes vå å indeksere observasjonene vi fjernet:
aidgrowth[(aidgrowth$aid >= 7.778758 | aidgrowth$gdp_growth >= 9.5358124),] # Bruker eller, |, for å finne observasjonene

# Det er en observasjon av Botswana med ekstremt høy vekst og ekstremt høy bistand. Eksklusjon
# av denne observasjonen har trolig størst betydning for at sammenhengen blir mye sterkere negativ enn før.
# Kanskje er den negative effekten mer robust enn vi først fikk inntrykk av?

## P.S.: Ikke begynn å ekskludere observasjoner uten god begrunnelse i egne analyser, spesielt ikke på grunnlag
## av verdier på avhengig variabel. Her er begrunnelsen to læringsformål:
## 1. R-koden er en god øvelse i praktisk anvendelse av ferdigheter
## 2. Det er nyttig å se hvor mye en observasjon med ekstremverdi både på avhengig og uavhengig variabel
## kan påvirke regresjonslinjen.

## Bonus: effekten av å bare fjerne Botswana-observasjonen:
summary(m1c <-lm(gdp_growth ~ aid, data = subset(aidgrowth, aidgrowth$aid!=10.3594999)))
 
### Oppgave 6: 

#Lag en ny variabel, `policy2` ved å omkode variabelen `policy` som følger:
#* Observasjoner med lavere verdi enn `-2` skal få verdien `0`
#* Observasjoner med lavere verdi enn `0` og verdi større eller lik `-2` skal få verdien `1`
#* Observasjoner med lavere verdi enn `2` og verdi større eller lik `0` skal få verdien `2`
#* Observasjoner med lavere verdi enn `4` og verdi større eller lik `2` skal få verdien `3`
#* Observasjoner med verdi større eller lik `4` skal få verdien `4`

aidgrowth$policy2 <- NA # Denne linjen er ikke nødvendig, den angir startverdi for policy2 før omkoding.

# Jeg kunne valgt en annen verdi, men det er en fin konvensjon å starte med NA, da er det lett å holde oversikt over
# endringer i variabelen

aidgrowth$policy2 <- ifelse(aidgrowth$policy < (-2), 0, aidgrowth$policy2)
aidgrowth$policy2 <- ifelse(aidgrowth$policy >= (-2) & aidgrowth$policy < 0, 1, aidgrowth$policy2)
aidgrowth$policy2 <- ifelse(aidgrowth$policy >= (0) & aidgrowth$policy < 2, 2, aidgrowth$policy2)
aidgrowth$policy2 <- ifelse(aidgrowth$policy >= (2) & aidgrowth$policy < 4, 3, aidgrowth$policy2)
aidgrowth$policy2 <- ifelse(aidgrowth$policy >= 4, 4, aidgrowth$policy2)

table(aidgrowth$policy2)

## Det er fint å teste omkoding av kontinuerlig til kategorisk variabel med et scatterplot:
ggplot(aidgrowth, aes(x = policy, y = policy2)) +
  geom_point() 

# Her legger jeg inn vertikale linjer som kan hjelpe oss med å se om omkodingen ble riktig ved hjelp av geom_vline:
ggplot(aidgrowth, aes(x = policy, y = policy2)) +
  geom_point() +
  geom_vline(xintercept = c(-2, 0, 2, 4)) +
  theme_tufte() # denne er fra pakken ggthemes()


### Oppgave 7:

#Lag et plot med `aid` på x-aksen, `gdp_growth` på y-aksen, og farge (`col =`) bestemt av verdien på `policy2`variabelen.

# Plotter policy2 som kontinuerlig variabel
ggplot(aidgrowth, aes(x = aid, y = gdp_growth, col = policy2)) + geom_point()

# Plotter policy2 som kategorisk variabel:
ggplot(aidgrowth, aes(x = aid, y = gdp_growth, col = as.factor(policy2))) + geom_point()

### Oppgave 8:

#Opprett nye variabler ved hjelp av matematisk transformasjoner av `policy`. Bruk `sqrt()`, `exp()` og `log()`. Kjør 
#bivariate regresjoner mellom `policy()` og `gdp_growth()`. Endres resultatene med ulike versjoner av variabelen?

aidgrowth$policy_sqrt <- sqrt(aidgrowth$policy)
aidgrowth$policy_e <- exp(aidgrowth$policy)
aidgrowth$policy_log <- log(aidgrowth$policy)

summary(lm(gdp_growth ~ policy, data = aidgrowth))      # positiv signifikant sammenheng
summary(lm(gdp_growth ~ policy_sqrt, data = aidgrowth)) # positiv signifikant sammenheng
summary(lm(gdp_growth ~ policy_e, data = aidgrowth))    # positiv signifikant sammenheng 
summary(lm(gdp_growth ~ policy_log, data = aidgrowth))  # positiv signifikant sammenheng

## De matematiske transformasjonene gir variablene nye substansielle tolkninger, men 
## Vi ser at i alle tilfeller forblir den forventede effekten av bedre policy en økning i vekst. 

### Oppgave 9:

#Lag nye datasett for 3 perioder (definert i variabelen `period`). Du kan bruke `subset()` til dette formålet. Gjenta 
#oppgave 2 for disse datasettene, hvordan ser sammenhengen ut nå? Kommenter både plot og regresjon.  
table(aidgrowth$period) # finner verdiene til periodevariabelen
periode2 <- subset(aidgrowth, aidgrowth$period == 2)
periode4 <- subset(aidgrowth, aidgrowth$period == 4)
periode7 <- subset(aidgrowth, aidgrowth$period == 7)

## Periode 2:
ggplot(periode2, aes(x = aid, y = gdp_growth)) +
  geom_point() +
  geom_smooth(method = "lm")


#Gjør deretter en hypotese-test der du sjekker om korrelasjonen mellom variablene er signifikant. 

cor.test(periode2$aid, periode2$gdp_growth) # positiv, ikke-signifikant korrelasjon


#Kjør til slutt den bivariate regresjonen som du tegnet inn i plottet. 
summary(m1d <- lm(gdp_growth ~ aid, data = periode2)) # ikke-signifikant, positiv koeffisient

## Periode 4:
ggplot(periode4, aes(x = aid, y = gdp_growth)) +
  geom_point() +
  geom_smooth(method = "lm")


#Gjør deretter en hypotese-test der du sjekker om korrelasjonen mellom variablene er signifikant. 

cor.test(periode4$aid, periode4$gdp_growth) # negativ, ikke-signifikant korrelasjon


#Kjør til slutt den bivariate regresjonen som du tegnet inn i plottet. 
summary(m1e <- lm(gdp_growth ~ aid, data = periode4)) # negativ, ikke-signifikant effekt

## Periode 7
ggplot(periode7, aes(x = aid, y = gdp_growth)) +
  geom_point() +
  geom_smooth(method = "lm")


#Gjør deretter en hypotese-test der du sjekker om korrelasjonen mellom variablene er signifikant. 

cor.test(periode7$aid, periode7$gdp_growth) # negativ, signifikant korrelasjon


#Kjør til slutt den bivariate regresjonen som du tegnet inn i plottet. 
summary(m1f <- lm(gdp_growth ~ aid, data = periode7)) # negativ, signifikant effekt

### Oppgave 10:

## Skriv en kort oppsummering av funnene dine, beskriv sammenhengen mellom variablene `aid`, `policy` og `gdp_growth`
# nærmere. Holder sammenhengene dersom man ser på ulike deler av datasettet? Dersom du har god tid, kan du 
# fortsette å utforske sammenhengene på egenhånd, for eksempel ved å velge ut deler av datasettet basert på variablene i 
# regresjonsmodell 5., regioner, enkeltland, m.m.


## Svar:
## Vi starter med følgende sammenhenger: negativ sammenheng mellom bistand og vekst, negativ sammenheng mellom 
## bistand og makroøkonomisk politikk og positiv sammenheng mellom økonomisk politikk og vekst.
## Vi ser at små endringer i regresjonsspessifikasjon kan få store utslag på resultatene våre. Særlig sammenhengen
## mellom bistand og vekst endret seg mye. I noen perioder er det ikke en negativ signikant sammenheng,
## mens sammenhengen samlet sett blir mye sterke negativ dersom du fjerner en observasjon av Botswana.
## De store endringene i effekten av aid gjør at man kan stille spørsmål ved hvorvidt data har nok informasjon
## til å gi et godt svar på hvordan den statistiske sammenhengen mellom bistand og vekst ser ut.
## Dersom vi ikke er trygge på den statistiske slutningen vi gjør, er det enda større grunn til å stille
## Spørsmål ved om den estimerte effekten gjengir kausalsammenhengen presist (jeg vil hevde at vi har dårlig
## grunnlag for å påstå at den estimerte effekten viser kausaleffekten av bistand).

## Merk: Det er flere av oppgavene som kunne vært besvart med annen tekst og kode. Det viktigste
##       er å produsere korrekt output i R, samt å vise noe forståelse for hva som foregår.



