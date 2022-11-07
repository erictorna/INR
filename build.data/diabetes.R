library(data.table)
library(dplyr)
library(tidyverse)

DX_DM2_BANYOLES <-fread('~/idiap/data/MAR_SERRAT/DX_DM2_BANYOLES.txt', sep = '@')
load('~/idiap/projects/INR/build.data/pop_dict.RData')

DX_DM2_BANYOLES = DX_DM2_BANYOLES %>% mutate(ids=PR_COD_U)
inr = merge(ids, DX_DM2_BANYOLES)[,ids:=NULL][,PR_COD_U:=NULL]
inr = inr %>% rename(cod_diab = PR_COD_PS)
inr = inr %>% rename(dat_diab = PR_DDE)
inr$USUA_UAB_UP <- NULL
inr$cod_diab<-NULL

save(inr, file = '~/idiap/projects/INR/build.data/diabetes.RData')
