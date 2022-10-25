library(data.table)
library(dplyr)
library(tidyverse)
# Carreguem dadaes, en Jordi em matara per fer-ho així pero lapply() i jo no som gaire bons amics
DX_CI_BANYOLES <- fread('~/idiap/data/MAR_SERRAT/DX_CI_BANYOLES.txt', sep = '@')
DX_DM2_BANYOLES <-fread('~/idiap/data/MAR_SERRAT/DX_DM2_BANYOLES.txt', sep = '@')
DX_ESTENOSI_MITRAL_BANYOLES <- fread('~/idiap/data/MAR_SERRAT/DX_ESTENOSI_MITRAL_BANYOLES.txt', sep = '@')
DX_FA_BANYOLES <-fread('~/idiap/data/MAR_SERRAT/DX_FA_BANYOLES.txt', sep = '@')
DX_HTA_BANYOLES <-fread('~/idiap/data/MAR_SERRAT/DX_HTA_BANYOLES.txt', sep = '@')
DX_ICTUS_BANYOLES <-fread('~/idiap/data/MAR_SERRAT/DX_ICTUS_BANYOLES.txt', sep = '@')
DX_MRC_BANYOLES <-fread('~/idiap/data/MAR_SERRAT/DX_MRC_BANYOLES.txt', sep = '@')
DX_OB_MORBIDA_BANYOLES <-fread('~/idiap/data/MAR_SERRAT/DX_OB_MORBIDA_BANYOLES.txt', sep = '@')
DX_OBESITAT_BANYOLES <-fread('~/idiap/data/MAR_SERRAT/DX_OBESITAT_BANYOLES.txt', sep = '@')
DX_PROTESI_VALVULAR_BANYOLES <-fread('~/idiap/data/MAR_SERRAT/DX_PROTESI_VALVULAR_BANYOLES.txt', sep = '@')
DX_SOBREPES_BANYOLES <-fread('~/idiap/data/MAR_SERRAT/DX_SOBREPES_BANYOLES.txt', sep = '@')
DX_TEP_BANYOLES <-fread('~/idiap/data/MAR_SERRAT/DX_TEP_BANYOLES.txt', sep = '@')
DX_TROMBOFLEBITIS_BANYOLES <-fread('~/idiap/data/MAR_SERRAT/DX_TROMBOFLEBITIS_BANYOLES.txt', sep = '@')
DX_VALVULOPATIA_AORTICA_BANYOLES <-fread('~/idiap/data/MAR_SERRAT/DX_VALVULOPATIA_AORTICA_BANYOLES.txt', sep = '@')
TRT_12M <-fread('~/idiap/data/MAR_SERRAT/TRT_12M_010520_311221.txt', sep = '@')
TRT_6M <-fread('~/idiap/data/MAR_SERRAT/TRT_6M_010520_311221.txt', sep = '@')
TTO_SINTROM_WARFARINA <-fread('~/idiap/data/MAR_SERRAT/TTO_SINTROM_WARFARINA_010121_300621.txt', sep = '@')
VACUNA_COVID <-fread('~/idiap/data/MAR_SERRAT/VACUNA_COVID_BANYOLES.txt', sep = '@')
VAR_INR <-fread('~/idiap/data/MAR_SERRAT/VAR_INR_010520_311221.txt', sep = '@')
VAR_INR2 <-fread('~/idiap/data/MAR_SERRAT/VAR_INR_010521_311221.txt', sep = '@')

# Ajuntem tots els ids en una sola llista
ids <- c(DX_CI_BANYOLES[[1]], DX_DM2_BANYOLES[[1]], DX_ESTENOSI_MITRAL_BANYOLES[[1]], DX_FA_BANYOLES[[1]], DX_HTA_BANYOLES[[1]],
                DX_ICTUS_BANYOLES[[1]], DX_MRC_BANYOLES[[1]], DX_OB_MORBIDA_BANYOLES[[1]], DX_OBESITAT_BANYOLES[[1]],
                DX_PROTESI_VALVULAR_BANYOLES[[1]], DX_SOBREPES_BANYOLES[[1]], DX_TEP_BANYOLES[[1]], DX_TROMBOFLEBITIS_BANYOLES[[1]],
                DX_VALVULOPATIA_AORTICA_BANYOLES[[1]], TRT_12M[[1]], TRT_6M[[1]], TTO_SINTROM_WARFARINA[[1]],
                VAR_INR[[1]], VAR_INR2[[1]])

# Eliminem els duplicats
ids = ids %>% unique()
ids = as.data.table(ids)

ids = ids %>% mutate(id = row_number())
# medea = merge(ids, medea)[,idp:=NULL]

save(ids, file = '~/idiap/projects/INR/build.data/pop_dict.RData')
