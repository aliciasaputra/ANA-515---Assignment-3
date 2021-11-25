
#Checking my working directory
getwd()
#Calling my library
library (tidyverse)
#Reading my data frame
mydata <- read_csv("downloads/StormEvents_details.csv")
spec (mydata)
#Limit my dataframe
myvars <- c ("BEGIN_DATE_TIME", "END_DATE_TIME","EPISODE_ID","EVENT_ID","STATE",
             "STATE_FIPS","CZ_NAME","CZ_TYPE","CZ_FIPS","EVENT_TYPE","SOURCE",
             "BEGIN_LAT","BEGIN_LON","END_LAT","END_LON")
newdata <- mydata[myvars]
head (newdata) #to see my new data frame

#converting beginning and ending dates

options(repos = list(CRAN="http://cran.rstudio.com/"))
install.packages("lubridate")
library (lubridate)
#calling my library
library (tidyverse)

mutate(BEGIN_DATE_TIME = dmy_hms(BEGIN_DATE_TIME), END_DATE_TIME= dmy_hms(END_DATE_TIME))

       