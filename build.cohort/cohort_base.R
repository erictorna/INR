library(data.table)
library(dplyr)
library(tidyverse)
library(lubridate)

load('~/idiap/projects/INR/build.data/pop_dict.RData')
f_nms = list.files(paste0('~/idiap/projects/INR/build.data/','/'))
f_nms = f_nms[grepl('.RData', f_nms, fixed = T) & !(grepl('pop_dict', f_nms, fixed = T))] 
f_nms = f_nms[!(grepl('var_inr', f_nms, fixed = T)) & !(grepl('var_inr2', f_nms, fixed = T))]
f_nms = f_nms[!(grepl('any', f_nms, fixed = T)) & !(grepl('migany', f_nms, fixed = T))]
f_nms = f_nms[!(grepl('TTO', f_nms, fixed = T))]
ids$ids<-NULL
cohort.base = ids
# cohort.base$ids<-NULL
setDT(cohort.base)


# Aqui he de preguntar amb quina data es vol quedar en els casos en que el mateix id surt multiples vegades
# Quina és la dmin i la dmax?
# Filtrar per edat?


# Per alguna rao no em fa be el left.join()
for(f_nm in f_nms){
  print(f_nm)
  load(paste0(paste0('~/idiap/projects/INR/build.data/','/', f_nm)))
  setDT(inr)
  # inr = inr[inr[[3]]>ymd('2000-01-01')]
  df = left_join(ids, inr)
  # cohort.base = left_join(ids, cohort.base)
  cohort.base = left_join(df, cohort.base)
}
# cohort.base$ids<-NULL

cohort.base = cohort.base[!is.na(USUA_SEXE)]
cohort.base = cohort.base[!duplicated(cohort.base), ]
