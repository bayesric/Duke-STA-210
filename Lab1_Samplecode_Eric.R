# Optional Assignment (Lab 1)
# STA 210: Regression Analysis (2015 Fall)
# Author: Eric

merge_sort <- function(arg1,arg2){
  # Merge two vectors in merge sort.
  #
  # Args:
  #   arg1: the 1st vector to be merged;
  #   arg2: the 2st vector to be merged;
  #
  # Returns:
  #   The merged vector.
  n <- length(arg1)+length(arg2)
  result <- rep(NA,n)
  tmp    <- 1
  while (!is.null(arg1) || !is.null(arg2)){
    if (is.null(arg1)){
      result[tmp:n] <- arg2
      arg2 <- NULL
    }else if (is.null(arg2)){
      result[tmp:n] <- arg1
      arg1 <- NULL
    }else{
      if (arg1[1] <= arg2[1]){
        result[tmp] <- arg1[1]
        if (length(arg1)==1){
          arg1 <- NULL
        }else{
          arg1 <- arg1[2:length(arg1)]
        }
      }else{
        result[tmp] <- arg2[1]
        if (length(arg2)==1){
          arg2 <- NULL
        }else{
          arg2 <- arg2[2:length(arg2)]
        }
      }
    }

    tmp <- tmp + 1
  }
  return(result)
}

mysort <- function(arg, method = "bubble"){
  # Sort a vector into ascending order.
  #
  # Args:
  #   arg: the vector to be sorted.
  #
  # Returns:
  #   The sorted vector.
  n   <- length(arg) # length of arg
  # Error handling
  # Currently only supports bubble sort and merge sort
  if (!(method %in% c("bubble","merge"))){
    stop("Undefined method!")
  }
  
  if (method == "bubble"){ # Bubble sort O(n^2)
    
    # Define a function inside a function *************************
    # Function defined inside "mysort" function only exists in the 
    # temporary environment when you call "mysort", but will not show
    # up in the global environment (your workspace)
    swap <- function(x, i, j){
    # swap the i th position and the j th position of the x vector
      tmp  <- x[i]
      x[i] <- x[j]
      x[j] <- tmp
      return(x)
    }
    #**************************************************************
    
    for (i in 1:(n-1)){
      tmp <- 1
      while(tmp <= n-i){
        if (arg[tmp] > arg[tmp+1]){
          arg <- swap(arg,tmp,tmp+1)
        }
        tmp <- tmp + 1
      }
    }
  }else{ # Merge sort O(nlogn)
    if (n==1){
      return(arg)
    }
    
    m     <- ceiling(n/2)
    left  <- arg[1:m]
    right <- arg[(m+1):n]
    
    left  <- mysort(left, method = "merge")
    right <- mysort(right, method = "merge")
    
    arg   <- merge_sort(left, right)
  }
  
  return(arg)
}

# Test
v <- rnorm(1E3)
# See if v is correctly sorted into a ascending order
system.time(tmp0 <- sort(v))
system.time(tmp1 <- mysort(v,method="merge"))
system.time(tmp2 <- mysort(v,method="bubble")) # Bubble sort is very slow!
all.equal(tmp0,tmp1)
all.equal(tmp0,tmp2)