library(data.table)
library(dplyr)
library(tidyverse)

DX_MRC_BANYOLES <-fread('~/idiap/data/MAR_SERRAT/DX_MRC_BANYOLES.txt', sep = '@')
load('~/idiap/projects/INR/build.data/pop_dict.RData')

DX_MRC_BANYOLES = DX_MRC_BANYOLES %>% mutate(ids=PR_COD_U)
inr = merge(ids, DX_MRC_BANYOLES)[,ids:=NULL][,PR_COD_U:=NULL]
inr = inr %>% rename(cod_mrc = PR_COD_PS)
inr = inr %>% rename(dat_mrc = PR_DDE)
inr$USUA_UAB_UP <- NULL
inr$cod_mrc<-NULL

save(inr, file = '~/idiap/projects/INR/build.data/MRC.RData')
