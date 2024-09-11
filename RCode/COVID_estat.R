# Source the packages and install whatever we don't have
source("./RCode/GetPackages.R")
# Get the data from estat
mary<-eurostat::get_eurostat("tps00206")
# Remove some of the columns that we don't need
mary%<>%dplyr::select(-indic_de,-freq)
# Convert time to year
mary$year<-str_split(mary$TIME_PERIOD,"-",simplify = T)[,1]
# Do some extra filtering, such as removing 'geo' values that are not countries or no longer countries
mary%<>%filter(nchar(geo)==2 & year>2005 & 
                 geo%in%unique(mary$geo[mary$year>2020]))%>%distinct()
# Plot marriages
mary%>%ggplot()+geom_line(aes(year,OBS_VALUE,colour=geo))+scale_y_log10()