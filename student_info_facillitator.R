library(randomNames)
library(ggplot2)
library(kableExtra)
library(dplyr)
library(tinytex)
library(rmarkdown)
library(tidyverse)
library(generator)
library(purrr)
options(tinytex.verbose = TRUE)

set.seed(100)
location = c('San Francisco','Los Angeles', 'San Diego','Sacramento','Santa Cruz')
location_id = paste0("location_id_", sample(1000:9999,length(location),replace = F))
number_of_chs = c(5,4,3,4,3)



locations = vector()
for(r in 1:5){
 locations = c(locations, rep(location[r],number_of_chs[r]))
}

locations_id = vector()
for(r in 1:5){
 locations_id = c(locations_id, rep(location_id[r],number_of_chs[r]))
}

clubhouse_id = as.character(paste0("ch_id_", sample(100:999,sum(number_of_chs),replace = F)))

bgc_facillitator_name <- randomNames(sum(number_of_chs))
bgc_facillitator_phone_number = r_phone_numbers(sum(number_of_chs), use_hyphens = TRUE)
bgc_facillitator_email <- paste0(str_replace(bgc_facillitator_name,', ',''), '@bgc.com')
fac_df = data.frame(locations,locations_id,clubhouse_id,
                    bgc_facillitator_name,
                    bgc_facillitator_email,
                    bgc_facillitator_phone_number)

## Specifications for Student Data Frame
num_clubs = nrow(fac_df)
rep_grade = 3
grades = c('K','1','2','3','4','5')
num_students = num_clubs*rep_grade*length(grades)

## Grades and Clubhouse Data Frame
grades_ch_df = expand.grid(grades,fac_df$clubhouse_id) %>%
  slice(rep(1:n(), each = rep_grade)) %>%
  rename(grade = Var1,
         clubhouse_id = Var2)

## Generate Students IDs and Names
student_id = paste0("s_id_",sample(100:999,num_students,replace = F))
student_name <- randomNames(num_students)
time_started <- sample(100:999,num_students,replace = F)

## Create Students Data Frame
student_df = data.frame(student_id,student_name,time_started) %>%
  bind_cols(grades_ch_df)

df = student_df %>%
  left_join(fac_df,"clubhouse_id")

write.csv(fac_df,'facillitator_table.csv',row.names = FALSE)
write.csv(student_df,'student_table.csv',row.names = FALSE)