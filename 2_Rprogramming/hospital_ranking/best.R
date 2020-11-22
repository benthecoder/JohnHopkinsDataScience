library(data.table)

best <- function(state, outcome) {
    # Read outcome data
    dt <- data.table::fread("./outcome-of-care-measures.csv")
    
    # change outcome to lowercase
    outcome <- tolower(outcome)
    
    # change variable name to prevent confusion
    chosen_state <- state

    # Check state and outcome are valid, if not return warning message
    if (!chosen_state %in% unique(dt[["State"]])) {
        stop("Invalid state")
    }
    
    if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
        stop("Invalid outcome")
    }

    dt <- dt %>% 
        rename_with(~ tolower(gsub("^Hospital 30-Day Death \\(Mortality\\) Rates from ", "", .x))) %>%
        filter(state == chosen_state) %>%
        mutate(rate = suppressWarnings(as.numeric(get(outcome)))) %>%
        clean_names() %>%
        select(hospital_name, state, rate) %>%
        filter(complete.cases(.)) %>%
        arrange(rate, hospital_name) %>%
        mutate(rank = row_number())  
    
    unlist(dt[1,1])
}

# sample outputs

best("TX", "heart attack")
# hospital name: 'CYPRESS FAIRBANKS MEDICAL CENTER'

best("MD", "pneumonia")
# hospital name: 'GREATER BALTIMORE MEDICAL CENTER'