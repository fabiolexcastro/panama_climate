
# Load libraries ----------------------------------------------------------
require(pacman)
pacman::p_load(geodata, spatialEco, glue, rgeos, gtools, dismo, sf, tidyverse, fs, corrplot)

g <- gc(reset = TRUE)
rm(list = ls())

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
hlls <-  '../raster/topograhy/hlls.tif'

plot(rast(srtm))
plot(rast(hlls))
