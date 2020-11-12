library(data.table)
library(lubridate)

# read in data
dt <- fread("power.txt", na.strings = "?")

# filtering dates
dt <- dt[dt$Date %in% c("1/2/2007", "2/2/2007") ,]

# converting date column to date time
dateTime <- dmy_hms(paste(dt$Date, dt$Time, sep = " "), tz = "UTC")

png("plot2.png", width = 480, height = 480)

# plot
plot(
    dateTime,
    dt$Global_active_power,
    type = "l",
    xlab = "",
    ylab = "Global Active Power (kilowatts)"
)

dev.off()