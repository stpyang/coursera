best <- function(state, outcome) {

    VALID_OUTCOMES <- c("heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)
    
    ## Read outcome data
    outcomeData <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
 
    ## Check that state and outcome are valid
    if (!any(state==outcomeData$State)) {
        stop("invalid state")
    }
    if (!any(outcome == names(VALID_OUTCOMES))) {
        stop("invalid outcome")
    }

    ## Clean up
    stateData <- outcomeData[outcomeData$State == state,]
    hospitalNames <- stateData$Hospital.Name
    outcomes <- as.numeric(stateData[[ VALID_OUTCOMES[outcome] ]])
    temp <- data.frame(hospitalNames, outcomes)
    temp <- temp[!is.na(temp[,2]),]

    ## Return hospital name in that state with lowest 30-day death rate
    myIndex <- which.min(temp[,2])
    as.character(temp[myIndex,1])
}
