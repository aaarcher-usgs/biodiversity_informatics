#' # Alex's First Reproducible Script
#' 
#' Programmer: Alex Maile
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
# This line clears the environment
remove(list = ls()) 


#' superscript^2  _"if the teacher doesn't know it why should I"_

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
#' ### Fishes are superior to everything
#' #### This is a 4th-level header
#' but __why__ are fishes the _best?_
#' 
#' 
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

#' Chunk 2: To create an unevaluated code
#' 
#' + chunk2
#x <- 200
#y <- 50
#print( # prints out anything inside this to the console
#  paste0( #pastes items together, separated by a comma, with 0 chars in between
#    "x divided by y is ", 
#    x/y
#  )
#)


#' Chunk 3: Here, we will re-evaluate x/y when x = 200, y = 50
#' 
#+ chunk3
x <- 200
y <- 50
print( # prints out anything inside this to the console
  paste0( #pastes items together, separated by a comma, with 0 chars in between
    "x divided by y is ", 
    x/y
  )
)

#' Chunk 4: Here, we will evaluate x/y when x = 500, y = 50
#' 
#+ chunk4
x <- 500
y <- 50
print( # prints out anything inside this to the console
  paste0( #pastes items together, separated by a comma, with 0 chars in between
    "x divided by y is ", 
    x/y
  )
)

#'   ## Additional challenge tasks (recommended for 475; required for 575 students)
#' 
#' - Write an equation in LaTeX format
#' - Include a block quote of your choice
#' - Include a 3 (row) by 4 (column) table with fake data
#' - Include another chunk of code that uses the "mean()" function, and make sure its documented
#' 

#' $$
#' FISHES>everything
#' $$
#' $$
#' Everything=Sucks
#' $$
#' That means...
#' $$
#' FISHES=Don't*Suck
#' $$
#'
#' ## These are words to live by
#'
#' > My logic is undeniable
#'
#' |Why|Fishes|Are|Better|
#' 
#' |Because|They|Just|Are|
#' 
#' |Because|They|Just|Are|
#'
#' Chunk ???? (so many chunks): Here we will discover the world of MEANS
#' 
#+ chunk5

x <- mean(c(1, 22, 15, 30, 40))
print( # prints out anything inside this to the console
  paste0( #pastes items together, separated by a comma, with 0 chars in between
    "The mean of 1, 22, 15, 30, 40 is ", 
    
    x
  )
)

#' To test (and finalize) your work, spin the document to html using this code:
#' 
#' ezspin(file = "AlexMaile/programs/20220126_practiceRMD.R",out_dir = "AlexMaile/output",fig_dir = "figures",keep_md = FALSE)
#' 
#' **Be careful not to overwrite anyone else's output!!**
#' 
#' Remember to commit > pull > push to submit your work to GitHub. Do this 
#' frequently!
