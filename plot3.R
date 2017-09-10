# Set the location of the data set for download
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Download the data set
download.file(url, destfile = "eda.zip", method = "curl")

# Unzip the data set
unzip("eda.zip")

# Load the data.table package
if(!require(data.table)){install.packages("data.table")}

# import the data set
hpc <- fread("household_power_consumption.txt", na="?")

# Set the Date variable as key variable
setkey(hpc, Date)

# Filter the household power consumption data
# using the dates 1/2/2007 and 2/2/2007
hpc <- hpc[c('1/2/2007', '2/2/2007')]

# create the datetime variable by combining Date and Time
hpc[,datetime:=as.POSIXct(paste(as.Date(Date, "%d/%m/%Y"), Time))]

# create the plot using the PNG device
png("plot3.png")
with(hpc,
     {plot(datetime, Sub_metering_1, type = "l", xlab = NA, ylab = "Energy sub metering")
     lines(datetime, Sub_metering_2, col = "red")
     lines(datetime, Sub_metering_3, col = "blue")
     legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub metering 1", "Sub metering 2", "Sub metering 3"))}
     )
dev.off()
