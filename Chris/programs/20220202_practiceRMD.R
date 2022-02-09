#' # Althea's First Reproducible Script
#' 
#' Programmer: Chris Krueth
#' 
#' Date: February 2, 2022
#' 
#' 
#' ## Header
#' 
#' This chunk of code will load in all required packages and clear environment
#' 
#+ header
library(knitr)
library(ezknitr)
# This line clears the environment
remove(list = ls()) 


#' superscript^2

#' 
#' ## Tasks to complete for this assignment for all students
#' 
#' 1. Turn this into a numerical list 
#' 2. Write some text in 3rd-level header format 
#' 3. Write "This is a 4th-level header" in 4th-level header format
#' 4. Write some plain text with one word bolded and one italicized
#' 5. Make the code below print without being evaluated
#' 6. Create a new chunk of code that is a copy of the code below but that is evaluated
#' 7. Create a third chunk of code that evaluates x/y when x = 500, y = 50
#' 
#' 
#' ### Some text in 3rd-Level header
#' #### This is a 4th-level header
#'  Some text in *italics* some text in **Bold**
#' 
#' 


#' 
#' Chunk 1: Here, we will evaluate x/y when x = 200, y = 50
#' 
#+ chunk1, eval=FALSE
x <- 200
y <- 50
print( # prints out anything inside this to the console
  paste0( #pastes items together, separated by a comma, with 0 chars in between
    "x divided by y is ", 
    x/y
  )
)
#' Chunk 2: Here, we will evaluate x/y when x = 200, y = 50
#' 
#+ chunk2 
x <- 200
y <- 50
print( # prints out anything inside this to the console
  paste0( #pastes items together, separated by a comma, with 0 chars in between
    "x divided by y is ", 
    x/y
  )
)
#' Chunk 3: Here, we will evaluate x/y when x = 500, y = 50
#' 
#+ chunk3, 
x <- 500
y <- 50
print( # prints out anything inside this to the console
  paste0( #pastes items together, separated by a comma, with 0 chars in between
    "x divided by y is ", 
    x/y
  )
)
#' ## Additional challenge tasks (recommended for 475; required for 575 students)
#' 
#' - Write an equation in LaTeX format
#' - Include a block quote of your choice
#' - Include a 3 (row) by 4 (column) table with fake data
#' - Include another chunk of code that uses the "mean()" function, and make sure its documented
#' 
#'  \pi(\omicron)=\sum
#'  
#'  
#'  left | Right | Right
#'  ----|------|-------
#'   3 | \sigma | ^37^
#'   
#'
#' chunk4
#' here we will calculate the mean of number from 2 through 15
 numbers.example <- 2:15
 
 mean(numbers.example)
 mean(2:15)
#' 
#' 
#' 
#' 
#' 

#' To test (and finalize) your work, spin the document to html using this code:
#' 
#' ezspin(file = "Chris/programs/20220202_practiceRMD.R",out_dir = "Chris/output",fig_dir = "figures",keep_md = FALSE)
#' 
#' **Be careful not to overwrite anyone else's output!!**
#' 
#' Remember to commit > pull > push to submit your work to GitHub. Do this 
#' frequently!
