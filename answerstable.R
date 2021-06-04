library(randomNames)
library(ggplot2)
library(kableExtra)
library(dplyr)
library(tinytex)
library(rmarkdown)
library(tidyverse)
options(tinytex.verbose = TRUE)

worksheet_id = as.character(paste0("w_sh_.id_", sample(100:999,16,replace = F)))
subject = c('Counting & Arithmetic', 'Number Sense','Geometry','Measurement & Data')
correct_answer <- sample(0:100,960,replace = F)
week <- c('1', '2', '3', '4')
grades = c('K','1','2','3','4','5')

#For loops for specifications 
wksht_ids = vector()
for(r in 1:4){
  wksht_ids = c(wksht_ids, rep(worksheet_id[r],length(week)))
}

wksht_id_final = vector()
for(r in 1:4){
  wksht_id_final = c(wksht_id_final, rep(wksht_ids[r],lenth(grade)))
}

# Specifications for Answers Data Frame
num_wkshts = 4
rep_grade = 4
num_questions = 1:10
num_students = num_wkshts*length(week)*length(grades)*num_questions



df_a = data.frame(worksheet_id, grades,
                subject, question_number,
                correct_answer, week)

# Wksht id subject case_when

df_a %>% 
  mutate(worksheet_id = case_when(
    subject = 'Counting & Arithmetic' ~ str_replace(worksheet_id,'.', 'ca_'),
    subject = 'Number Sense' ~ str_replace(worksheet_id,'.', 'ns_'),
    subject = 'Geometry' ~ str_replace(worksheet_id,'.', 'g_'),
    subject = 'Measurement & Data' ~ str_replace(worksheet_id,'.', 'md_')))

## Grades and Worksheet Data Frame
grades_a_df = expand.grid(grades,df_a$worksheet_id) %>%
  slice(rep(1:n(), each = rep_grade)) %>%
  rename(grade = Var1,
         clubhouse_id = Var2)

#Creating CSV's
write.csv(df,'answers_table.csv',row.names = FALSE)