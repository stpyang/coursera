## Return getters and setters for matrix and inverse
makeCacheMatrix <- function(x = matrix()) {
    ## store the inverse here
    i <- NULL
    
    ## setter for the data
    set <- function(y) {
        x <<- y
        i <<- NULL
    }
    
    ## getter for the data
    get <- function() x
    
    ## setter for the inverse
    setinv <- function(inv) i <<- inv

    ## getter for the inverse
    getinv <- function() i
    
    ## return stuff
    list(set = set, get = get,
         setinv = setinv,
         getinv = getinv)    
}


## Return a matrix that is the inverse of 'x'
cacheSolve <- function(x, ...) {
    i <- x$getinv()
    
    ## the inverse is cached so return the precomputed value
    if(!is.null(i)) {
        message("getting cached data")
        return(i)
    }
    
    ## the inverse is not cached so calculate it and save the value
    data <- x$get()
    i <- solve(data, ...)
    x$setinv(i)
    i    
}

## Test it
SIZE <- 500
m <- matrix(runif(SIZE*SIZE), SIZE, SIZE)
cachem <- makeCacheMatrix(m)
inv1 <- cacheSolve(cachem)
inv2 <- solve(m)
if (all(inv1 == inv2)) {
    print("cacheSolve correctly found the inverse!", quote=0)
    a <- system.time(cacheSolve(cachem))
    b <- system.time(solve(m))
    print("cached sys.time(): ", quote=0)
    print(a)
    print("", quote=0)
    print("uncached sys.time():", quote=0)
    print(b)
    print("", quote=0)
} else {
    print("oops! something's wrong")
}

## HERE IS THE OUTPUT

# > source("cachematrix.R")
# [1] cacheSolve correctly found the inverse!
#
# cached sys.time(): 
#     user  system elapsed 
# 0.000   0.000   0.001 
# 
# uncached sys.time():
#    user  system elapsed 
# 0.141   0.000   0.142 
#