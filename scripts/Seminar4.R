###########################################
#### Seminar 4 - regresjonsdiagnostikk ####
###########################################

#### Forberedelser: ####

rm(list=ls())
setwd()

### Installasjon av pakker:
#install.packages("car")
#install.packages("moments")

### Innlasting av pakker:
library(car)
library(ggplot2)
library(moments)

### Last inn data på egenhånd :), kall det for aidgrowth2


## Dersom det er missingverdier i noen av variablene vi bruker i en regresjonsanalyse, 
## vil observasjonene med missingverdier på disse variablene fjernes (listwise deletion).   
## Det er hensiktsmessig å lage et eget datasett til analyse + diagnostikk, som kun inneholder 
## observasjonene som er med i modellen. Plot basert på et slikt datasett vil gi et klarere bilde av hva som
## foregår enn et plot der observasjoner som ikke er med i analysen er lagt inn.
## Vi kan lage et eget datasett for analysen med complete.obs()

## datasett som brukes i analysen
bd_data <- aidgrowth2[complete.cases(aidgrowth2[,c("gdp_growth", "gdp_pr_capita", "ethnic_frac", 
                                                   "assasinations", "institutional_quality" ,  "m2_gdp_lagged", "region", 
                                                   "aid", "policy", "period")]),]

## Burnside og Dollar sin modell:
summary(bd <- lm(gdp_growth ~ log(gdp_pr_capita) + ethnic_frac * assasinations +
             institutional_quality + m2_gdp_lagged + region + aid*policy +
             as.factor(period),
           data = bd_data, na.action = "na.exclude"))

## Legger residualer inn i datasett
bd_data$bd_resid <- resid(bd)
bd_data$bd_fitted <- bd$fitted.values 

### 1. Utelatt variabelskjevhet (Restleddene korrelerer med en av de uavhengige variablene i modellen)

# En sentral forutsetning for å gjøre slutninger om kausalsammenhenger med utgangspunkt i alle typer 
# regresjonsmodeller, er at det ikke er utelatt variabelskjevhet. Vi har utelatt variabelskjevhet dersom variabelen
# vi er interessert i å estimere effekten til, *X*, korrelerer med en variabel som ikke er med i regresjonsanalysen,
# *Z*, dersom *Z* også har en kausaleffekt på den avhengige variabelen, *Y*. Du bør sette opp en kausalmodell 
# og tenke gjennom relasjonene mellom variablene på forhånd. Det er en egen litteratur om hvordan man spesifiserer
# kausalmodeller, og hvilke variabler man egentlig skal kontrollere for, men det dekker vi ikke her. 
# Dere vil imidlertid ikke kontrollere for en mellomliggende variabel dersom dere vil estimere den direkte effekten
# til en uavhengig variabel.

# Dersom vi har informasjon om en potensielt utelatt variabel, kan vi teste om den er utelatt ved å legge den inn 
# i regresjonsanalysen, og se om resultatet vårt endrer seg. 

# Ville utelatelse av m2_gdp_lagged føre til utelatt variabelskjevhet?
summary(bd_alt <- lm(gdp_growth ~ log(gdp_pr_capita) + ethnic_frac * assasinations +
                   institutional_quality + region + aid*policy +
                   as.factor(period),
                 data = bd_data, na.action = "na.exclude"))

summary(bd_alt)
summary(bd) # påvirker ikke konklusjonene våre om aid og policy nevneverdig.

# Dersom vi ikke har informasjon om en potensielt utelatt variabel, kan vi ikke teste denne forutseningen. (Det er 
# imidlertid mulig å simulere konsekvensene av ulike tenkte utelatte variabler.) Eksperimenter og eksperimentlignende
# forskningsdesign er vanlige måter å håndtere denne forutsetningen på.

### 2. Normalfordelte restledd

## Formell statstikk for skjevhet og kurtose:

library(moments)
skewness(bd$residuals) # skjev fordeling?
kurtosis(bd$residuals) # tjukke haler?

# Lite skjevhet, men mye lengre haler enn en normalfordeling.

#Grafisk test:
 
ggplot(bd_data, aes(x = bd_resid)) + geom_histogram()
qqPlot(bd) 
# qqplot Viser en linje med faktisk fordeling mot forventet fordeling gitt normalfordelte restledd. 
# Dersom observasjonene ligger langs den rette linjen, er restleddene normalfordelte.
# Her ser vi at det tykke haler

plot(bd) # Gir 4 diagnostikkplot, inkludert qqplot

### 3. Homoskedastiske restledd

# Plot for å sjekke heteroskedastisitet
ggplot(bd_data, aes(x = bd_fitted, y = bd_resid)) + geom_point() +
  geom_smooth()

ncvTest(bd) # Ikke pensum- Breusch-Pagan test for heteroskedastistitet
# Ser ut om det er noe heteroskedastisitet, da det er noen uteliggere i fordelingen.

# Vi kan også se dette fra regresjonsplot med konfidensintervaller, som vi tidligere har laget med `geom_smooth`.
# For å plotte en multivariat modell riktig, bør vi imidlertid plotte på en litt mer komplisert måte,
# som du kan lese om her: https://github.com/martigso/stv4020aR/blob/master/Gruppe%201/docs/Regresjonsplot.md.
# Denne metoden er ikke pensum. Dere kan imidlertid bruke `geom_smooth()` metoden for å få et inntrykk.


