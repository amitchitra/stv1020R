## Kode som løser hjemmeoppgavene etter 1. seminar.

## Oppgave 1:
Frida <- c("kvinne", 22, "student", 12000)   
Per <- c("mann", 25, "murer", 30000)
Ole <- c("mann", 35, "konsulent", 50000)
Ida <- c("kvinne", 27, "sykepleier",  32000)
Nils <- c("mann", 28, "arbeidsledig", 10000)

## Oppgave 2:
data <- t(data.frame(Frida, Per, Ole, Ida, Nils))
data <- (data.frame(rbind(Frida, Per, Ole, Ida, Nils), stringsAsFactors=F))

## Oppgave 3:
colnames(data) <- c("kjønn", "alder", "yrke", "lønn")

## Oppgave 4:
data$lønn[which(data$lønn<30000)]
data$kjønn[which(data$lønn<30000)]
data[(which(data$lønn<15000)),c("alder", "yrke")]  

## Bonus: 
# Dersom det finnes en fin pakke som lar deg indeksere på en annen måte: dplyr.
# Denne pakken er skrevet av Hadley Wickham, som er utvikler hos R-studio, og som har 
# skrevet mange av de beste pakkene til R, inkludert ggplot2 som vi skal bruke i seminarene.
# Her er løsningen på oppgave 4 med dplyr:

install.packages("dplyr")
library(dplyr)

data %>% 
  filter(lønn<15000) %>%
  select(alder, yrke)
  



