# Oppgaver fjerde seminar
# Datasett: religion.csv
# Hver rad er en respondent i en survey


# 0. Opprett nytt skript og finn kode for å laste inn data (samme som forrige gang: ligger på www.github.com/martigso/stv1020r)

# 1. Last inn religion i kommaseperert format (.csv) -- viktig å huske stringsAsFactors = FALSE

# 2. Kod om variabelen "utdanning til å være nummerisk, slik at laveste utdanningsnivå er 0 og høyeste er 6 (det er 7 nivåer i data) i en ny variabel "utd_num"
  # a. Lag så enda en ny variabel (utd_cat) der du slår sammen alle fra den opprinnelige variabelen som har "primary" i teksten, 
    # alle som har "secondary" og alle som har "tertiary" i hver sin kategori. 
  # b. Hvilken av de to nye variablene bør vi bruke videre? Og hvorfor?



# 3. Lag et subset "prot" av "religion" data, der bare de som er protestanter eller ikke har religiøs tilhørighet er med
  # a. Gjør om "relig_denom" til nummerisk dikotom variabel der protestanter får verdien 0 og ingen religion verdien 1 

# 4. I de nye data, vis hvordan du finner korrelasjonen mellom "aksept_homofili", "utd_num", "alder" og "ant_barn".
  # Bruk pakken "psych" 
  # a. Kommentér sammenhengens styrke, retning, form og om sammenhengen er signifikant.



# 5. Vis hvordan du gjennomfører en regresjonsanalyse med "aksept_aktiv_dodshjelp" som AV 
  # og "alder", "utd_cat", "ant_barn" og "kjonn" som UV. Husk 'na.action = "na.exclude"'
  # a. Tolk konstantleddet, variabelkoeffisientene og R2.
  # b. Lag en kopi av "prot", "prot2", der du standariserer versjoner av alle variablene i analysen.
  # c. Kjør regresjonen på nytt. Hvordan tolkes nå resultatene 

# 6. For å teste om regresjonene er i tråd med forutsetningene til OLS må vi gjøre flere ting:
  # a. Legg inn forventede verdier og residualer i datasettet "prot"
  # b. Sjekk om residualene er normalfordelt i begge regresjonene. Kommenter resultatene.
  # c. Visualiser forventede verdier og residualer. Kommenter plottet.

  # BONUS! Visualiser forskjellen i forventet Y mellom en ikke religiøs person og en protestant