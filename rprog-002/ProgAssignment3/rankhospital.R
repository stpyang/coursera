rankhospital <- function(state, outcome, num = "best") {

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
    
    VALID_OUTCOMES <- c("heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)
    
    ## Read outcome data
    outcomeData <- read.csv("outcome-of-care-measures.csv", 
                            colClasses = "character")
    
    ## Check that state and outcome are valid
    if (!any(state==outcomeData$State)) {
        stop("invalid state")
    }
    if (!any(outcome == names(VALID_OUTCOMES))) {
        stop("invalid outcome")
    }

    ## Clean up
    outcomeIndex <- VALID_OUTCOMES[outcome]
    stateData <- outcomeData[outcomeData$State == state,]
    stateData[,outcomeIndex] <- as.numeric(stateData[,outcomeIndex])
    stateData <- stateData[!is.na(stateData[,outcomeIndex]),]

    ## Return hospital name in that state with the given rank 30-day death rate
    
    myFunction(stateData[outcomeIndex],
               stateData$Hospital.Name,
               num)    
}