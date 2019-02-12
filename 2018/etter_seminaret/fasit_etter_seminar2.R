###################################################
#### Løsningsforslag oppgaver etter seminar 2  ####
###################################################

############################
###### Forberedelser #######
############################

## Fjerner objekter fra environment.
rm(list = ls())

## start med å laste inn datasettet "personstemmer.csv", dersom du ikke har lastet det inn 
## Fjerne "#" dersom datasettet ikke er innlastet.

## Laster inn fra mappe på egen pc
#personst <- read.csv("data/personstemmer.csv", stringsAsFactors = F)

## Laster inn fra github:
#personst <- read.csv("https://raw.githubusercontent.com/langoergen/stv1020R/master/data/personstemmer.csv", 
#                     stringsAsFactors = F)

## installerer pakker, fjern "#" dersom pakke ikke er installert.
#install.packages("haven")
#install.packages("ggplot2")
#install.packages("wesanderson") # for å pynte plot, trengs egentlig ikke
#install.packages("ggthemes")    # for å pynte plot, trengs egentlig ikke
#install.pacakges("devtools")
#install_github("andreacirilloac/paletter") # last inn devtools først


## Laster inn pakker i R
library(ggplot2)
library(haven)
library(wesanderson)
library(ggthemes)
library(devtools)
library(paletter)
?palette_pander
#######################
#### Oppgave 1 ########
#######################

# Se løsningsforslag til oppgaver fra seminar 2 på github


#######################
#### Oppgave 2 ########
#######################

str(personst) # ser at kjønn er integer, ikke character, men kan omkode til factor allikevel 


personst$kjønn <- as.factor(personst$kjønn)
personst$parti <- as.factor(personst$parti)

str(personst) # ser at variablene er blitt factors

######################
#### Oppgave 3 ######
#####################


# Lager farger til plot med paletter pakken:
download.file("http://beautiful-lands.com/images/posts/NikolaiAstrupPaintingNorway2.jpg", 
              "bilder/NikolaiAstrupPaintingNorway2.jpg")
my_cols <- create_palette("bilder/NikolaiAstrupPaintingNorway2.jpg", 
                          type_of_variable = "categorical", 
                          number_of_colors = 17)

# plot (fjern scale_colors_manual om du ikke har laget farger)
ggplot(personst, aes(x = rangering, y = rangering_original, col = parti, shape = kjønn)) +
  geom_point() +
  theme_tufte() +
  labs(x = "Rangering",  y = "Opprinnelig rangering", title = "Sammenheng mellom 4 variabler") +
  scale_color_manual(values = my_cols)


###############################
#### Oppgave 4 ################
###############################

# se kode for å installere 'haven' over.

save(personst, file =  "personstemmer.Rdata") # lagrer som .Rdata med save()
write.csv(personst, "personstemmer.csv") # lagrer som .csv 
write_sav(personst, "personstemmer.sav") # lagrer i spss format, bruker funksjon fra haven
colnames(personst)[8] <- "kjonn"
write_dta(personst, "personstemmer.dta") # lagrer i stata format, bruker funksjon fra haven


personst1 <- read.csv("personstemmer.csv", stringsAsFactors = F)
personst2 <- load("personstemmer.Rdata")
personst3 <- read_stata("personstemmer.dta")
personst4 <- read_spss("personstemmer.sav")



################################
#### Oppgave 5 #################
################################

## Korrekt kode
ggplot(personst, aes(x = rangering, y = medietreff, col = as.factor(valgt))) +
  geom_point() + 
  ggtitle("et plot") + 
labs(x = "x-akse", y = "y-akse") + 
     theme_bw()

## Gal kode:
ggploT(personst, aes(x = rangerings, y = medietreff, col = as.factor(valgt))) +
  geom_point() + 
  ggtitle("et plot")  
labs(x = x-akse, y = "y-akse"") + 
  theme_bw()

