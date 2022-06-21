


# Load libraries ----------------------------------------------------------
require(pacman)
pacman::p_load(geodata, spatialEco, rgeos, gtools, dismo, sf, tidyverse, fs, corrplot)

g <- gc(reset = TRUE)
rm(list = ls())


# Load data ---------------------------------------------------------------
path <- 'G:/CLIMATECHANGE/Modelos'
prds <- c('2030', '2050', '2070')
mdls <- c('FIO-ESM2-0', 'MPI-ESM1-2-HR', 'MPI-ESM1-2-LR')
ssps <- c('ssp126', 'ssp585')
vars <- c('Precipitacion', 'Tmaxima', 'Tminima')
znes <- c('Arco Seco', 'Caribe Occidental', 'Caribe Oriental', 
          'Pacífico Occidental', 'Pacífico Oriental', 'Región Central')

# Function ----------------------------------------------------------------

prd <- prds[1]
mdl <- mdls[1]
ssp <- ssps[1]

addm <- function(prd, mdl, ssp){
  
  cat(prd, mdl, ssp, '\n', sep = ' ')
  pth <- glue('{path}/{prd}/{mdl}/{ssp}')
  pth
  
  
  
}





































