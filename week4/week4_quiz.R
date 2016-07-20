# Getting and Cleaning Data
# Week 4 quiz
#
# Author:  Matt Turner

# Q1
idaho_housing <- read.csv("ss06hid.csv")
name_data <- names(idaho_housing)
names_split <- strsplit(name_data,"wgtp")
names_split[123]

# Q2
library(data.table)
library(dplyr)
gdp <- data.table(read.csv("GDP.csv",skip=4,nrows=190))
gdp <- select(gdp,X,X.1,X.3,X.4)
setnames(gdp,c("X","X.1","X.3","X.4"),c("CountryCode","Rank","Name","GDP"))
gdp_numeric <- as.numeric(gsub(",","",gdp$GDP))
mean(gdp_numeric)

# Q3
united <- grep("^United",gdp$Name)
length(united)

#Q4
edInfo <- data.table(read.csv("EDSTATS_Country.csv"))
merged_info <- merge(gdp,edInfo,by="CountryCode")
year_end <- grepl("fiscal year end",tolower(merged_info$Special.Notes))
june <- grepl("june",tolower(merged_info$Special.Notes))
table(year_end,june)

# Q5
library(quantmod)
detach(package:data.table)
amzn <- getSymbols("AMZN",auto.assign=FALSE)
sampleTimes <- index(amzn)
year_data <- grepl("2012",ymd(sampleTimes))
month_data <- grepl("Mon",wday(sampleTimes[year_data],label=TRUE))
length(year_data[year_data==TRUE])
length(month_data[month_data==TRUE])
