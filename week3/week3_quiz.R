# Getting and cleaning data
# Week 3 quiz
#
# by:
#    Matthew Turner

# Q1
acs <- read.csv("acs2006.csv")
## Set index numbers
#ACR = 11 # acreage.  value of 3 = 10+ acres
#AGS = 12  # agricuulture product sold.  value of 6 = $10000+

agricultureLocal <- acs$ACR == 3 & acs$AGS == 6
which(agricultureLocal)[1:3]


# Q2
# Load the jpeg library
library(jpeg)
img <- readJPEG("question2.jpg",native=TRUE)
quantile(img,probs=c(.3,.8))


# Q3
library(data.table)
library(dplyr)
gdp <- data.table(read.csv("GDP.csv",skip=4,nrows=190))
gdp <- select(gdp,X,X.1,X.3,X.4)
setnames(gdp,c("X","X.1","X.3","X.4"),c("CountryCode","Rank","Name","GDP"))
edInfo <- data.table(read.csv("EDSTATS_Country.csv"))
merged_info <- merge(gdp,edInfo,by="CountryCode")
nrow(merged_info)
sorted_data <- arrange(merged_info,desc(Rank))
sorted_data$Name[13]

# Q4
tapply(merged_info$Rank,merged_info$Income.Group,mean)

# Q5
library(Hmisc)
merged_info$RankGroups <- cut2(merged_info$Rank,g=5)
table(merged_info$RankGroups,merged_info$Income.Group)
