
# Load libraries ----------------------------------------------------------
require(pacman)
pacman::p_load(geodata, rgeos, gtools, dismo, sf, tidyverse, fs, corrplot)

g <- gc(reset = TRUE)
rm(list = ls())

# Load data ---------------------------------------------------------------

# Topography information
srtm <- '../raster/topography/pan/DEM_SAGA.tif'
hlls <- '../raster/topography/pan/Hillshade_SRTM30m_214.tif'

plot(terra::rast(srtm))
plot(terra::rast(hlls))

