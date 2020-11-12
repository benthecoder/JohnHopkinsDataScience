complete <- function(directory, id=1:332) {
    files <- list.files(directory, pattern = ".csv", full.name=TRUE)
    # empty vector to store files
    df <- complete
    df %>% 
        mutate(complete = complete.cases(df)) %>%
        group_by(id) %>%
        summarise(complete=sum(complete.cases(df)))
}