#' # Jenna's First Reproducible Script
#' 
#' Programmer: Jenna 
#' 
#' Date: January 26, 2022
#' 
#' Description: Introduction to script work using R Markdown. Learning how 
#' different syntax translates from R into an html file with a few exercises.
#' 
#' ## Load Packages
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
#' 3. Write "This is a 4th-level header" in 4th-level header format
#' 4. Write some plain text with one word bolded and one italicized
#' 5. Make the code below print without being evaluated
#' 6. Create a new chunk of code that is a copy of the code below but that is evaluated
#' 7. Create a third chunk of code that evaluates x/y when x = 500, y = 50
#' 
#' ### My work:
#' 

#' ### This is a third level header
#' 

#' #### This is a fourth level header
#' 

#' Some plain text with one word **bold** and one *italicized*
#' 

#' 
#' Chunk 1: Here, we will evaluate x/y when x = 200, y = 50
#' 
#' **this chunk will print without being evaluated**
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

#' 
#' Chunk 2: Here, we will evaluate x/y when x = 200, y = 50
#' 
#' **this chunk will print and be evaluated**
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

#' 
#' Chunk 3: Here, we will evaluate x/y when x = 500, y = 50
#' 
#' 
#+ chunk3
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
#' 1. Write an equation in LaTeX format
#' 2. Include a block quote of your choice
#' 3. Include a 3 (row) by 4 (column) table with fake data
#' 4. Include another chunk of code that uses the "mean()" function, and make sure its documented
#' 
#' ### My work:
#' 

#' Equation in LaTex format: $\beta = \gamma/\alpha$
#' 

#' My block quote
#' 
#' >What did you do as a child that made the hours pass by like minutes? 
#' 
#' >Therein lies the key to your Earthly pursuits.
#' 

#' Three by four table with data
#' 
df <- data.frame(site1=rep(c('A', 'B', 'C')),
                 site2=rep(c('G', 'F', 'B')),
                 site3=rep(c('A', 'G', 'C')),
                 site4=rep(c('A', 'C', 'C'))
)
head(df)

#' Code using mean function
#' 
mean(c(2, 4, 10,20))



#' To test (and finalize) your work, spin the document to html using this code:
#' 
#' ezspin(file = "Jenna/programs/20220126_practiceRMD.R",out_dir = "Jenna/output",fig_dir = "figures",keep_md = FALSE)
#' 
#' **Be careful not to overwrite anyone else's output!!**
#' 
#' Remember to commit > pull > push to submit your work to GitHub. Do this 
#' frequently!