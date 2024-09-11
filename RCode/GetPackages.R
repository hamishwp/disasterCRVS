# Allows you the possibility to choose the repository location
directory<-"./"
# We love this
options(stringsAsFactors = FALSE)

GetSourceFiles<-function(packred){
  
  #@@@@@ SOURCE FILES @@@@@#
  # Basic functions:
  source(paste0(directory,'RCode/Setup/Functions.R'))
}

LoadLibraries<-function(packred){
  
  library(dplyr)
  library(magrittr)
  library(tidyverse)
  library(ggplot2)
  library(sp)
  library(sf)
  library(ggmap)
  library(geojsonR)
  library(countrycode)
  library(stringr)
  library(pracma)
  library(parallel)
  library(gstat)
  library(raster)
  library(geosphere)
  library(terra)
  library(rworldmap)
  library(rworldxtra)
  library(eurostat)
  
}

GetPackages<-function(packred){
  
  list.of.packages <- c("dplyr", "ggplot2","sf","tidyverse","openxlsx","pracma",
                        "geojsonR", "gstat", "rgdal", "RColorBrewer","reshape2",
                        "ggthemes","countrycode","rworldmap","rworldxtra","chron",
                        "openxlsx","rJava","eurostat","OpenStreetMap","osmdata")
  
  new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
  if(length(new.packages)>0) install.packages(new.packages, repos='http://cran.us.r-project.org')
  
  LoadLibraries(packred)
  GetSourceFiles(packred)
  
}

GetPackages(packred=T)