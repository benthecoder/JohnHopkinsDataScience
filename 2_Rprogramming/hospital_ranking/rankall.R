rankall <- function(outcome, num = "best") {
    # Read outcome data
    dt <- data.table::fread('data/outcome-of-care-measures.csv')
    
    # change outcome to lowercase
    outcome <- tolower(outcome)
    
    # check if outcome is valid
    if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
        stop('invalid outcome')
    }
    
    # Renaming Columns to be less verbose and lowercase
    setnames(dt, tolower(
        sapply(
            colnames(dt),
            gsub,
            pattern = "^Hospital 30-Day Death \\(Mortality\\) Rates from ",
            replacement = ""
        )
    ))
    
    # Columns indices to keep
    col_indices <-
        grep(paste0("hospital name|state|^", outcome), colnames(dt))
    
    # Filtering out unnecessary data
    dt <- dt[, .SD , .SDcols = col_indices]
    
    
    # Change outcome column class
    dt[, outcome] <-
        dt[, suppressWarnings(as.numeric(get(outcome)))]
    
    if (num == "best") {
        return(dt[order(state, get(outcome), `hospital name`)
                  , .(hospital = head(`hospital name`, 1))
                  , by = state])
    }
    
    if (num == "worst") {
        return(dt[order(state, get(outcome), `hospital name`)
                  , .(hospital = tail(`hospital name`, 1))
                  , by = state])
    }
    
    # this is wrong
    return(dt[order(state, get(outcome), `hospital name`)
              , head(.SD, num)
              , by = state
              , .SDcols = c("hospital name")])
    
}