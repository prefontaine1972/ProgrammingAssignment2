## This commentary describes the functions makeCacheMatrix and cacheSolve
## Further details and information on running the functions may be found in
## the README.md file

## makeCacheMatrix is a function that stores a list of functions (set, get, setmatrix, getmatrix)
## To use a function stored in makeCacheMatrix, use the name of the main function plus $ and the 
## name of the 2nd function with arguments 

makeCacheMatrix <- function(x = matrix()) {
  
    m <- NULL
  set <- function(y){
    x <<- y
    m <<- NULL
  }
get <- function() x  
setmatrix <- function(solve) m <<- solve
getmatrix <- function() m
list (set=set, get=get, setmatrix=setmatrix, getmatrix=getmatrix)
}


## cacheSolve is a function that will either return the value of the inverse
## matrix stored in cache or if there is no value present it will calculate
## the inverse matrix and then stores and displays that matrix

## Further details on running this function will be provided in the README.md

cacheSolve <- function(x = matrix(), ...) {
## get the cached value
  m <- x$getmatrix()
## if a cached value present return it  
  if(!is.null(m)) {
    message("getting cache data")
    return(m)
  }
## if no cached value, calculate inverse and store in cache  
  matrix <-x$get()
  m <- solve (matrix, ...)
  x$setmatrix(m)  
  
## This returns a matrix that is the inverse of 'x'
  m
}
