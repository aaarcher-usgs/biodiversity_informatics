#' # Working with data in R
#' 
#' Biodiversity Informatics (BIOL 475/575)
#' 
#' February 16, 2022
#' 
#' Programmer: Glenna
#' 
#' In this program, We will continue with what we were working on last week with basic arithmetic: how to subset.
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
#' Create a vector, x # X is a vector and it has 5 different values)
x <- c(56, 95.3, 0.4, 2.3, 4)

#' Add the second value of x to 4.7
#' 
x[2] + 4.7

#' Add the second and third value of x to 4.7
# we do this to show a string of numbers in x. Just adding a comma to square brackets, RStudio reads that as coordinates.
x[c(2,3)] + 4.7
#' OR
x[2:3] + 4.7


#' What is the fourth value of x?
#' 
x[4]

#' Add names for x
#' 
names(x) <- c("banana", "coconut", "blueberry", "strawberry", "kiwi")

#' Use the names to add the coconut's weight to 4.7
#' 
x["coconut"] +4.7

# this is a more reproducible way to do things since the values of x[2] can change, but assigning a name will ensure just names(x) one value.

#' Use the names to remove the non-tropical fruit
#' 
# One way:
x[c("banana", "coconut", "kiwi")]
(nontropical <- x[c("banana", "coconut", "kiwi")])
# 

# Another way:
x[c(-3, -4)]

#' Sort the values of x by size (ascending)x[] and print those, but don't overwrite x
sort(x)
# X is still the same, this is a way to quickly sort the data without changing the original order.


#' Sort the value of x by size (descending) and overwrite x with this new order


Order(x, decreasing = T)
# this shows what the order of x would be if it were in decreasing order

(x <- x[order(x, decreasing = T)])
# This is what you would do to actually reorder the data in decreasing order.

#Another way to use subset is in a logical way. There is a logical test where x for the value of coconut is looking for a true match and skipping over the false  matches





#' Print the *logical* values of x where x is larger than 1
#' 
x > 1
# by doing this we get the names and whether true or false if they are over the value of 1.


#' Use the same approach but now change any values less than 1 to *NA*
#' 
x <- ifelse(test = x < 1, yes = NA, no = x)
#ifelse is used to overwrite values

#For this one we are trying to look at x and 

#' Calculate the mean of the fruit that are less than 50 but more than 2
#' 
x < 50 & x > 2
mean(x[x < 50 & x > 2 ], na.rm = T)
#The function doesnt know how to work with NAs so we need to remove them and equal them to true for this example.

#' Calculate the mean of the fruits that are more than 50

mean(x[x>50], na.rm = T)

#greater than or equal to >=

#' Calculate the mean of the fruit that are greater or equal to 4
mean(x[x == 4], na.rm = T)
# Test of is x equal to 4, use two equals signs


#' ### Practice exercises
#' 
#' 1. Create a new vector named "evens" that includes all even numbers between 1 and 11.
x <- c(2, 4, 6, 8, 10)
names(x) <- "evens"

#' 2. Create a new vector called "odds" by adding one to the "evens" vector
y <- x+1
names(y) <- "odds"

#' 3. Determine if "evens" is a Numeric, Integer, Character, or Logical vector type
#' 
typeof(x)



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
#' ezspin(file = "GlennaJaede/programs/20220216_data_in_R.R",out_dir = "GlennaJaede/output", fig_dir = "figures",keep_md = FALSE, keep_rmd = FALSE)
