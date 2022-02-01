#' # Althea's First Reproducible Script
#' 
#' Programmer: Althea (first name is acceptable to maintain privacy)
#' 
#' Date: January 17, 2022
#' 
#' 
#' ## Header
#' 
#' This chunk of code will load in all required packages and clear environment
#' 
#+ header
library(knitr)
library(ezknitr)
remove(list = ls())

#' 
#' ## Tasks to complete for this assignment for all students
#' 
#' 1. Turn this into a numerical list
#' 2. Write some text in 3rd-level header format
#' 
#' ### Third level Header
#' 
#' 3. Write "This is a 4th-level header" in 4th-level header format
#' 
#' #### This is a 4th-level header
#' 
#' 4. Write some plain text with one word bolded and one italicized
#' 
#' **one** *word*
#' 
#' 5. Make the code below print without being evaluated
#' 6. Create a new chunk of code that is a copy of the code below but that is evaluated
#' 7. Create a third chunk of code that evaluates x/y when x = 500, y = 50
#' 
#' Chunk 1: Here, we will evaluate x/y when x = 200, y = 50
#' 
#+ chunk1, eval = FALSE
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
  paste0( #pastes items together, separated by a commam with 0 chars in betweem
    "x divided by y is ",
    x/y
  )
)
#' Chunk 3: Here, we will evaluate x/y when x = 500, y = 50
#' 
#+ chunk3
#'
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
#' This is the equation: $y = 2x + b^2$
#' 
#' > block quote
#' 
#' Sepal | Petal | Stamen | Ovary
#' ----- |-------|--------|-----
#'   4   |  3    |  3     | 1
#'   2   |  1    |  2     | 1
#'   3   |  2    |  1     | 4
#'
mean(2,4,6,8,10,12)

  
#' To test (and finalize) your work, spin the document to html using this code:
#' 
#' ezspin(file = "MOlinger/programs/20220126_practiceRMD.R",out_dir = "MOlinger/output",fig_dir = "figures",keep_md = FALSE)
#' 
#' **Be careful not to overwrite anyone else's output!!**
#' 
#' Remember to commit > pull > push to submit your work to GitHub. Do this 
#' frequently!