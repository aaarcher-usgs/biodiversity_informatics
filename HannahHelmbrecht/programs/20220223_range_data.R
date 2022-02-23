#' # Working with genomic range data in R
#' 
#' Biodiversity Informatics (BIOL 475/575)
#' 
#' February 23, 2022
#' 
#' Programmer: Hannah Helmbrecht
#' 
#' In this program, xxx
#' 
#' 
#' ### Header
#' 
#' 
# Load Libraries
library(ezknitr)
library(ggplot2)

# Clear Environment & Set Seed
remove(list=ls())
set.seed(71587)

#' _____________________________________________________________________________
#' ## 1. Load libraries from new sources
#' 
#' ### Use biocManager to get package GenomicRanges
#' 
# if (!require("BiocManager", quietly = TRUE))#   install.packages("BiocManager")# BiocManager::install(version = "3.14")# Now install the package
 BiocManager::install("GenomicRanges")# library(IRanges)

#' Source the script from the textbook to make figures
#' 
source("plot-ranges.R")

#' _____________________________________________________________________________
#' ## 2. Introduction to range data
#' 
#' IRanges are an object that R recognizes as being a genomic range.
#' 
#' Remember that ranges would normally have metadata such as 
#' 
#' 1. Chromosome name, such as "chr17" or "chrY" or "contig184"
#' 2. Range that demonstrates the specific sequence on the chromosome
#' 3. Strand, which is either forward (positive) or backward (negative)
#' 

# Ranges can be made by designating start and end
 (rng <- IRanges(start = 4, end = 13))

# Ranges can be made by designating start or end AND width
 (rng <- IRanges(start = 4, width = 11))

#' IRanges objects can also be created to contain many ranges 
#' 
(x <- IRanges(start = c(4, 7, 2, 20), end =c(13, 7, 5, 23)))

#' And each range within the IRanges object can be named:
#' 
names(x) <- letters [1:length(x)]
x


#' Let's plot the ranges
#' 
plotIRanges(x)

#' What values start each range?
#' 


#' What values end each range?
#' 

#' What is the width of each range?
#' 

#' What is the total range of the IRanges object?
#' 


#' What is the difference between range(x) and width(x)??
#' 



#' We can manipulate the ranges with standard arithmetic:
#' 


#' We can also use many of the other R functions to manipulate IRanges:
#' 
#' Use subsetting to look at just second and third row of x
#' 

#' Use subsetting to look at just ranges named "a" and "c"
#' 


#' Display logical answer for when start of x is less than 5
#' 


#' Display ranges that are greater than 8 in width
#' 


#' We can also merge ranges together with c() 
#' 



#' _____________________________________________________________________________
#' ## 3. More advanced range operations
#' 
#' 


#' By adding 4L, this grows the sequence symmetrically by 4 on each side
#' 


#' By subtracting, we symmetrically cut off each end of the sequence
#' 


#' By restricting the ranges, we cut them off to fit in a specific range
#'
#'   


#' We can also flank the ranges to create downstream or upstream
#' sequences that contain promoter sequences
#' 


#' We can also reduce the ranges that are potentially overlapping
#' by merging them to a single range in the result. This is useful if 
#' we care about what regions a sequence covers, but not the specific
#' ranges
#' 
set.seed(0) # reset random generator, make sure we all have the same result
# Create a longer set of ranges, 20 total


#' Similarly, we can identify the gaps!
#' 



#' 
#' 
#' 
#' ### Footer
#' 
#' spin this with:
#' ezspin(file = "HannahHelmbrecht/programs/20220223_range_data.R",out_dir = "HannahHelmbrecht/output", fig_dir = "figures",keep_md = FALSE, keep_rmd = FALSE)
