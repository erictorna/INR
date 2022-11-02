library(data.table)
library(dplyr)
library(tidyverse)

DX_OB_BANYOLES <-fread('~/idiap/data/MAR_SERRAT/TRT_12M_010520_311221.txt', sep = '@')
load('~/idiap/projects/INR/build.data/pop_dict.RData')

DX_OB_BANYOLES = DX_OB_BANYOLES %>% mutate(ids=VU_COD_U)
any = merge(ids, DX_OB_BANYOLES)[,ids:=NULL][,VU_COD_U:=NULL]
any = any %>% rename(dat_trt_12M = VU_DAT_ACT)
any = any %>% rename(val_trt_12M = VU_VAL)
any$USUA_UAB_UP <- NULL

save(any, file = '~/idiap/projects/INR/build.data/any.RData')
