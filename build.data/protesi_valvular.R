library(data.table)
library(dplyr)
library(tidyverse)

DX_OB_BANYOLES <-fread('~/idiap/data/MAR_SERRAT/DX_PROTESI_VALVULAR_BANYOLES.txt', sep = '@')
load('~/idiap/projects/INR/build.data/pop_dict.RData')

DX_OB_BANYOLES = DX_OB_BANYOLES %>% mutate(ids=PR_COD_U)
inr = merge(ids, DX_OB_BANYOLES)[,ids:=NULL][,PR_COD_U:=NULL]
inr = inr %>% rename(cod_prot_valv = PR_COD_PS)
inr = inr %>% rename(dat_prot_valv = PR_DDE)
inr$USUA_UAB_UP <- NULL

save(inr, file = '~/idiap/projects/INR/build.data/protesi_valvular.RData')
