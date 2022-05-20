

# Load libraries ----------------------------------------------------------
require(pacman)
pacman::p_load(geodata, rgeos, gtools, dismo, sf, tidyverse, fs, corrplot)

g <- gc(reset = TRUE)
rm(list = ls())


# To start ----------------------------------------------------------------
ssps <- c('ssp126', 'ssp585')
prdo <- c('2021-2040', '2041-2060', '2061-2080')
mdls <- c('FIO-ESM', 'MPI-ESM1-2-HR', 'MPI-ESM1-2-LR')

base <- 'https://geodata.ucdavis.edu/cmip6/tiles/'
print(ssps); print(prdo); print(mdls); print(base)

vars <- c('prec', 'tmax', 'tmin')

# Function ----------------------------------------------------------------

# Proof
ssp <- ssps[1]
mdl <- mdls[1]
prd <- prdo[1]

down <- function(ssp, mdl, prd){
  
  cat(ssp, ' ', mdl, '\t')
  
  purrr::map(.x = 1:length(vars), .f = function(i){
    
    # i <- 1
    path <- glue('{base}/{mdl}/{ssp}/wc2.1_30s_{vars[i]}_{mdl}_{ssp}_{prd}_tile-28.tif')
    
    
  })
  
  
  
}


