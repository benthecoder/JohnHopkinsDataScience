library("data.table")

pollutantmean <- function(directory, pollutant, id = 1:332) {
    
    # Format number with fixed width and then append .csv to number
    fileNames <- paste0(directory, '/', formatC(id, width=3, flag="0"), ".csv" )
    
    # Reading in all files and making a large data.table
    dt <- lapply(fileNames, data.table::fread) %>% rbindlist()
    
    dt %>% summarise_at(c(pollutant), mean, na.rm=TRUE)
}