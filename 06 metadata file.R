


# Load libraries ----------------------------------------------------------
require(pacman)
pacman::p_load(geodata, spatialEco, glue, rgeos, gtools, dismo, sf, tidyverse, fs, corrplot)

g <- gc(reset = TRUE)
rm(list = ls())


# Load data ---------------------------------------------------------------
path <- 'G:/CLIMATECHANGE/Modelos'
prds <- c('2030', '2050', '2070')
mdls <- c('FIO-ESM-2-0', 'MPI-ESM1-2-HR', 'MPI-ESM1-2-LR')
ssps <- c('ssp126', 'ssp585')
vars <- c('Precipitacion', 'Tmaxima', 'Tminima')
znes <- c('Arco Seco', 'Caribe Occidental', 'Caribe Oriental', 
          'Pacífico Occidental', 'Pacífico Oriental', 'Región Central')

# Function ----------------------------------------------------------------

prd <- prds[1]
mdl <- mdls[1]
ssp <- ssps[1]

addm <- function(prd, mdl, ssp){
  
  cat(prd, mdl, ssp, '\n', sep = ' ')
  pth <- glue('{path}/{prd}/{mdl}/{ssp}')
  pth
  drs <- glue('{pth}/{vars}')
  
  i <- 1 # Correr y luego borrar
  
  purrr::map(.x = 1:length(drs), .f = function(i){
    
    cat(i, '\n')
    dir <- drs[i]
    dir <- dir_ls(dir)
    dir <- as.character(dir)
  
    j <- 1 # Correr y luego borrar
    
    purrr::map(.x = 1:length(dir), .f = function(j){
      
      cat(j, '\n')
      dr <- dir[j]
      fl <- dir_ls(dr)
      fl
      
      no <- c('.aux.xml', '.var.cpg', '.vat.dbf')
      fl <- fl[-grep(paste0(no, collapse = '|'), fl, value = F)]
      fl <- fl[-grep('vat', fl, value = F)]
      fl <- as.character(fl)
      fl <- fl[-grep('info', fl, value = F)]
      fl <- fl[-grep('prec30_as$', fl, value = F)]
      fl
      
      rs <- terra::rast(fl)
      plot(rs[[1]])
      plot(rs[[14]])
      
      
    })
    
    
    
  })
  
  
}



# G:\CLIMATECHANGE\Modelos\2030\FIO-ESM-2-0\ssp126\Precipitacion


















