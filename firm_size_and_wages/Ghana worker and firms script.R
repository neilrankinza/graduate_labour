
#removing duplicates
ghan# METADATA ----
# Description: Ghana worker-firm data tutorial, Stellenbosch Graduate Labour Economics
# Creator: Neil Rankin
# Created: 2015-08-01
# Last update: 2017-08-14
# Last edit: Neil Rankin


# INITIALISE ----
rm(list = ls())

#first load the package 'foreign'
library(foreign)
#dplyr
library(dplyr)
library(ggplot2)
library(doBy)
library(quantreg)

#getting rid of scientific notation
options(scipen=100)
options(digits=3)

# LOAD DATA & WRANGLE ----

ghana_firms_workers <- read.dta("firm_size_and_wages/firms_workers/firms_workers.dta")
a_firms_workers <- ghana_firms_workers[!duplicated(ghana_firms_workers[c("wid", "firm", "wave", "age")]), ]


#Do we need unique IDs? Can use mutate to do it
ghana_firms_workers <- mutate(ghana_firms_workers, n_wid = (firm*1000)+900+wid) #Have not dealt with the NAs

ghana_firms_workers <- mutate(ghana_firms_workers, nworkers = as.numeric(worker))

ghana_firms_workers$bigfirm <- ifelse(ghana_firms_workers$nworkers<50, FALSE, TRUE)


# ANALYSIS ----


#descriptive statistics

big_firms = ghana_firms_workers$bigfirm
big_firms_freq = table(big_firms) 
big_firms_freq
summary(ghana_firms_workers$lrearn)


# do workers in different sized firms look different?
# gender
reg1_1 <- lm(male ~ bigfirm, data=ghana_firms_workers)
summary(reg1_1)
# controlling for sector
reg1_2 <- lm(male ~ bigfirm + as.factor(sector), data=ghana_firms_workers)
summary(reg1_2)

# education
reg2_1 <- lm(educ ~ bigfirm, data=ghana_firms_workers)
summary(reg2_1)
# controlling for sector
reg2_2 <- lm(educ ~ bigfirm + as.factor(sector), data=ghana_firms_workers)
summary(reg2_2)


#################################
# are they paid differently?
# kdensity to look at the distributions of earnings for workers at big and small firms.
# start with some descriptive stats
# how are earnings changing over time
summaryBy(lrearn~as.factor(wave), data=ghana_firms_workers, FUN=c(mean, median, sd), na.rm=TRUE)


workers_with_firm_size <- ghana_firms_workers %>% filter (!is.na(bigfirm))

ggplot(workers_with_firm_size, aes(x = lrearn, fill = bigfirm)) + geom_density(alpha = 0.4)

# What does the bigfirm premium look like on average?
reg3_1 <- lm(lrearn ~ bigfirm + as.factor(sector), data=ghana_firms_workers)
summary(reg3_1)

# At the median?
reg3_2 <- rq(lrearn ~ bigfirm + as.factor(sector), data=ghana_firms_workers, tau=0.5)
summary(reg3_2)

# At the 25 percentile
reg3_3 <- rq(lrearn ~ bigfirm + as.factor(sector), data=ghana_firms_workers, tau=0.25)
summary(reg3_3)


#********************************************************************************
#  * Is this because big firms hire people who look different (for example they have more education)?

# Gender
reg4_1 <- lm(lrearn ~ bigfirm + male + as.factor(wave), data=ghana_firms_workers)
summary(reg4_1)

# Sectors?
reg4_2 <- lm(lrearn ~ bigfirm + male + as.factor(sector) + as.factor(wave), data=ghana_firms_workers)
summary(reg4_2)

# What role does education and age play?
reg4_3 <- lm(lrearn ~ bigfirm + male + age + agesq + educ + educsq + as.factor(locdum) + as.factor(wave), data=ghana_firms_workers)
summary(reg4_3)

# Is this becuae the sample is different?
# subset
g_data <- ghana_firms_workers %>% filter(!is.na(educ) | !is.na(age) | !is.na(locdum))
reg4_4 <- lm(lrearn ~ bigfirm + male + as.factor(wave), data=g_data)
summary(reg4_4)

#Can you figure out when 'peak' earnings are:
# by age?
# by education?

#********************************************************************************
  
# Let's look at the returns to education a bit more
reg5_1 <- lm(lrearn ~ bigfirm + male + age + agesq + educ + educsq + as.factor(wave)+ as.factor(locdum) + as.factor(sector), data=g_data)
summary(reg5_1)

# Now look within firms

#with R we need to load another package 'plm' to be able to do panel data regressions simply
library(plm)
# see the vignette http://r.adu.org.za/web/packages/plm/vignettes/plm.pdf

#plm is used for a 'standard' panel - in this case individuals over time, rather than firms.
# rather we'll use a 'work around'.


# Least squares dummy variable - within firms
reg5_2 <- lm(lrearn ~ bigfirm + male + age + agesq + educ + educsq + as.factor(wave)+ as.factor(locdum) + as.factor(sector) + as.factor(firm), data=g_data)
summary(reg5_2)


# Is there a difference in returns to education between big and small firms
reg5_3 <- lm(lrearn ~ bigfirm*educ + bigfirm*educsq + male + age + agesq  + as.factor(wave) + as.factor(locdum), data=g_data)
summary(reg5_3)

# Now control for sector
reg5_4 <- lm(lrearn ~ bigfirm*educ + bigfirm*educsq + male + age + agesq  + as.factor(wave) + as.factor(locdum) + as.factor(sector), data=g_data)
summary(reg5_4)

# What do these curves look like?
# What can we conclude from the estimates with and without the sector controls

# What happens when you run a within/fixed-effects estimation?
# What is identifying the coefficients
reg5_5 <- lm(lrearn ~ bigfirm*educ + bigfirm*educsq + male + age + agesq  + as.factor(wave) + as.factor(firm), data=g_data)
summary(reg5_5)

###################################
# Making a nice table
library(stargazer)
stargazer(reg5_1, reg5_2, reg5_3, reg5_4, reg5_5, style = 'qje', type = 'text',  
          title            = "Big firms and earnings"
          )








# panel with plm
reg5_3 <- plm(lrearn ~ bigfirm + male + age + agesq + educ + educsq + as.factor(wave)+ as.factor(locdum) + as.factor(sector), data=g_data, index=c("firm", "wave"), model="within")
summary(reg5_3)

panel_dataset <- select(ghana_firms_workers, n_wid, wavef, locdum, male:ocdum)



est_fe <- plm(lrearn ~ male + age + agesq + educ + educsq, data=g_data, model = "within")

summary(est_fe)


g_data_panel <- pdata.frame(g_data, index=c("firm","wave"), drop.index=TRUE, row.names=TRUE)



xtset firm
xi: xtreg lrearn bigfirm male age agesq educ educsq i.wave i.locdum, fe
* What does this mean?







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




reg1 <- lm(lrearn ~ male + age + agesq + educ + educsq + wavef + locdum, data=ghana_firms_workers)
summary(reg1)










       



df[!duplicated(df[c("wid", "firm", "wage", "age")]),]
