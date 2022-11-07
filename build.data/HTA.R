library(data.table)
library(dplyr)
library(tidyverse)

DX_HTA_BANYOLES <-fread('~/idiap/data/MAR_SERRAT/DX_HTA_BANYOLES.txt', sep = '@')
load('~/idiap/projects/INR/build.data/pop_dict.RData')

DX_HTA_BANYOLES = DX_HTA_BANYOLES %>% mutate(ids=PR_COD_U)
inr = merge(ids, DX_HTA_BANYOLES)[,ids:=NULL][,PR_COD_U:=NULL]
inr = inr %>% rename(cod_hta = PR_COD_PS)
inr = inr %>% rename(dat_hta = PR_DDE)
inr$USUA_UAB_UP <- NULL
inr$cod_hta<-NULL

save(inr, file = '~/idiap/projects/INR/build.data/HTA.RData')
