

# Load libraries ----------------------------------------------------------
require(pacman)
pacman::p_load(tidyverse, glue, terra, raster, rgeos, gtools, fs, readxl, hablar)

g <- gc(reset = TRUE)
rm(list = ls())
options(scipen = 999, warn = -1)

# Load data ---------------------------------------------------------------
path <- 'G:/ProyectoR/raster/future/cm6/panama'
ssps <- basename(dir_ls(path))
mdls <- c('FIO-ESM-2-0', 'MPI-ESM1-2-HR', 'MPI-ESM1-2-LR')
prds <- c('2021-2040', '2041-2060', '2061-2080')
vars <- c('prec', 'tmax', 'tmin')

# Function ----------------------------------------------------------------

# Proof
prd <- prds[1]
mdl <- mdls[1]
ssp <- ssps[1]

add_metadata <- function(prd, mdl, ssp){
  
  cat(prd, mdl, ssp, '\n', sep = ' ')
  
  # To list the files
  pth <- glue('{path}/{ssp}/{mdl}/{prd}')
  fls <- dir_ls(pth)
  fls <- as.character(fls)
  fls <- mixedsort(fls)
  
  # To read the files as a raster 
  prec <- grep('prec', fls, value = TRUE) %>% grep('.tif', ., value = TRUE) %>% purrr::map(.x = ., .f = raster::raster)
  tmax <- grep('tmax', fls, value = TRUE) %>% grep('.tif', ., value = TRUE) %>% purrr::map(.x = ., .f = raster::raster)
  tmin <- grep('tmin', fls, value = TRUE) %>% grep('.tif', ., value = TRUE) %>% purrr::map(.x = ., .f = raster::raster)
  
  # To create the metadata file
  
  # Precipitation
  mtdt_prec <- list()
  tmpr <- c('Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre')
  
  for(i in 1:12){
    
    mtdt_prec[[i]] <- list(
      feat = list(
        
        modelo_ssp <- ssp, 
        periodo <- prd,
        modelo_gcm <- mdl,
        variable <- 'Precipitacion',
        units <- 'mm'
        
      ),
      
      fuente = 'CMIP 6 - Worldclim',
      webservice = 'worldclim.org',
      mes = tmpr[i],
      resolucion = '1 km2'
      
    )
    
  }
  
  # To add the metadata file (prec)
  for(i in 1:12){
    metadata(prec[[i]]) <- mtdt_prec[[i]]
  }
  
  writeRaster(x = prec[[1]], filename = './prec_borrardespues.tif')
  
}
