#' # Introduction to R
#' 
#' Biodiversity Informatics (BIOL 475/575)
#' 
#' February 9, 2022
#' 
#' Programmer: Evan
#' 
#' In this program, we will learn basic programming and data skills with 
#' Program R
#' 
#' 
#' ### Header
#' 
#' 

# Load Libraries
library(ezknitr)


# Clear Environment & Set Seed
remove(list=ls())
set.seed(71587)

#' _____________________________________________________________________________
#' ## 1. Arithmetic in R
#' 
#' Calculate 4 plus 3
#' 
4 + 3 
#' 
#' Calculate 4 times 3
4 * 3
#' 
#' Calculate 4 minus 3
4 - 3
#' 
#' Calculate 4 - 3
4 - 3
#' 
#' Calculate 4 minus 3/5
#' 
4 - 3/5

#' 
#' Calculate 4 - 3 divided by 5
#' 
(4 - 3)/5
#'
#' Look up the help documentation of the function "log" using a question mark:
#' 
#+ helpdoc, eval = F
?log()

#' Consider this: Why did I make the chunk option above "eval = F"?
#' 


#' 
#' Calculate the square root of 25 using a function
#' 
sqrt(25)

#' 
#' Calculate the natural log of 100 using a function
log(100)

#' 
#' Calculate the base-10 log of 100 using a function
log10(100)
#' 
#' Calculate the square root of 3.5, but round to 2 digits, using 2 functions
#' 
sqrt((3.5), 2)

x <- sqrt(3.5)
round(x, digits = 2)
?round
round(x = sqrt(3.5), digits = 2)
#' 
#' ### Practice Exercises:
#' 
#' *Make sure each of these tasks is properly, individually documented 
#' with html text like those above.*
#' 
#' 1. Calculate factorial of 5 using a function
#' 2. Calculate $5^2 + 5^{-1} - \pi$ (Look at the html to see the formula)
#' 3. Print $\pi$ with 10 digits
#' 4. Calculate the absolute value of -23
#' 
factorial(5)
5^2 + 5^{-1} - pi
print(pi)
x <- pi
round(x, digits = 10)
abs(-23)
#' _____________________________________________________________________________
#' ## 2. Variables, Vectors, and Assignments
#' 
#' Assign a new variable "x" as 3.1
#' 
x <- 3.1
?variable.names
y <- setNames(x)
#' 
#' Print the value of x
#' 
print(x, digits = 2) # another way, which alolws us to change digits directly
(x)
#' 
#' Assign a new variable "y" as exp(2*x)-1 AND print the value on one line
#' 
print(y <- exp(2 * x) - 1)
#' 
#' A vector is a container of contiguous data, of any length 1 or more. In R, we 
#' store objects like "x" and "y" above as vectors of length 1:
#' Vectors are also 1-D strings ex: x = 2, 3, 4
#' Just list a bunch of numbers
#' 
length(x)
x <- c(2, 3, 4, 5, 6)
length(x)
#' 
#' To create longer vectors we concatenate or combine them with function "c()"
#' C stands for combining
#' 
x <- c(2, 3, 4, 5, 6)

#' 
#' Create a vector called "x" with values of 56, 95.3, and 0.4
#' and another one called "y" with values of 3.2, 1.1, and 0.2
#' 
x <- c(56, 95.3, 0.4)
y <- c(3.2, 1.1, 0.2)

#' 
#' Vectors retain their inherent order, through vectorization, which makes it
#' easy to loop over each vector element-wise.
#' 
#' Demonstrate this with x + y:
#' 
x + y
#' 
#' x-y:
x - y
#' 
#' x/y:
x/y
#' 
#' Vectors also loop over in interesting ways. Notice here what happens when you
#' add together vectors of varying lengths:
#' 
c(1,2) + c(0,0,0,0)
c(1,2) + c(0,0,0)

#' Note that the function works but it does give you a warning. These looping
#' actions in R can be great, or can mess you up if you're not aware that it's 
#' happening!
#' 



#' 
#' 
#' 
#' ### Footer
#' 
#' spin this with:
#' ezspin(file = "Evan/programs/20220209_intro_R.R",out_dir = "Evan/output", fig_dir = "figures",keep_md = FALSE, keep_rmd = FALSE)
