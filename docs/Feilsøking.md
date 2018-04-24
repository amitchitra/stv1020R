# Feilsøking
Erlend Langørgen  
April 24, 2018  



## Feilsøking i R.

Dette dokumentet er ment som hjelp til å løse problemer som oppstår i R. Dokumentet er ikke uttømmende, men det inneholder forhåpentligvis mange nyttige tips.

Jeg dekker følgende emner:
1. Koden min fungerer ikke
2. R fungerer ikke
3. Plottene mine fungerer ikke/er rare

## Koden min fungerer ikke

Det kan dessverre være flere grunner til at koden din ikke fungerer. Mitt første tips er at du sjekker om det er skrivefeil i koden din. Her er noen vanlige skrivefeil:

* datasett$ før variabelnavn i funksjoner uten data-argument
* for mange/få parenteser eller komma
* for mange/få `"`, kan oppdages ved at koden din endrer farge til fargen for tekst.
* store og små bokstaver

Dersom du mistenker skrivefeil, men ikke er sikker på hvor feilen er, kan du lete ved å starte innerst i koden (innerst i parentesene), og se om hvert enkelt komponent fungerer. Dersom jeg skulle feilsøkt koden `complete.cases(mtcars[,"cyl", "mpg""])` ville jeg startet med å se om `mtcars[,"cyl", "mpg""]` fungerte, før jeg testet koden rundt. Forhåpentligvis ville jeg da funnet frem til løsningen, `mtcars[,c("cyl", "mpg")]`

Dersom du ikke finner skrivefeil i koden din, men den fortsatt ikke fungerer, anbefaler jeg deg å sjekke om pakkene til alle funksjonene du bruker er lastet inn. Dersom jeg kjører koden `?ggplot` får jeg opp hjelpefilene til funksjonen kun dersom jeg har lastet inn pakken `ggplot2`. Dersom jeg ikke har lastet inn `ggpplot2` med `library()`, får jeg feilmeldingen 
`No documentation for ‘ggplot’ in specified packages and libraries: you could try ‘??ggplot’`
Denne feilmeldingen gir et godt tips, dersom hjelpefilen til en funksjon vi skal bruke ikke dukker opp, kan vi søke etter pakken funksjonen tilhører med `??`. Når vi kjører `??ggplot` er `ggplot2` det første treffet vi får opp.

En annen mulighet er at koden din ikke virker, fordi du sendte kode til `console` som ikke er kjørt ferdig enda.
For eksempel vil koden `ggplot(mtcars, aes(x=cyl)) + geom_histogram() +`, vil du se at `console` viser `+` på nederste linje i stedet for `>`. Dette problemet løses ved å trykke med musepekeren i `console`, og
deretter trykke på `esc`. 

Videre kan det være at koden din ikke fungerer på grunn av at du tidligere har sendt kode som har endret datasettet. Dersom du for eksempel har skrevet over en variabel og ikke fått det ønskede resultatet, kan det godt hende at du får trøbbel med kode senere. Ta derfor en titt på datasett/variabler du skal bruke på en kodelinje (du kan kjøre deskriptiv statistikk, sjekke for missing med `is.na()`, og åpne hele datasettet). Det kan også hende at variablene dine har en klasse som gjør at en funksjon ikke fungerer. Da anbefaler jeg opprettelse av ny variabel med riktig klasse ved hjelp av funksjoner som `as.factor()`, `as.numeric()` og `as.character()`. Husk også å sjekke om du faktisk har lastet inn data, dette kan gjøres ved hjelp av `str(data)`, eller ved å se om datasettet ditt finnes i `Environment` oppe til høyre i Rstudio.

Dersom det er en statistisk funksjon som ikke fungerer, sjekk om funksjonen har et missing argument som du kan spesifisere, som f.eks. `na.rm = T` eller `use = "pairwise.complete.obs"`. Det er et godt generelt tips å sjekke argumentene til en funksjon, har du spesifisert alle nødvendige argumenter, og har du satt dem i **default** rekkefølge (som angitt av rekkefølgen i hjelpefilen)?

Dersom heller ikke dette er problemet, bør du tenke gjennom koden din. Kanskje du har glemt å indeksere noe, eller en liten funksjon som `c()`, eller kanskje du må omspesifisere den logiske testen din? Dersom du får en feilmelding i console, kan det ofte fungere å google den feilmeldingen, kanskje har noen andre har støtt på samme problem og fått hjelp på forum som stackoverflow.


## R fungerer ikke

Du vil ofte få opp en beskjed om at R trenger en omstart i forbindelse med installasjon av pakker (`install.packages`). Dersom pakken allerede er installert (`library(pakkenavn)` fungerer), kan du avbryte koden, da du ikke trenger å installere pakken på nytt. Dersom pakken ikke er installert, kan du trygt la R starte på nytt igjen, da scriptet ditt vil åpnes neste gang du åpner R.

Dersom du ser et lite rødt stop-skilt i `console` betyr det at R jobber. Dersom R henger seg helt opp, og ikke vil stoppe å jobbe, kan du trykke på stopp, og se over koden din. Dersom du blir spurt om du vil `terminate current R session` eller lignende kan du trykke ja, da scriptet ditt vil dukke opp neste gang du åpner R. Slike problemer kan i noen tilfeller oppstå når man sender kode med småfeil i til `console`.

For å unngå at R ikke fungerer, er mitt beste tips at dere sørger for å ha de relevante pakkene til seminaret installert på pcen dere skal bruke før prøven starter. Dersom dere vil bruke en UiO PC, kan dere komme 5-10 minutter før prøvestart, og installere `ggplot2`, ``moments`, `car` og `haven` (samt `dplyr` dersom dere liker den pakken).


## Plottene mine fungerer ikke/er rare.

Dersom du får problemer med plot, gjelder alt jeg har skrevet tidligere i dette dokumentet. I tillegg kan koden `dev.off()` være verdt å forsøke før du kjører koden som lager plot på nytt. Denne koden fjerner grafiske parametre, som kan ødelegge plottene dine. 




