# Seminar 4
Erlend Langørgen  
April 9, 2018  



## Velkommen til 4. R-seminar!

Først, er det noen spørsmål om oppgaver? 

### Om Prøven:

 - Oppgaven + kodebok kommer i papirformat.
 - Innlevering i innleveringsmappe på fronter (i din seminargruppe). Mappen vil stenge 1 minutt over kl. hel. 
 - For fredagsseminarene vil innleveringsmapper også være åpne på tirsdag. Dere må registrere når dere skal ta prøven på skjema.
 - Data til prøven vil legges på github
 - Med unntak av oppgaven der du skal laste inn data, vil det ikke være sjanse for følgefeil
 - Neste seminar vil kun innbefatte 
 - Prøver fra tidligere år er fin forberedelse, jeg skal legge ut flere datasett
 - Alle hjelpemidler, bortsett fra kommunikasjon med andre er lov.
 - Dersom du får tekniske problemer som ikke skyldes feilkoding (R henger seg opp e.l.) kan du få hjelp. Mer om dette neste uke


### Dagens tema:

1. Regresjonsanalyse
2. Regresjonsdiagnostikk
3. Dataanalyse i praksis - oppgaveløsning


## Regresjonsanalyse

Vi gikk raskt gjennom regresjonsanalyse i forrige seminar, her følger en litt grundigere gjennomgang. Til gjennomgangen bruker jeg `aidgrowth2`, som er en omkodet versjon av `aidgrowth`datasettet fra forrige seminar.

### Bivariat regresjon




Syntaksen er `lm(av.var ~ uavh.var, data = datasett)`


```r
summary(m1 <- lm(gdp_growth ~ aid, data = aidgrowth2))
```

```
## 
## Call:
## lm(formula = gdp_growth ~ aid, data = aidgrowth2)
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


### Multivariat regresjon

Vi legger inn flere uavhengige variabler med `+`. 


```r
summary(m2 <- lm(gdp_growth ~ aid + policy + region, data = aidgrowth2))
```

```
## 
## Call:
## lm(formula = gdp_growth ~ aid + policy + region, data = aidgrowth2)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -12.0631  -1.6756  -0.0298   1.6239  12.9271 
## 
## Coefficients:
##                           Estimate Std. Error t value Pr(>|t|)    
## (Intercept)               1.247388   0.769502   1.621   0.1061    
## aid                      -0.004915   0.138609  -0.035   0.9717    
## policy                    1.157168   0.179478   6.447 4.99e-10 ***
## regionOther              -1.239202   0.712964  -1.738   0.0833 .  
## regionSub-saharan Africa -2.201016   0.857236  -2.568   0.0108 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 3.204 on 279 degrees of freedom
##   (47 observations deleted due to missingness)
## Multiple R-squared:  0.2334,	Adjusted R-squared:  0.2224 
## F-statistic: 21.24 on 4 and 279 DF,  p-value: 2.645e-15
```

### Samspill

Vi legger inn samspill ved å sett `*` mellom to variabler. De individuelle regresjonskoeffisientene til variablene vi spesifisere samspill mellom blir automatisk lagt til.


```r
summary(m3 <- lm(gdp_growth ~ aid*policy + region, data = aidgrowth2))
```

```
## 
## Call:
## lm(formula = gdp_growth ~ aid * policy + region, data = aidgrowth2)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -12.0096  -1.7193  -0.0145   1.6436  12.9254 
## 
## Coefficients:
##                          Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                1.7862     0.8729   2.046 0.041669 *  
## aid                       -0.1270     0.1672  -0.760 0.448074    
## policy                     0.9362     0.2469   3.792 0.000183 ***
## regionOther               -1.5598     0.7535  -2.070 0.039359 *  
## regionSub-saharan Africa  -2.5654     0.9008  -2.848 0.004727 ** 
## aid:policy                 0.1399     0.1074   1.302 0.194043    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 3.2 on 278 degrees of freedom
##   (47 observations deleted due to missingness)
## Multiple R-squared:  0.2381,	Adjusted R-squared:  0.2244 
## F-statistic: 17.37 on 5 and 278 DF,  p-value: 5.806e-15
```

### Andregradsledd og andre omkodinger

Vi kan legge inn andregradsledd eller andre omkodinger av variabler i regresjonsligningene våre. 
Andregradsledd legger vi inn med `I(uavh.var^2)`. Under har jeg lagt inn en `log()` omkoding, en `as.factor()` omkoding og et andregradsledd. Merk at dere må legge inn førstegradsleddet separat når dere legger inn andregradsledd.


```r
summary(m4 <- lm(gdp_growth ~ log(gdp_pr_capita) +  institutional_quality + m2_gdp_lagged +  I(m2_gdp_lagged^2) + region + aid*policy +  as.factor(period),
           data = aidgrowth2, na.action = "na.exclude"))
