library(data.table)
library(dplyr)
library(tidyverse)

DX_OB_BANYOLES <-fread('~/idiap/data/MAR_SERRAT/DX_OBESITAT_BANYOLES.txt', sep = '@')
load('~/idiap/projects/INR/build.data/pop_dict.RData')

DX_OB_BANYOLES = DX_OB_BANYOLES %>% mutate(ids=PR_COD_U)
inr = merge(ids, DX_OB_BANYOLES)[,ids:=NULL][,PR_COD_U:=NULL]
inr = inr %>% rename(cod_obesitat = PR_COD_PS)
inr = inr %>% rename(dat_obesitat = PR_DDE)
inr$USUA_UAB_UP <- NULL

save(inr, file = '~/idiap/projects/INR/build.data/obesitat.RData')
