## Oppgaver 4.5
# Professor Carl Henrik Knutsen har lest den famøse Burnside & Dollar (2000) artikkelen 
# men stoler ikke på resultatene. Han har bedt deg replisere modell 5 
# (se https://github.com/martigso/stv1020R/tree/master/docs/aidgrowth). 

# 0. Last inn dataene "aidgrowth"
aidgrowth <- read.csv("./data/aidgrowth.csv", stringsAsFactors = FALSE)

# 1. Gjør om variablen "gdp_pr_capita" til en logget versjon med funksjonen log() 
  # og omkod variablene "sub_saharan_africa", "fast_growing_east_asia" og "period" til
  # ordinale variabler med funksjonen as.factor()


# 2. Repliser modellen med funksjonen lm() (OLS). Se https://github.com/martigso/stv1020R/tree/master/docs/aidgrowth for originale resultater og modellspesifikasjon
  # Avhengig variabel er "gdp_growth"
  # Husk å bruke variablene du opprettet i oppgave 1 (også "period", selv om denne ikke er rapportert i Burnside & Dollar (2000))
  # a. Blir resultatene like? 
  # b. Hvilken informasjon har Burnside & Dollar utelatt fra sin tabell, og hvorfor er dette problematisk?


# 3. Test en av fortutsetningene for OLS og kommenter om denne er oppfylt i Burnside & Dollar's artikkel


