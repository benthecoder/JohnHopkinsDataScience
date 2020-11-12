library(dplyr)
library(ggplot2)
library(stringr)

NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

vehicleSCC <- filter(SCC, str_detect(SCC.Level.Two, "[Vv]ehicle"))
vehicleNEI <- filter(NEI, SCC %in% vehicleSCC$SCC)

balt_la <- vehicleNEI %>% filter(fips %in% c("24510", "06037"))

facet_labels <- as_labeller(c(`24510` = "Baltimore City", `06037` = "Los Angeles County"))

g6 <- ggplot(balt_la, aes(factor(year), Emissions), fill = fips)
g6 + geom_bar(stat = "identity") +
    theme_bw(base_family = "Helvetica") +
    facet_grid(. ~ fips, labeller = facet_labels) +
    labs(x = "Years", y = "Total emissions", 
         title = "Motor Vehicle Emissions between Baltimore & LA County from 1999 to 2008") +
    ggsave("plot6.png", width = 30, height = 30, units = "cm")