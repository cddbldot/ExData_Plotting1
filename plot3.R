library(data.table)
library(lubridate)

# read data and subset to relevant dates
consumption <- fread("household_power_consumption.txt", na.strings = "?")
consumption <- subset(consumption,
                      consumption$Date %in% c("1/2/2007", "2/2/2007"))

# change types of Date and Time
consumption[, Date := dmy(Date)]
consumption[, DateTime := strptime(paste(Date, Time),
                                   format = "%Y-%m-%d %H:%M:%S")]

# initialize PNG-device
png("plot3.png", width = 480, height = 480)

# line graph without x axis label and modified y axis
plot(consumption$Time, consumption$Sub_metering_1, type = "l",
     xlab = "", ylab = "Energy sub metering")

# add submetering 2 in red color
lines(consumption$Time, consumption$Sub_metering_2, col = "red")

# add submetering 3 in blue color
lines(consumption$Time, consumption$Sub_metering_3, col = "blue")

# add the legend
legend("topright", lwd = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# close PNG-device
dev.off()
