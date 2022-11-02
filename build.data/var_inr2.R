library(data.table)
library(dplyr)
library(tidyverse)

DX_OB_BANYOLES <-fread('~/idiap/data/MAR_SERRAT/VAR_INR_010521_311221.txt', sep = '@')
load('~/idiap/projects/INR/build.data/pop_dict.RData')

DX_OB_BANYOLES = DX_OB_BANYOLES %>% mutate(ids=VU_COD_U)
inr2 = merge(ids, DX_OB_BANYOLES)[,ids:=NULL][,VU_COD_U:=NULL]
inr2 = inr2 %>% rename(usu_inr21 = VU_USU)
inr2 = inr2 %>% rename(dat_inr21 = VU_DAT_ACT)
inr2$USUA_UAB_UP <- NULL

save(inr2, file = '~/idiap/projects/INR/build.data/var_inr2.RData')
