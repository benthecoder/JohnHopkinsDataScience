## makeCacheMatrix function creates a special "matrix" object that can cache
##  it's inverse while cacheSolve computes the inverse of the special "matrix"
## returned by makeCacheMatrix. If inverse is already calculated, then cacheSolve
## should retrieve the inverse from the chache 

## The function makeCacheMatrix initializes two objects, x (as function argument)
## and m (within function environment). After intializing the objects, the setters 
## and getters are defined for both x and m. Lastly, each function is assigned as 
## an element within a list and is returned to parent environment. 

makeCacheMatrix <- function(x = matrix()) { 
    # erasing cached data
    m <- NULL
    
    # set value of matrix
    set <- function(y) {
        # <<- used to assign values to objects x and m in parent environment
        x <<- y 
        m <<- NULL
    }
    
    # get value of matrix
    get <- function() x # lexical scoping
    
    # set value of inverse matrix
    setinverse <- function(inverse) m <<- inverse
    
    # get value of inverse matrix
    getinverse <- function() m
    
    # named elements in list allows use of $ to access functions
    list(set = set, # gives name set to set()
         get = get, # gives name get to get()
         setinverse = setinverse, # gives name setinverse to setinverse()
         getinverse = getinverse # gives name getinverse to getinverse()
         )
}


## cacheSolve() computes the inverse matrix returned by function makeCacheMatrix()
## If the inverse is already computed, cacheSolve will retrieve it and return it
## else, it'll compute the inverse again and return it.

cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    m <- x$getinverse()
    # returns to parent env if cached matrix is valid
    if(!is.null(m)) {
        message("getting cached matrix")
        return(m)
    }
    # executes if false
    data <- x$get()
    m <- inverse(data, ....)
    x$setinverse(data)
    m
}
