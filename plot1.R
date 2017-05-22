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
png("plot1.png", width = 480, height = 480)

# red histogram with altered header and label for x axis
hist(consumption$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

# close PNG-device
dev.off()
