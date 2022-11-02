library(data.table)
library(dplyr)
library(tidyverse)

DX_OB_BANYOLES <-fread('~/idiap/data/MAR_SERRAT/TRT_6M_010520_311221.txt', sep = '@')
load('~/idiap/projects/INR/build.data/pop_dict.RData')

DX_OB_BANYOLES = DX_OB_BANYOLES %>% mutate(ids=VU_COD_U)
migany = merge(ids, DX_OB_BANYOLES)[,ids:=NULL][,VU_COD_U:=NULL]
migany = migany %>% rename(dat_trt_6M = VU_DAT_ACT)
migany = migany %>% rename(val_trt_6M = VU_VAL)
migany$USUA_UAB_UP <- NULL

save(migany, file = '~/idiap/projects/INR/build.data/migany.RData')
