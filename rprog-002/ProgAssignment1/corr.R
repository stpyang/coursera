corr <- function(directory, threshold = 0) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0
    
    ## Return a numeric vector of correlations
        
    myReadCsv <- function(i) {
        fileName <- sprintf("%03d.csv", i)
        fileName <- paste(directory, "/", fileName, sep="")
        read.csv(fileName)        
    }
    
    myCorr <- function(i) {
        temp <- myReadCsv(i)
        good <- complete.cases(temp$sulfate, temp$nitrate)
        if (sum(good) > threshold) {
            temp <- temp[good,]
            cor(temp$sulfate, temp$nitrate)
        } else {
            NA
        }
    }
    
    numFiles <- 332
    result <- sapply(1:numFiles, myCorr)
    result[!is.na(result)]
}