
## Plot3.R

library(data.table)
library(tidyr)
library(dplyr)

# Read the data
# the Date is converted to a date object. after loading the table is filterd to get the two day subset.
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )
hpc <- data.table(read.table("./household_power_consumption.txt",sep =";", na.strings="?",colClasses=c("myDate", "character" ,rep("numeric",7)), header= TRUE)) %>%
  filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

# create a time list 
timeList <- strptime( paste(format(hpc$Date, "%y/%m/%d"), hpc$Time), "%y/%m/%d %H:%M:%S")
leg.txt <- c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3")
leg.col <- c("black", "red", "blue")

# Create the plot
png(file = "plot3.png", width=480, height=480)
plot( timeList , hpc$Sub_metering_1, type="n", xlab ="", ylab="Global Active Power (kilowatts")
lines(timeList , hpc$Sub_metering_1, col="black")
lines(timeList , hpc$Sub_metering_2, col="red")
lines(timeList , hpc$Sub_metering_3, col="blue")
legend("topright",leg.txt, col= leg.col, lty = c(1, 1, 1))
dev.off()