library(dplyr)
library(ggplot2)
library(stringr)

NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

vehicleSCC <- filter(SCC, str_detect(SCC.Level.Two, "[Vv]ehicle"))
vehicleNEI <- filter(NEI, SCC %in% vehicleSCC$SCC)

balt_vehicleNEI <- filter(vehicleNEI, fips=="24510")

g5 <- ggplot(balt_vehicleNEI, aes(factor(year), Emissions))
g5 + geom_bar(stat="identity") +
    theme_bw(base_family = "Helvetica") +
    labs(x="Years", y="Total emissions", 
         title="Motor Vehicle Sources Emissions in Baltimore from 1999 to 2008") + 
    ggsave("plot5.png", width = 30, height = 30, units = "cm")