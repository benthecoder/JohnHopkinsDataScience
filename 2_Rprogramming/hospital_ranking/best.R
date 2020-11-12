library(data.table)

best <- function(state, outcome) {
    # Read outcome data
    dt <- data.table::fread("data/outcome-of-care-measures.csv")
    
    # change outcome to lowercase
    outcome <- tolower(outcome)
    
    # change variable name to prevent confusion
    chosen_state <- state
    
    # Check state and outcome are valid
    if (!chosen_state %in% unique(dt[["State"]])) {
        stop("Invalid state")
    }
    if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
        stop("Invalid outcome")
    }
    
    # simplify and lower case column names similar to outcome variable
    setnames(dt, tolower(
        sapply(
            colnames(dt),
            gsub,
            pattern = "^Hospital 30-Day Death \\(Mortality\\) Rates from ",
            replacement = ""
        )
    ))
    
    # filtering state
    dt <- dt[state == chosen_state]
    
    # grab all columns with patterns hospital name, state and given outcome
    col_indices <-
        grep(paste0("hospital name|state|^", outcome), colnames(dt))
    
    # use .SD to filter out unnecessary columns
    dt <- dt[, .SD, .SDcols = col_indices]
    
    # change class of outcome to numeric
    dt[, outcome] <- dt[, suppressWarnings(as.numeric(get(outcome)))]
    
    # remove all NAs
    dt <- dt[complete.cases(dt), ]
    
    # order outcome and hospital name alphabetically
    dt <- dt[order(get(outcome), `hospital name`)]
    
    # return lowest mortality rate as data table
    return(dt[, "hospital name"][1]) 
    # dt[1, `hospital name`] returns string of best hospital
}
