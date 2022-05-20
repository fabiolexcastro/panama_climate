

# Load libraries ----------------------------------------------------------
require(pacman)
pacman::p_load(geodata, rgeos, gtools, dismo, sf, tidyverse, fs, corrplot)

g <- gc(reset = TRUE)
rm(list = ls())


# To start ----------------------------------------------------------------
ssps <- c('ssp126', 'ssp585')
prdo <- c('2021-2040', '2041-2060', '2061-2080')
mdls <- c('FIO-ESM', 'MPI-ESM1-2-HR', 'MPI-ESM1-2-LR')


base <- 'https://geodata.ucdavis.edu/cmip6/tiles/'

print(ssps); print(prdo); print(mdls); print(base)
