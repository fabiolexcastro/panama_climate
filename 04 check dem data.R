

# Load libraries ----------------------------------------------------------
require(pacman)
pacman::p_load(terra, sf, tidyverse, geodata, glue, fs)

g <- gc(reset = TRUE)
rm(list = ls())


# Load data ---------------------------------------------------------------
srtm <- '../raster/topograhy/DEM_SAGA.tif'
srtm <- terra::rast(srtm)
srtm
