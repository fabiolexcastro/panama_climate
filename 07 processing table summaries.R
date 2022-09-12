


# Load libraries ----------------------------------------------------------
require(pacman)
pacman::p_load(tidyverse, glue, fs, readxl)

g <- gc(reset = TRUE)
rm(list = ls())
options(scipen = 999, warn = -1)

# Load data ---------------------------------------------------------------
path <- "G:/CZECHCLIMATE/R/Excel_data/Tempcsv.xlsx.csv"
tble <- read.csv2(path)
tble <- as_tibble(tble)

head(tble)
tail(tble)

# To make the summarise ----------------------------------------------------
smmr <- tble %>% 
  group_by(DATE) %>% 
  summarise(Model_max = max(Model), 
            Model_min = min(Model)) %>% 
  ungroup()

View(smmr)

