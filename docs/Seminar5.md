# Seminar 5
Erlend Langørgen  
April 24, 2018  



## Seminar 5

### Om prøven: 

* Dagens seminar er en forsmak på prøven, dere har til og med mulighet til å laste opp oppgaven på fronnter i en innleveringsmappe som stenger to minutter etter klokken hel. Du skal kun levere et R-script.  
* Jeg anbefaler alle å ta en titt på indeksering, `subset()`, `ifelse()`, logiske tester og innlasting av datasett, dersom dere ikke føler dere trygge på at dere kan dette. Disse emnene er grunnleggende, men samtidig ikke nødvendigvis de letteste.
* Jeg har lagt ut et dokument med tips til feilsøking av problemer i R.
* Jeg jobber med en fullstendig oversikt/forklaring av funksjoner som er aktuelle til prøven, den blir ferdig i løpet av kort tid. Den inneholder funksjonene vi har gått gjennom i seminarene, med unntak av noen få funksjoner vil alt vi har gjennomgått være pensum.
* Andregangsprøve blir 25. mai. 
* Prøvene på tirsdag kommer til å være helt fulle.
* Treffetid på onsdag fra 16.00 - 17.00, PC rommet i kjelleren på Harriett Holters hus og på torsdag i samme rom fra 13.30-14.30


### Oppsamlingsheat

Det er noen funksjoner som jeg ikke har gått grundig gjennom tidligere i seminarrekken, som jeg skal gjennomgå i dag, da de vil være pensum til prøven:

1. Boxplot
2. funksjoner for missing data
3. Korrelasjonsmatrise


### Boxplot:

Et boxplot viser fordelingen til en eller flere grupper på en kontinuerlig variabel visuelt. I midten av et boxplot er det en boks med en svart strek inne i boksen. Den svarte streken angir medianverdien til variabelen. Boksen viser fordelingen til den halvdelen av observasjonene som er i midten av fordelingen (mellom 1. og 3. kvartil, dvs. observasjonene mellom 25% og 75% av observasjonene ordnet fra lav til høy verdi). Ut fra boksene stikker det to streker, som er differansen mellom 3. og 1. kvartil gange med `1.5`. Uteliggere som ligger utenfor disse strekene, er plottet som separate punkter. Et boxplot angir dermed masse informasjon om fordelingen til en variabel, dere kan tenke på det som den visuelle ekvivalentent til `summary()`. For å lage et boxplot, bruker vi `ggplot()` med geom funksjonen `geom_boxplot()`. Boxplot er også nyttige for å se nærmere på hvordan ulike grupper fra variabler på nominalnivå/ordinalnivå (f.eks. kjønn) er fordelt på kontinuerlige variabler (som f.eks. inntekt). Her er et eksempel:



```r
library(ggplot2)
ggplot(mtcars, aes(as.factor(cyl), mpg)) + geom_boxplot() + labs(x = "Sylindre", y = "Miles per gallon")
```




![](../bilder/boxplot1.png)<!-- -->



### Funksjoner for missing data

Vi har sett på to nyttige funksjoner for missing data, `is.na()` og `complete.cases()`. Med `is.na()` kan vi gjøre en logisk test av om en variabel har missingverdier eller ikke, som f.eks:

```r
is.na(mtcars$mpg)
```

```
##  [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [12] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [23] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
```

```r
table(is.na(mtcars$mpg))
```

```
## 
## FALSE 
##    32
```

Med `complete.cases()` kan vi teste om en observasjon har missing på minst en variabel, f.eks.:

```r
complete.cases(mtcars[,3:8])
```

```
##  [1] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
## [15] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
## [29] TRUE TRUE TRUE TRUE
```

```r
table(complete.cases(mtcars[,3:8]))
```

```
## 
## TRUE 
##   32
```

Disse funksjonene er nyttige både for å feilsøke problemer, og for å forstå missing i statistikk. Mer om dette under neste tema.

### Korrelasjonsmatrise

En korrelasjonsmatrise viser korrelasjon mellom mange variabler samtidig, og er en effektiv måte å raskt får oversikt over sammenhenger i et datasett. Under forklarer jeg korrelasjonsmatriser steg for steg.

