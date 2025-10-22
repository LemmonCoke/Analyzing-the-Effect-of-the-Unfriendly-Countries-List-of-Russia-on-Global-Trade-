#install.packages("fixest")
#install.packages("etwfe")
#install.packages("ggplot2")
#install.packages("dplyr")

library(ggplot2)
library(fixest)
library(etwfe)
library(dplyr)

#Section 5.1 DID Assumptions
#No Anticipation Test
#Import from Russia 
data <-read.csv(file.choose()) #Choose "RUIM.csv"
data6 <- data %>% filter(TimeIndex < 0)
data7 <- data %>% filter(TimeIndex < 10)
data7 <- data7 %>% filter(reporterISO != "USA" & reporterISO != "CZE")
est_did2 <- fepois(trade ~ LGDP + REXR + CA + After1 * Group_1|  reporterISO + TimeIndex,vcov = ~reporterISO+TimeIndex, data6)
est_did3 <- fepois(trade ~ LGDP + REXR + CA + After2 * Group_2|  reporterISO + TimeIndex,vcov = ~reporterISO+TimeIndex, data7)
est_did2
est_did3

#Export to Russia 
data <-read.csv(file.choose()) #Choose "RUEX.csv"
data6 <- data %>% filter(TimeIndex < 0)
data7 <- data %>% filter(TimeIndex < 10)
data7 <- data7 %>% filter(reporterISO != "USA" & reporterISO != "CZE")
est_did2 <- fepois(trade ~ LGDP + REXR + CA + After1 * Group_1|  reporterISO + TimeIndex,vcov = ~reporterISO+TimeIndex, data6)
est_did3 <- fepois(trade ~ LGDP + REXR + CA + After2 * Group_2|  reporterISO + TimeIndex,vcov = ~reporterISO+TimeIndex, data7)
est_did2
est_did3

#Import from Ukraine 
data <-read.csv(file.choose()) #Choose "URIM.csv"
data6 <- data %>% filter(TimeIndex < 0)
data7 <- data %>% filter(TimeIndex < 10)
data7 <- data7 %>% filter(reporterISO != "USA" & reporterISO != "CZE")
est_did2 <- fepois(trade ~ LGDP + REXR + CA + After1 * Group_1|  reporterISO + TimeIndex,vcov = ~reporterISO+TimeIndex, data6)
est_did3 <- fepois(trade ~ LGDP + REXR + CA + After2 * Group_2|  reporterISO + TimeIndex,vcov = ~reporterISO+TimeIndex, data7)
est_did2
est_did3

#Export to Ukriane 
data <-read.csv(file.choose()) #Choose "UREX.csv"
data6 <- data %>% filter(TimeIndex < 0)
data7 <- data %>% filter(TimeIndex < 10)
data7 <- data7 %>% filter(reporterISO != "USA" & reporterISO != "CZE")
est_did2 <- fepois(trade ~ LGDP + REXR + CA + After1 * Group_1|  reporterISO + TimeIndex,vcov = ~reporterISO+TimeIndex, data6)
est_did3 <- fepois(trade ~ LGDP + REXR + CA + After2 * Group_2|  reporterISO + TimeIndex,vcov = ~reporterISO+TimeIndex, data7)
est_did2
est_did3

#Diversion 
data <-read.csv(file.choose()) #Choose "DiversionFull.csv"
data6 <- data %>% filter(TimeIndex < 0)
data7 <- data %>% filter(TimeIndex < 10)
data7 <- data7 %>% filter(reporterISO != "USA" & reporterISO != "CZE")
est_did2 <- fepois(trade ~ LGDP + LGDPEX + REXR + REXREX + CA + After1 * Group_1|  reporterISO + TimeIndex,vcov = ~reporterISO+TimeIndex, data6)
est_did3 <- fepois(trade ~ LGDP + LGDPEX + REXR + REXREX + CA + After2 * Group_2|  reporterISO + TimeIndex,vcov = ~reporterISO+TimeIndex, data7)
est_did2
est_did3


#Section 5.2 Russia Model 
#Import from Russia 
data <- read.csv(file.choose()) #Choose "RUIM.csv"
data <- data %>% filter(refYear != 2024)
mod <- etwfe(trade ~ LGDP + REXR + CA, tvar = TimeIndex, gvar = Time_TreatmentIndex, ivar = reporterISO, family = "poisson", cgroup = "never", data = data)
mod_att <- emfx(mod)
mod_group <- emfx(mod, type = "group")
mod_att
mod_group


