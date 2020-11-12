library(data.table)
library(lubridate)

# read in data
dt <- fread("power.txt", na.strings = "?")

# filtering dates
dt <- dt[dt$Date %in% c("1/2/2007", "2/2/2007") , ]

# png graphics device
png("plot1.png", width = 480, height = 480)

# histogram
hist(
    dt$Global_active_power,
    xlab = "Global Active Power (kilowatts)",
    ylab = "frequency",
    main = "Global Active Power",
    col = "Red"
)

dev.off()