### 4. Restleddene korrelerer med hverandre

# Restledd kan korrelere med hverandre av flere grunner, for eksempel fordi verdien til en observasjon
# på avhengig variabel endres inkrementelt fra en periode til den neste. Korrelasjon over tid kalles
# autokorrelasjon. Vi tester for korrelasjon mellom restleddene med Durbin-Watson testen. 
# Pass på at observasjonene er organisert slik at alle observasjoner av en enhet kommer etterhverandre kronologisk.

durbinWatsonTest(bd)

# Ingen autokorrelasjon, da dw statistikken ikke er signifikant forskjellig fra 2. Se Cristophersen for detaljer 

### 5. Fravær av sterk grad av kolinearitet og multikolinearitet mellom de uavhengige variablene

# man kan få et inntrykk av multikolinearitet fra en korrelasjonsmatrise
# Vi kan lage en korrelasjonsmatrise av et datasett med bare numeric/integer-variabler
cordata <- bd_data[,c("gdp_growth", "gdp_pr_capita", "ethnic_frac", "assasinations",
  "institutional_quality", "m2_gdp_lagged", "sub_saharan_africa", "fast_growing_east_asia", "aid",
  "policy", "period")]
cor(cordata)
# Man kan også se på vif (variance inflation factor). Kvadratroten av vif indikerer hvor mye konfidensintervallet
# til estimatet av en variabels effekt øker på grunn av multikolinearitet.
vif(bd)
## GVIF er en generalisert versjon av VIF som tar hensyn til andregradspolynomer/sampspill/faktor-variabler. 
## GVIF tolkes likt som VIF, og er helt lik dersom det ikke er andregradspolynomer/sampspill/faktor-variabler.  



### 6. Betydningsfulle observasjoner
dev.off()
influenceIndexPlot(bd, id.n = 5)
dev.off() # nullstiller grafiske parametre, bruk dersom plot blir rare.

# Det er fint å se både på de største uteliggerne (studentized residuals), observasjonene med størst leverage (hat-values)
# og observasjonene med høyest Cook's D.

### 7. Sannsynlighetsutvalg fra populasjonen man vil undersøke 

# Her er det ingen formell test, i stedet må du se på data, og tenke gjennom hva du vil sammenligne i analysen din.

# Til å teste dette kan du se på grafiske tester, korrelasjoner mellom variabler og samspill.
# Du kan også lese artikler med kritisk sans og vurdere utvalget nøye

# Dersom du oppdager noe mistenkelig - Spør deg selv følgende:

# Stammer utvalget fra to ulike populasjoner, eller er det heterogenitet i populasjonen vi er interessert i?

# Eksempel: epler og pærer, eller **granny smith** og **gravenstein**? 

  
# Teori bestemmer følgende:
#  1. Er observasjoner  med i populasjonen vi er interessert i?
#  2. Er vi interessert i å modellere forskjellen mellom granny smith og gravenstein, eller holder det å ta 
#     gjennomsnittet av de to?
#   + Hvor mye epler spises det i Norge? Her er forskjellen ikke relevant.
#   + Liker nordmenn epler bedre enn appelsiner? Her er forskjellen kanskje relevant 
#     (siden `Gravenstein > appelsin i sesong > Granny Smith > appelsin utenfor sesong == TRUE`).

# Merk: utvalg med heterogenitet som skyldes smaksforskjell mellom **granny smith** og **gravenstein** kan fortsatt
# være sannsynlighetsutvalg fra populasjonen av epler spist i Norge. Spørsmål 2 er derfor knyttet til hvordan vi velger å modellere data, ser vi på effekten av ulike epletyper på smak som en utelatt variabel, eller er vi kun interessert i gjennomsnittet av alle epler.

# Bruk denne tankegangen når dere ser plot av denne typen:
ggplot(bd_data, aes(x = aid, y = gdp_growth, col = region)) + geom_point()



### 8. Missingverdier

## Det er lurt å se på korrelasjon mellom missing på de uavhengige variablene i analysen, og verdiene til avhengig
## Variabel. Man kan også sammenligne gjennomsnittsverdier til uavhengige variabler i fullt datasett med 
## gjennomsnittsverdier i datasettet man bruker til å estimere regresjonen:

summary(aidgrowth2) # er det store forskjeller? 
summary(bd_data) 


# Det finnes en rekke andre metoder for å se nærmere på missingverdier, mange av dem er svært avanserte.

### 9. Relasjonens form

## Vi kan se på plot mellom uavhengig og avhengig variabel:
ggplot(bd_data, aes(x = aid, y = gdp_growth)) + geom_point()

## Vi kan også bruke ceresPlots fra car, som tegner sammenhengen mellom to variabler i en regresjon
## så godt den klarer. Den fungerer imidlertid ikke på modeller med samspill. CeresPlots er ikke pensum, men
## en veldig god måte å teste for linearitet.

ceresPlots(lm(formula = gdp_growth ~ log(gdp_pr_capita) + ethnic_frac + 
                assasinations + institutional_quality + m2_gdp_lagged + region + 
                aid + policy + as.factor(period), data = bd_data, na.action = "na.exclude"))  # Ikke pensum