```

```
## 
## Call:
## lm(formula = gdp_growth ~ log(gdp_pr_capita) + institutional_quality + 
##     m2_gdp_lagged + I(m2_gdp_lagged^2) + region + aid * policy + 
##     as.factor(period), data = aidgrowth2, na.action = "na.exclude")
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -10.7966  -1.6035  -0.1033   1.5936  12.1278 
## 
## Coefficients:
##                            Estimate Std. Error t value Pr(>|t|)    
## (Intercept)               4.746e+00  2.860e+00   1.660 0.098239 .  
## log(gdp_pr_capita)       -6.508e-01  3.825e-01  -1.701 0.090104 .  
## institutional_quality     7.104e-01  1.720e-01   4.129 4.94e-05 ***
## m2_gdp_lagged             1.905e-02  5.112e-02   0.373 0.709728    
## I(m2_gdp_lagged^2)       -7.546e-05  5.935e-04  -0.127 0.898919    
## regionOther              -1.342e+00  7.027e-01  -1.909 0.057322 .  
## regionSub-saharan Africa -3.305e+00  8.707e-01  -3.796 0.000184 ***
## aid                      -3.284e-02  1.748e-01  -0.188 0.851110    
## policy                    6.872e-01  2.423e-01   2.836 0.004934 ** 
## as.factor(period)3       -6.439e-02  6.215e-01  -0.104 0.917562    
## as.factor(period)4       -1.466e+00  6.339e-01  -2.313 0.021530 *  
## as.factor(period)5       -3.499e+00  6.524e-01  -5.363 1.84e-07 ***
## as.factor(period)6       -2.038e+00  6.646e-01  -3.066 0.002401 ** 
## as.factor(period)7       -2.388e+00  7.034e-01  -3.395 0.000796 ***
## aid:policy                1.907e-01  1.010e-01   1.888 0.060111 .  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 2.874 on 255 degrees of freedom
##   (61 observations deleted due to missingness)
## Multiple R-squared:  0.389,	Adjusted R-squared:  0.3555 
## F-statistic:  11.6 on 14 and 255 DF,  p-value: < 2.2e-16
```


## Regresjonsdiagnostikk

I forrige seminar gjorde vi en god del uformell regresjonsdiagnostikk gjennom å se på ulike plot. Nå har dere også lært om mer formelle statistiske tester for å sjekke om forutsetningene til OLS. På forelesning gikk dere gjennom følgende forutsetninger:

1. Utelatt variabelskjevhet (Restleddene korrelerer med en av de uavhengige variablene i modellen)
2. Normalfordelte restledd
3. Homoskedastiske restledd
4. Restleddene korrelerer med hverandre
5. Fravær av sterk tendens til kolinearitet og multikolinearitet mellom de uavhengige variablene

I tilegg nevner **Cristophersen** følgende:

6. Betydningsfulle observasjoner
7. Sannsynlighetsutvalg fra populasjonen man vil undersøke
8. Manglende opplysninger/missing values
9. Relasjonens form

Det finnes mange måter å beskrive forutsetningene for **OLS**, og hva som kalles en forutsetning varierer. Det er blant annet et skille mellom forutsetninger for at **OLS** skal være **BLUE** (Best linear unbiased estimator), og forutsetninger for at **OLS** skal være en unbiased estimator. Listen over er derfor ikke ment som en autoriativ fremstilling av forutsetninger for **OLS** (det overlater jeg til Simen), men som en liste over ting du bør sjekke/tenke gjennom når du spesifiserer en regresjonsanalyse.   

I R-scriptet til seminaret viser jeg hvordan du kan gå gjennom denne sjekklisten. 

## Oppgave:

Kjør den samme regresjonsanalysen som Burnside og Dollar separat for land sør for sahara ,ikke kontroller for region, og gjennomfør din egen regresjonsdiagnostikk av modellen. Dersom du vil, kan du spesifisere en annen regresjonsmodell. Bruk koden i scriptet, og lag plot der du synes det er hensiktsmessig. Jobb gjerne sammen.


