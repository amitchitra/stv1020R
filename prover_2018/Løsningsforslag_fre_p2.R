##################################################
####  Løsningsforslag R-prøve 2 fredag, V18   ####
##################################################

#### Forberedelser: ####

rm(list = ls())
setwd()

#install.packages("haven")
#install.packages("ggplot2")
#install.packages("dplyr)
#install.packages("moments")
#install.packages("car")

library(car)
library(haven)
library(ggplot2)
library(moments)
library(dplyr)

#### Oppgave 1 ####

wage <- read.csv("https://raw.githubusercontent.com/langoergen/stv1020R/master/data/wages.csv",
                 stringsAsFactors = F)

str(wage)

#### Oppgave 2 ####

table(wage$language) # 497 personer snakker fransk
table(wage$language, wage$sex) # 262 damer, og 235 menn snakker fransk

#### Oppgave 3 ####

table(is.na(wage$wages)) # 3278 missing på wages var.

table(complete.cases(wage)) # 3438 observasjoner med missing på minst en var. totalt.


#### Oppgave 4 ####

ggplot(wage, aes(x = wages)) + geom_histogram(bins = 200)

wage$wages_log <- log(wage$wages)
ggplot(wage, aes(x = wages_log)) + geom_histogram(bins = 200)

# Vil si at wages_log ser mest normalfordelt ut.

#### Oppgave 5 ####

str(wage)
menn_som_pusher_50 <- wage %>%
  filter(sex == "Male") %>%
  filter(age > 50)

damer_under_50 <- wage %>%
  filter(sex == "Female" & age <50)

median(menn_som_pusher_50$wages, na.rm = T) # 18.92
median(damer_under_50$wages, na.rm = T) # 12.03


# Denne oppgaven kan også løses med [] eller med subset(), her viser jeg bare dplyr

#### Oppgave 6 ####

ggplot(wage, aes(x = age, y = wages)) + 
  geom_point()+
  geom_smooth(method = "lm")

#### Oppgave 7 ####

# Denne indekseringen kan også gjøres med:
# kordata <- wage[,c("age", "wages", "education")]

kordata <- wage %>%
  select(age, wages, education)

# Her kunne vi brukt na.omit på kordata. Da hadde vi ikke trengt å spesifisere use = i cor()

cor(kordata, use = "complete.obs")
cor.test(wage$education, wage$wages)

# Det er en positiv sammenheng mellom utdanning og lønn. Sammenhengen er statistisk signifikant.

#### Oppgave 8 ####

m1 <- lm(wages ~ education + age + sex + as.factor(language), data = wage)
summary(m1)

# Effekten av utdanning er statistisk signifikant på 0.001 konfidens-nivå.
 
# Substansiell tolkning utdanning:
# Den forventede effekten av et ekstra år med utdanning, er en økning i lønn på 0.91 Canadiske dollar per time
# Dette kort få store utslag i hvor mye man tjener - medianlønnen er 14 dollar timen. Derfor: temmelig sterk substansiell effekt
summary(wage$wages)
summary(wage$education)

#### Oppgave 9 ####

m2 <- lm(wages ~ education + age*sex + as.factor(language), data = wage)
summary(m2)

# 3484 observasjoner fjernes pga. missing i regresjonen

# Forventet differanse mann og kvinne 20 år:
(-1.36213*1 + 0.12986 *1*20 + 0.19012*20) - # Mann 20
  0.19012*20   # kvinne 20                     

# 1.23507

# Forventet differanse mann og kvinne 60 år:
(-1.36213*1 + 0.12986 *1*60 + 0.19012*60) - # Mann 20
  0.19012*60   # kvinne 20  

# 6.42947

vif(m2)
# sex og samspillsleddet mellom age og sex hara høyest multikolinearitet. Dette er typisk for samspill - 
# se siste kapittel i boken til Simen for en forklaring.

#### Oppgave 10 ####
summary(wage$age)
wage$cohort <- ifelse(wage$age<30, 1, NA)
wage$cohort <- ifelse(wage$age<40 & wage$age>=30, 2, wage$cohort)
wage$cohort <- ifelse(wage$age<50 & wage$age>=40, 3, wage$cohort)
wage$cohort <- ifelse(wage$age<60 & wage$age>=50, 4, wage$cohort)
wage$cohort <- ifelse(wage$age>= 60, 5, wage$cohort)

wage %>%
  group_by(sex, cohort) %>%
  summarise(med_wage = median(wages, na.rm = T),
            mean_wage = mean(wages, na.rm = T),
            med_ed = median(education, na.rm = T),
            mean_ed = mean(education, na.rm =T))


ggplot(wage, aes(x = education, y = wages, col = as.factor(sex))) + 
  geom_point() +
  facet_wrap(~cohort)
