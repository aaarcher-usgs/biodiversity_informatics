# (day 1)
install.packages("terra", repos = "https://rspatial.r-universe.dev")  # see https://github.com/rspatial/terra for additional instructions if you have installation problems
install.packages("rgbif", repos = "https://dev.ropensci.org")
install.packages("scrubr", repos = "https://dev.ropensci.org")
install.packages("sdmpredictors")
install.packages("fuzzySim", repos = "http://R-Forge.R-project.org")

library(rgbif)
library(scrubr)
library(terra)
library(sdmpredictors)
library(fuzzySim)
library(raster)
library(ezknitr)


# GET SPECIES OCCURRENCE DATA DATA ####

# here we'll download GBIF occurrence data for a particular species; 
# you can replace it with another species of your choice, but things can be quite 
# slow if there are many occurrence points!

myspecies <- "Hesperia dacotae"

gbif_data <- occ_data(scientificName = myspecies, hasCoordinate = TRUE, limit = 20000)
gbif_data  # see if "Records returned" is smaller than "Records found", in which case you need to re-run 'occ_data' with a larger 'limit' above

