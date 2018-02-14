
# Laster inn en pakke: rvest. Denne gjør det enklere å strukturere informasjon fra nettsider
library(rvest)

# Lager objekt for urlen vi henter data fra (med RStudio versjon >= 1.0.136 kan du shift-klikke på linken for å åpne i nettleser)
url <- "http://www.sv.uio.no/isv/?vrtx=tags&tag=Komparativ%20politikk&resource-type=person&sorting=resource%3Asurname%3Aasc&sorting=resource%3AfirstName%3Aasc"

# Leser inn rå html fra urlen
raw_isvkp <- read_html(url)

# Henter ut tabellen vi vil ha 
 # (den leser <table> fra kildekoden trykk ctrl i chrome for å få opp kildekode i nettleseren)
isv_kp <- raw_isvkp %>% html_table()

# Sjekker hvilken type objekt det er
class(isv_kp)

# Sjekker hvor mange tabeller vi har funnet
length(isv_kp)

# Trekker ut tabellen vi vil ha
isv_kp <- data.frame(navn[[1]])

# Ved å inspisere datasettet ser vi at navn og stilling har kommet i samme variabel -- det må fikses manuelt
head(isv_kp)

# 

isv_kp$Navn[which(grepl("Hagtvet", isv_kp$Navn))] <- paste0(isv_kp$Navn[which(grepl("Hagtvet", isv_kp$Navn))], "\n NA")

isv_kp$stilling <- stringr::str_trim(sapply(strsplit(isv_kp$Navn, "[\n]"), "[[", 2))
isv_kp$Navn <- stringr::str_trim(sapply(strsplit(isv_kp$Navn, "[\n]"), "[[", 1))
