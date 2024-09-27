# Download the data
PC <- readr::read_csv("https://sdd.spc.int/census-and-survey-calendar/export")
# Remove any data that has not already occurred
PC%<>%filter(Year<=2024)
# Which surveys are we interested in?
survys<-c("Population and Housing Census",
          "Household Income and Expenditure Survey",
          "Multiple indicator cluster survey PLUS",
          # "Labour force survey",
          "Multiple indicator cluster survey",
          # "Agricultural census / survey",
          # "COVID-19 Rapid Assessment Survey",
          "Other Census and Surveys",
          # "Business survey",
          # "Disability survey",
          "Demographic and Health Survey",
          # "Behavioural Risk Factor Surveillance Survey",
          # "Youth Risk Behavioural Surveillance Survey",
          # "Household Listing",
          # "Gender and Environment Survey",
          # "Financial Inclusion Demand Side Survey",
          # "Business Economic Survey",
          "Multiple Indicator Cluster Survey with additional Demographic and Health Survey modules")
# Group all the others into one
PC$`Collection Type`[!PC$`Collection Type`%in%survys]<-"Other Census and Surveys"
# Group all the MICS
PC$`Collection Type`[grepl("multiple",PC$`Collection Type`,ignore.case = T)]<-"Multiple Indicator Cluster Survey"
# Now wrangle into most recent for each survey collection type, per country
PC%<>%filter(`Collection Type`%in%unique(PC$`Collection Type`))%>%
  group_by(Country,`Collection Type`)%>%
  reframe(Year=max(Year))%>%
  pivot_wider(names_from = `Collection Type`, values_from = Year)
# Sort the order out
PC<-PC[,c(1,4,5,6,2,3)]
# Adjust column names
colnames(PC)<-c("Country","Census","MICS","DHS","HIES","Other")
# Just reduce the length of some country names
PC$Country<-str_replace_all(str_replace_all(PC$Country," \\(Republic of\\)","")," \\(CNMI\\)","")
PC$Country[PC$Country=="Federated States of Micronesia"]<-"Micronesia"
# Save out the results
openxlsx::write.xlsx(PC,"./data/Cleaned_PC_CensusSurvey.xlsx")
