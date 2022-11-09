library(data.table)
library(dplyr)
library(tidyverse)
library(lubridate)
library(writexl)

load('~/idiap/projects/INR/build.data/pop_dict.RData')
f_nms = list.files(paste0('~/idiap/projects/INR/build.data/','/'))
f_nms = f_nms[grepl('.RData', f_nms, fixed = T) & !(grepl('pop_dict', f_nms, fixed = T))] # Es el diccionari de ids 
f_nms = f_nms[!(grepl('var_inr', f_nms, fixed = T)) & !(grepl('var_inr2', f_nms, fixed = T))] # INR
f_nms = f_nms[!(grepl('any', f_nms, fixed = T)) & !(grepl('migany', f_nms, fixed = T))] # Temps en rang terapeutic
f_nms = f_nms[!(grepl('TTO', f_nms, fixed = T))] # Tipus de tractament
f_nms = f_nms[!(grepl('vacunes', f_nms, fixed = T))] # Vacunes
ids$ids<-NULL
cohort.base = ids
setDT(cohort.base)

# Comorbiditats
for(f_nm in f_nms){
# CI, diabetes, estenosi mitral, FA, HTA, ictus, MRC, obesitat morbida, obesitat, protesi valvular, sobrepes, TEP, trombofilitis, valvulopatia arotica
  print(f_nm)
  load(paste0(paste0('~/idiap/projects/INR/build.data/','/', f_nm)))
  setDT(inr)
  inr = inr %>%
    group_by(id) %>%
    arrange(inr[,2]) %>%
    slice(1L)
  setDT(inr)
  # Fem fora gent que hagi patit comorbiditats posteriors a la data de finalitzacio de l'estudi
  inr = inr[inr[[2]]<ymd('2021-07-01')]
  cohort.base = full_join(cohort.base, inr)
}
cohort.base = cohort.base[!is.na(USUA_SEXE)]
cohort.base = cohort.base[!duplicated(cohort.base), ]

# Vacunes, tenim en compte nomes la primera dosi sempre i quant aquesta no shagi produit més tard del juliol del 2021
load('~/idiap/projects/INR/build.data/vacunes.RData')
vacunes = vacunes %>%
  group_by(id) %>%
  arrange(data_vacuna) %>%
  slice(1L)
setDT(vacunes)
vacunes = vacunes[vacunes[[4]]<ymd('2021-07-01')]
cohort.base = full_join(cohort.base, vacunes)
nrow(cohort.base[is.na(VA_U_DOSI), .N, keyby=.(id)]) 

# Temps en rang terapeutic
load('~/idiap/projects/INR/build.data/any.RData')
load('~/idiap/projects/INR/build.data/migany.RData')

# cohort.base = full_join(cohort.base, any)
# cohort.base = full_join(cohort.base, migany)


# Tractament warfarina (B01AA03) i Sintrom (B01AA07)
load('~/idiap/projects/INR/build.data/TTO.RData')
tto = tto %>% mutate(duration_tto = dat_fi_tto - dat_ini_tto) %>% 
  select(id, cod_tto, dat_ini_tto, dat_fi_tto, duration_tto, USUA_SEXE, DATA_NAIX, EDAT)
cohort.base = full_join(cohort.base, tto)


# INR
load('~/idiap/projects/INR/build.data/var_inr.RData')
# load('~/idiap/projects/INR/build.data/var_inr2.RData')


# Exclusions
cohort.base = cohort.base[!(is.na(cohort.base$VA_U_COD))] # Eliminem els no vacunats
cohort.base = cohort.base[!(is.na(cod_tto))] # Ens quedem només amb els que tenen tractament amb warfarina o sintrom
cohort.base = cohort.base[EDAT>18] # Treiem els menors de 18 anys

# write_xlsx(cohort.base,"~/idiap/projects/INR/build.data/cohort.xlsx")
