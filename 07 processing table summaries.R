


# Load libraries ----------------------------------------------------------
require(pacman)
pacman::p_load(tidyverse, glue, fs, readxl)

g <- gc(reset = TRUE)
rm(list = ls())
options(scipen = 999, warn = -1)

# Load data ---------------------------------------------------------------
path <- "G:/CZECHCLIMATE/R/Excel_data/Tempcsv.xlsx.csv"
tble <- read_csv(path)

head(tble)
tail(tble)
