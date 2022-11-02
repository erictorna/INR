library(data.table)
library(dplyr)
library(tidyverse)

vacunes <-fread('~/idiap/data/MAR_SERRAT/VACUNA_COVID_BANYOLES.txt', sep = '@')
load('~/idiap/projects/INR/build.data/pop_dict.RData')

vacunes = vacunes %>% rename(ids = VA_U_USUA_CIP)
vacunes = left_join(ids, vacunes)
vacunes$ids<-NULL
vacunes$USUA_UAB_UP<-NULL

vacunes = vacunes %>% rename(data_vacuna = VA_U_DATA_VAC)

save(vacunes, file = '~/idiap/projects/INR/build.data/vacunes.RData')
