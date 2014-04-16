complete <- function(directory, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return a data frame of the form:
    ## id nobs
    ## 1  117
    ## 2  1041
    ## ...
    ## where 'id' is the monitor ID number and 'nobs' is the
    ## number of complete cases
    
    myReadCsv <- function(i) {
        fileName <- sprintf("%03d.csv", i)
        fileName <- paste(directory, "/", fileName, sep="")
        read.csv(fileName)        
    }
    
    myFunction <- function(i) {
        temp <- myReadCsv(i)
        good <- complete.cases(temp$sulfate, temp$nitrate)
        sum(good)
    }
    
    data.frame(id, nobs = sapply(id, myFunction))
}