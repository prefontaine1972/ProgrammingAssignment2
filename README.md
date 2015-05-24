### Introduction
The second programming assignment required an R function designed to
cache potentially time-consuming computations.  
Taking the mean of a numeric vector is typically a fast
operation.  However, taking the inverse of a matrix may possibly be much more
demanding, especially if it has to be computed repeatedly (e.g.
in a loop).  If the contents of a matrix are not changing, it may make
sense to cache the value of the inverse matrix so that when we need it again, it
can be looked up in the cache rather than recomputed. In this
Programming Assignment the scoping rules of the R language are used
to preserve state inside of an R object.

### Example: Caching the Inverse Matrix


1.  `makeCacheMatrix`: This function creates a special "matrix" object
    that can cache its inverse.




The `<<-` operator which can be used to
assign a value to an object in an environment that is different from the
current environment. Below are two functions that are used to create a
special object that stores a matrix and caches its inverse matrix.

The first function, `makeCacheMatrix` creates a special "matrix", which is
really a list containing a function to

1.  set the value of the inverse matrix
2.  get the value of the matrix
3.  set the value of the inverse matrix
4.  get the value of the inverse matrix

<!-- -->

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

The following function calculates the inverse of the special "matrix"
created with the above function. However, it first checks to see if the
inverse has already been calculated. If so, it `get`s the inverse matrix from the
cache and skips the computation. Otherwise, it calculates the inverse of
the matrix and sets the value of the mean in the cache via the `setmatrix`
function.

2.  `cacheSolve`: This function computes the inverse of the special
    "matrix" returned by `makeCacheMatrix` above. If the inverse has
    already been calculated (and the matrix has not changed), then
    `cacheSolve` should retrieve the inverse from the cache.

Computing the inverse of a square matrix can be done with the `solve`
function in R. For example, if `X` is a square invertible matrix, then
`solve(X)` returns its inverse.

For this assignment, assume that the matrix supplied is always
invertible.



  cacheSolve <- function(x = matrix(), ...) {
  m <- x$getmatrix()
  if(!is.null(m)) {
    message("getting cache data")
    return(m)
  }
  matrix <-x$get()
  m <- solve (matrix, ...)
  x$setmatrix(m)  
  m

}


### Assignment: Caching the Inverse of a Matrix

Matrix inversion is usually a costly computation and there may be some
benefit to caching the inverse of a matrix rather than computing it
repeatedly (there are also alternatives to matrix inversion that we will
not discuss here). Your assignment is to write a pair of functions that
cache the inverse of a matrix.



