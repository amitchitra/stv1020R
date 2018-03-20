# Seminar3



# Velkommen til 3. Seminar!

Først: Er det noen spørsmål/kommentarer til hjemmeoppgavene?

I dagens seminar skal vi dekke følgende emner:

1. [Dataanalyse i praksis](#praksis)
2. [Regresjonsanalyse](#regresjon)
3. [Omkoding](#omkoding)
4. [Repetisjon](#repetisjon)

## Dataanalyse i praksis

I dette, og neste seminar, skal vi gjøre ekte forskning (riktignok forskning andre har gjort før oss). Vi skal jobbe med replikasjon av en publisert forskningsartikkel: 
*Burnside, C., & Dollar, D. (2000). Aid, policies, and growth. American economic review, 90(4), 847-868.*

Valget av denne artikkelen er ikke tilfeldig, den er svært godt egnet til å lære dataanalyse med lineær regresjon. Videre er datasettetsom ble brukt i artikkelen offentlig tilgjengelig.

Vi skal se nærmere på en av hypotesene til **Burnside og Dollar (2000)**: *Effekten av bistand på økonomisk utvikling avhenger av den makroøkonomiske politikken som føres i landet som får bistand*.  
Denne hypotesen testes i regresjonsmodell 5 fra tabell 4 på s. 856. Vi skal se på den første spesifikasjonen av denne modellen (kolonnen **OLS**), som er en multivariat, lineær regresjon med samspill. 

I dagens seminar, skal vi jobbe med å forstå grunnlaget for slutningene regresjonsmodell 5 gir oss. Vi kan skille mellom 2 fremgangsmåter å gjøre dette på:

1. **Teoretisk**: les artikkel og kodebok (i dette tilfellet i artikkelen), og tenk gjennom grunnlaget for slutningene. Dette innebærer å stille spørsmål som dette: Hvilke valg (f.eks. spesifikasjon av variabler) tar forfatterne for å kunne teste hypotesen sin? Hvilke andre valg kunne forfatterne tatt? Gjør forfatterne noen implisitte antagelser gjennom valgene sine? Er begrunnelsene for valgene forfatterne tar gode? Dersom du fikk tilgang på all informasjon du hadde lyst på, og kunne lage et eksperiment, hvordan ville du godt frem? Hvordan skiller den faktiske analysen seg fra den ideelle analysen? 
2. **Vurdering av den empiriske slutningen (ved hjelp av R)**: Vi kan bruke deskriptiv statistikk, plotting og regresjonsdiagnostikk til å øke forståelsen vår av datagrunnlaget for slutningen fra modell 5. Ved å studere data nærmere, kan vi få et inntrykk av om sammenhengen virker robust. Videre kan vi teste konsekvensen av å gjøre andre valg enn det forfatterne av en artikkel gjorde, for eksempel ved å legge inn eller fjerne kontrollvariabler, eller kode variabler på andre måter enn det forfatterne gjorde. Dersom vi synes at kodingen av en variabel er vilkårlig fordi den mangler en god begrunnelse,  kan vi teste om slutningene regresjonsmodellen gir er robust til omkoding av variabelen. 

En god vurdering av den empiriske støtten for en statistisk modell bør inneholde både en vurdering av det teoretiske grunnlaget for slutningen, og en vurdering av den faktiske empiriske slutningen. Selv om vi ofte får informasjon som gir oss noe grunnlag for å vurdere den empiriske slutningen, er det stort sett alltid mer å hente ved å undersøke grunnlaget for den statistiske slutningen selv.

I oppgavene til dagens seminar skal vi først og fremst se på univariate og bivariate sammenhenger, men det er også noen multivariate slutninger. Det viktigste med tanke på R-prøven, er å forstå hvordan koden fungerer, dere trenger ikke henge dere altfor mye opp i det empiriske grunnlaget for slutningen i modell 5 om dere ikke har lyst. Jeg vil likevel påstå at det er vel verdt å bruke tid på å forstå dataanalysene vi gjennomfører i dette og neste seminar, da det kan gi dere en økt forståelse av regresjonsanalyse, og dataanalyse generelt. 

## Omkoding av variabler

For å spesifisere regresjonsmodell 5 hos **Burnside og Dollar (2000)**, må vi først gjøre noen omkodinger. Dersom dere leser artikkelen, vil dere se at nødvendigheten av alle disse omkodingene ikke fremgår av beskrivelsen av modellen. Det burde det ha gjort. Dersom vi ikke helt vet hvordan en regresjon er spesifisert, kan vi ikke vurdere alle forutsetningene for slutningene modellen gir. Heldigvis muliggjør omkoding av variabler i datasettet som følger med artikkelen replikasjon av modell 5. Jeg skal nå vise disse omkodingene. Jeg har gjemt koden for å laste inn datasettet, siden det er den første oppgaven til dagens seminar. Jeg har kalt datasettet for **aidgrowth**




Vi skal se på eksempler på tre forskjellige typer omkodinger. Jeg legger ut en mer komplett liste over funksjoner for omkodinger i et oversiktsdokument.

### Omkoding av variabler med matematiske transformasjoner

Når vi omkoder variabler i et datasett, har vi lyst til å opprette en ny variabel. Dersom vi ikke gjør dette, erstatter vi informasjonen i den opprinnelige variabelen. Informasjonen i den opprinnelige variabelen er uunværlig for å teste at omkodingen har fungert som vi ønsker. Den er enda mer uunværlig dersom vi har gjort en feil som vi ikke kan rette opp uten den opprinnelige variabelen (dette hender). Derfor er syntaksen for å omkode en variabel som følger:

```r
data$ny_omkodet_variabel <- funksjon_for_omkoding(data$gammel_variabel)
```

Den første omkodingen vi skal gjøre er en matematisk transformasjon av en variabel. Her skal vi gjøre en logtransformasjon av BNP per capita (GDP er engelsk for BNP):


```r
aidgrowth$gdp_pr_capita_log <- log(aidgrowth$gdp_pr_capita)
# lager ny variabel, som er en logtransformasjon av eksisterende variabel i datasettet
```

Når du har omkodet en variabel, er det lurt å sjekke at du har gjort riktig. Vi kan gjøre dette med en tabell. Dersom vi ikke spesifiserer et tilleggsargument, gir funksjonen `log()` den naturlige logaritmen til en variabel. Vi kan dermed sjekke om antilogaritmen til den omkodede variabelen som vi får med `exp()`, er lik den opprinnelige variabelen:


```r
# Logikken til testen
a <- log(3)
exp(a) == 3
```

```
## [1] FALSE
```

```r
# Test av omkoding:
table(exp(aidgrowth$gdp_pr_capita_log) == aidgrowth$gdp_pr_capita)
```

```
## 
## FALSE  TRUE 
##   266    58
```

Vi kunne også gjort testet omkodingen på andre måter. Når man gjør helt enkle omkodinger er det viktigste gjerne å sjekke om det har skjedd noe rart i R. Her ser vi at det kan ha skjedd noe rart, det fremgår også i koden som viser logikken til testen. La oss se nærmere på hva som skjer:


```r
log(3)
```

```
## [1] 1.098612
```

```r
exp(1.098612)
```

```
## [1] 2.999999
```

```r
round(exp(1.098612)) == 3
```

```
## [1] TRUE
```

Her har det skjedd en avrundingsfeil, 3 blir til `2.99999`. La oss spesifisere testen  på nytt, med avrunding:

```r
## Ny teste av omkoding
table(round(exp(aidgrowth$gdp_pr_capita_log)) == aidgrowth$gdp_pr_capita)
```

```
## 
## TRUE 
##  324
```

Heldigvis se det ut som om onkodingen vår virket! Denne testen viser viktigheten av å holde tungen bent i munnen, og av å forstå hva som skjer både i R og i testen. På prøven kommer jeg ikke til å be om tester av omkodinger med denne typen R-komplikasjoner, men det er viktig å vite om at slike tilfeller kan forekomme.


### Omkoding med ifelse()

En svært nyttig funksjon til omkoding, er `ifelse()`. Denne funksjonen har følgende syntaks: 

```r
data$ny_omkodet_variabel <- ifelse(data$gammel_variabel == "logisk test", output hvis resultat av logisk test er TRUE, output hvis resultat av logisk test er FALSE)

# Man kan spesifisere alle slags logiske tester med gammel_variabel)
```

Vi skal lage en variabel for regioner, basert på regionsdummyene `sub_saharan_africa` og `fast_growing_east_asia`:


```r
aidgrowth$regions <- ifelse(aidgrowth$sub_saharan_africa == 1, "Sub-Saharan Africa", "Other")
aidgrowth$regions <- ifelse(aidgrowth$fast_growing_east_asia == 1, "East Asia", aidgrowth$regions)

# Tester resultat av omkoding:
table(aidgrowth$regions)
```

```
## 
##          East Asia              Other Sub-Saharan Africa 
##                 30                177                124
```

```r
table(aidgrowth$regions, aidgrowth$sub_saharan_africa)
```

```
##                     
##                        0   1
##   East Asia           30   0
##   Other              177   0
##   Sub-Saharan Africa   0 124
```

```r
table(aidgrowth$regions, aidgrowth$fast_growing_east_asia)
```

```
##                     
##                        0   1
##   East Asia            0  30
##   Other              177   0
##   Sub-Saharan Africa 124   0
```

```r
# Tabellene indikerer at omkodingen fungerte
```

### Omkoding av klasse 
Vi har lyst til at R automatisk skal lage dummyer av regionsvariabelen vår når vi gjør regresjonsanalyse. Da må den være av klassen `factor`. La oss teste om variabelen har denne klassen:

```r
class(aidgrowth$regions)
```

```
## [1] "character"
```
Vi ser at variabelen har klassen `character`. Vi kan endre klasse på en variabel med funksjoner som heter `as.klassenavn`. Her trenger vi funksjonen `as.factor`. La oss lage en ny variabel med denne omkodingen:


```r
aidgrowth$regions_f <- as.factor(aidgrowth$regions)
table(aidgrowth$regions_f)
```

```
## 
##          East Asia              Other Sub-Saharan Africa 
##                 30                177                124
```

```r
levels(aidgrowth$regions_f)
```

```
## [1] "East Asia"          "Other"              "Sub-Saharan Africa"
```

```r
## Bytter referansekategori til "Others"
levels(aidgrowth$regions_f) <- levels(aidgrowth$regions_f)[c(2,1,3)]
levels(aidgrowth$regions_f)
```

```
## [1] "Other"              "East Asia"          "Sub-Saharan Africa"
```

Vi har nå gjennomført omkodingene som er nødvendig for å spesifisere regresjonsmodell 5 i artikkelen til Burnside og Dollar 2000.


## Regresjonsanalyse

Syntaksen for regresjonsanalyse er som følger:


```r
lm(avh.var ~ uavh.var1, data = datasett) # bivariat
lm(avh.var ~ uavh.var1 + uavh.var2, data = datasett) # multivariat
lm(avh.var ~ uavh.var1 * uavh.var2, data = datasett) # samspill
lm(avh.var ~ uavh.var1 + I(uavh.var1^2) , data = datasett) # andregradsledd
```

Funksjonen for lineær regresjon er `lm`, avhengig variabel spesifiseres først, deretter kommer `~`. etterfulgt av de uavhengige variablene. Til slutt har jeg lagt inn et argument som lar oss spesifisere datasett, slik at vi slipper å indeksere alle variablene i regresjonsligningen. Det finnes også flere argumenter, blant annet for missing data. Sjekk med `?lm()`  


Vi har ofte lyst til å lagre output fra regresjonsanalyser som objekter. Regresjonsobjekter er en egen type objekt, men generiske funksjoner, som `summary()`, `names()` og `str()` virker også på denne typen objekter. Her er syntaks for å lage og jobbe med regresjonsobjekter:


```r
## For å lagre som objekt:
modell1 <- lm(avh.var ~ uavh.var1, data = datasett)

## For å hente ut resultatene:
summary(modell1)
## For å se nærmere på innholdet i et regresjonsobjekt:
str(modell1)
names(modell1)
plot(modell1)
```

La oss nå først spesifisere en bivariat regresjon mellom bistand og økonomisk vekst, før vi ser på modell 5 fra **Burnside og Dollar (2000)**:


```r
m1 <- lm(gdp_growth ~ aid, data = aidgrowth)
summary(m1)
```

```
## 
## Call:
## lm(formula = gdp_growth ~ aid, data = aidgrowth)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -12.813  -2.181   0.144   2.153  15.443 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   1.5570     0.2730   5.704 2.64e-08 ***
## aid          -0.2993     0.1036  -2.889  0.00412 ** 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 3.711 on 323 degrees of freedom
##   (6 observations deleted due to missingness)
## Multiple R-squared:  0.02519,	Adjusted R-squared:  0.02218 
## F-statistic: 8.348 on 1 and 323 DF,  p-value: 0.004122
```

```r
m5 <- lm(gdp_growth ~ gdp_pr_capita_log + ethnic_frac * assasinations +
               institutional_quality + m2_gdp_lagged + regions + policy * aid +
               as.factor(period),
             data = aidgrowth, na.action = "na.exclude") 
# Argumentet na.action = "na.exclude" spesifiserer at missing-verdier skal ekskluderes.
summary(m5)
```

```
## 
## Call:
## lm(formula = gdp_growth ~ gdp_pr_capita_log + ethnic_frac * assasinations + 
##     institutional_quality + m2_gdp_lagged + regions + policy * 
##     aid + as.factor(period), data = aidgrowth, na.action = "na.exclude")
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -10.7213  -1.6078  -0.1369   1.5895  12.0507 
## 
## Coefficients:
##                           Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                4.69849    3.02355   1.554 0.121443    
## gdp_pr_capita_log         -0.59961    0.39262  -1.527 0.127965    
## ethnic_frac               -0.42359    0.81009  -0.523 0.601507    
## assasinations             -0.44895    0.30119  -1.491 0.137311    
## institutional_quality      0.68684    0.17452   3.936 0.000107 ***
## m2_gdp_lagged              0.01222    0.01627   0.751 0.453130    
## regionsOther              -1.30739    0.73063  -1.789 0.074747 .  
## regionsSub-Saharan Africa -3.17987    0.88895  -3.577 0.000416 ***
## policy                     0.71245    0.24359   2.925 0.003760 ** 
## aid                       -0.02078    0.17808  -0.117 0.907182    
## as.factor(period)3        -0.01252    0.61994  -0.020 0.983901    
## as.factor(period)4        -1.41449    0.62920  -2.248 0.025434 *  
## as.factor(period)5        -3.46987    0.64085  -5.415 1.43e-07 ***
## as.factor(period)6        -2.01030    0.66149  -3.039 0.002622 ** 
## as.factor(period)7        -2.25625    0.70848  -3.185 0.001631 ** 
## ethnic_frac:assasinations  0.79154    0.62031   1.276 0.203111    
## policy:aid                 0.18622    0.10113   1.841 0.066752 .  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 2.873 on 253 degrees of freedom
##   (61 observations deleted due to missingness)
## Multiple R-squared:  0.3944,	Adjusted R-squared:  0.3561 
## F-statistic:  10.3 on 16 and 253 DF,  p-value: < 2.2e-16
```

I dagens seminar trenger dere ikke å forstå denne regresjonen, men dere skal jobbe med variablene fra regresjonsmodellen.

 


