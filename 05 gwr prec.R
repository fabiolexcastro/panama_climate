
# Load libraries ----------------------------------------------------------
require(pacman)
pacman::p_load(geodata, spatialEco, glue, rgeos, gtools, dismo, sf, tidyverse, fs, corrplot)

g <- gc(reset = TRUE)
rm(list = ls())

# Change the temporal files directory
terraOptions(tempdir = "G:/ProyectoR/tmpr")

# Load data ---------------------------------------------------------------

path <- 'G:/SAGA/modelos/FIO_ESM1_2_0/2030/ssp126'

srtm <- terra::rast('G:/SAGA/ProyectoR/raster/topograhy/srtm.tif')
srtm


