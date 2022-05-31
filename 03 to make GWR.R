
# Load libraries ----------------------------------------------------------
require(pacman)
pacman::p_load(geodata, spatialEco, glue, rgeos, gtools, dismo, sf, tidyverse, fs, corrplot)

g <- gc(reset = TRUE)
rm(list = ls())

# Change the temporal files directory
terraOptions(tempdir = "G:/ProyectoR/tmpr")

# Environmental SAGA ------------------------------------------------------
envr <- 'D:/Cárdenas-Castillero/Trabajo/MiAmbiente/Shape and info/saga-8.2.0_x64/saga-8.2.0_x64'
envr <- rsaga.env(envr)

# Load data ---------------------------------------------------------------

# Climate data
root <- '../raster/future/cm6/panama/'
ssps <- c('ssp126', 'ssp585')
mdls <- c('FIO-ESM-2-0', 'MPI-ESM1-2-HR', 'MPI-ESM1-2-LR')
prds <- c('2021-2040', '2041-2060', '2061-2080')
vars <- c('prec', 'tmax', 'tmin')
srtm <-  '../raster/topograhy/srtm.tif'

# Check SRTM raster 
srtm_rast <- terra::rast(srtm)
srtm_rast
limt <- geodata::gadm(country = 'PAN', level = 0, path = '../tmpr')
srtm_rast <- terra::crop(srtm_rast, limt)
srtm_rast <- terra::mask(srtm_rast, limt)

hlls <-  '../raster/topograhy/hlls.tif'

plot(rast(srtm))
plot(rast(hlls))

# To apply the function ---------------------------------------------------

s <- m <- p <- 1 # Correr y borrar

purrr::map(.x = 1:length(ssps), .f = function(s){
  
  purrr::map(.x = 1:length(mdls), .f = function(m){
    
    purrr::map(.x = 1:length(prds), .f = function(p){
      
      cat(ssps[s], mdls[m], prds[p], '\n', sep = ' ')
      dinp <- glue('../raster/future/cm6/panama/{ssps[s]}/{mdls[m]}/{prds[p]}')
      fles <- dir_ls(dinp)
      fles <- as.character(fles)
      vars <- c('prec', 'tmax', 'tmin')
      fles <- grep(paste0(vars, collapse = '|'), fles, value = TRUE)
      
      # Filtering only for tmax and tmin
      fles <- grep('tm', fles, value = TRUE)
      fles <- grep(paste0(c('tmax', 'tmin'), collapse = '|'), fles, value = TRUE)
      fles <- mixedsort(fles)
      print(fles)
    
      purrr::map(.x = 1:length(fles), .f = function(i){
        
        finp <- fles[i]
        fout <- glue('{dinp}/gwr_{basename(finp)}')
        
        
        rslt <- rsaga.geoprocessor(
          lib = 'statistics_regression',
          module = 'GWR for Grid Downscaling',
          param = list(PREDICTORS = srtm,
                       REGRESSION = fout,
                       DEPENDENT = finp),
          env = envr)
        
      })
      
    })
    
  })
  
})



# Finish -----------------------------------------------------------------





















# Testing GWR  ------------------------------------------------------------

finp <- glue('{root}/{ssps[1]}/{mdls[1]}/{prds[1]}/prec_1.tif')
fout <- glue('{dirname(finp)}/gwr_{basename(finp)}.tif')

rsl <- rsaga.geoprocessor(
  lib = 'statistics_regression',
  module = 'GWR for Grid Downscaling',
  param = list(PREDICTORS = srtm,
               REGRESSION = fout,
               DEPENDENT = finp),
  env = envr)

rs.srtm <- terra::rast(fout)
fout
plot(rs.srtm)
rs.srtm


