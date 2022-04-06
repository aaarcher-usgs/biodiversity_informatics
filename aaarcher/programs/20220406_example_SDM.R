library(rgbif)
library(terra)
library(sdmpredictors)

remove(list = ls())
#' 
#' Scientific name of the species
myspecies <- "Emydoidea blandingii"

#' 
#' Download the data
gbif_data <- occ_data(scientificName = myspecies, 
                      hasCoordinate = TRUE, 
                      limit = 20000)

#'
#' See if "Records returned" is smaller than "Records found", in which case you need to re-run 'occ_data' with a larger 'limit' above
gbif_data  

#' Citations for data. Run this once, only after analysis so that you 
#' can properly cite your data sources on the final presentation.
#' 
# gbif_citation(gbif_data)

#' 
#' Map the species occurrence data:
#'
#' Download shapefiles of world countries
countries <- terra::vect("data/countries/world_countries.shp")


#' 
#' Plot the countries, then add the occurrences in green
plot(countries)  
points(gbif_data$data[ , c("decimalLongitude", "decimalLatitude")], 
       pch = 20, 
       col = "green")

#' Notice that one green dot shows up in Europe. This species does NOT
#' occur in Europe!
#' 
#' How can you find out which one is the outlier?
presences <- gbif_data$data[ , c("key","decimalLongitude", 
                                 "decimalLatitude", 
                                 "coordinateUncertaintyInMeters")]
presences$uniqueID <- 1:nrow(presences)
presences <- presences[presences$decimalLongitude < 0,]

#' 
#' Let's re-plot the map within the coordinates of our presence points:
plot(countries, xlim = range(presences$decimalLongitude), 
     ylim = range(presences$decimalLatitude), border = "grey")
points(presences[ , c("decimalLongitude", "decimalLatitude")], 
       pch = 20, 
       col = "green")

#' 
#' These data look good, but let's remove any data points that have
#' very uncertain coordinates (>70,000 m)
#' 
#' 
range(presences$coordinateUncertaintyInMeters, na.rm = T)
remove.IDs <- presences$uniqueID[presences$coordinateUncertaintyInMeters > 70000 &
                                   complete.cases(presences)]
length(remove.IDs) # how many to remove? How many should be left?

presences <- presences[! presences$uniqueID %in% remove.IDs,]
summary(presences)

# map the cleaned occurrence records on top of the raw ones:
points(presences[ , c("decimalLongitude", "decimalLatitude"),], 
       pch = 20, 
       col = "blue")

#' Blanding's turtle is NOT located in southern states. We need to also
#' remove records from areas that are not possible.
#' 
remove.IDs.SE <- presences$uniqueID[presences$decimalLatitude < 39]
presences <- presences[! presences$uniqueID %in% remove.IDs.SE,]

#' Double check: Did the number of records make sense??
#' 

#' Map the cleaned occurrence records on top of the raw ones:
points(presences[ , c("decimalLongitude", "decimalLatitude"),], 
       pch = 20, 
       col = "red")

#' 
#' We'll use functions in the 'sdmpredictors' package to access 
#' different online datasets:
pred_datasets <- list_datasets(terrestrial = TRUE, marine = TRUE)
pred_datasets$description

#' 
#' Remember to always cite the data sources!
# pred_datasets[,c(1,6)]

#' Explore the possible data:
#' 
pred_layers <- list_layers(datasets = pred_datasets)
unique(pred_layers$dataset_code)
# example of terrestrial variables dataset
unique(pred_layers[pred_layers$dataset_code == "WorldClim", ]$name)  
# example of marine variables dataset
unique(pred_layers[pred_layers$dataset_code == "Bio-ORACLE", ]$name)  

#' 
#' Let's choose one dataset (e.g. WorldClim) and 
#' one particular set of variables 
#' (e.g. altitude and the bioclimatic ones, 
#' which are in rows 1 to 20):
layers_choice <- unique(pred_layers[pred_layers$dataset_code == "WorldClim", c("name", "layer_code")])
layers_choice
layers_choice <- layers_choice[1:20, ]
layers_choice


# define folder for downloading the map layers:
options(sdmpredictors_datadir = "../outputs/sdmpredictors")
# load the layers to the current R session (downloading them if they aren't already in the folder defined above):
layers <- load_layers(layers_choice$layer_code, rasterstack = FALSE)  # rasterstack=TRUE gives error when there are layers with different extents
layers
# see how many elements in 'layers':
length(layers)
# plot each layer:
#sapply(layers, plot)
# plot a couple of layers to see how they look:
names(layers)
plot(layers[[1]], main = names(layers)[1])
plot(layers[[5]], main = names(layers)[5])

# find out if your layers have different extents or resolutions:
unique(pred_layers[pred_layers$dataset_code == "WorldClim", ]$cellsize_lonlat)  
# 0.08333333 - spatial resolution can then be coarsened as adequate for your species data and study area (see below)
unique(sapply(layers, raster::extent))
# if you get more than one extent (which doesn't happen with WorldClim, but may happen with other datasets), you'll have to crop all layers to the minimum common extent before proceeding
# for example, if the first layer has the smallest extent:
#layers <- lapply(layers, crop, extent(layers[[1]]))

# once all layers have the same extent and resolution, you can stack them in a single multi-layer Raster object:
layers <- raster::stack(layers)
# you can instead convert them to a SpatRaster object (of package 'terra') for faster processing:
#layers <- terra::rast(layers)
plot(layers)

