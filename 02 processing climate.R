
# Load libraries ----------------------------------------------------------
require(pacman)
pacman::p_load(geodata, spatialEco, rgeos, gtools, dismo, sf, tidyverse, fs, corrplot)

g <- gc(reset = TRUE)
rm(list = ls())

# Environmental SAGA ------------------------------------------------------
envr <- 'D:/Cárdenas-Castillero/Trabajo/MiAmbiente/Shape and info/saga-8.2.0_x64/saga-8.2.0_x64'
envr <- rsaga.env(envr)

# Load data ---------------------------------------------------------------

# Topography information
srtm <- '../raster/topograhy/pan/DEM_SAGA.tif'
hlls <- '../raster/topograhy/pan/Hillshade_SRTM30m_214.tif'

plot(terra::rast(srtm))
plot(terra::rast(hlls))

srtm <- terra::rast(srtm)
srtm <- terra::project(srtm, 'epsg:4326')

hlls <- terra::rast(hlls)
hlls <- terra::project(hlls, 'epsg:4326')

terra::writeRaster(x = srtm, filename = '../raster/topography/srtm.tif')
terra::writeRaster(x = hlls, filename = '../raster/topography/hlls.tif')

# Climate data
root <- '../raster/future/cm6/panama/'
ssps <- c('ssp126', 'ssp585')
mdls <- c('FIO-ESM-2-0', 'MPI-ESM1-2-HR', 'MPI-ESM1-2-LR')
prds <- c('2021-2040', '2041-2060', '2061-2080')
vars <- c('prec', 'tmax', 'tmin')

# Convert stack to each one layer -----------------------------------------

purrr::map(.x = 1:length(ssps), .f = function(s){
  
  purrr::map(.x = 1:length(mdls), .f = function(m){
    
    purrr::map(.x = 1:length(prds), .f = function(p){
      
      purrr::map(.x = 1:length(vars), .f = function(v){
        
        cat(ssps[s], mdls[m], prdo[p], vars[v], '\t', sep = ' ')
        pth <- glue('{root}/{ssps[s]}/{mdls[m]}/{prdo[p]}/{vars[v]}.tif')
        terra::rast(pth)
        
      })
      
    })
    
  })
  
})



