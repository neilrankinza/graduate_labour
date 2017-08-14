#Graduate labour economics
#Ghana worker-firm data tutorial
#Neil Rankin
#August 2015


#first load the package 'foreign'
library(foreign)
#dplyr and plyr are also useful
library(dplyr)
library(plyr)

#getting rid of scientific notation
options(scipen=100)
options(digits=3)


ghana_firms_workers <- read.dta("C:/Users/neilrankin/Dropbox/neil/1/Data/Firms/Ghana/original data/CSAE-Dataset-GhanaRPEDGMES-I-VII-all-files/CSAE-Dataset-GhanaRPEDGMES-I-VII/firms_workers.dta")

#removing duplicates
ghana_firms_workers <- ghana_firms_workers[!duplicated(ghana_firms_workers[c("wid", "firm", "wave", "age")]), ]


#Do we need unique IDs? Can use mutate to do it
ghana_firms_workers <- mutate(ghana_firms_workers, n_wid = (firm*1000)+900+wid) #Have not dealt with the NAs

ghana_firms_workers <- mutate(ghana_firms_workers, nworkers = as.numeric(worker))

ghana_firms_workers$bigfirm <- ifelse(ghana_firms_workers$nworkers<50, "small", "big")


#descriptive statistics
library(MASS)
big_firms = ghana_firms_workers$bigfirm
big_firms_freq = table(big_firms) 
big_firms_freq
tabulate(ghana_firms_workers$bigfirm))
summary(ghana_firms_workers$lrearn)


#simple OLS
#do males earn more than females?
reg1 <- lm(lrearn ~ male, data=ghana_firms_workers)
summary(reg1)
#different sample sizes between Stata and R
#Because they work in differnt sectors?
ghana_firms_workers$sectorf <- factor(ghana_firms_workers$sector) #need to do this so R does not treat it like a linear trend
reg2 <- lm(lrearn ~ male + sectorf, data=ghana_firms_workers)
summary(reg2)


#clustering is not as straightforward as in Stata, see http://www.richard-bluhm.com/clustered-ses-in-r-and-stata-2/


#with R we need to load another package 'plm' to be able to do panel data regressions simply
library(plm)

#to use this, one way to tell the package the cross-sectional and time compnents is to put them in the first two columns
ghana_firms_workers$wavef <- factor(ghana_firms_workers$wave) #need to do this so R does not treat it like a linear trend

panel_dataset <- select(ghana_firms_workers, n_wid, wavef, locdum, male:ocdum)



est_fe <- plm(lrearn ~ male + age + agesq + educ + educsq, data=panel_dataset, model = "within")

summary(est_fe)


reg1 <- lm(lrearn ~ male + age + agesq + educ + educsq + wavef + locdum, data=ghana_firms_workers)
summary(reg1)










       



df[!duplicated(df[c("wid", "firm", "wage", "age")]),]
