


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
                     maxlany = as.numeric(maxlany), 
                     lanymaxhourly = as.numeric(lanymaxhourly), 
                     minlany = as.numeric(minlany),
                     lanyminhourly = as.numeric(lanyminhourly))

# To make the summarise ----------------------------------------------------
smmr <- tble %>% 
  group_by(DATE) %>% 
  summarise(Model_max = max(Model), 
            Model_min = min(Model)) %>% 
  ungroup()

View(smmr)

# Join the summarise table with the global table 
tble <- full_join(tble, smmr, by = 'DATE')
tble <- dplyr::select(tble, -mondel.mean)
tble <- mutate(tble, lanyminhourly = as.numeric(lanyminhourly))
tble <- mutate(tble, ecua_1 = ((maxlany - minlany) / (Model_max - Model_min)) * (Model + minlany - Model_min + lanyminhourly - (lanymaxhourly + lanyminhourly)/ 2) ^ 2 + ((maxlany + minlany) / 2))
tble %>% dplyr::select(ecua_1) %>% head()
