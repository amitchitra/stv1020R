########################################
#### Oppgaver etter seminar 3  #########
########################################

## I dette scriptet lærer du to nye argumenter til ggplot, samt funksjonen subset.
## Du får også repetert ifelse() og lm()
## Dersom du har lyst, kan du også lære mer om hvordan en regresjonsanalyse fungerer,
## både visuelt og statistisk, i oppgave 4. Denne oppgaven er imidlertid valgfri 


##########################
#### Oppgave 1 ###########
##########################

## a) Last inn datafilen aidgrowth.Rdata i Rstudio, og opprett et objekt som du kaller aidgrowth.
## b) Finn ut mer om funksjonen subset med ?
## c) Lag et nytt datasett som kun inneholder land som har verdien 1 på variabelen sub_saharan_africa
## d) kjør en lineære regresjon med aid som uavhengig og gdp_growth som avhengig variabel i det nye datasettet og tolk.
## Du kan eventuelt bruke funksjonen filter fra dplyr-pakken i stedet for subset.

#########################
#### Oppgave 2 ##########
#########################

## Lag en ny variabel ved å multiplisere assassinations med ethnic_frac.
## Opprett deretter en dummyvariabel ved hjelp av ifelse(), slik at observasjoner
## med verdi på den nye variabelen som er større enn 0 får verdien 1, mens andre får verdien 0.
summary(aidgrowth$assasinations*aidgrowth$ethnic_frac)

##########################
### Oppgave 3 ############
##########################

## Under har jeg skrevet deler av koden til et ggplot() med noen nye argumenter.
## Din oppgave er å fylle inn koden, slik at du får et plot med aid på x-aksen, og gdp_growth på y-aksen.
## Du skal legge til ett nytt argument om gangen, for å se effekten av å legge til de ulike argumentene.
## Jeg har skrevet forklaringer av argumentene under.

ggplot(aidgrowth, aes(x = , y =)) +
  geom_point(aes(size = policy, col = region)) 
  geom_smooth(method = lm)
  facet_wrap(~region)

## Forklaring av nye argumenter:
# size = er et av flere argumenter du kan bruke i aes for å visualisere mer enn to variabler i ett todimensjonalt plot.
# Andre slike andre er col, shape, fill og alpha. Jeg liker særlig å bruke size = for å visualisere kontinuerlige variabler

# facet_wrap() deler opp plottet ditt i flere delplot, avhengig av verdien til en eller flere variabler. 
# Du legger inn variabler i facet_wrap på samme måte som uavhengige variabler i lineær regresjon:
# facet_wrap(~ uavh. var1 + uavh_var2)  
  
# Det er mulig å spesifisere aes() inne i hvert enkelt geom_ argument. Jeg velger å gjøre dette i plottet over,
# Fordi geom_smooth(method = lm) forsøker å tegne en regresjonslinje for alle variabler vi legger inn i 
# ggplot(data, aes()). 

# P.S.: Merk forøvrig at geom_smooth(method = "lm") gir bivariat regresjon mellom variablene på x-aksen
# og y-aksen, funksjonen lar deg ikke plotte effekter i multivariat regresjon.



###############################
##### Oppgave 3 ###############
###############################
  
## Les koden så raskt eller så grundig som du ønsker. Ved å se nøye på resultatene av koden
## kan du få økt forståelse av hva kontrollvariabler gjør i lineær regresjon.  
  
## Vi skal bygge regresjon, der vi ser på effekten av aid på gdp_growth:
## Regresjonen vi begynner å bygge oss mot er modell 5 fra Burnside og Dollar (2000)
summary(lm(gdp_growth ~ aid, data = aidgrowth))
# Negativ, signifikant effekt

ggplot(aidgrowth, aes(x = aid, y = gdp_growth)) +
  geom_point() +
  theme_bw() +
  geom_smooth(method = "lm")

## Hva skjer når vi legger inn første kontrollvariabel (policy)?  

cor(aidgrowth$policy, aidgrowth$aid, use = "pairwise.complete.obs")   
## Negativ korrelasjon
cor(aidgrowth$policy, aidgrowth$gdp_growth, use = "pairwise.complete.obs")
## Positiv korrelasjon

summary(lm(gdp_growth ~ aid + policy, data = aidgrowth))
## Negativ effekt, nå bare signifikant på 0.1 konfidensnivå. 
## Standardfeilen til estimatet for effekten av aid er like stor som før,
## men effekten av aid er mindre. Dette forklarer forskjellen.

## Sammenhengen mellom aid og policy med info om gdp_growth
ggplot(aidgrowth, aes(x = aid, y = policy)) +
         geom_point(aes(size = gdp_growth, col = gdp_growth)) +
         theme_bw() +
         geom_smooth(method = "lm")

## Sammenhengen mellom aid og gdp_growth, med info om policy
ggplot(aidgrowth, aes(x = aid, y = gdp_growth)) +
  geom_point(aes(size = policy, col = policy)) +
  theme_bw() +
  geom_smooth(method = "lm")

## Åpne plottene i eget vindu ved å trykke på "zoom"

## Kommentar: Vi ser at det er 

