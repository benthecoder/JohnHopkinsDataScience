complete <- function(directory, id=1:332) {
    
    # Format number with fixed width and then append .csv to number
    fileNames <- paste0(directory, '/', formatC(id, width=3, flag="0"), ".csv" )

    # Reading in all files and making a large data.table
    df <- lapply(fileNames, data.table::fread) %>% 
        rbindlist()
    
    df %>% 
        dplyr::mutate(complete = complete.cases(df)) %>%
        group_by(ID) %>%
        summarise(nobs=sum(complete.cases(df)), .groups="drop")
}

complete("specdata", 1)