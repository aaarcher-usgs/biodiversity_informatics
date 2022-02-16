#' # Working with data in R
#' 
#' Biodiversity Informatics (BIOL 475/575)
#' 
#' February 16, 2022
#' 
#' Programmer: Emma
#' 
#' In this program, we did xxx
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
#' ## 1. Finishing up basic R tasks
#' 
#' ### Subsetting and indexing in R
#' 
#' Create a vector, x
x <- c(56, 95.3, 0.4, 2.3, 4)

#' Add the second value of x to 4.7
#' 

#' What is the fourth value of x?
#' 

#' Add names for x
#' 
names(x) <- c("banana", "coconut", "blueberry", "strawberry", "kiwi")

#' Use the names to add the coconut's weight to 4.7
#' 

#' Use the names to remove the non-tropical fruit
#' 
# One way:

# Another way:

#' Sort the values of x by size (ascending) and print those, but don't overwrite x
#' 
#' 

#' Sort the value of x by size (descending) and overwrite x with this new order
#' 

#' Print the *logical* values of x where x is larger than 1
#' 

#' Use the same approach but now change any values less than 1 to *NA*
#' 

#' Calculate the mean of the fruit that are less than 50 but more than 2
#' 


#' ### Practice exercises
#' 
#' 1. Create a new vector named "evens" that includes all even numbers between 1 and 11.
#' 2. Create a new vector called "odds" by adding one to the "evens" vector
#' 3. Determine if "evens" is a Numeric, Integer, Character, or Logical vector type
#' 4. Change "evens" to a different vector type, making sure to show the results
#' 


#' _____________________________________________________________________________
#' ## 2. Working with data in R
#' 
#' *Note:* Normally, we would load in all necessary data at the top of the script,
#' rather than down a ways. All libraries, necessary data, etc should be loaded 
#' in one place for reproducibility and for better troubleshooting.
#' 
#' Load in the dataset:
#' 
df.ex <- read.csv()

#' Look at the structure of the data
#' 

#' Note that the strings get loaded as factors by default. Change this:
#' 


#' View head (n = 3)
#' 
#' 

#' Dimensions of a data frame come in "rows, columns"
#' 
#' 

#' Query the column names for this dataset
#' 


#' Note that some column names don't make sense, change "X.GC" to "percent.GC"
#' 

#' Use $ to access a single column. Specifically, calculate the average of the depth
#' column
#' 

#' Now use subsetting square brackets to do the same thing:
#' 


#' Now, calculate the average of the depth column values, but only when depth 
#' is greater than 5. (Hint, we have to use subsetting again here, but to subset
#' only rows where depth > 5.)
#' 

#' While not very reproducible, let's just calculate the mean of the first 10
#' rows of the depth column. This time do it both with the $ operator AND with 
#' square brackets only.
#' 

#' Add on a new column that is a test (TRUE/FALSE) of whether the genetic window 
#' is in the centromere location (25,800,000 to 29,700,000).
#' 

#' Tally up the results using table()
#' 

#' Tally up the results using sum()
#' 




#' 
#' 
#' 
#' ### Footer
#' 
#' spin this with:
#' ezspin(file = "emkuechle/programs/20220216_data_in_R.R",out_dir = "emkuechle/output", fig_dir = "figures",keep_md = FALSE, keep_rmd = FALSE)
