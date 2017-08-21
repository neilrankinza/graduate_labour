*Do file for 'machine learning' tutorial

clear
*load data
import delimited "C:\Users\neilrankin\Dropbox\neil\1\Teaching\Graduate Labour\2017\graduate_labour\job_search_matching\data\ej_data.csv"

gen employed = 0 if working=="No"
replace employed = 1 if working=="Yes"

set seed 12345

ssc install randomtag

*this should create a tag for our training dataset.
randomtag, count(15612) gen(train)


destring(cft_answer_ods), gen(CFT) force

*regresssion model

reg employed english_mark CFT if train==1

predict pemp if train==0

twoway (kdensity pemp if employed==0) (kdensity pemp if employed==1)
