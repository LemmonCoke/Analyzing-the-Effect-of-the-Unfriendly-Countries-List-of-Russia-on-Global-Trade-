#install.packages("fixest")
#install.packages("etwfe")
#install.packages("ggplot2")
#install.packages("dplyr")

library(ggplot2)
library(fixest)
library(etwfe)
library(dplyr)

#Section 5.1 DID Assumptions
#Parallel Trend Test
#Import from Russia
data <-read.csv(file.choose()) #Choose "RUIM.csv"
est_did1 <- fepois(trade ~ GDP + REXR + CA + i(TimeIndex, UCL,-88) | reporterISO + TimeIndex,vcov = ~reporterISO^TimeIndex, data)
iplot(est_did1,col = "darkcyan", bg = "lightgrey", grid.par = list(col = "white"), xlab = "Time Period", ylab = "DiD Coeffcients", ref.line = 10)

#Export to Russia 
data <-read.csv(file.choose()) #Choose "RUEX.csv"
#Before adding the Interactions, the test will fail
est_did1 <- fepois(trade ~ GDP + REXR + CA + i(TimeIndex, UCL,-88) | reporterISO + TimeIndex,vcov = ~reporterISO^TimeIndex, data)
iplot(est_did1,col = "darkcyan", bg = "lightgrey", grid.par = list(col = "white"), xlab = "Time Period", ylab = "DiD Coeffcients", ref.line = 10)
#Adding interactions
est_did2 <- fepois(trade ~ GDP + REXR + CA  + i(TimeIndex, UCL,-88) + i(TimeIndex, GDP) + i(TimeIndex, CA) + i(TimeIndex, REXR)  |reporterISO + TimeIndex,vcov = ~reporterISO^TimeIndex, data)
iplot(est_did2,col = "darkcyan", bg = "lightgrey", grid.par = list(col = "white"), xlab = "Time Period", ylab = "DiD Coeffcients", ref.line = 10)


#Section 5.2 Russia Model
data <-read.csv(file.choose()) #Choose "RUIM.csv"
data <- data %>% filter(refYear != 2024)
mod <- etwfe(trade ~ LGDP + REXR + CA, tvar = TimeIndex, gvar = Time_TreatmentIndex, ivar = reporterISO,  vcov = ~reporterISO, family = "poisson", cgroup = "never", data = data)
est <- emfx(mod, type = "calendar")
ggplot(est, aes(x = TimeIndex, y = estimate, ymin = conf.low, ymax = conf.high)) +
  geom_hline(yintercept = 0, color = "black") +
  geom_vline(aes(xintercept = 0, color = "UCL First Wave"), linetype = "solid") +
  geom_vline(aes(xintercept = 10, color = "UCL Second Wave"), linetype = "solid") +
  geom_vline(aes(xintercept = 9, color = "Western Countries Issued Sanction on Russia"), linetype = "dashed") +
  
  geom_pointrange(color = "darkcyan") +
  labs(x = "Time Period", y = "Effect on Import from Russia") +
  scale_color_manual(name = "Reference Lines", 
                     values = c("UCL First Wave" = "black", 
                                "UCL Second Wave" = "red", 
                                "Western Countries Issued Sanction on Russia" = "blue")) +
  scale_linetype_manual(name = "Reference Lines", 
                        values = c("UCL First Wave" = "solid", 
                                   "UCL Second Wave" = "solid", 
                                   "Western Countries Issued Sanction on Russia" = "dashed")) +
  theme(legend.position = c(1, 1), # Adjusts legend position to the upper-right corner
        legend.background = element_rect(color = "black", fill = "white", size = 0.5, linetype = "solid"),
        legend.justification = c("right", "top"))


#Section 5.3 Ukraine Model
#Import from Ukriane
data <-read.csv(file.choose()) #Choose "URIM.csv"
mod <- etwfe(trade ~ LGDP, tvar = TimeIndex, gvar = Time_TreatmentIndex, ivar = reporterISO,  vcov = ~reporterISO^TimeIndex, cgroup = "never", family = "poisson", data = data)
mod_es <- emfx(mod, type = "calendar")
ggplot(mod_es, aes(x = TimeIndex, y = estimate, ymin = conf.low, ymax = conf.high)) +
  geom_hline(yintercept = 0) +
  geom_vline(xintercept = c(0,10))+
  geom_pointrange(col = "darkcyan") +
  labs(x = "Time Period", y = "Effect on Import from Ukraine")

#Export to Ukriane 
data <-read.csv(file.choose()) #Choose "UREX.csv"
mod <- etwfe(trade ~ LGDP, tvar = TimeIndex, gvar = Time_TreatmentIndex, ivar = reporterISO,  vcov = ~reporterISO^TimeIndex, cgroup = "never", family = "poisson", data = data)
mod_es <- emfx(mod, type = "calendar")
ggplot(mod_es, aes(x = TimeIndex, y = estimate, ymin = conf.low, ymax = conf.high)) +
  geom_hline(yintercept = 0) +
  geom_vline(xintercept = c(0,10))+
  geom_pointrange(col = "darkcyan") +
  labs(x = "Time Period", y = "Effect on Export to Ukraine")


#Section 5.4 Trade Diversion
#Full Data 
data <- read.csv(file.choose()) #Choose "DiversionFull.csv"
mod <- etwfe(trade ~ LGDP + LGDPEX , tvar = TimeIndex, gvar = Time_TreatmentIndex, vcov = ~reporterISO^partnerISO^TimeIndex, cgroup = "never", family = "poisson", data = data)
mod_es <- emfx(mod, type = "calendar")
ggplot(mod_es, aes(x = TimeIndex, y = estimate, ymin = conf.low, ymax = conf.high)) +
  geom_hline(yintercept = 0) +
  geom_vline(xintercept = c(0,10))+
  geom_pointrange(col = "darkcyan") +
  labs(x = "Time Period", y = "Effect on Import of the Third Countries")


#Increased Import Subsample 
data <- read.csv(file.choose()) #Choose "DiversionSub.csv
mod <- etwfe(trade ~ LGDP + LGDPEX , tvar = TimeIndex, gvar = Time_TreatmentIndex,cgroup = "never", vcov = ~reporterISO^partnerISO^TimeIndex, family = "poisson", data = data)
mod_es <- emfx(mod, type = "calendar")
ggplot(mod_es, aes(x = TimeIndex, y = estimate, ymin = conf.low, ymax = conf.high)) +
  geom_hline(yintercept = 0) +
  geom_vline(xintercept = c(0,10))+
  geom_pointrange(col = "darkcyan") +
  labs(x = "Time Period", y = "Effect on Import of the Third Countries")


