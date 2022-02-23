#' # Lecture Notes
#' 
#' Programmer: Glenna
#' 
#' Date: February 23, 2022
#' 
#' 
#' ## Header
#' 
#' This is an attempt to practice using R while taking notes for my bioinfo class.
#' 
#' 
#' This chunk of code will load in all required packages and clear environment
#' 
#+ header
library(knitr)
library(ezknitr)
# This line clears the environment
remove(list = ls()) 

#' ## Notes
#' 
#' Geonomics
#' Remember, we aren't just in a data science class, what should we be thinking about with data processing
#' 
#' Sequencing
#' Genomic DNA is fragmented into random pieces and cloned as a bacterial library.
#' DNA from individual bacterial clones is sequenced assembled through overlapping. 
#' 
#' Contigs - contiguous sequences
#' Scaffolds - larger sequences made up of contigs
#' Chromosomes - Made of scaffolds and contigs once fully assembled
#' 
#' Ranges - As, Ts, Cs, and Gs are important but also act as a coordinate system.
#' 
#' 
#' 'X' is a forward reading range
#' 'Y' is a reverse reading range 
#' 
#' Range systems are either 0-based(Python) or 1-based(R)
#' 0-based" half closed, half open
#' - Included ->[27, 30) <- Excluded
#' - Better in 2 ways: 
#' 1. 0-based systen can calculate range width. ie. 30-27=3. 3 is width of range. 
#' 2. And Looking for where you want to cut a range. Can specify locations between two base pairs.
#' 
#' 
#' 
#' 1-based both sides closed [27,30]
#' - To find the width of the range, we need to add one to the subtraction
#' 1. 30-27+1=4
#' 
#' 
#' 
#' 
#' #Remind the professor to record
#' 
#' 



#' To test (and finalize) your work, spin the document to html using this code:
#' 
#' ezspin(file = "GlennaJaede/programs/20220223_Lecture_NotesRMD.R",out_dir = "GlennaJaede/output",fig_dir = "figures",keep_md = FALSE)
#' 
#' **Be careful not to overwrite anyone else's output!!**
#' 
#' Remember to commit > pull > push to submit your work to GitHub. Do this 
#' frequently!
