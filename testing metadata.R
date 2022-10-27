

# Load libraries ----------------------------------------------------------
require(pacman)
pacman::p_load(tidyverse, glue, terra, raster, rgeos, gtools, fs, readxl, geodata, hablar)

g <- gc(reset = TRUE)
rm(list = ls())
options(scipen = 999, warn = -1)

# Load data ---------------------------------------------------------------
prec <- geodata::worldclim_country(country = 'PAN', var = 'prec', path = './raster')

attr(prec)

# For January -------------------------------------------------------------
prec_jan <- prec[[1]]
names(prec_jan) <- 'Precipitacion'
time(prec_jan) <- as.Date('2040-01-01')

prec_jan
attr(prec_jan, "meta") <- "bar"

writeRaster(x = prec_jan, filename = './raster/prec_1.tif')


# Create metadata 
# https://rdrr.io/github/jnghiem/bfasttools/man/create_raster_metadata.html