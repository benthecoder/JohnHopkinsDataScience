library(data.table)

# reading data
outcome <- data.table::fread("data/outcome-of-care-measures.csv", colClasses = "character")

# preprocessing data for histogram
histogram_data <- outcome %>% 
    rename(death_rate_30_HA = 11) %>%
    mutate(death_rate_30_HA = suppressWarnings(as.numeric(death_rate_30_HA))) %>%
    select(death_rate_30_HA) %>%
    unlist()
 
png(file="heart-attacks-hist.png")

# plot histogram
hist(histogram_data, 
	main = "Hospital 30-day Death (Mortality) Rates from Heart Attacks",
    xlab = "Deaths", 
    col = "red")

dev.off()