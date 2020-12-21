complete <- function(directory, id=1:332) {
    
    # Format number with fixed width and then append .csv to number
    fileNames <- paste0(directory, '/', formatC(id, width=3, flag="0"), ".csv" )
    
    # Reading in all files and making a large data.table
    df <- lapply(fileNames, data.table::fread) %>% 
        rbindlist()
    
    df %>% 
        filter(complete.cases(df)) %>%
        group_by(ID) %>%
        summarise(nobs=n(), .groups="drop")
}

# complete("specdata", 1)