Steg 1: Lag et numerisk datasett

En korrelasjonsmatrise lages med utgangspunkt i et datasett som kun består av numeriske variabler. Du kan teste om datasettet ditt kun har slike variabler ved hjelp av `str()`:

```r
str(mtcars)
```

```
## 'data.frame':	32 obs. of  11 variables:
##  $ mpg : num  21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
##  $ cyl : num  6 6 4 6 8 6 8 4 4 6 ...
##  $ disp: num  160 160 108 258 360 ...
##  $ hp  : num  110 110 93 110 175 105 245 62 95 123 ...
##  $ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
##  $ wt  : num  2.62 2.88 2.32 3.21 3.44 ...
##  $ qsec: num  16.5 17 18.6 19.4 17 ...
##  $ vs  : num  0 0 1 1 0 1 0 1 1 1 ...
##  $ am  : num  1 1 1 0 0 0 0 0 0 0 ...
##  $ gear: num  4 4 4 3 3 3 3 4 4 4 ...
##  $ carb: num  4 4 1 1 2 1 4 2 2 4 ...
```

Vi ser at alle variablene er av klassen `numeric` (num), så lenge vi kun har variabler av klassene `integer` eller `numeric` trenger vi ikke gjøre noen omkodinger. Dersom vi har variabler som ikke er numeriske, må vi enten lage et nytt datasett utenn disse variablene, eller omokde variablene slik at de blir numeriske. 


Steg 2: Beregn korrelasjoner

Nå skal du ha et datasett med kun numeriske variabler. Du kan nå forsøke å lage korrelasjonsmatrisen ved hjelp av `cor()`, som kan ta et numerisk datasett som første argument:


```r
cor(mtcars)
```

```
##             mpg        cyl       disp         hp        drat         wt
## mpg   1.0000000 -0.8521620 -0.8475514 -0.7761684  0.68117191 -0.8676594
## cyl  -0.8521620  1.0000000  0.9020329  0.8324475 -0.69993811  0.7824958
## disp -0.8475514  0.9020329  1.0000000  0.7909486 -0.71021393  0.8879799
## hp   -0.7761684  0.8324475  0.7909486  1.0000000 -0.44875912  0.6587479
## drat  0.6811719 -0.6999381 -0.7102139 -0.4487591  1.00000000 -0.7124406
## wt   -0.8676594  0.7824958  0.8879799  0.6587479 -0.71244065  1.0000000
## qsec  0.4186840 -0.5912421 -0.4336979 -0.7082234  0.09120476 -0.1747159
## vs    0.6640389 -0.8108118 -0.7104159 -0.7230967  0.44027846 -0.5549157
## am    0.5998324 -0.5226070 -0.5912270 -0.2432043  0.71271113 -0.6924953
## gear  0.4802848 -0.4926866 -0.5555692 -0.1257043  0.69961013 -0.5832870
## carb -0.5509251  0.5269883  0.3949769  0.7498125 -0.09078980  0.4276059
##             qsec         vs          am       gear        carb
## mpg   0.41868403  0.6640389  0.59983243  0.4802848 -0.55092507
## cyl  -0.59124207 -0.8108118 -0.52260705 -0.4926866  0.52698829
## disp -0.43369788 -0.7104159 -0.59122704 -0.5555692  0.39497686
## hp   -0.70822339 -0.7230967 -0.24320426 -0.1257043  0.74981247
## drat  0.09120476  0.4402785  0.71271113  0.6996101 -0.09078980
## wt   -0.17471588 -0.5549157 -0.69249526 -0.5832870  0.42760594
## qsec  1.00000000  0.7445354 -0.22986086 -0.2126822 -0.65624923
## vs    0.74453544  1.0000000  0.16834512  0.2060233 -0.56960714
## am   -0.22986086  0.1683451  1.00000000  0.7940588  0.05753435
## gear -0.21268223  0.2060233  0.79405876  1.0000000  0.27407284
## carb -0.65624923 -0.5696071  0.05753435  0.2740728  1.00000000
```


Steg 3: Missing