# select the study area, e.g. (if your species is terrestrial) using the countries where your species has occurrence points (which means it was surveyed in those countries):
# (mind there are several other ways of delimiting the study area, e.g. using ecoregions or other biogeographic units)
# first, convert the species occurrences to a spatial object (like when you import a delimited text file into a GIS, you need to specify which columns contain the spatial coordinates and what is the cartographic projection / coordinate reference system):
names(presences)
pres_spat_vect <- vect(presences, 
                     geom = c("decimalLongitude", "decimalLatitude"), 
                     crs = "+proj=longlat")
# then get the country polygons that contain presence points:
pres_countries <- countries[pres_spat_vect, ]
plot(pres_countries)
plot(pres_spat_vect, col = "blue", add = TRUE)

# if your species is terrestrial and you see that in some countries it is clearly under-surveyed, you can select only particular countries where the survey was better distributed, for example:
#names(pres_countries)
#unique(pres_countries$NAME)
#chosen_countries <- subset(pres_countries, pres_countries$NAME %in% c("United States of America", "Canada" ))
#plot(chosen_countries)

# alternatively or additionally to this, or if you can't select evenly surveyed countries (e.g. if you're working with marine species), you can delimit the modelling region as a buffer of a given distance -- e.g. 2 geographic degrees, or 200 km, or some estimate of the dispersal capacity of our species:
pres_buff <- terra::aggregate(terra::buffer(pres_spat_vect, width = 50000))
plot(pres_buff, lwd = 2)
plot(pres_spat_vect, col = "blue", add = TRUE)
plot(countries, border = "tan", add = TRUE)
#plot(chosen_countries, border = "green", add = TRUE)


studyarea <- intersect(pres_buff, countries)
plot(studyarea, border = "red", lwd = 3, add = TRUE)

studyarea <- as(studyarea, "Spatial")

# IF YOU USED A LIMITED WINDOW OF COORDINATES to download the occurrence data, 
# you need to intersect or crop with that too:
#studyarea <- intersect(studyarea, mywindow)
#plot(studyarea, border = "green", add = TRUE)


# cut the variable maps with the limits of the study area:
# layers_cut <- terra::crop(layers, studyarea)
# plot(layers_cut)
# plot(layers_cut[[1]])
# plot(countries, border = "tan", add = TRUE)
# plot(studyarea, add = TRUE)
# plot(pres_spatial, col = "blue", add = TRUE)

# remember, the spatial resolution of the variables should be adequate to the data and study area!
# closely inspect your species data vs. the size of the variables' pixels:
plot(layers[[1]], 
     xlim = range(presences$decimalLongitude), 
     ylim = range(presences$decimalLatitude))
plot(pres_spat_vect, col = "blue", cex = 0.1, add = TRUE)
# plot within smaller x/y limits if necessary to see if presence point 
#resolution matches pixel resolution:
plot(layers[[1]], xlim = c(-84, -82), ylim = c(42, 43))
plot(pres_spat_vect, col = "blue", add = TRUE)

# IF NECESSARY, you can aggregate the layers, to e.g. a 5-times coarser resolution (choose the 'fact' value that best matches your presence data resolution to your variables' resolution):
# layers_aggr <- terra::aggregate(layers_cut, fact = 5, fun = mean)
# res(layers_aggr)
# plot(layers_aggr[[1]], xlim = range(presences$decimalLongitude), ylim = range(presences$decimalLatitude))
# plot(pres_spatial, col = "blue", cex = 0.1, add = TRUE)

# run the command below only if you did need to aggregate the layers:
#layers_cut <- layers_aggr

pres_spatial$Occurrence <- 1
pres_spatial <- as(pres_spat_vect, "Spatial")

#' Have to add in non-presence data
#' 
absences <- sp::spsample(x = studyarea,
                         n = nrow(presences), 
                         type = "random")
abs_spat <- as(absences, "SpatialPointsDataFrame")
plot(abs_spat, col = "black", add = TRUE)

maptools::spRbind(pres_spat_vect, absences)


# now make a dataframe (which you'll need for modelling) of the species 
# occurrence data gridded (thinned) to the resolution of the raster variables
# i.e., one row per pixel with the values of the variables 
# and the presence/absence of the species:
df.sdm <- sdm::sdmData(train = pres_spatial,
                  predictors = layers[[1]])

m1 <- sdm(Occurrence ~ ., data = df.sdm, methods = c("glm", "gam"))



# plot the absences (pixels without presence records):
points(dat[dat$presence == 0, c("x", "y")], col = "red", cex = 0.5)
# plot the presences (pixels with presence records):
points(dat[dat$presence == 1, c("x", "y")], col = "blue", cex = 0.7)


# SAVE OBJECTS FOR FUTURE USE ####

# save "dat" as a .csv file on disk:
write.csv(dat, paste0("../outputs/", myspecies, "/presences/data_gridded.csv"), row.names = FALSE)

# save the names and codes of the chosen variables:
write.csv(layers_choice, paste0("../outputs/", myspecies, "/layers_choice.csv"), row.names = FALSE)

# create a folder and save each of 'layers_cut' as a raster map:
layers_dir <- paste0("../outputs/", myspecies, "/layers_cut")
dir.create(layers_dir)
for (l in 1:nlyr(layers_cut)) {
  writeRaster(layers_cut[[l]], overwrite=TRUE,
              filename = paste0(layers_dir, "/", names(layers_cut)[l], ".tif"))
}




# I suggest you use this species dataset first for the practicals, as it should work properly from beginning to end; and then repeat the above script to build another analogous dataset with your own species, region and variables
