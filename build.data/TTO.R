library(data.table)
library(dplyr)
library(tidyverse)

DX_OB_BANYOLES <-fread('~/idiap/data/MAR_SERRAT/TTO_SINTROM_WARFARINA_010121_300621.txt', sep = '@')
load('~/idiap/projects/INR/build.data/pop_dict.RData')

DX_OB_BANYOLES = DX_OB_BANYOLES %>% mutate(ids=PPFMC_PMC_USUARI_CIP)
tto = merge(ids, DX_OB_BANYOLES)[,ids:=NULL][,PPFMC_PMC_USUARI_CIP:=NULL]
tto = tto %>% rename(cod_tto = PPFMC_ATCCODI)
tto = tto %>% rename(dat_ini_tto = PPFMC_PMC_DATA_INI)
tto = tto %>% rename(dat_fi_tto = PPFMC_DATA_FI)
tto$USUA_UAB_UP <- NULL

save(tto, file = '~/idiap/projects/INR/build.data/TTO.RData')
