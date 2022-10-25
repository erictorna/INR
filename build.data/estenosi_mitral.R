library(data.table)
library(dplyr)
library(tidyverse)

DX_ESTENOSI_MITRAL_BANYOLES <-fread('~/idiap/data/MAR_SERRAT/DX_ESTENOSI_MITRAL_BANYOLES.txt', sep = '@')
load('~/idiap/projects/INR/build.data/pop_dict.RData')

DX_ESTENOSI_MITRAL_BANYOLES = DX_ESTENOSI_MITRAL_BANYOLES %>% mutate(ids=PR_COD_U)
inr = merge(ids, DX_ESTENOSI_MITRAL_BANYOLES)[,ids:=NULL][,PR_COD_U:=NULL]
inr = inr %>% rename(cod_estenosi = PR_COD_PS)
inr = inr %>% rename(dat_estenosi = PR_DDE)
inr$USUA_UAB_UP <- NULL

save(inr, file = '~/idiap/projects/INR/build.data/estenosi_mitral.RData')
