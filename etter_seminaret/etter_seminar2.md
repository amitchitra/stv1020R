# Oppgaver etter seminar 2
Erlend Langørgen  
March 2, 2018  



## Oppgaver å gjøre etter 2. R-seminar

Disse oppgavene gir deg repetisjon av seminar 2, mer trening i å lese inn ulike typer datafiler, samt mer trening i feilsøking. Du lærer også å plotte mer enn to variabler i et scatterplot.

## Oppgave 1:
Se gjennom [løsningsforslaget til seminar2](https://github.com/langoergen/stv1020R/blob/master/scripts/seminar2_l%C3%B8sningsforslag.R) i mappen scripts. Du kan velge om du vil forsøke å løse oppgavene uten å se på løsningsforslaget, eller om du vil se løsningsforslaget med en gang. Det viktigste er at du bruker tid på å forsøke å forstå hvordan koden fungerer. Dersom noe er uklart (eller du oppdager feil), ta kontakt. 

### Oppgave 2: 
Vi skal fortsette å jobbe med datasettet `personst` fra seminar 2.
Omkod variablene parti og kjønn fra klassen `character` til `factor`. Til dette bruker du funksjonen `as.factor()`.
Her er et hint til hvordan du løser denne oppgaven (du må fylle inn mer kode selv):
`as.factor(personst$kjønn)`

Det finnes forøvrig tilsvarende funksjoner for å konvertere til andre variabeltyper, som `as.character()` og `as.numeric()`

### Oppgave 3

Lag et scatterplot mellom variablene `rangering` og `rangering_original` ved hjelp av `ggplot()`.
Når du har fått til dette, endrer du `aes()` argumentet til:
`aes(x = rangering, y = rangering_original, col = parti, shape = kjønn)`
Du skal nå få et plot der 4 variabler visualiseres i et scatterplot.

Det er en kunst å visualisere mange variabler på en effektiv måte i ett og samme plot, jeg påstår ikke at plottet du får her er særlig godt.

### Oppgave 4

Installer pakken `haven`, og last den inn i R. 

Bruk funksjonene `save()`, `write.csv()`, `write_sav()`og `write_dta()` til å lagre datasettet `personst` fra seminaret som henholdsvis `personstemmer.Rdata`, `personstemmer.csv`, `personstemmer.sav` og `personstemmer.dat` I ditt working directory.

Last deretter datasettene inn i R som objekter under navnene `personst1`, `personst2`, `personst3` og `personst4`.
Du finner funksjonene du trenger i [dokumentet til seminar 2](https://github.com/langoergen/stv1020R/blob/master/docs/Seminar2.md) eller på internett.

Filer av typen `.sav` er vanlig i SPSS, mens filer av typen `.dta` er vanlig i stata. Funksjonene for å håndtere disse filtypene stammer fra `haven` pakken skrevet av Hadley Wickham.

**P.S.:** 
1. For å lagre datasettet som en `.dta` fil må du bytte navn på variabelen kjønn til kjonn, her er hjelp: 
`colnames(personst)[] <- " "`, fyll inn koden som mangler.
2. For å lagre datasettet som en `.Rdata` fil må du spesifisere `file = ""` inne i funksjonen, se `?save`

Datasettene ligger også i data-mappen på github.

### Oppgave 5:

Kopier denne koden inn i et script, og finn ut hva som er galt! Koden skal lage et scatterplot mellom medietreff og rangering, med ulik farge for dem som ble valgt og dem som ikke ble valgt, og varaer. Det er flere feil. Feilsøk en linje om gangen.



```r
ggploT(personst, aes(x = rangerings, y = medietreff, col = as.factor(valgt))) +
  geom_point() + 
  ggtitle("et plot")  
  labs(x = x-akse, y = "y-akse"") + 
  theme_bw()
```







