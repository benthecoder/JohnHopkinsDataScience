library(dplyr)
library(ggplot2)
library(stringr)

NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

SCC_coal_comb <- SCC %>%
    filter(str_detect(SCC.Level.One, "[Cc]omb")) %>%
    filter(str_detect(SCC.Level.Three, "[Cc]oal")) %>%
    filter(str_detect(SCC.Level.Four, "[Cc]oal"))
NEI_coal_comb <- filter(NEI, SCC %in% SCC_coal_comb$SCC)

g4 <- ggplot(NEI_coal_comb, aes(factor(year), Emissions))
g4 + geom_bar(stat = "identity") +
    theme_bw(base_family = "Helvetica") +
    labs(x = "Years", y = "Total Emissions", 
         title = "Coal Combustion Source emissions across US from 1999 to 2008") +
    ggsave("plot4.png", width = 30, height = 30, units = "cm")