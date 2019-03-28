---
title: "Før seminar 4"
author: "Erlend Langørgen"
date: "March 28, 2019"
output: 
  html_document:
    keep_md: TRUE
---



## Regresjonsanalyse

I denne introduksjonen, forklarer jeg lineær regresjonsanalyse med R. 

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

## Begge deler samtidig:
summary(modell1 <- lm(avh.var ~ uavh.var1, data = datasett))

## For å se nærmere på innholdet i et regresjonsobjekt:
str(modell1)
names(modell1)
plot(modell1)
```

La oss nå først spesifisere en bivariat regresjon mellom bistand og økonomisk vekst, før vi ser på modell 5 fra **Burnside og Dollar (2000)**:


```r
# Last inn "aidgrowth2.csv" eller "aidgrowth2.Rdata" -
# I disse datasettene har jeg lagret region-variabelen vi opprettet 
# forrige seminar
aidgrowth <- read.csv("https://raw.githubusercontent.com/langoergen/stv1020R/master/data/aidgrowth2.csv",
                      stringsAsFactors = F) # Dette argumentet gjør at variabler som ser ut som tekst lese inn med klassen character i stedet for factor.

# Bivariat regresjon

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
# Multivariat regresjon

# Må gjøre en omkoding for å kunne kjøre modellen:
aidgrowth$gdp_pr_capita_log <- log(aidgrowth$gdp_pr_capita)

m5 <- lm(gdp_growth ~ gdp_pr_capita_log + ethnic_frac * assasinations +
               institutional_quality + m2_gdp_lagged + region + policy * aid +
               as.factor(period),
             data = aidgrowth, na.action = "na.exclude") 
# Argumentet na.action = "na.exclude" spesifiserer at missing-verdier skal ekskluderes.
summary(m5)
```

```
## 
## Call:
## lm(formula = gdp_growth ~ gdp_pr_capita_log + ethnic_frac * assasinations + 
##     institutional_quality + m2_gdp_lagged + region + policy * 
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
## regionOther               -1.30739    0.73063  -1.789 0.074747 .  
## regionSub-saharan Africa  -3.17987    0.88895  -3.577 0.000416 ***
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

I seminar 4 trenger dere ikke å forstå alt som foregår i denne regresjonen, men dere skal jobbe med variablene fra regresjonsmodellen.

 


