 

# Load libraries ----------------------------------------------------------
require(pacman)
pacman::p_load(geodata, spatialEco, rgeos, gtools, dismo, sf, tidyverse, fs, corrplot)

g <- gc(reset = TRUE)
rm(list = ls())

# Load data ---------------------------------------------------------------
path <- '../raster/future/cm6/tile'
ssps <- c('ssp126', 'ssp585')
mdls <- c('FIO-ESM-2-0', 'MPI-ESM1-2-HR', 'MPI-ESM1-2-LR')
prds <- c('2021-2040', '2041-2060', '2061-2080')
limt <- terra::vect('../shp/base/panama.shp')

# Make the process --------------------------------------------------------
s <- m <- p <- 1

purrr::map(.x = 1:length(ssps), .f = function(s){
  
  purrr::map(.x = 1:length(mdls), .f = function(m){
    
    purrr::map(.x = 1:length(prds), .f = function(p){
      
      dir <- glue('{path}/{ssps[s]}/{mdls[m]}')
      fls <- dir_ls(dir, regexp = '.tif')
      fls <- as.character(fls)
      fls <- grep('.tif$', fls, value = T)
      fls <- grep(prds[p], fls, value = T)
      print(fls)
      
      ppt <- grep('prec', fls, value = T) %>% terra::rast()
      tmx <- grep('tmax', fls, value = T) %>% terra::rast()
      tmn <- grep('tmin', fls, value = T) %>% terra::rast()
      
      ppt <- terra::crop(ppt, limt) %>% terra::mask(., limt)
      tmx <- terra::crop(tmx, limt) %>% terra::mask(., limt)
      tmn <- terra::crop(tmn, limt) %>% terra::mask(., limt)
      
      # To write these rasters
      
      
      
    })
    
  })
  
})





























