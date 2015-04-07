
## Plot4.R

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

#start plotting to a png device
png(file = "plot4.png", width=480, height=480)

# define the number of plots per row and colum.
par(mfrow = c(2,2))

#
# left top plot
#
plot( timeList , hpc$Global_active_power, type="n", xlab ="", ylab="Global Active Power")
lines( timeList , hpc$Global_active_power)

#
# right top plot
#
plot( timeList , hpc$Voltage, type="n", xlab ="datetime", ylab="Voltage")
lines( timeList , hpc$Voltage)

#
#left bottom plot
# 
leg.txt <- c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3")
leg.col <- c("black", "red", "blue")

# Create the plot
 
plot( timeList , hpc$Sub_metering_1, type="n", xlab ="", ylab="Global Active Power (kilowatts")
lines(timeList , hpc$Sub_metering_1, col="black")
lines(timeList , hpc$Sub_metering_2, col="red")
lines(timeList , hpc$Sub_metering_3, col="blue")
legend("topright",leg.txt, col= leg.col, lty = c(1, 1, 1), bty="n")


#
# right bottom plot
#

plot( timeList , hpc$Global_reactive_power, type="n", xlab="datetime", ylab="Global_reactive_power")
lines( timeList , hpc$Global_reactive_power)


#close the ploting to the png device
dev.off()