# Coursera Getting and Cleaning Data
# Week 2 quiz
# By: necktweaker

setwd('/Users/matthewturner/Desktop/School/Coursera/Getting_And_Cleaning_Data/')

##
## Question 1
##
# Ensure that the 'httr' library is loaded
library(httr)
oauth_endpoints('github')
myapp <- oauth_app("github",
                   key = "aadfd2f73be7af39be86",
                   secret = "7ea5bb950dd448f1ee291597b8464ac54ea21b49")

# Get oauth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"),myapp)

# Use the api
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/rate_limit", gtoken)
stop_for_status(req)

BROWSE("https://api.github.com/users/jtleek/repos",authenticate("Access Token","x-oauth-basic","basic"))

##
## Question 2
##
# Load the sqldf library
install.packages("sqldf")
library(sqldf)

# Read the csv file
acs <- read.csv(file="getdata_data_ss06pid.csv",header=TRUE,sep=',')
head(acs)
sqldf("select pwgtp1 from acs where AGEP < 50",drv="SQLite")

##
## Question 3
##
length(unique(acs$AGEP))
sqldf("select distinct AGEP from acs",drv="SQLite")

##
## Question 4
##
url_address <- "http://biostat.jhsph.edu/~jleek/contact.html"
con <- url(url_address)
htmlCode <- readLines(con)
close(con)
sapply(htmlCode[c(10,20,30,100)],nchar)

##
## Question 5
##
data <- read.fwf(file="getdata_wksst8110.for",widths=c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4), skip=4)
head(data)
sum(data[,4])
