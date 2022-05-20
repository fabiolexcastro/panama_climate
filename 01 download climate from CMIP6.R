

# Load libraries ----------------------------------------------------------
require(pacman)
pacman::p_load(geodata, rgeos, gtools, dismo, sf, tidyverse, fs, corrplot)

g <- gc(reset = TRUE)
rm(list = ls())


# To start ----------------------------------------------------------------
ssps <- c('ssp126', 'ssp585')
prdo <- c('2021-2040', '2041-2060', '2061-2080')
mdls <- c('FIO-ESM-2-0', 'MPI-ESM1-2-HR', 'MPI-ESM1-2-LR')

base <- 'https://geodata.ucdavis.edu/cmip6/tiles/'
print(ssps); print(prdo); print(mdls); print(base)

vars <- c('prec', 'tmax', 'tmin')

# Limite 
cntr <- 'PAN'
limt <- geodata::gadm(country = cntr, level = 0, path = '../tmpr')
plot(limt)

# Function ----------------------------------------------------------------

# Proof
ssp <- ssps[1]
mdl <- mdls[1]
prd <- prdo[1]

down <- function(ssp, mdl, prd){
  
  cat(ssp, ' ', mdl, '\t')
  
  out <- purrr::map(.x = 1:length(vars), .f = function(i){
    
    # i <- 1
    path <- glue('{base}/{mdl}/{ssp}/wc2.1_30s_{vars[i]}_{mdl}_{ssp}_{prd}_tile-28.tif')
    dout <- glue('../raster/future/cm6/tile/{ssp}/{mdl}')
    ifelse(!file.exists(dout), dir_create(dout), print('Exists'))
    dout <- glue('{dout}/{basename(path)}')
    download.file(url = path, destfile = dout, mode = 'wb')
    return(dirname(dout))
    
  })
  
  out <- unlist(out) %>% unique()
  fls <- dir_ls(out) %>% as.character() %>% grep('.tif$', ., value = T)
  rst <- purrr::map(.x = 1:length(fls), .f = function(j){
    cat(fls[j], '\n')
    rs <- terra::rast(fls[j])
    rs <- terra::crop(rs, limt)
    rs <- terra::mask(rs, limt)
    cat('Done!\n')
    return(rs)
  })
  
  plot(rst[[1]][[1]])
  
  
  
}