I dette eksempelet gikk alt smertefritt, men dersom du har missing-verdier, må du angi et argument for hvordan missing skal håndteres. Dette gjør du ved hjelp av argumentet `use = ` i `cor()` funksjonen. La oss legge inn noen missingverdier for å se hva som skjer:


```r
mydata <- mtcars
mydata$cyl[1:3] <- NA
mydata$mpg[3:5] <- NA
cor(mydata)
```

```
##      mpg cyl       disp         hp        drat         wt        qsec
## mpg    1  NA         NA         NA          NA         NA          NA
## cyl   NA   1         NA         NA          NA         NA          NA
## disp  NA  NA  1.0000000  0.7909486 -0.71021393  0.8879799 -0.43369788
## hp    NA  NA  0.7909486  1.0000000 -0.44875912  0.6587479 -0.70822339
## drat  NA  NA -0.7102139 -0.4487591  1.00000000 -0.7124406  0.09120476
## wt    NA  NA  0.8879799  0.6587479 -0.71244065  1.0000000 -0.17471588
## qsec  NA  NA -0.4336979 -0.7082234  0.09120476 -0.1747159  1.00000000
## vs    NA  NA -0.7104159 -0.7230967  0.44027846 -0.5549157  0.74453544
## am    NA  NA -0.5912270 -0.2432043  0.71271113 -0.6924953 -0.22986086
## gear  NA  NA -0.5555692 -0.1257043  0.69961013 -0.5832870 -0.21268223
## carb  NA  NA  0.3949769  0.7498125 -0.09078980  0.4276059 -0.65624923
##              vs          am       gear        carb
## mpg          NA          NA         NA          NA
## cyl          NA          NA         NA          NA
## disp -0.7104159 -0.59122704 -0.5555692  0.39497686
## hp   -0.7230967 -0.24320426 -0.1257043  0.74981247
## drat  0.4402785  0.71271113  0.6996101 -0.09078980
## wt   -0.5549157 -0.69249526 -0.5832870  0.42760594
## qsec  0.7445354 -0.22986086 -0.2126822 -0.65624923
## vs    1.0000000  0.16834512  0.2060233 -0.56960714
## am    0.1683451  1.00000000  0.7940588  0.05753435
## gear  0.2060233  0.79405876  1.0000000  0.27407284
## carb -0.5696071  0.05753435  0.2740728  1.00000000
```

Alle korrelasjoner der `cyl` og `mpg` inngår er nå missing. Hvis vi velger `use = "complete.obs"` vil alle observasjoner som har missing på minst en variabel kastes ut før korrelasjoner beregnes. Resultatet blir det samme som om du lager et nytt datasett der du tar og fjerner dem som har `FALSE` på en logisk test med `complete.cases()`.


```r
cor(mydata, use = "complete.obs")
```

```
##             mpg        cyl       disp         hp       drat         wt
## mpg   1.0000000 -0.8663052 -0.8655241 -0.7783080  0.7024425 -0.8728096
## cyl  -0.8663052  1.0000000  0.9033376  0.8405024 -0.7116653  0.7861527
## disp -0.8655241  0.9033376  1.0000000  0.7928141 -0.6991629  0.8936297
## hp   -0.7783080  0.8405024  0.7928141  1.0000000 -0.4546798  0.6461912
## drat  0.7024425 -0.7116653 -0.6991629 -0.4546798  1.0000000 -0.7217054
## wt   -0.8728096  0.7861527  0.8936297  0.6461912 -0.7217054  1.0000000
## qsec  0.4257104 -0.6054871 -0.4706050 -0.7438638  0.1322096 -0.1907273
## vs    0.7023243 -0.8406055 -0.7814675 -0.7780404  0.5285770 -0.6049366
## am    0.6336996 -0.5115449 -0.5504814 -0.1946924  0.6975878 -0.6930103
## gear  0.4914358 -0.4840644 -0.5328011 -0.1128775  0.6755270 -0.5878970
## carb -0.5774516  0.5580234  0.4595830  0.8057677 -0.1666577  0.4586149
##            qsec         vs           am       gear         carb
## mpg   0.4257104  0.7023243  0.633699627  0.4914358 -0.577451617
## cyl  -0.6054871 -0.8406055 -0.511544916 -0.4840644  0.558023406
## disp -0.4706050 -0.7814675 -0.550481359 -0.5328011  0.459582970
## hp   -0.7438638 -0.7780404 -0.194692425 -0.1128775  0.805767680
## drat  0.1322096  0.5285770  0.697587760  0.6755270 -0.166657660
## wt   -0.1907273 -0.6049366 -0.693010257 -0.5878970  0.458614916
## qsec  1.0000000  0.7297266 -0.213518692 -0.2030905 -0.649732341
## vs    0.7297266  1.0000000  0.240098019  0.2503552 -0.537508227
## am   -0.2135187  0.2400980  1.000000000  0.8027083  0.005267537
## gear -0.2030905  0.2503552  0.802708337  1.0000000  0.244061179
## carb -0.6497323 -0.5375082  0.005267537  0.2440612  1.000000000
```

