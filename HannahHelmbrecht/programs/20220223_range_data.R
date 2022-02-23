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
#' #' ### Use biocManager to get package GenomicRanges
#' #' 
#' # if (!require("BiocManager", quietly = TRUE))#   install.packages("BiocManager")# BiocManager::install(version = "3.14")# Now install the package
#' # BiocManager::install("GenomicRanges")# library(IRanges)
#' 
#' #' Source the script from the textbook to make figures
#' #' 
#' source("plot-ranges.R")

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
start(x)

#' What values end each range?
#' 
end(x)
#' What is the width of each range?
#' 
width(x)

#' What is the total range of the IRanges object?
#' 
range(x)
# not the same as width, range is the biggest minus smallest value

#' What is the difference between range(x) and width(x)??
#' 
#' > Range summarizes the start and end and width across all the reads/ranges, 
#' but width gives just each individual range's width


#' We can manipulate the ranges with standard arithmetic:
#' 
end(x) <- end (x) + 4
x


#' We can also use many of the other R functions to manipulate IRanges:
#' 
#' Use subsetting to look at just second and third row of x
#' 
x[2:3]
#' Use subsetting to look at just ranges named "a" and "c"
#' 
x[c("a", "c")]

#' Display logical answer for when start of x is less than 5
#' 
x[start(x) <5]

#' Display ranges that are greater than 8 in width
#' 
x[width(x) >8]

#' We can also merge ranges together with c() 
#' 
(a <- IRanges(start = 7, width = 4))
(b <- IRanges(start = 2, width = 5))
c(a,b)


#' _____________________________________________________________________________
#' ## 3. More advanced range operations
#' 
#' 
x <- IRanges(start = c(40, 80),
             end = c(67, 114))
names(x) <- letters[1:length(x)]
plotIRanges(x)

#' By adding 4L, this grows the sequence symmetrically by 4 on each side
#' 
(y <- x + 4L)
names(y) <- paste0(names(y), " + 4L")
y

#' By subtracting, we symmetrically cut off each end of the sequence
#' 
z <- x - 10L 
names(z) <- paste0(names(z), " - 10L")
z 
plotIRanges(c(x,y,z))

#' By restricting the ranges, we cut them off to fit in a specific range
#'
#'   
y <- IRanges(start = c(4, 6, 8, 12), width =13)
names(y) <- letters[1:length(y)]

z <- restrict(x = y, start = 5, end = 10)
names(z) <- paste0(names(z), "-restricted")
plotIRanges(c(y, z))

#' We can also flank the ranges to create downstream or upstream
#' sequences that contain promoter sequences
#' 
x <- IRanges(start =c(40,80),
             width =c(28, 35))
names(x) <- letters[1:length(x)]
# upstream flanks
y <- flank(x, width = 7, start = TRUE)
names(y) <- paste0(names(y), "-upstrm")
# downstream flanks 
z <- flank(x, width = 7, start = FALSE)
names(z) <- paste0(names(z), "-downstrm")
plotIRanges(c(x,y,z))

#' We can also reduce the ranges that are potentially overlapping
#' by merging them to a single range in the result. This is useful if 
#' we care about what regions a sequence covers, but not the specific
#' ranges
#' 
set.seed(0) # reset random generator, make sure we all have the same result
# Create a longer set of ranges, 20 total

alns <- IRanges(start =sample(seq_len(50), 20), 
                width = 5)
names(alns) <- letters[1:length(alns)]
plotIRanges(alns)
alns.reduce <- reduce(alns)
names(alns.reduce) <- paste0(letters[1:length(alns.reduce)], "-reduce")
alns.reduce
plotIRanges(c(alns, alns.reduce))

#' Similarly, we can identify the gaps!
#' 
alns.gap <- gaps(alns)
names(alns.gap) <- paste0(letters[1:length(alns.gap)], "-gap")
alns.gap
plotIRanges(c(alns, alns.gap))
#' 
#' 
#' 
#' ### Footer
#' 
#' spin this with:
#' ezspin(file = "HannahHelmbrecht/programs/20220223_range_data.R",out_dir = "HannahHelmbrecht/output", fig_dir = "figures",keep_md = FALSE, keep_rmd = FALSE)
