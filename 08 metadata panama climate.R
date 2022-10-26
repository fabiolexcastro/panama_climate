

# Load libraries ----------------------------------------------------------
require(pacman)
pacman::p_load(tidyverse, glue, terra, raster, fs, readxl, hablar)

g <- gc(reset = TRUE)
rm(list = ls())
options(scipen = 999, warn = -1)

# Load data ---------------------------------------------------------------
path <- 'G:/ProyectoR/raster/future/cm6/panama'
ssps <- basename(dir_ls(path))
mdls <- c('FIO-ESM-2-0', 'MPI-ESM1-2-HR', 'MPI-ESM1-2-LR')
prds <- c('2021-2040', '2041-2060', '2061-2080')
vars <- c('prec', 'tmax', 'tmin')

# Function ----------------------------------------------------------------


