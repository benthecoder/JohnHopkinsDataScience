library(data.table)

rankHospital <- function(state, outcome, num="best") {
    # Read outcome data
    dt <- data.table::fread("data/outcome-of-care-measures.csv")
    
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

    if (num == "best") {
        unlist(head(dt[[1]], 1))
    }
    
    else if (num == "worst") {
        unlist(tail(dt[[1]], 1))
    }
    
    else {
        dt %>% 
            slice(num) %>%
            select(hospital_name) %>%
            unlist()
    }
}

# sample outputs

rankHospital("TX", "heart failure", "best")
# 'FORT DUNCAN MEDICAL CENTER'

rankHospital("MD", "heart attack", "worst")
# 'HARFORD MEMORIAL HOSPITAL'

rankHospital("MN", "heart attack", 5000) 
# rank that breaks limit returns nothing