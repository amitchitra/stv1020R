# Du har fått i oppgave å analysere reaksjoner på Donal Trumps statuser gjennom valgkampen i 2016.
# Dataene du får du fra http://folk.uio.no/martigso/stv1020/testprove/trump_face.csv .
# Variabelbeskrivelse finnes i egen fil på fronter

# 1. Last inn data "trump_face.csv" 

# 2. Opprett en ny variabel, "clinton_mentioned", som tar verdien 1 hvis variabelen "status_message" inneholder ordet "Clinton", og 0 ellers.
  # Hvor mange statuser ble Clinton nevnt i?
  # Hint: Se oppgave 2a fra seminar 4

# 3. Opprett to variabler som viser..
  # a. Prosent likes ("num_likes") av alle reaksjoner ("num_reactions")

  # b. Prosent sinte reaksjoner ("num_angrys") av alle reaksjoner ("num_reactions")

# 4. Lag et boxplot som viser proporsjonen likes (fra oppgave 3) på y aksen og tidspunkt statusen ble delt på x-aksen ("time_of_day")
  # a. Hvilket tidspunkt viser boxblotet lavest median på?

# 5. Lag et subset av data (nytt datasett), der bare statuser som er publisert på natten ("night") er med

  # a. Lag en korrelasjonsmatrise fra det originale datasettet (fra oppgave 1) mellom variablene fra oppgave 3 (prosent likes og angry), 
    # antall negative ord ("negative_words") og antall postive ord ("negative_words"). 
    # Slett enheter list-wise.

  # b. Lag samme korrelasjonsmatrise som over, men på det nye datasettet med bare nattlige statuser
    # Slett enheter list-wise.

  # c. Signifikanstest en av korrelasjonene med begge datasettene. Kommenter kort resultatene.

# 6. Lag en regresjon fra det komplette datasettet, med antal sinte reaksjoner ("num_angrys") som avhengig variabel og
  # "positive_words" , "negative_words", om Clinton er nevnt, og dummysett av "time_of_day" som uavhengige variabler

  # a. Hvor mange flere sinte reaksjoner kan vi forvente Trump får om han nevner Clinton i statusen sin?

  # b. Sjekk om forutsettningen om normalfordelte restledd er oppfylt. Kommenter resultatet kort.

# 7. Gjør samme regresjon som oppgave 6, men nå med prosent sinte reaksjoner som avhengig variabel.

  # a. Sjekk om forutsettningen om normalfordelte restledd er oppfylt. Kommenter forskjellen fra oppgave 6a
