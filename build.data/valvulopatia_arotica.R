library(data.table)
library(dplyr)
library(tidyverse)

DX_OB_BANYOLES <-fread('~/idiap/data/MAR_SERRAT/DX_VALVULOPATIA_AORTICA_BANYOLES.txt', sep = '@')
load('~/idiap/projects/INR/build.data/pop_dict.RData')

DX_OB_BANYOLES = DX_OB_BANYOLES %>% mutate(ids=PR_COD_U)
inr = merge(ids, DX_OB_BANYOLES)[,ids:=NULL][,PR_COD_U:=NULL]
inr = inr %>% rename(cod_valv_aro = PR_COD_PS)
inr = inr %>% rename(dat_valv_aro = PR_DDE)
inr$USUA_UAB_UP <- NULL
inr$cod_valv_aro<-NULL

save(inr, file = '~/idiap/projects/INR/build.data/valvulopatia_arotica.RData')
