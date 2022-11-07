library(data.table)
library(dplyr)
library(tidyverse)

DX_ICTUS_BANYOLES <-fread('~/idiap/data/MAR_SERRAT/DX_ICTUS_BANYOLES.txt', sep = '@')
load('~/idiap/projects/INR/build.data/pop_dict.RData')

DX_ICTUS_BANYOLES = DX_ICTUS_BANYOLES %>% mutate(ids=PR_COD_U)
inr = merge(ids, DX_ICTUS_BANYOLES)[,ids:=NULL][,PR_COD_U:=NULL]
inr = inr %>% rename(cod_ictus = PR_COD_PS)
inr = inr %>% rename(dat_ictus = PR_DDE)
inr$USUA_UAB_UP <- NULL
inr$cod_ictus<-NULL

save(inr, file = '~/idiap/projects/INR/build.data/ictus.RData')
