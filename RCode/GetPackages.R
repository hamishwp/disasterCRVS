# Allows you the possibility to choose the repository location
directory<-"./"
# We love this
options(stringsAsFactors = FALSE)
# Create the data directory
dir.create("./data",showWarnings = F)

GetSourceFiles<-function(packred){
  
  #@@@@@ SOURCE FILES @@@@@#
  # Basic functions:
  source(paste0(directory,'RCode/Functions.R'))
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
  
  list.of.packages <- c("dplyr", "ggplot2","tidyverse","openxlsx","pracma",
                        "RColorBrewer","reshape2","ggthemes","countrycode",
                        "openxlsx","eurostat","readr","openxlsx")
  
  new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
  if(length(new.packages)>0) install.packages(new.packages, repos='http://cran.us.r-project.org')
  
  LoadLibraries(packred)
  GetSourceFiles(packred)
  
}

GetPackages(packred=T)