source("complete.R")

corr <- function(directory, threshold=0) {
    lst <- lapply(file.path(directory, list.files(path=directory, pattern=".csv")), data.table::fread)
    
    # bind all files by rows
    dt <- lst %>%
        rbindlist()
    
    dt %>%
        filter(complete.cases(dt)) %>% 
        group_by(ID) %>%
        mutate(nobs=n()) %>%
        filter(nobs > threshold) %>%
        summarise(corr = cor(x=sulfate, y=nitrate), .groups="drop") %>%
        select(corr) %>%
        as.matrix() %>%
        c()
}