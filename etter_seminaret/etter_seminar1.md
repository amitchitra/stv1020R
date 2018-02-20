Oppgaver å gjøre etter første seminar
================
Erlend Langørgen
20 februar 2018

Oppgaver
--------

I disse oppgavene får du mer selvstending trening i temaene vi gikk gjennom i dagens seminar. Oppgavene trener deg i indeksering, og i forståelse av enheter, variabler og datasett. Du blir også trent i å lese hjelpefiler, og å forstå nye funksjoner. Evnen til å kombinere funksjoner du har lært med andre funksjoner er essensielt for å lykkes med R.

### Oppgave 1:

I denne oppgaven skal du opprette 5 objekter. Disse vektorene representerer 5 **enheter**, Frida, Per, Ole, Ida og Nils. Bruk personnavnene som navn på objektene. For hver enhet har vi informasjon om kjønn, alder, yrke og månedslønn (før skatt) (i den rekkefølgen). Under er informasjon om disse variablene for hver enhet. Bruk denne informasjonen til å opprette vektorene.

1.  Frida - kvinne, 22, student, 12000
2.  Per - mann, 25, murer, 30000
3.  Ole - mann, 35, konsulent, 50000
4.  Ida - kvinne, 27, sykepleier, 32000
5.  Nils - mann, 28, arbeidsledig, 10000

**Tips:** Copy-paste informasjonen over inn i scriptet ditt, og bruk som utgangspunkt for å lage vektorene.

### Oppgave 2:

I denne oppgaven skal du lage et datasett av objektene du opprettet i forrige oppgave. I seminaret opprettet vi datasett ved å kombinere vektorer som representerte **variabler**. For å løse denne oppgaven, må du anvende den samme funksjonen som vi brukte for å lage datasett med variabler i seminaret, men du må også bruke en av de to følgende funksjonene (begge fungerer):

`t()` eller `rbind()`.

Funksjonen `rbind()` binder sammen vektorer i rekker, dersom dere vil bruke `t()` får dere finne ut av hva som foregår på egenhånd :). Lagre datasettet som et objekt.

Hjelp: du kan sjekke at du har gjort riktig ved å lage variabler av informasjonen i oppgave 1, og opprette datasett på samme måte som i seminaret. Resultatene skal bli like (jeg anbefaler forøvrig å sette `stringsAsFactors = FALSE`)

### Oppgave 3:

I denne oppgaven skal du få litt hjelp. Den demonstrerer flere anvendelser av **assignment operatoren**, `<-`. Ved å skrive `colnames(datasett) <-`, kan vi angi nye variabelnavn til datasettet vårt. Angi nye navn til datasettet, ved å skrive en tekstvektor etter `<-`, som inneholder navnene `kjønn`, `alder`, `yrke` og `lønn`. Sjekk at du har klart å bytte variabelnavn ved å sende `colnames(datasett)` til console.

**Merk:** Dersom du har gitt datasettet ditt et annet navn, må du bytte navn der jeg har skrevet `datasett`

### Oppgave 4:

Vis hvordan du kan identifisere de enhetene som har månedslønn større eller lik 30000 i datasettet, ved hjelp av `which()` og en logisk test. Bruk denne informasjonen til å indeksere følgende informasjon fra datasettet ditt:

1.  Alle verdier på variabelen lønn som er større eller lik 30000
2.  Alle verdier på variabelen kjønn, for de enhetene som har lønn større eller lik 30000
3.  Alle verdier på variablene alder og yrke, for dem som har lønn under 15000

Den siste deloppgaven er vanskelig, men den lar seg best løse ved å bruke muligheten til å velge både kolonner og rader i et datasett inne i klammeparenteser. Alt kode som trengs for å løse den siste deloppgaven ble gjennomgått i seminaret. Dersom du klarer å løse de to første deloppgavene ved hjelp av to metoder for indeksering blir jeg forøvrig imponert. Lagre scriptet, og send meg en melding på slack dersom du lurer på om du har fått det til. Jeg vil snakke kort om oppgavene på starten av neste seminar (løsning blir lagt ut fredag neste uke). Lykke til!
