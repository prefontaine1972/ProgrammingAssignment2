# Introduction
The second programming assignment required an R function designed to
cache potentially time-consuming computations.  Taking the mean of a numeric vector is typically a fast
operation.  However, matrix inversion is usually a costly computation and there may be some
benefit to caching the inverse of a matrix rather than computing it repeatedly (e.g.
in a loop).  If the contents of a matrix are not changing, it may make
sense to cache the value of the inverse matrix so that when we need it again it
can be looked up in the cache rather than recomputed. In this
Programming Assignment the scoping rules of the R language were used
to preserve state inside of an R object.

##Caching the Inverse Matrix

The `<<-` operator can be used to
assign a value to an object in an environment that is different from the
current environment. Below are two functions that are used to create a
special object that stores a matrix, calculates its inverse, and caches its inverse matrix.

##makeCacheMatrix

`makeCacheMatrix`: This function creates a special "matrix" object, which is
really a list containing a function to:

1.  set the value of the matrix
2.  get the value of the matrix
3.  set the value of the inverse matrix
4.  get the value of the inverse matrix

```
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
```

##cacheSolve

`cacheSolve`: This function calculates the inverse of the special "matrix"
created with the above function. However, it first checks to see if the
inverse has already been calculated. If so, it `get`s the inverse matrix from the
cache and skips the computation. Otherwise, it calculates the inverse of
the matrix and sets the value of the mean in the cache via the `setmatrix`
function.


```
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
```

##Examples of Running the Code

For this assignment, one was to assume that the matrix supplied was always
invertible.  Note: when `<` is displayed the line is inputed into the command line, while if `#`is added it shows additional commentary.


```

>a <- makeCacheMatrix()

>a$set(matrix(1,2,4,6, 2,2)

>cacheSolve(a)

 [,1] [,2]
[1,]   -3  2.0
[2,]    1 -0.5

#re-run to see if cached 

>cache Solve(a)

getting cache data
     [,1] [,2]
[1,]   -3  2.0
[2,]    1 -0.5

```







