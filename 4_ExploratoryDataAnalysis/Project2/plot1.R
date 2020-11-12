library(dplyr)

NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")

# data tidying for plot
total <- NEI %>% select(Emissions, year) %>%
    group_by(year) %>%
    mutate(year = factor(year)) %>%
    summarize(total_em = sum(Emissions))

png(filename = "plot1.png")

# create bar plot with base R
with(
    total,
    barplot(
        total_em,
        names = year,
        xlab = "Years",
        ylab = "Emissions",
        main = "Emissions over the years"
    )
)

dev.off()