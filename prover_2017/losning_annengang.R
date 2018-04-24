rm(list = ls())
# 1. Last inn data
taler <- read.csv("http://folk.uio.no/martigso/jippii/talk-of-norway.csv", stringsAsFactors = FALSE)

# 2. Lag et stolpediagram over representantenes listeplasseringen ved forrige valg. Kommenter kort hva plotet viser.
library(ggplot2)

ggplot(taler, aes(x = liste_nummer_valg))+
  geom_bar()

# 3. Vis hvordan du finner median og gjennomsnitt på variabelen "alder". Lag en ny variabel i datasettet som sentrerer alder til den mest egnede av disse (gjennomsnitt eller median), og kontroller at variabelen ble riktig opprettet.
median(taler$alder)
mean(taler$alder)
taler$alder_sent <- taler$alder - median(taler$alder)

# 4. Lag et box-plot med kjønn på x-aksen og antall taler på y-aksen. Kommenter hvilket kjønn som har høyest median på antall taler.
ggplot(taler, aes(x = kjonn, y = ant_taler)) +
  geom_boxplot()

# 5. Estimer en OLS-modell med antall taler som avhengig variabel og gjennomsnitt antall ord, listeplassering ved forrige valg, kjønn og alder (sentrert) som uavhengige variabler. Kommenter kort den substansielle meningen til konstantleddet.
reg <- lm(ant_taler ~ gj_ant_ord + liste_nummer_valg + factor(kjonn) + alder, data = taler)
summary(reg)

# 6. Estimer samme OLS-modell som over, men nå også med talers rolle som uavhengig variabel. Kommenter forskjellen i R2 mellom disse to modellene, og hvorfor denne endringen skjer ved å kontrollere for talers rolle.
reg2 <- lm(ant_taler ~ factor(talers_rolle) + gj_ant_ord + liste_nummer_valg + factor(kjonn) + alder, data = taler)
summary(reg2)

# 7. Lag to nye variabel i datasettet som viser a) restleddene (residualene) og b) forventet (predikert) verdi til hver enhet fra den siste modellen (oppgave 6).
taler$restledd <- resid(reg2)
taler$forventet <- predict(reg2)

# 8. Vis en korrelasjonstest mellom restledd og forventede verdier (fra oppgave 7). Kommenter kort resultatet og hvilke konsekvenser dette eventuelt har for analysen.
cor.test(taler$restledd, taler$forventet)

