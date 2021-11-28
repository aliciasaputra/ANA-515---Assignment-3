
#Checking my working directory
getwd()
#Calling my library
library (tidyverse)
#Reading my data frame
mydata <- read_csv("downloads/StormEvents_details.csv")
show_col_types = FALSE
spec (mydata)
#Limit my dataframe
myvars <- c ("BEGIN_DATE_TIME", "END_DATE_TIME","EPISODE_ID","EVENT_ID","STATE",
             "STATE_FIPS","CZ_NAME","CZ_TYPE","CZ_FIPS","EVENT_TYPE","SOURCE",
             "BEGIN_LAT","BEGIN_LON","END_LAT","END_LON")
newdata <- mydata[myvars]
head (newdata) #to see my new data frame

#converting beginning and ending dates

#calling my library

options(repos = list(CRAN="http://cran.rstudio.com/"))
install.packages("lubridate")
library (lubridate)
library (tidyverse)

#convert the beginning and ending dates
newdata1<-mutate(newdata, BEGIN_DATE_TIME = dmy_hms(newdata$BEGIN_DATE_TIME), 
                 END_DATE_TIME= dmy_hms(newdata$END_DATE_TIME))
head (newdata1)

#Change state to title case
newdata$STATE=str_to_title(newdata$STATE)
head (newdata)

#Change county to title case
newdata$CZ_NAME=str_to_title(newdata$CZ_NAME)
head (newdata)

#limit the events listed by county
newdata=filter(newdata,CZ_TYPE == "C")
head (newdata)

#remove CZ Type column
newdata %>% select(-CZ_TYPE)
head(newdata)

#Pad the state and county FIPS with a “0” at the beginning
newdata$STATE_FIPS=str_pad(newdata$STATE_FIPS, width=3, side = "left", pad="0")
head (newdata)

newdata$CZ_FIPS=str_pad(newdata$CZ_FIPS, width=3, side = "left", pad="0")
head(newdata)

#unite two columns
library(dplyr)
unite (newdata, "FIPS", "STATE_FIPS","CZ_FIPS")

#change all column names to lower case
rename_all(newdata,tolower)

#get the dataset that lives in R
data ("state")
us_state_info<-data.frame(state=state.name, region=state.region, area=state.area)
head (us_state_info)

#Create a dataframe
table (us_state_info$columnname)
newset <-data.frame (us_state_info$columnname)
head (newset)

newset1<-rename(newset, c("state"="Var1"))
merged <- merge(x=newset1,y=us_state_info,by.x="state", by.y="state")

newdatasetname<-(mutate_all(newset, toupper))
head (newdatasetname)

#Plotting my graph
library(ggplot2)

storm_plot <- ggplot(merged,aes(x = area , y = Freq)) + geom_point(aes(color=region)) + labs(x="Land Area (square miles)",y = "# of storms events in 1999")

storm_plot






       