# Set the location of the data set for download
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Download and unzip the data set if it is not
# yet downloaded
if(!file.exists("exdata.zip")){
  download.file(url, destfile = "exdata.zip", method = "curl")
  unzip("exdata.zip")
}

# Load the data.table package
if(!require(data.table)){install.packages("data.table")}

# import the data set
hpc <- fread("household_power_consumption.txt", na="?")

# Set the Date variable as key variable
setkey(hpc, Date)

# Filter the household power consumption data
# using the dates 1/2/2007 and 2/2/2007
hpc <- hpc[c('1/2/2007', '2/2/2007')]

# create the plot using the PNG device
png("plot2.png")
with(hpc, 
     plot(datetime, Global_active_power, 
          type = "l",
          xlab = NA,
          ylab = "Global Active Power (kilowatts)"
          )
     )
dev.off()
