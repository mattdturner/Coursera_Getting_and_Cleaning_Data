over1mil <- function() {
    # Set the file URL
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
    # Download the file, and save it in idaho_housing.csv
    download.file(url=fileUrl,destfile="idaho_housing.csv",mode="w",method="curl")

    # Store the date downloadted
    dateDownloaded <- date()

    # Load the data
    idahoData <- read.csv("idaho_housing.csv")

    # Count the number of properties worth $1mil or more
    num_properties = length(idahoData$VAL[!is.na(idahoData$VAL) & idahoData$VAL==24])
}