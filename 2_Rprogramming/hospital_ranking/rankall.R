library(data.table)

rankAll <- function(outcome, num = "best") {
    # Read outcome data
    dt <- data.table::fread("data/outcome-of-care-measures.csv")
    
    # change outcome to lowercase
    outcome <- tolower(outcome)
    
    # check if outcome is valid
    if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
        stop('invalid outcome')
    }
    
    dt <- dt %>% 
        rename_with(~ tolower(gsub("^Hospital 30-Day Death \\(Mortality\\) Rates from ", "", .x))) %>%
        mutate(rate = suppressWarnings(as.numeric(get(outcome)))) %>%
        clean_names() %>%
        select(hospital_name, state, rate) %>%
        filter(complete.cases(.)) %>%
        group_by(state) %>%
        arrange(rate, hospital_name, .by_groups=TRUE) %>% 
        arrange(state) %>%
        mutate(rank = row_number()) 
    
    if (num == "best") {
        dt %>% 
            filter(rank == 1) %>%
            select(hospital_name, state)
    }
    
    else if (num == "worst") {
        dt %>%
            group_by(state) %>%
            filter(rank == max(rank)) %>%
            select(hospital_name, state)
    }
    
    else {
        dt %>%
            group_by(state) %>%
            filter(rank == num) %>%
            select(hospital_name, state)
    }
}

## sample outputs

head(rankAll("heart attack", 20), 5)

##                             hospital state
##       D W MCMILLAN MEMORIAL HOSPITAL    AL
##    ARKANSAS METHODIST MEDICAL CENTER    AR
##  JOHN C LINCOLN DEER VALLEY HOSPITAL    AZ
##                SHERMAN OAKS HOSPITAL    CA
##             SKY RIDGE MEDICAL CENTER    CO

tail(rankAll("pneumonia", "worst"), 3)

##                                   hospital state
## MAYO CLINIC HEALTH SYSTEM - NORTHLAND, INC    WI
##                     PLATEAU MEDICAL CENTER    WV
##           NORTH BIG HORN HOSPITAL DISTRICT    WY

tail(rankAll("heart failure"), 10)

##                                                     hospital_name state
##                         WELLMONT HAWKINS COUNTY MEMORIAL HOSPITAL    TN
##                                        FORT DUNCAN MEDICAL CENTER    TX
## VA SALT LAKE CITY HEALTHCARE - GEORGE E. WAHLEN VA MEDICAL CENTER    UT
##                                          SENTARA POTOMAC HOSPITAL    VA
##                            GOV JUAN F LUIS HOSPITAL & MEDICAL CTR    VI
##                                              SPRINGFIELD HOSPITAL    VT
##                                         HARBORVIEW MEDICAL CENTER    WA
##                                    AURORA ST LUKES MEDICAL CENTER    WI
##                                         FAIRMONT GENERAL HOSPITAL    WV
##                                        CHEYENNE VA MEDICAL CENTER    WY