

# Load libraries ----------------------------------------------------------
require(pacman)
pacman::p_load(terra, sf, tidyverse, geodata, glue, fs)

g <- gc(reset = TRUE)
rm(list = ls())


# Load data ---------------------------------------------------------------
srtm <- '../raster/topograhy/DEM_SAGA.tif'
srtm <- terra::rast(srtm)
srtm

# To change the negative values  ------------------------------------------
rslt <- srtm
rslt[which.lyr(rslt < 0)] <- 0
rslt
min(rslt, na.rm = TRUE)

# To write the raster -----------------------------------------------------
dout <- '../raster/topograhy/pan/DEM_SAGA_OK.tif'
terra::writeRaster(rslt, filename = dout, overwrite = FALSE)

# Finish ------------------------------------------------------------------



