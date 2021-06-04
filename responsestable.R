library(randomNames)
library(ggplot2)
library(kableExtra)
library(dplyr)
library(tinytex)
library(rmarkdown)
library(tidyverse)
options(tinytex.verbose = TRUE)

# Variables
question_number = 1:10
responses <- sample(0:100,960,replace = F)
week <- c("1", "2", "3", "4")

worksheet_id = as.character(paste0("w_sh_.id_", sample(100:999,16,replace = F)))
student_id = as.character(paste0("p_id_", sample(100:999,20,replace = F)))


df_r = expand.grid(worksheet_id, grades, student_id, question_number,
                responses, week)

# Wksht id subject case_when

df_r %>% 
  mutate(worksheet_id = case_when(
    subject = 'Counting & Arithmetic' ~ str_replace(worksheet_id,'.', 'ca'),
    subject = 'Number Sense' ~ str_replace(worksheet_id,'.', 'ns'),
    subject = 'Geometry' ~ str_replace(worksheet_id,'.', 'g'),
    subject = 'Measurement & Data' ~ str_replace(worksheet_id,'.', 'md')))
  distinct(question_number, keep)

write.csv(df,'responses_table.csv',row.names = FALSE)
