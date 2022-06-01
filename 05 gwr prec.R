
# Load libraries ----------------------------------------------------------
require(pacman)
pacman::p_load(geodata, spatialEco, glue, rgeos, gtools, dismo, sf, tidyverse, fs, corrplot)

g <- gc(reset = TRUE)
rm(list = ls())

# Change the temporal files directory
terraOptions(tempdir = "G:/ProyectoR/tmpr")

# Load data ---------------------------------------------------------------

path <- 'G:/SAGA/modelos/FIO_ESM1_2_0/2030/ssp126'

srtm <- terra::rast('G:/ProyectoR/raster/topograhy/srtm.tif')
srtm_proj <- terra::project(srtm, '+proj=utm +zone=17 +datum=WGS84 +units=m +no_defs')

slpe <- terra::terrain(x = srtm_proj, v = c('slope'), unit = 'degrees')
terra::writeRaster(slpe, filename = 'G:/ProyectoR/raster/topograhy/slpe_proj.tif')

slpe_geog <- terra::project(slpe, terra::crs(srtm))
terra::writeRaster(slpe_geog, filename = 'G:/ProyectoR/raster/topograhy/slpe_geog.tif')