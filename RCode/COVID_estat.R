# Source the packages and install whatever we don't have
source("./RCode/GetPackages.R")

#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ MARRIAGES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#
# Get the data from estat
mary<-get_eurostat("tps00206")
# Remove some of the columns that we don't need
mary%<>%dplyr::select(-indic_de,-freq)
# Convert time to year
mary$year<-str_split(mary$TIME_PERIOD,"-",simplify = T)[,1]
# Do some extra filtering, such as removing 'geo' values that are not countries or no longer countries
mary%<>%filter(nchar(geo)==2 & year>2005 & 
                 geo%in%unique(mary$geo[mary$year>2020]))%>%distinct()
# Add the country names from the ISO2 codes
# mary%<>%left_join(rbind(efta_countries,eu_countries,ea_countries,eu_candidate_countries)%>%distinct(),
#                         join_by("geo"=="code"))%>%
#   filter(!is.na(name))%>%dplyr::select(-label,geo)
# Change names
colnames(mary)<-c("ISO2","Date","Vital_Rate","Year")
# Plot marriages
mary%>%ggplot(aes(group=ISO2))+geom_line(aes(Year,Vital_Rate,colour=ISO2))+scale_y_log10()

#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ DEATHS @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#
# Get the data from estat
dery<-get_eurostat("demo_r_deaths")
# Remove some of the columns that we don't need
dery%<>%dplyr::select(-unit,-freq)
# Convert time to year
dery$year<-str_split(dery$TIME_PERIOD,"-",simplify = T)[,1]
# Do some extra filtering, such as removing 'geo' values that are not countries or no longer countries
dery%<>%filter(nchar(geo)==2 & year>2005 & 
                 geo%in%unique(dery$geo[dery$year>2020]))%>%distinct()
# Change names
colnames(dery)<-c("ISO2","Date","Vital_Rate","Year")
# Plot marriages
dery%>%ggplot(aes(group=ISO2))+geom_line(aes(Year,Vital_Rate,colour=ISO2))+scale_y_log10()

#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ BIRTHS @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#
# Get the data from estat
biry<-get_eurostat("demo_r_births")
# Remove some of the columns that we don't need
biry%<>%dplyr::select(-unit,-freq)
# Convert time to year
biry$year<-str_split(biry$TIME_PERIOD,"-",simplify = T)[,1]
# Do some extra filtering, such as removing 'geo' values that are not countries or no longer countries
biry%<>%filter(nchar(geo)==2 & year>2005 & 
                 geo%in%unique(biry$geo[biry$year>2020]))%>%distinct()
# Change names
colnames(biry)<-c("ISO2","Date","Vital_Rate","Year")
# Plot it!
biry%>%ggplot(aes(group=ISO2))+geom_line(aes(Year,Vital_Rate,colour=ISO2))+scale_y_log10()





