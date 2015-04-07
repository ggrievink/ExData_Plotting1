
## plot1.R

library(data.table)
library(tidyr)
library(dplyr)

# Read the data
# the Date is converted to a date object. after loading the table is filterd to get the two day subset.
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )
hpc <- data.table(read.table("./household_power_consumption.txt",sep =";", na.strings="?",colClasses=c("myDate", "character" ,rep("numeric",7)), header= TRUE)) %>%
       filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

# Create the plot
png(file = "plot1.png", width=480, height=480)
hist(hpc$Global_active_power, main="Global Active Power", col="red", xlab="Global Active Power (kilowatts)")
dev.off()