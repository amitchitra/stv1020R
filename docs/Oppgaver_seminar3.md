# Oppgaver Seminar 3



## Oppgaver 3. R-seminar

Du skal lage et fint og ryddig R-script med svar på oppgavene! Vi skal se på sammenhengen mellom vekst (`gdp_growth`), bistand (`aid`), og makroøkonomisk politikk (`policy`). Du kan løse oppgavene i den rekkefølgen du vil, oppgavene er ment som en hjelp til å utforske hypotesen. Du kan også utforske data på andre måter enn jeg ber om i oppgavene. Jeg vil imidlertid be om at dere forsøker på oppgave 2, 6, og 7 i løpet av seminaret.

### Oppgave 1:

Last inn `aidgrowth.csv` eller `aidgrowth.Rdata` i R (inneholder samme datasett). Datasettene ligger på github for STV 1020 i data mappen. Du kan lagre filene i working directory, eller laste direkte inn fra url. Vi skal jobbe med dette datasettet i hele dagens seminar.

### Oppgave 2:

Lag et scatterplot mellom bistand (`aid`) og økonomisk vekst (`gdp_growth`). Tegn deretter regresjonslinjen for den bivariate regresjonen mellom bistand og vekst med argumentet `geom_smooth(method = "lm")`.

Gjør deretter en hypotese-test der du sjekker om korrelasjonen mellom variablene er signifikant. 

Kjør til slutt den bivariate regresjonen som du tegnet inn i plottet. 

### Oppgave 3:

Se nærmere på univariat deskrpitiv statistikk for `policy`, `aid` og `growth`. Du bør i hvertfall se nærmere på standardavvik, maksimums- og minimumsverdier, samt ulike mål for sentraltendens.

Lag deretter histogram for de tre variablene. Kommenter til slutt fordelingen til variablene.

### Oppgave 4: 

Gjenta oppgave 2 for sammenhengen mellom `policy` og `gdp_growth`, og `aid` og `policy`. Kommenter plottene. 

### Oppgave 5:

Fjern de fem observasjonene med høyest verdi på `gdp_growth`, og de fem observasjonene med høyest verdi på `aid`. Gjennomfør oppgave 2 på nytt.

### Oppgave 6: 

Lag en ny variabel, `policy2` ved å omkode variabelen `policy` som følger:
* Observasjoner med lavere verdi enn `-2` skal få verdien `0`
* Observasjoner med lavere verdi enn `0` og verdi større eller lik `-2` skal få verdien `1`
* Observasjoner med lavere verdi enn `2` og verdi større eller lik `0` skal få verdien `2`
* Observasjoner med lavere verdi enn `4` og verdi større eller lik `2` skal få verdien `3`
* Observasjoner med høuere verdi enn `4` skal få verdien `4`

### Oppgave 7:

Lag et plot med `aid` på x-aksen, `gdp_growth` på y-aksen, og farge (`col =`) bestemt av verdien på `policy2` variabelen.

### Oppgave 8:

Opprett nye variabler ved hjelp av matematisk transformasjoner av `policy`. Bruk `sqrt()`, `exp()` og `log()`. Kjør bivariate regresjoner mellom `policy()` og `gdp_growth()`. Endres resultatene?

### Oppgave 9:

Lag nye datasett for 3 perioder (definert i variabelen `period`). Du kan bruke `subset()` til dette formålet. Gjenta oppgave 2 for disse datasettene, hvordan ser sammenhengen ut nå? Kommenter både plot og regresjon.  



### Oppgave 10:
Skriv en kort oppsummering av funnene dine, beskriv sammenhengen mellom variablene `aid`, `policy` og `gdp_growth` nærmere. Holder sammenhengene dersom man ser på ulike deler av datasettet? Dersom du har god tid, kan du fortsette å utforske sammenhengene på egenhånd, for eksempel ved å velge ut deler av datasettet basert på variablene i regresjonsmodell 5., regioner, enkeltland, m.m.




