library(dplyr)
library(ggplot2)

NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")

balt_type <- NEI %>% select(type, fips, Emissions, year) %>%
    filter(fips == '24510')

g3 <- ggplot(balt_type, aes(factor(year), Emissions), fill = type)
g3 + geom_bar(stat = "identity") +
    theme_bw(base_family = "Helvetica") +
    facet_wrap(. ~ type, nrow = 2, ncol = 2) +
    labs(x = "Years",
         y = "Total Emissions",
         title = "Total Emissions in Baltimore City by Source types") +
    ggsave("plot3.png", width = 30, height = 30, units = "cm")