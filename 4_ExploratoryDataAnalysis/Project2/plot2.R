library(dplyr)

NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")

balt <- NEI %>% select(fips, Emissions, year) %>%
    filter(fips == '24510') %>%
    group_by(year) %>%
    mutate(year = factor(year)) %>%
    summarize(total_em = sum(Emissions))

png(filename = "plot2.png")

with(
    balt,
    barplot(
        total_em,
        names = year,
        xlab = "Years",
        ylab = "Emissions",
        main = "Total Emissions in Baltimore City from 1999 to 2008"
    )
)

dev.off()