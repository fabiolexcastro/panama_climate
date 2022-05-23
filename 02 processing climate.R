
# Load libraries ----------------------------------------------------------
require(pacman)
pacman::p_load(geodata, rgeos, gtools, dismo, sf, tidyverse, fs, corrplot)

g <- gc(reset = TRUE)
rm(list = ls())

# Load data ---------------------------------------------------------------

# Topography information
srtm <- '../raster/topograhy/pan/DEM_SAGA.tif'
hlls <- '../raster/topograhy/pan/Hillshade_SRTM30m_214.tif'

plot(terra::rast(srtm))
plot(terra::rast(hlls))

srtm <- terra::rast(srtm)
srtm <- terra::project(srtm, 'epsg:4326')

# Climate information 



