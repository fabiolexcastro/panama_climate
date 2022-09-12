


# Load libraries ----------------------------------------------------------
require(pacman)
pacman::p_load(tidyverse, glue, fs, readxl, hablar)

g <- gc(reset = TRUE)
rm(list = ls())
options(scipen = 999, warn = -1)

# Load data ---------------------------------------------------------------
path <- "G:/CZECHCLIMATE/R/Excel_data/Tempcsv.xlsx.csv"
tble <- read.csv2(path)
tble <- as_tibble(tble)

head(tble)
tail(tble)

# Change the column format 
tble <- mutate(tble, Model = as.numeric(Model), mondel.mean = as.numeric(model.mean),
                     maxlany = as.numeric(maxlany), lanymaxhourly = as.numeric(lanymaxhourly), minlany = as.numeric(minlany))

# To make the summarise ----------------------------------------------------
smmr <- tble %>% 
  group_by(DATE) %>% 
  summarise(Model_max = max(Model), 
            Model_min = min(Model)) %>% 
  ungroup()

View(smmr)