#Export to Russia 
data <-read.csv(file.choose()) #Choose "RUEX.csv"
data <- data %>% filter(refYear != 2024)
mod <- etwfe(trade ~ LGDP + REXR + CA, tvar = TimeIndex, gvar = Time_TreatmentIndex, ivar = reporterISO,  vcov = ~reporterISO^TimeIndex, family = "poisson", cgroup = "never", data = data)
mod_att <- emfx(mod)
mod_group <- emfx(mod, type = "group")
mod_att
mod_group


#Section 5.3 Ukraine Model 
#Import from Ukriane  
data <-read.csv(file.choose()) #Choose "URIM.csv"
mod <- etwfe(trade ~ LGDP, tvar = TimeIndex, gvar = Time_TreatmentIndex, ivar = reporterISO,  vcov = ~reporterISO^TimeIndex, cgroup = "never", family = "poisson", data = data)
mod_att <- emfx(mod)
mod_group <- emfx(mod, type = "group")
mod_att
mod_group

#Export to Ukriane  
data <-read.csv(file.choose()) #Choose "UREX.csv"
mod <- etwfe(trade ~ LGDP, tvar = TimeIndex, gvar = Time_TreatmentIndex, ivar = reporterISO,  vcov = ~reporterISO^TimeIndex, cgroup = "never", family = "poisson", data = data)
mod_att <- emfx(mod)
mod_group <- emfx(mod, type = "group")
mod_att
mod_group


#Section 5.4 Trade Diversion
#Full Data 
data <- read.csv(file.choose()) #Choose "DiversionFull.csv"
mod <- etwfe(trade ~ LGDP + LGDPEX , tvar = TimeIndex, gvar = Time_TreatmentIndex, vcov = ~reporterISO^partnerISO^TimeIndex, cgroup = "never", family = "poisson", data = data)
mod_group <- emfx(mod, type = "group")
mod_att <- emfx(mod)
mod_att
mod_group


#Increased Import Subsample
data <- read.csv(file.choose()) #Choose "DiversionSub.csv
mod <- etwfe(trade ~ LGDP + LGDPEX , tvar = TimeIndex, gvar = Time_TreatmentIndex,cgroup = "never", vcov = ~reporterISO^partnerISO^TimeIndex, family = "poisson", data = data)
mod_group <- emfx(mod, type = "group")
mod_att <- emfx(mod)
mod_att
mod_group

#Section 6.1 Alternative Control Group 
#Import from Russia 
data <- read.csv(file.choose()) #Choose "RUIM.csv"
data <- data %>% filter(refYear != 2024)
mod <- etwfe(trade ~ LGDP + REXR + CA, tvar = TimeIndex, gvar = Time_TreatmentIndex, ivar = reporterISO,  vcov = ~reporterISO, family = "poisson", cgroup = "notyet", data = data)
mod_att <- emfx(mod)
mod_group <- emfx(mod, type = "group")
mod_att
mod_group


#Export to Russia 
data <-read.csv(file.choose()) #Choose "RUEX.csv"
data <- data %>% filter(refYear != 2024)
mod <- etwfe(trade ~ LGDP + REXR + CA, tvar = TimeIndex, gvar = Time_TreatmentIndex, ivar = reporterISO^TimeIndex,  vcov = ~reporterISO^TimeIndex, family = "poisson", cgroup = "notyet", data = data)
mod_att <- emfx(mod)
mod_group <- emfx(mod, type = "group")
mod_att
mod_group

#Section 6.2 Sun Abraham 
#Import from Russia 
data <- read.csv(file.choose()) #Choose "RUIM.csv"
data <- data %>% filter(refYear != 2024)
modsun <- fepois(trade ~ LGDP + CA + REXR + sunab(Time_TreatmentIndex, TimeIndex)| reporterISO + TimeIndex, vcov = ~reporterISO^TimeIndex, data = data )
summary(modsun, agg = "ATT")
summary(modsun, agg = "cohort")

#Export to Russia 
data <- read.csv(file.choose()) #Choose "RUEX.csv"
data <- data %>% filter(refYear != 2024)
modsun <- fepois(trade ~ LGDP + CA + REXR + sunab(Time_TreatmentIndex, TimeIndex)| reporterISO + TimeIndex, vcov = ~reporterISO^TimeIndex, data = data )
summary(modsun, agg = "ATT")
summary(modsun, agg = "cohort")