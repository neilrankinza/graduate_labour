#R script to set up data for machine learning tutorial
# Neil Rankin 
# 2017/08/21

library(dplyr)


ej_data <- readRDS("C:/Users/neilrankin/Dropbox/harambee_data_folder/processed_data/ej_job_families_match_all.rds")

ej_data <- ej_data %>% select(CandidateId, Survey.Label, survey_date_month, Booking.Date, working, english_mark, maths_mark, maths_lit_mark, CFT_answer_ODS, COM_answer_ODS)
ej_data <- ej_data %>% filter(!is.na(english_mark)) %>% filter(!is.na(working)) %>% filter(!is.nan(working)) %>% filter(!is.infinite(working))

saveRDS(ej_data, "job_search_matching/data/ej_data.rds")
write.csv(ej_data, "job_search_matching/data/ej_data.csv")
