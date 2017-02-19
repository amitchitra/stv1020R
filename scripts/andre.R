#####################
#### Seminar 1.5 ####
#####################

# Gjenomgang av de leverte skriptene fra forrige gang.

###################
#### Seminar 2 ####
###################

# 0. Få tak i data og lagre data
#     a. Lag prosjekt i R-studio -> rullegardin helt oppe til høyre
#     b. Last ned personstemmer.csv fra https://github.com/martigso/stv1020R/tree/master/data
#        (God mappestruktur er viktig: lag en egen mappe for data!)


# 1. Last inn `personstemmer.csv` i R
#     a. Bruk read.csv()-funksjonen
#     b. Husk å sende R inn i data-mappen

# 2. Vis hvordan du får frem frekvensfordelingen til «mediatreff» med et stolpediagram.

# 3. Vis hvordan du får frem gjennomsnitt, median, standardavvik, skjevhet og kurtose til «mediatreff».

# 4. Opprett variabelen «media» med utgangspunkt i variabelen «mediatreff», slik at:
#     a. media = 0: Hvis mediatreff er lavere enn sin median
#     b. godt = 1: Hvis mediatreff er høyere eller lik sin median 
#     c. Kontroller at «media» ble korrekt opprettet

# 5. Lag et boxplot av «personstemmer» og «valgt».

# 6. Lag en ny variabel «valgt2», der «Vara» fra variabelen «valgt» er definert som missing.
#     a. Kontroller at variabelen ble korrekt opprettet.

# 7. Vis hvordan du undersøker med en kji-kvadrat-test om sammenhengen mellom «valgt2» og «media» er signifikant. 
#     a. Hva forteller testen om styrken på sammenhengen? 

# 8. Lagre scriptet og det modifiserte survey-datasettet.