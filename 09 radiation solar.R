

require(pacman)
p_load(lubridate, tidyverse, glue, fs, sf, readxl)

# To create the dates


startDate <- as.POSIXct('1990-01-01 0:00', format = '%Y-%m-%d %H')
endDate <- as.POSIXct('2020-12-31 24:00', format = '%Y-%m-%d %H')
seq(as.POSIXct("2015-1-1 0:00"), as.POSIXct("2015-1-1 12:00"), by = "hour")
seq(startDate, endDate, by = 'hour')


Radiation <- function(date, long=long_glb, la=lat_glb, tz=time_zone) {
  
  a <- 0.25
  b <- 0.5
  
  d.psx <- as.POSIXct(x = date, format = "%Y-%m-%dT%H:%M:%SZ")
  
  G_sc <- 1367.7
  r_lat <- 0.874831
  #r_lat = la*pi/180.0
  diy  <-  as.numeric(strftime(d.psx, format = "%j"))
  t <- as.numeric(format(x=d.psx, format="%H"))
  noon <- solarnoon(long=long, doy=diy, tz=tz)
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