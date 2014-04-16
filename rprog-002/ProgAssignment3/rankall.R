rankall <- function(outcome, num = "best") {
    
    myFunction <- function(outcomes, hospitalNames) {
        if (num == "best") {
            myIndex <- which.min(outcomes)
        } else if (num == "worst") {
            myIndex <- which.max(outcomes)
        } else {
            myIndex <- order(outcomes, hospitalNames, decreasing = FALSE)[num]  
        }
        hospitalNames[myIndex]
    }
    
    VALID_OUTCOMES = c("heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)
    
    ## Read outcome data
    outcomeData <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ## Check that outcome is valid
    if (!any(outcome == names(VALID_OUTCOMES))) {
        stop("invalid outcome")
    }
    
    ## Clean up
    outcomeIndex <- VALID_OUTCOMES[outcome]
    outcomeData[,outcomeIndex] <- as.numeric(outcomeData[,outcomeIndex])
    outcomeData <- outcomeData[!is.na(outcomeData[,outcomeIndex]),]
    
    ## For each state, find the hospital of the given rank
    outcomes <- split(outcomeData[[outcomeIndex]], outcomeData$State)
    hospitalNames <- split(outcomeData$Hospital.Name, outcomeData$State)

    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
    result <- data.frame(mapply(myFunction, outcomes, hospitalNames))
    result$state <- row.names(result)
    names(result) <- c("hospital", "state")
    result
}