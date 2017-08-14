***do file for Ghana firms and firm_sizes

*Do firms of different sizes hire different types of firm_sizes?
*do returns to education and skills differ across different types of firms?



use "C:\Users\neilrankin\Dropbox\neil\1\Data\Firms\Ghana\original data\CSAE-Dataset-GhanaRPEDGMES-I-VII-all-files\CSAE-Dataset-GhanaRPEDGMES-I-VII\firms_workers.dta", clear
duplicates list wid firm wave age
duplicates drop wid firm wave age, force /*getting rid of duplicates so as to be able to use firm_size FE later*/

/*creating a unique firm_size id*/
gen n_wid=wid
replace n_wid = (firm*1000)+900+wid if wid<99
replace n_wid = (firm*1000)+900+99 if wid==.

*checking duplicates
duplicates list n_wid wave

replace skill=. if skill~=0 & skill~=1 


bysort firm wave: egen firm_size=max(emp)


*let's start by looking at different sized firms
tabstat firm_size, stat(mean p50 sd n min max) by(wave)

gen bigfirm=0 if firm_size<50 & firm_size~=.
replace bigfirm=1 if firm_size>=50 & firm_size~=.


********************************************************************************

*do workers in different sized firms look different?
reg male bigfirm 
*controlling for sector
reg male bigfirm i.sector

reg educ bigfirm 
*controlling for sector
reg educ bigfirm i.sector

********************************************************************************

*are they paid differently?
* kdensity to look at the distributions of earnings for workers at big and small firms.
*start with some descriptive stats
* how are earnings changing over time
tabstat lrearn, stat(mean p50 sd n min max) by(wave)


twoway ((kdensity lrearn if bigfirm==0)(kdensity lrearn if bigfirm==1))
*What does the bigfirm premium look like on average?
reg lrearn bigfirm i.sector
* At the median?
xi:qreg lrearn bigfirm i.sector, q(0.5)
* At the 25 percentile
xi:qreg lrearn bigfirm i.sector, q(0.25)


********************************************************************************
* Is this because big firms hire people who look different (for example they have more education)?

*Gender
xi: reg lrearn bigfirm  male i.wave
*Sectors?
xi: reg lrearn bigfirm  male i.sector i.wave
*What role does education and age play?
xi: reg lrearn bigfirm male age agesq educ educsq i.wave i.locdum
* Is this becuae the sample is different?
xi: reg lrearn bigfirm  male i.wave if educ!=. & age!=. & locdum !=""

*Can you figure out when 'peak' earnings are:
*by age?
*by education?

********************************************************************************

* Let's look at the returns to education a bit more
xi: reg lrearn bigfirm male age agesq educ educsq i.wave i.locdum i.sector

* Now look within firms
xtset firm
xi: xtreg lrearn bigfirm male age agesq educ educsq i.wave i.locdum, fe
* What does this mean?

* Is there a difference in returns to education between big and small firms
xi: reg lrearn i.bigfirm*educ i.bigfirm*educsq male age agesq  i.wave i.locdum
* Now control for sector
xi: reg lrearn i.bigfirm*educ i.bigfirm*educsq male age agesq  i.wave i.locdum i.sector
* What do these curves look like?
* What can we conclude from the estimates with and without the sector controls

* What happens when you run a within/fixed-effects estimation?
* What is identifying the coefficients
xi: xtreg lrearn i.bigfirm*educ i.bigfirm*educsq male age agesq  i.wave i.locdum, fe




