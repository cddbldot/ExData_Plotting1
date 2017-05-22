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

# initialize PNG-device for four plots in a 2x2 matrix
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2), mar = c(4, 4, 3, 2), oma = c(0, 0, 0, 0))

###
### top left plot
###

# line graph without x axis label and modified y axis as in plot2.R
plot(consumption$Time, consumption$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power")


###
### top right plot
###

# line graph with modified x and y axis labels
plot(consumption$Time, consumption$Voltage, type = "l",
     xlab = "datetime", ylab = "Voltage")


###
### bottom left plot
###

# line graph as in plot3.R withoug box around the legend
plot(consumption$Time, consumption$Sub_metering_1, type = "l",
     xlab = "", ylab = "Energy sub metering")
lines(consumption$Time, consumption$Sub_metering_2, col = "red")
lines(consumption$Time, consumption$Sub_metering_3, col = "blue")
legend("topright", lwd = 1, col = c("black", "red", "blue"), bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


###
### bottom right plot
###

# line graph with modified x and y axis labels
plot(consumption$Time, consumption$Global_reactive_power, type = "l",
     xlab = "datetime", ylab = "Global_reactive_power")


# close PNG-device
dev.off()

