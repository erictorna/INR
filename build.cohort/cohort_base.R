library(data.table)
library(dplyr)
library(tidyverse)
library(lubridate)

load('~/idiap/projects/INR/build.data/pop_dict.RData')
f_nms = list.files(paste0('~/idiap/projects/INR/build.data/','/'))
f_nms = f_nms[grepl('.RData', f_nms, fixed = T) & !(grepl('pop_dict', f_nms, fixed = T))] # Es el diccionari de ids 
f_nms = f_nms[!(grepl('var_inr', f_nms, fixed = T)) & !(grepl('var_inr2', f_nms, fixed = T))] # INR
f_nms = f_nms[!(grepl('any', f_nms, fixed = T)) & !(grepl('migany', f_nms, fixed = T))] # Temps en rang terapeutic
f_nms = f_nms[!(grepl('TTO', f_nms, fixed = T))] # Tipus de tractament (tto = TratamienTO?)
f_nms = f_nms[!(grepl('vacunes', f_nms, fixed = T))] # DB amb les vacunes
ids$ids<-NULL
cohort.base = ids
setDT(cohort.base)

# Aqui he de preguntar amb quina data es vol quedar en els casos en que el mateix id surt multiples vegades
# Quina és la dmin i la dmax?
# Filtrar per edat?

for(f_nm in f_nms){
# CI, diabetes, estenosi mitral, FA, HTA, ictus, MRC, obesitat morbida, obesitat, protesi valvular, sobrepes, TEP, trombofilitis, valvulopatia arotica
  print(f_nm)
  load(paste0(paste0('~/idiap/projects/INR/build.data/','/', f_nm)))
  setDT(inr)
  # inr = inr[inr[[3]]>ymd('2000-01-01')]
  cohort.base = full_join(cohort.base, inr)
}
cohort.base = cohort.base[!is.na(USUA_SEXE)]
cohort.base = cohort.base[!duplicated(cohort.base), ]

# Vacunes

load('~/idiap/projects/INR/build.data/vacunes.RData')

cohort.base = full_join(cohort.base, vacunes)
nrow(cohort.base[is.na(VA_U_DOSI), .N, keyby=.(id)]) # 1673 de 9329 id que no tenen vacuna (~18%)

# Temps en rang terapeutic

load('~/idiap/projects/INR/build.data/any.RData')
load('~/idiap/projects/INR/build.data/migany.RData')

cohort.base = full_join(cohort.base, any)
cohort.base = full_join(cohort.base, migany)
nrow(cohort.base[is.na(val_trt_12M), .N, keyby=.(id)]) # 8890
nrow(cohort.base[val_trt_12M==-1.00, .N, keyby=.(id)]) # 125

# Tractament warfarina (B01AA03) i Sintrom (B01AA07)

load('~/idiap/projects/INR/build.data/TTO.RData')
cohort.base = full_join(cohort.base, tto)

# INR, preguntar perquè hi ha dos arxius diferents

load('~/idiap/projects/INR/build.data/var_inr.RData')
load('~/idiap/projects/INR/build.data/var_inr2.RData')
