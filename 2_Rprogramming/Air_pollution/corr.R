source("complete.R")

corr <- function(directory, threshold=0) {
    lst <- lapply(file.path(directory, list.files(path=directory, pattern=".csv")), data.table::fread)
    
    # bind all files by rows
    dt <- rbindlist(lst)
    
    # filtering out data tables with na values
    dt <- dt[complete.cases(dt)]
    
    dt <- dt[, .(nobs=.N, corr=cor(x=sulfate, y=nitrate)), by=ID][nobs > threshold]
    return(dt[,corr])
}