


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
      fl <- mixedsort(fl)
      
      rs <- purrr::map(.x = fl, .f = terra::rast)
      plot(rs[[1]])
      plot(rs[[14]])
      
      
      # To create the metadata file
      mtdt <- list()
      tmpr <- c('Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic', 'Temporada 1', 'Temporada 2', 'Temporada 3', 'Temporada 4')
      
      for(i in 1:length(tmpr)){
        
        mtdt[[i]] <- list(
            feat = list(
              
              modelo_ssp <- ssp,
              periodo <- pr,
              modelo_gcm <- mdl
              
              
            ),
            
            fuente = 'CMIP6 - Worldclim', 
            webservice = 'worldclim.org',
            tiempo = tmpr[[i]]
            
          )
        
      }
      

      
      
      
      metadata(rs[[1]])
      
      
      
      
    })
    
    
    
  })
  
  
}



# G:\CLIMATECHANGE\Modelos\2030\FIO-ESM-2-0\ssp126\Precipitacion


















