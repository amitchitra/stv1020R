# 1
ministers <- read.csv("https://raw.githubusercontent.com/martigso/ministersNor/master/data/ministers_alt.csv", stringsAsFactors = FALSE, sep = ";")
ministers <- read.csv("stv1020prove/data/ministers.csv",
                      stringsAsFactors = FALSE)

min <- ministers[, c("nsd_id", "party", "start_year", 
                     "gender", "birth", "duration", "resigcalls")]
names(min) <- c("id", "parti", "start_aar", 
                "kjonn", "fodselsaar", 
                "varighet", "maa_gaa")
write.csv(min, "stv1020prove/data/ministers.csv", row.names = FALSE)
# 2 
library(ggplot2)

ggplot(min, aes(x = parti, y = varighet))+
  geom_boxplot()

# 3 
min$alder <- min$start_aar - min$fodselsaar

# 4
table(min$maa_gaa)

# 5
ggplot(min, aes(x = varighet)) +
  geom_density(bw = 50)

# 6
cor(min[,c("alder", "varighet", "maa_gaa")])
cor.test(min$maa_gaa, min$varighet)

# 7
ggplot(min, aes(x = maa_gaa, y = varighet))+
  geom_point()+
  geom_smooth(method = "lm")

# 8
reg <- lm(varighet ~ maa_gaa + factor(kjonn) + alder, data = min)
summary(reg)


plot(density(resid(reg)))
