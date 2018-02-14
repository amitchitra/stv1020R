# Stipendiat Haakon Gjerløw er interessert i historiske trender i den amerikanske congressen, 
# og spesielt forholdet mellom senatet og huset. Han har bedt deg strukturere og analysere 
# data på dette. 
# Du finner ut at det er data tilgjengelig på https://github.com/martigso/stv1020R/tree/master/data . Du kan kjøre:


# Disse dataene inkluderer nummer på kongressen, kammer, alder, navn med mer.

# 1. Last inn data med `load()`

# 2. Konstruer variabelen "age" basert på variabler i data. 
  # Hint: datovariabler kan trekkes fra hverandre, og i gjennomsnitt er det 365.25 dager i ett år
  #       og det er lurt å gjøre den numerisk til senere.

# 3. Gjør om variablene "chamber", "party", og "incumbent" til numerisk dikotome variabler
  # Sett alle som ikke er Demokrat eller Republikaner på "party" til NA

# 4. Lag korrelasjonsmatrise mellom variablene fra forrige oppgave og variabelen age
  # a. Fjern missingenheter listwise
  # b. Fjern missingenheter pair-wise -- er det forskjeller mellom a. og b.?
  # c. Er det noen korrelasjoner som stikker seg frem? Hvis ja, valider om sammenhengen er signifikant

# 5. Estimer en linær regresjonsmodell med den dikotome "chamber"-variabelen som avhengig variabel 
  # og "age", "party" og "congress" som uavhengige variabler
  # Husk å bruke na.action = "na.exclude"
  # a. Forklar den substansielle meningen til resultatene
  # b. Hva betyr det at konstantleddet er negativt når avhengig variabel er rangert fra 0 til 1?

# 6. Kontroller om restleddene fra regjersjonen over er normalfordelt
  # a. Hvilke konsekvenser har dette for slutningene man kan gjøre basert på regresjonen?



