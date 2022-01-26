#' # Althea's First Reproducible Script
#' 
#' Programmer: Althea Archer
#' 
#' Date: January 26, 2022
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
#' - Turn this into a numerical list
#' - Write some text in 3rd-level header format
#' - Write "This is a 4th-level header" in 4th-level header format
#' - Write some plain text with one word bolded and one italicized
#' - Make the code below print without being evaluated
#' - Create a new chunk of code that is a copy of the code below but that is evaluated
#' - Create a third chunk of code that evaluates x/y when x = 500, y = 50
#' 

#' 
#' Chunk 1: Here, we will evaluate x/y when x = 200, y = 50
#' 
#+ chunk1
x <- 200
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

#' To test (and finalize) your work, spin the document to html using this code:
#' 
#' ezspin(file = "aaarcher/programs/20220126_practiceRMD.R",out_dir = "aaarcher/output",fig_dir = "figures",keep_md = FALSE)
#' 
#' **Be careful not to overwrite anyone else's output!!**
#' 
#' Remember to commit > pull > push to submit your work to GitHub. Do this 
#' frequently!
