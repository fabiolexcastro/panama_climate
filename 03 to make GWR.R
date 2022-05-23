
# Load libraries ----------------------------------------------------------
require(pacman)
pacman::p_load(geodata, spatialEco, glue, rgeos, gtools, dismo, sf, tidyverse, fs, corrplot)

g <- gc(reset = TRUE)
rm(list = ls())

# Environmental SAGA ------------------------------------------------------
envr <- 'D:/Cárdenas-Castillero/Trabajo/MiAmbiente/Shape and info/saga-8.2.0_x64/saga-8.2.0_x64'
envr <- rsaga.env(envr)


