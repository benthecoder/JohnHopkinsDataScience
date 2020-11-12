# reading data
outcome <- data.table::fread("data/outcome-of-care-measures.csv", colClasses = "character")

# numeric data
outcome[,11] <- as.numeric(outcome[,11])
                
# create histogram
hist(outcome[,11], main = "Hospital 30-day Death (Mortality) Rates from Heart Attacks",
     xlab = "Deaths", col = "red")

