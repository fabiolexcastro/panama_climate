


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
tble <- mutate(tble, ecua_1 = ((maxlany - minlany) / (Model_max - Model_min)) * (Model + minlany - Model_min + lanyminhourly - (maxlany + minlany)/ 2) ^ 2 + ((maxlany + minlany) / 2))
tble %>% dplyr::select(ecua_1) %>% head()

# To date and hour 
tbl2 <- mutate(tble, DATE = as.Date(DATE, format = '%d/%m/%Y'))
tbl2 <- as_tibble(tbl2)

time <- tibble(time_1 = unique(tbl2$TIME))

head(tbl2)


tbl2 <- mutate(tbl2, jornada = str_sub(TIME, nchar(TIME) - 6, nchar(TIME))) %>% 
  dplyr::select(DATE, TIME, jornada, everything())
tbl2 <- mutate(tbl2, jornada = str_sub(jornada, 1, 1))
table(tbl2$jornada)

tbl2 <- mutate(tbl2, TIME_2 = parse_number(TIME)) %>% 
  dplyr::select(DATE, TIME, jornada, everything())
pull(tbl2, TIME_2)
tbl2 <- mutate(tbl2, TIME_2 = ifelse(jornada == 'p', TIME_2 + 12, TIME_2))
head(tbl2, 4)
tbl2 <- dplyr::select(tbl2, DATE, TIME, TIME_2, jornada, everything())
tbl2 <- mutate(tbl2, TIME_2 = paste0(TIME_2, ':00:00'))
head(tbl2, 4)

# Add the time 
tbl2 <- mutate(tbl2, DATE_2 = paste0(DATE, ' ', TIME_2))
tbl2 <- dplyr::select(tbl2, DATE, DATE_2, TIME, TIME_2, jornada, everything())
head(tbl2, 4)

# Fill NAS  ---------------------------------------------------------------
tbl2_1 <- drop_na(tbl2)
nrow(tbl2_1); head(tbl2_1)
tbl2_2 <- tbl2[!complete.cases(tbl2),]
nrow(tbl2_1); head(tbl2_2)


dtes <- seq(as.Date('1991-13-01', format = '%Y-%d-%m'), as.Date('1991-31-01', format = '%Y-%d-%m'), by = 'day')
dtes <- purrr::map(.x = 1:length(dtes), .f = function(i){rep(dtes[i], 24)})


# To make the graph 

ggplot(data = tble) + 
  geom_line(aes(x = DATE, y = ecua_1, group = 1), col = 'red') +
  geom_line(aes(x = DATE, y = maxlany, group = 1), col = 'blue') + 
  geom_line(aes(x = DATE, y = minlany, group = 1), col = 'green')
