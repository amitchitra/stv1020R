# Oppgaver fjerde seminar
# Datasett: religion.csv
# Hver rad er en respondent i en survey


# 0. Opprett nytt skript og finn kode for å laste inn data (samme som forrige gang: ligger på www.github.com/martigso/stv1020r)

# 1. Last inn religion i kommaseperert format (.csv) -- viktig å huske stringsAsFactors = FALSE
religion <- read.csv("https://raw.githubusercontent.com/martigso/stv1020R/master/data/religion.csv", stringsAsFactors = FALSE)

# 2. Kod om variabelen "utdanning til å være nummerisk, slik at laveste utdanningsnivå er 0 og høyeste er 6 (det er 7 nivåer i data) i en ny variabel "utd_num"
library(car)
table(religion$utdanning)
religion$utd_num <- recode(religion$utdanning,"
                           'pre-primary education or none education'='0';
                           'primary education or first stage of basic education'='1';
                           'lower secondary or second stage of basic education'='2';
                           '(upper) secondary education'='3';
                           'post-secondary non-tertiary education'='4';
                           'first stage of tertiary education'='5';
                           'second stage of tertiary education'='6'
                           ")

table(religion$utd_num, substr(religion$utdanning, 1, 5))

  # a. Lag så enda en ny variabel (utd_cat) der du slår sammen alle fra den opprinnelige variabelen som har "primary" i teksten, alle som har "secondary" og alle
    # som har "tertiary" i hver sin kategori. 
religion$utd_cat <- NA
religion$utd_cat[which(grepl("tertiary", religion$utdanning))] <- "Tertiary" # Siden en av "secondary" verdiene også har "tertiary" i seg kjører vi denne først
religion$utd_cat[which(grepl("secondary", religion$utdanning))] <- "Secondary"
religion$utd_cat[which(grepl("primary", religion$utdanning))] <- "Primary"

table(religion$utd_cat, religion$utd_num)


  # b. Hvilken av de to nye variablene bør vi bruke videre? Og hvorfor?



# 3. Lag et subset "prot" av "religion" data, der bare de som er protestanter eller ikke har religiøs tilhørighet er med
prot <- subset(religion, relig_denom == "ingen religion" | relig_denom == "protestant")

  # a. Gjør om "relig_denom" til nummerisk dikotom variabel der protestanter får verdien 0 og ingen religion verdien 1 
prot$relig_denom_num <- ifelse(prot$relig_denom == "protestant", 0, 1)

# 4. I de nye data, vis hvordan du finner korrelasjonen mellom "aksept_homofili", "utd_num", "alder" og "ant_barn".
# Bruk pakken "psych" 
library(psych)
cor_mat <- corr.test(prot[, c("utd_num", "alder", "aksept_aktiv_dodshjelp", "ant_barn")])
print(cor_mat, short = FALSE)
  
  # a. Kommentér sammenhengens styrke, retning, form og om sammenhengen er signifikant.



# 5. Vis hvordan du gjennomfører en regresjonsanalyse med "aksept_aktiv_dodshjelp" som AV 
# og "alder", "utd_cat", "ant_barn" og "kjonn" som UV. Husk 'na.action = "na.exclude"'
aktiv_reg <- lm(aksept_aktiv_dodshjelp ~ alder + factor(utd_cat) + factor(kjonn) + ant_barn + factor(relig_denom), na.action = "na.exclude", data = prot)

summary(aktiv_reg)

# a. Tolk konstantleddet, variabelkoeffisientene og R2.

# b. Lag en kopi av "prot", "prot2", der du standariserer versjoner av alle variablene i analysen.
prot2 <- prot
prot2[, c("utd_cat", "kjonn", "relig_denom_num")] <- apply(prot2[, c("utd_cat", "kjonn", "relig_denom_num")], 2, function(x) as.numeric(as.factor(x)))
head(prot2)

# For å gjøre koden mer oversiktelig:
reg_vars <- c("aksept_aktiv_dodshjelp", "alder", "utd_cat", "kjonn", "ant_barn", "relig_denom_num")

prot2[, reg_vars] <- apply(prot2[, reg_vars], 2, function(x) scale(x))
head(prot2)

# c. Kjør regresjonen på nytt. Hvordan tolkes nå resultatene 
aktiv_reg_scaled <- lm(aksept_aktiv_dodshjelp ~ alder + utd_cat + kjonn + ant_barn + relig_denom,
                       na.action = "na.exclude", data = prot2)

summary(aktiv_reg_scaled)

# 6. For å teste om regresjonene er i tråd med forutsetningene til OLS må vi gjøre flere ting:
# a. Legg inn forventede verdier og residualer i datasettet "prot"
prot$reg_resid <- resid(aktiv_reg)
prot$reg_forventet <- predict(aktiv_reg)

prot2$reg_scaled_resid <- resid(aktiv_reg_scaled)
prot2$reg_scaled_forventet <- predict(aktiv_reg_scaled)

# b. Sjekk om residualene er normalfordelt i begge regresjonene. Kommenter resultatene.
library(ggplot2)
ggplot(prot, aes(x = reg_resid)) +
  geom_density()

ggplot(prot2, aes(x = reg_scaled_resid)) +
  geom_density()

# c. Visualiser forventede verdier og residualer. Kommenter plottet.
ggplot(prot, aes(x = reg_forventet, y = reg_resid)) +
  geom_point() +
  geom_smooth(method = "lm")


# BONUS! Visualiser forskjellen i forventet Y mellom en ikke religiøs person og en protestant
pred_df <- data.frame(alder = median(prot$alder, na.rm = TRUE),
                      utd_cat = "Secondary",
                      kjonn = "mann",
                      ant_barn = median(prot$ant_barn, na.rm = TRUE),
                      relig_denom = c("protestant", "ingen religion"))

pred_df <- data.frame(pred_df, predict(aktiv_reg, newdata = pred_df, interval = "confidence", level = 0.99)) 
  # Se hva som skjer når level varieres

ggplot(pred_df, aes(x = relig_denom, y = fit)) +
  geom_pointrange(aes(ymin = lwr, ymax = upr), size = 2) +
  scale_y_continuous(limits = c(5, 7.1), breaks = seq(5, 7, .5)) +
  labs(x = "Religiøs tilhørighet", y = "Forventet aksept for aktiv dødshjelp") +
  theme_bw()


unique(prot$kjonn)
