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

## a) Last inn datafilen aidgrowth.Rdata i Rstudio (fra data-mappen på github), og opprett et objekt som du kaller aidgrowth.
## b) Finn ut mer om funksjonen subset med ?
## c) Lag et nytt datasett som kun inneholder land som har verdien 1 på variabelen sub_saharan_africa
## d) kjør en lineære regresjon med aid som uavhengig og gdp_growth som avhengig variabel i det nye datasettet og tolk.
## Du kan eventuelt bruke funksjonen filter fra dplyr-pakken i stedet for subset.
## Du skal få samme resultat med subset som med aidgrowth[which(aidgrowth$sub_saharan_africa==1),]

aidgrowth <- read.csv("data/aidgrowth.csv")

## Husk at vi fant en negativ effekt av aid i den bivariate regresjonen vi kjørte i seminaret!

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

## Oppretter variabelen region til plottet: (vi gjorde dette i seminar 3 også)
aidgrowth$region <- ifelse(aidgrowth$sub_saharan_africa == 1, "Sub-saharan Africa",
                           ifelse(aidgrowth$fast_growing_east_asia == 1, "East Asia", "Other"))
library(ggplot2)
ggplot(aidgrowth, aes(x = aid, y = gdp_growth)) +
  geom_point(aes(size = policy, col = as.factor(region))) +
  geom_smooth(method = "lm") +
  facet_wrap(~period)

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

## Noen mulige kommentar til fullt plot: 
## 1) Vi ser at det ikke er en negativ sammenheng mellom aid og gdp_growth i alle tidsperioder, kan effekten av bistand ha.
## endret seg over tid?
## 2) Videre ser vi av fargene at landene i Asia får svært lite aid jevnt over, mens landene i Afrika får klart mest aid
## Med utgangspunkt i dette mønsteret kan man f.eks. spørre seg om det er kan være at de landene som får svært mye bistand 
## får vekst, mens bistand har en negativ effekt for land som får relativt lite bistand. Eventuelt kan man spørre
## seg om det kan være slik at land i Afrika generelt får en positiv effekt av bistand (i motsetning til andre regioner).
## Man kan også spørre seg om positive effekten av bistand i Afrika endres av å fjerne de få observasjonene som
## har svært høy vekst og som får svært mye bistand. Kanskje er det et enkeltland som i stor grad driver den positive
## sammenhengen mellom bistand og vekst i Afrika?
## 3) Det ser ut som om land med positiv vekst jevnt over har positive verdier på policy-variabelen (ikke så lett å se)  

 

###############################
##### Oppgave 4 ###############
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
## men den negative effekten av aid er mindre. Forskjellen i estimatet forklarer forskjellen i signifikans.
## Ved å legge inn variabelen policy ble altså den forventede negative effekten av bistand svakere,
## og ikke lenger signifikant på 0.05 konfidensnivå.

## Åpne plottene i eget vindu ved å trykke på "zoom"!!

## Sammenhengen mellom aid og policy med info om gdp_growth
ggplot(aidgrowth, aes(x = aid, y = policy)) +
         geom_point(aes(size = gdp_growth, col = gdp_growth)) +
         theme_bw() +
         geom_smooth(method = "lm")

## Mulig kommentar: Ser at det er en gruppe observasjoner øverst i venstre hjørne som får svært lite bistand,
## men som har høy verdi på makroøkonomisk politkk og positiv vekst. Er det noe spesielt ved disse observasjonene?

## Sammenhengen mellom aid og gdp_growth, med info om policy
ggplot(aidgrowth, aes(x = aid, y = gdp_growth)) +
  geom_point(aes(size = policy, col = policy)) +
  theme_bw() +
  geom_smooth(method = "lm")

## Mulig kommentar: Ser at det er en gruppe observasjoner med lav verdi på bistand, men høy vekst og høy verdi på politikk.
## Ser at land som får veldig mye bistand stort sett har lav verdi på økonomisk politikk.

## Samlet kommentar: Man kan spørre seg om den negative sammenhengen mellom bistand og politikk vil forsvinne
## dersom man fjerner den gruppen med land som har svært høy vekst, svært lav bistand og svært god økonomisk politikk.
## Man kan også spørre seg om sammenhengen mellom bistand og vekst blir positiv dersom man fjerner disse observasjonene
## Man kan imidlertid ikke bare fjerne observasjoner uten grunn. Vi kan teste om resultatene våre er robuste til
## fjerning av observasjoner, men en god begrunnelse for å fjerne observasjonene bør ha en mer teoretisk basis,
## som argumentasjon for at det ikke gir mening fra et teoretisk perspektiv å sammenligne observasjoner.


### Legger inn en kontrollvariabel for region:
summary(lm(gdp_growth ~ aid + policy + factor(region), data = aidgrowth))