Hvis du velger `pairwise.complete.obs` vil observasjoner kun fjernes når de har missing på en variabel som inngår i en korrelasjon. Du kan sjekke hvilke observasjoner som fjernes i de enkelte bivariate korrelasjonene ved hjelp av `is.na()`:

```r
which(is.na(mydata$mpg)|is.na(mydata$cyl))
```

```
## [1] 1 2 3 4 5
```

Her ser vi at i korrelasjonen mellom `mpg` og `cyl`, så vil observasjon 1-5 fjernes. I korrelasjonen mellom `cyl` og `hp` ser vi derimot at kun observasjon 1-3 vil fjernes når vi velger `use = "pairwise.complete.obs"`.


```r
which(is.na(mydata$hp)|is.na(mydata$cyl))
```

```
## [1] 1 2 3
```


```r
cor(mydata, use="pairwise.complete.obs")
```

```
##             mpg        cyl       disp         hp        drat         wt
## mpg   1.0000000 -0.8663052 -0.8612202 -0.7752113  0.70089900 -0.8694417
## cyl  -0.8663052  1.0000000  0.9050086  0.8339079 -0.70379865  0.7783139
## disp -0.8612202  0.9050086  1.0000000  0.7909486 -0.71021393  0.8879799
## hp   -0.7752113  0.8339079  0.7909486  1.0000000 -0.44875912  0.6587479
## drat  0.7008990 -0.7037986 -0.7102139 -0.4487591  1.00000000 -0.7124406
## wt   -0.8694417  0.7783139  0.8879799  0.6587479 -0.71244065  1.0000000
## qsec  0.4125848 -0.6054955 -0.4336979 -0.7082234  0.09120476 -0.1747159
## vs    0.6730197 -0.8322585 -0.7104159 -0.7230967  0.44027846 -0.5549157
## am    0.6131707 -0.5146838 -0.5912270 -0.2432043  0.71271113 -0.6924953
## gear  0.4928805 -0.4883477 -0.5555692 -0.1257043  0.69961013 -0.5832870
## carb -0.5599429  0.5213383  0.3949769  0.7498125 -0.09078980  0.4276059
##             qsec         vs          am       gear        carb
## mpg   0.41258481  0.6730197  0.61317066  0.4928805 -0.55994286
## cyl  -0.60549554 -0.8322585 -0.51468377 -0.4883477  0.52133828
## disp -0.43369788 -0.7104159 -0.59122704 -0.5555692  0.39497686
## hp   -0.70822339 -0.7230967 -0.24320426 -0.1257043  0.74981247
## drat  0.09120476  0.4402785  0.71271113  0.6996101 -0.09078980
## wt   -0.17471588 -0.5549157 -0.69249526 -0.5832870  0.42760594
## qsec  1.00000000  0.7445354 -0.22986086 -0.2126822 -0.65624923
## vs    0.74453544  1.0000000  0.16834512  0.2060233 -0.56960714
## am   -0.22986086  0.1683451  1.00000000  0.7940588  0.05753435
## gear -0.21268223  0.2060233  0.79405876  1.0000000  0.27407284
## carb -0.65624923 -0.5696071  0.05753435  0.2740728  1.00000000
```













