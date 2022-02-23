#' # Working with data in R
#' 
#' Biodiversity Informatics (BIOL 475/575)
#' 
#' February 16, 2022
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
x[2] +4.7 


#' What is the fourth value of x?
#' 
x[4]
#' Add names for x
#' 
names(x) <- c("banana", "coconut", "blueberry", "strawberry", "kiwi")



#' Use the names to add the coconut's weight to 4.7
#' 

x["coconut"] + 4.7

#' Use the names to remove the non-tropical fruit
#' 
nontropical <- x[c("banana", "coconut", "kiwi")]


#' 
# One way:

(nontropical <- x[c("banana", "coconut", "kiwi")])

# Another way:

x[c(-3,-4)]

#' Sort the values of x by size (ascending) and print those, but don't overwrite x
#' 
sort(x)

#' Sort the value of x by size (descending) and overwrite x with this new order
#' 
(x <- x[order(x, decreasing = T)])

#' Print the *logical* values of x where x is larger than 1
#' 
#' 

x > 1


#' Use the same approach but now change any values less than 1 to *NA*
#' 

x <- ifelse(test = x < 1,
            yes = NA, 
            no = x)

#' Calculate the mean of the fruit that are less than 50 but more than 2
#' 
x < 50 & x > 2
mean(x[x < 50 & x > 2], na.rm = T)


#' ### Practice exercises
#' 
#' 1. Create a new vector named "evens" that includes all even numbers between 1 and 11.
#' 

evens <- c(2, 4, 6, 8, 10)


#' 2. Create a new vector called "odds" by adding one to the "evens" vector
#' 
#' 

odds <- c(1, 3, 5, 7, 9, 11)

#' 3. Determine if "evens" is a Numeric, Integer, Character, or Logical vector type
#' 
#' 
#' 
typeof("evens")
# evens is currently a character vector, needs to be changed

#' 4. Change "evens" to a different vector type, making sure to show the results
#' 
numbers <- as.numeric("evens")


#' _____________________________________________________________________________
#' ## 2. Working with data in R
#' 
#' *Note:* Normally, we would load in all necessary data at the top of the script,
#' rather than down a ways. All libraries, necessary data, etc should be loaded 
#' in one place for reproducibility and for better troubleshooting.
#' 
#' Load in the dataset:
#' 
df.ex <- read.csv(file = "data/raw/Dataset_S1.txt")

#' Look at the structure of the data
#' 
str(df.ex)

#' Note that the strings get loaded as factors by default. Change this:
#' 
df.ex <- read.csv(file = "data/raw/Dataset_S1.txt", stringsA = F)

#' View head (n = 3)
#' 
#' 
head(df.ex, n = 3)
# This displays first three rows

#' Dimensions of a data frame come in "rows, columns"
#' 
#' 
dim(df.ex)
# always displays rows and then columns 

#' Query the column names for this dataset
#' 
colnames(df.ex)
# never include spaces in column names or it reads as a period


#' Note that some column names don't make sense, change "X.GC" to "percent.GC"
#' 

colnames(df.ex) <- ifelse(test = colnames(df.ex) == "X.GC", 
                          yes = "percent.GC", 
                          no =colnames(df.ex))

colnames(df.ex)
# this is a way to change column name and then check it 


#' Use $ to access a single column. Specifically, calculate the average of the depth
#' column
#' 

mean(df.ex$depth)
# this finds the mean of the depth column

#' Now use subsetting square brackets to do the same thing:
#' 
mean(df.ex[ , "depth"])

# this format finds the mean of the depth column using square brackets

#' Now, calculate the average of the depth column values, but only when depth 
#' is greater than 5. (Hint, we have to use subsetting again here, but to subset
#' only rows where depth > 5.)
#' 

mean(df.ex[df.ex$depth > 5 , "depth"])
# this calculates the mean of the depth column only for values greater than 5

#' While not very reproducible, let's just calculate the mean of the first 10
#' rows of the depth column. This time do it both with the $ operator AND with 
#' square brackets only.
#' 

mean(df.ex[1 :10 , "depth"])
#this does this task using square brackets

mean(df.ex$depth[1:10])

#this does the task above just using a dollar sign rather than square brackets

#' Add on a new column that is a test (TRUE/FALSE) of whether the genetic window 
#' is in the centromere location (25,800,000 to 29,700,000).
#' 
#' 

df.ex$centromere <- NA

#this is how you name a new column

cent.start <- 25800000
cent.end <- 29700000
df.ex$centromere <- df.ex$start >= cent.start & df.ex$end <= cent.end

#' Tally up the results using table()
#' 
table(df.ex$centromere)

# shows results for how many of our values fall within centromere values

#' Tally up the results using sum()
#' 
sum(df.ex$centromere)

#' 
#' 
#' 
#' ### Footer
#' 
#' spin this with:
#' ezspin(file = "HannahHelmbrecht/programs/20220216_data_in_R.R",out_dir = "HannahHelmbrecht/output", fig_dir = "figures",keep_md = FALSE, keep_rmd = FALSE)
