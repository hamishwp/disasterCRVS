# Source the packages and install whatever we don't have
source("./RCode/GetPackages.R")

#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ MARRIAGES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#
# Get the data from estat
mary<-get_eurostat("tps00206")
# Convert time to year
mary$year<-year(mary$TIME_PERIOD)
# Remove some of the columns that we don't need
mary%<>%dplyr::select(-indic_de,-freq,-TIME_PERIOD)
# Get AUS data - population
auspop<-readr::read_csv("https://datahub.io/core/population/r/population.csv")%>%
  filter(`Country Code`=="AUS" & Year==(year(Sys.Date())-4))%>%pull(Value)
# now marriages
aus<-read.csv("./data/AUS_marriages.csv",sep = ",")%>%dplyr::select(-Country)%>%
  mutate(values=1000*values/auspop)%>%
  filter(year>=min(mary$year,na.rm = T))
# Merge with AUS data
mary%<>%rbind(aus)
# Do some extra filtering, such as removing 'geo' values that are not countries or no longer countries
mary%<>%filter(nchar(geo)==2 & year>2000 & 
                 geo%in%unique(mary$geo[mary$year>2020]))%>%distinct()%>%
  mutate(year=as.integer(year))
# Add the country names from the ISO2 codes
# mary%<>%left_join(rbind(efta_countries,eu_countries,ea_countries,eu_candidate_countries)%>%distinct(),
#                         join_by("geo"=="code"))%>%
#   filter(!is.na(name))%>%dplyr::select(-label,geo)
# Change names
colnames(mary)<-c("ISO2","Vital_Rate","Year")
# Plot marriages
p<-mary%>%filter(Year<=2022)%>%
  ggplot(aes(group=ISO2))+
  geom_line(aes(as.factor(Year),Vital_Rate,colour=ISO2))+
  scale_y_log10()+ylab("Crude Marriage Rate")+xlab("Year")+labs(colour="Country ISO2")
# Save the figure
ggsave("CrudeMarriageRate_Year.png", plot=p,path = 'Plots/',width = 8,height = 5)
# Add country to the dataframe
mary%<>%mutate(Country=convIso3Country(convIso2Iso3(ISO2))); mary$Country[mary$geo=="EL"]<-"Greece"; mary$Country[mary$geo=="UK"]<-"United Kingdom"
# Now to calculate the outlier probability. First add mean and sd
mary%<>%left_join(mary%>%filter(Year<2021)%>%
                    group_by(ISO2)%>%
                    reframe(mean_bl=mean(Vital_Rate,na.rm=T),
                            sd_bl=sd(Vital_Rate,na.rm=T)),
                  by=c("ISO2"))
mary%<>%mutate(Norm=0.5-abs(0.5-pnorm(Vital_Rate, mean=mean_bl,sd=sd_bl,lower.tail = F)),
               Severity=-log(Norm))%>%
  filter(Norm<0.05)%>%
  dplyr::select(Country,Year,Vital_Rate,Severity)
# Now let's plot that!
write.csv(mary%>%mutate(across(where(is.numeric), ~ round(., 2))),
           "./data/COVID_outlierISOs.csv", row.names = FALSE)

#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ DEATHS @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#
# Get the data from estat
# dery<-get_eurostat("demo_r_deaths")
dery<-get_eurostat("demo_r_mwk_ts")
# Add the country names
dery$Country<-convIso3Country(convIso2Iso3(dery$geo)); dery$Country[dery$geo=="EL"]<-"Greece"; dery$Country[dery$geo=="UK"]<-"United Kingdom"
# Remove some of the columns that we don't need
dery%<>%dplyr::select(-unit,-freq)
# Convert time to year
dery$year<-year(dery$TIME_PERIOD)
# Do some extra filtering, such as removing 'geo' values that are not countries or no longer countries
dery%<>%filter(nchar(geo)==2 & 
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
biry$year<-year(biry$TIME_PERIOD)
# Do some extra filtering, such as removing 'geo' values that are not countries or no longer countries
biry%<>%filter(nchar(geo)==2 & year>2005 & 
                 geo%in%unique(biry$geo[biry$year>2020]))%>%distinct()
# Change names
colnames(biry)<-c("ISO2","Date","Vital_Rate","Year")
# Plot it!
biry%>%ggplot(aes(group=ISO2))+geom_line(aes(Year,Vital_Rate,colour=ISO2))+scale_y_log10()





