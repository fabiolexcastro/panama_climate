
# Load libraries ----------------------------------------------------------
require(pacman)
p_load(lubridate, maptools, TrenchR, tidyverse, glue, fs, sf, readxl)

# To create the dates -----------------------------------------------------
startDate <- as.POSIXct('1990-01-01 0:00', format = '%Y-%m-%d %H')
endDate <- as.POSIXct('2020-12-31 24:00', format = '%Y-%m-%d %H')
Dates <- seq(startDate, endDate, by = 'hour')

# Longitude
lon <- 0.2269

# Prof
date <- Dates[7]
long <- lon

# Function ----------------------------------------------------------------
Radiation <- function(date, long=long_glb, la=lat_glb){
  
  a <- 0.25
  b <- 0.5
  
  d.psx <- as.POSIXct(x = date, format = "%Y-%m-%dT%H:%M:%SZ")
  
  G_sc <- 1367.7
  r_lat <- 0.874831
  #r_lat = la*pi/180.0
  diy  <-  as.numeric(strftime(d.psx, format = "%j"))
  t <- as.numeric(format(x=d.psx, format="%H"))
  noon <- solar_noon(long, diy, 1) # 1 diff time with Greenwich
  delta <- 0.409 * sin( (2 * pi * diy/ 365.0) - 1.39)
  ws <- acos(-tan(r_lat) * tan(delta))
  dr <- 1 + 0.033 * cos(2*pi*diy/365.0)
  R_a <- G_sc * dr * (ws * sin(r_lat) * sin(delta) + cos(r_lat) * cos(delta) * sin(ws))/ pi
  R_a <- max(0.0, R_a)
  sin_e <-  sin(r_lat) * sin(delta) + cos(r_lat) * cos(delta) * cos( 2 * pi * (t - noon) / 24.0)
  R_s <- max(sin_e * R_a, 0.0)
  S_t <- (a + b) * R_s
  return(S_t)
  
}

# Apply the function ------------------------------------------------------
r_sol <- purrr::map(.x = 1:length(Dates), .f = function(i){
  cat(i, '\n')
  rslt <- Radiation(date = Dates[i], long = lon)
  return(rslt)
})

r_sol <- unlist(r_sol)



