

# Load libraries ----------------------------------------------------------
require(pacman)
pacman::p_load(tidyverse, glue, terra, raster, fs, readxl, hablar)

g <- gc(reset = TRUE)
rm(list = ls())
options(scipen = 999, warn = -1)

# Load data ---------------------------------------------------------------

path <- 'G:/ProyectoR/raster/future/cm6/panama'
dir_ls(path)