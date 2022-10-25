library(data.table)
library(dplyr)
library(tidyverse)

DX_CI_BANYOLES <-fread('~/idiap/data/MAR_SERRAT/DX_CI_BANYOLES.txt', sep = '@')
load('~/idiap/projects/INR/build.data/pop_dict.RData')

DX_CI_BANYOLES = DX_CI_BANYOLES %>% mutate(ids=PR_COD_U)
inr = merge(ids, DX_CI_BANYOLES)[,ids:=NULL][,PR_COD_U:=NULL]
inr = inr %>% rename(cod_ci = PR_COD_PS)
inr = inr %>% rename(dat_ci = PR_DDE)
inr$USUA_UAB_UP <- NULL

save(inr, file = '~/idiap/projects/INR/build.data/CI.RData')
