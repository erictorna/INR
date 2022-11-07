library(data.table)
library(dplyr)
library(tidyverse)

DX_FA_BANYOLES <-fread('~/idiap/data/MAR_SERRAT/DX_FA_BANYOLES.txt', sep = '@')
load('~/idiap/projects/INR/build.data/pop_dict.RData')

DX_FA_BANYOLES = DX_FA_BANYOLES %>% mutate(ids=PR_COD_U)
inr = merge(ids, DX_FA_BANYOLES)[,ids:=NULL][,PR_COD_U:=NULL]
inr = inr %>% rename(cod_fa = PR_COD_PS)
inr = inr %>% rename(dat_fa = PR_DDE)
inr$USUA_UAB_UP <- NULL
inr$cod_fa<-NULL

save(inr, file = '~/idiap/projects/INR/build.data/FA.RData')