## Vi ser at den negative effekten av bistand blir enda svakere. 

library(wesanderson)

ggplot(aidgrowth, aes(aid, gdp_growth)) + 
  geom_point(aes(size = policy, color = region)) + 
  scale_color_manual(values = wes_palette("Darjeeling")) + 
  theme_bw() +
  geom_smooth(method = "lm")

## Plottet viser oss at vi land i sub-saharan-Africa utgjør alle observasjoner som får mer enn 5 % av verdien til 
## eget BNP i bistand. Landene i øst-Asia får knapt nok bistand. De fleste landene i kategorien other får også lite
## bistand. Samtidig ser vi de landene i Afrika som får mest bistand også har ganske lav vekst sammenlignet med
## mange land som knapt får bistand. Ved å kontrollere for region i regresjon, kontrollerer vi for muligheten for at 
## den negative effekten av bistand kan skyldes at landene som ikke er i sub saharan Africa jevnt over får mer bistand,
## samtidig som de har lavere vekst. Med andre ord: kan positiv korrelasjon mellom aid og sub-saharan africa og
## negativ korrelasjon mellom sub-saharan Africa (sammelignet med andre regioner) forklare at  vi estimerer en negativ
## effekt av bistand? Reduksjonen i regresjonskoeffisienten til aid indikerer at svaret er:
## "delvis, men effekten til bistand er fortsatt estimert til å være negativ. 
## Men man kan spørre seg: burde ikke effekten av bistand være signifikant positiv?"


## korrelasjon mellom regionene, bistand og vekst:
tabell <- cor(cbind(aidgrowth$sub_saharan_africa, aidgrowth$fast_growing_east_asia),
    cbind(aidgrowth$aid, aidgrowth$gdp_growth), use = "pairwise.complete.obs")
tabell <- (as.data.frame(tabell))
row.names(tabell) <- c("Sub-Saharan Africa", "East Asia")
colnames(tabell) <- c("Bistand", "Vekst")



## Siden det virker å være så sterke sammenhenger mellom region og bistand og vekst, kan det være lurt å sjekke
## sjekke om vi har klart å modellere sammenhengen mellom disse variablene tilfredsstillende.
## La oss se hva som skjer dersom vi legger inn et samspill mellom region og aid:
aidgrowth$region <- as.factor(aidgrowth$region)
levels(aidgrowth$region) <- levels(aidgrowth$region)[c(2,1,3)]
levels(aidgrowth$region)
summary(lm(gdp_growth ~ aid*region + policy, data = aidgrowth))

## Vi ser vi at den forventede effekten av bistand for land i Sub-Saharan Africa
## er positiv, fordi den positibe koeffisienten til samspillsleddet mellom aid og sub-saharan africa er større.
## en den negative koeffisienten til aid. Vi ser også at effekten av bistand i Øst Asia er negativ. 
## Med denne kunnskapen, må vi bestemme oss for hva slags sammenligning vi ønsker å estimere,
## dersom vi mener at det grunn til å tro at det er en substansiel viktig grunn til forskjellene av effektene til
## aid i ulike regioner, burde vi enten modellere forskjellene, eller dele opp data.
## Dersom vi mener det er statistiske tilfeldigheter som forklarer forskjellene, eller at variasjonen i effekten av
## bistand er i ulike regioner er irrelevant/uinteressant (av teoretiske grunner).
## Det er imidlertid vanskelig å ignorere samspillet når man har sett nærmere på det grafisk:



ggplot(aidgrowth, aes(aid, gdp_growth)) + 
  geom_point(aes(size = policy, color = log(gdp_pr_capita))) + 
  facet_wrap(~region) +
  theme_bw() +
  geom_smooth(method = "lm")

## Vi ser at det er et positivt samspill mellom bistand og sub-saharan Africa, negativt samspill med de andre regionene
## Vi kan i det minste si at den negative effekten av bistand ikke virker særlig robust.


## Burnside og Dollar legger ikke inn samspill mellom region og aid, man kan dermed spørre seg hvor godt
## resultatene holder dersom vi legger til et samspillsledd:

summary(lm(gdp_growth ~ log(gdp_pr_capita) + ethnic_frac * assasinations +
     institutional_quality + m2_gdp_lagged + region*aid + aid*policy +
     as.factor(period),
   data = aidgrowth, na.action = "na.exclude")) 


## Vi ser at det nå virker som om effekten av bistand er sterkere positiv i Øst-Asia enn i Afrika,
## der effekten nå er svakt negativ. Effekten av å legge til flere kontrollvariabler, har vært at 
## sammenhengen vi så i plottet over er snudd. Vi kan bruke korrelasjoner og plot for å undersøke nøyaktig
## hva som foregår nærmere.










