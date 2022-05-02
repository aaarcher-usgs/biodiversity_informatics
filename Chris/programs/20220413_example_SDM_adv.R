#' Biodiversity Informatics (BIOL 475/575)
#' 
#' April 13, 2022
#' 
#' Programmer: Chris
#' 
#' ### Header
#' 
#' 
# Load Libraries
library(ezknitr)
library(rgbif)
library(terra)
library(sdmpredictors)
library(fuzzySim)
library(sdm)
library(raster)

remove(list = ls())

#' _____________________________________________________________________________
#' 
#' ## 1. Download data
#' 
#' Scientific name of the species
myspecies <- "Bombus affinis Cresson, 1864"

#' 
#' Download the data using rgbif library
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


#' _____________________________________________________________________________
#' 
#' ## 2. Explore and clean data
#' 
#' Map the species occurrence data:
#'
#' Download shapefiles of world countries
countries <- terra::vect("data/countries/world_countries.shp")


#' 
#' Plot the countries, then add the occurrences in green
plot(countries)  
points(gbif_data$data[ , c("decimalLongitude", "decimalLatitude", "year")], 
       pch = 20, 
       col = "green")

#' Notice that one green dot shows up in Europe. This species does NOT
#' occur in Europe!
#' 
#' How can you find out which one is the outlier?
presences <- gbif_data$data[ , c("key","decimalLongitude", 
                                 "decimalLatitude", 
                                 "coordinateUncertaintyInMeters", 
                                 "year")]
presences$uniqueID <- 1:nrow(presences)
presences <- presences[presences$decimalLongitude < 0 & presences$decimalLongitude > -105 & presences$year > 1999,]

#' 
#' Let's re-plot the map within the coordinates of our presence points:
plot(countries, xlim = range(presences$decimalLongitude, na.rm = T), 
     ylim = range(presences$decimalLatitude, na.rm = T), border = "grey")
points(presences[ , c("decimalLongitude", "decimalLatitude", "year")], 
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
remove.IDs.SE <- presences$uniqueID[presences$decimalLatitude < 25]
presences <- presences[! presences$uniqueID %in% remove.IDs.SE,]

#' Double check: Did the number of records make sense??
#' 

#' Map the cleaned occurrence records on top of the raw ones:
points(presences[ , c("decimalLongitude", "decimalLatitude"),], 
       pch = 20, 
       col = "red")

#' _____________________________________________________________________________
#' 
#' ## 3. Download predictors data
#' 
#' We'll use functions in the 'sdmpredictors' package to access 
#' different online datasets:
pred_datasets <- sdmpredictors::list_datasets(terrestrial = TRUE, marine = TRUE)
pred_datasets$description

#' 
#' Remember to always cite the data sources! (run this line only for citing)
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
layers_choice <- layers_choice[c(1:20), ]
layers_choice


#' Define folder for downloading the map layers:
options(sdmpredictors_datadir = "../outputs/sdmpredictors")

#' load the layers to the current R session 
#' (downloading them if they aren't already in the folder defined above):
layers <- load_layers(layers_choice$layer_code, rasterstack = FALSE)  
layers

# see how many elements in 'layers':
length(layers)

# plot a couple of layers to see how they look:
names(layers)
plot(layers[[1]], main = names(layers)[1])
plot(layers[[2]], main = names(layers)[2])
plot(layers[[3]], main = names(layers)[3])
# find out if your layers have different extents or resolutions:
unique(pred_layers[pred_layers$dataset_code == "WorldClim", ]$cellsize_lonlat)  
# 0.08333333 - spatial resolution can then be coarsened as adequate for your species data and study area (see below)
unique(sapply(layers, raster::extent))

# if you get more than one extent (which doesn't happen with WorldClim, 
# but may happen with other datasets), you'll have to crop all layers to the 
# minimum common extent before proceeding. 
# For example, if the first layer has the smallest extent:
#layers <- lapply(layers, crop, extent(layers[[1]]))

#' Once all layers have the same extent and resolution, 
#' you can stack them in a single multi-layer Raster object and plot some to check
layers <- raster::stack(layers)
plot(layers[[1:3]])

#' _____________________________________________________________________________
#' 
#' ## 4. Define study area and extent of possible range
#' 
#' Select the study area, e.g. (if your species is terrestrial) 
#' using the countries where your species has occurrence points 
#' (which means it was surveyed in those countries)
#' 
#' Mind there are several other ways of delimiting the study area, 
#' e.g. using ecoregions or other biogeographic units)
#' 
#' First, convert the species occurrences to a spatial object 
#' (like when you import a delimited text file into a GIS, 
#' you need to specify which columns contain the spatial coordinates and 
#' what is the cartographic projection / coordinate reference system):
names(presences)
pres_spat_vect <- vect(presences, 
                     geom = c("decimalLongitude", "decimalLatitude"), 
                     crs = "+proj=longlat")

#' Then get the country polygons that contain presence points:
pres_countries <- countries[pres_spat_vect, ]
plot(pres_countries)
plot(pres_spat_vect, col = "blue", add = TRUE)

# if your species is terrestrial and you see that in some countries it is clearly under-surveyed, you can select only particular countries where the survey was better distributed, for example:
#names(pres_countries)
#unique(pres_countries$NAME)
#chosen_countries <- subset(pres_countries, pres_countries$NAME %in% c("United States of America", "Canada" ))
#plot(chosen_countries)

#' Then also buffer your points with reasonable distance
pres_buff <- terra::aggregate(terra::buffer(pres_spat_vect, width = 50000))
plot(pres_buff, lwd = 2)
plot(pres_spat_vect, col = "blue", add = TRUE)
plot(countries, border = "tan", add = TRUE)

#' Finally, define study area as the area within buffer but also 
#' within countries (e.g., not ocean)
studyarea <- intersect(pres_buff, countries)
plot(studyarea, border = "red", lwd = 3, add = TRUE)

studyarea <- as(studyarea, "Spatial")

# IF YOU USED A LIMITED WINDOW OF COORDINATES to download the occurrence data, 
# you need to intersect or crop with that too:
#studyarea <- intersect(studyarea, mywindow)
#plot(studyarea, border = "green", add = TRUE)


#' Cut the variable maps with the limits of the study area:
layers_cut <- terra::crop(terra::mask(layers, studyarea), studyarea)
plot(layers_cut[[1]])

#' Remember, the spatial resolution of the variables should be 
#' adequate to the data and study area!
#' 
#' Closely inspect your species data vs. the size of the variables' pixels:
plot(layers_cut[[1]])
plot(pres_spat_vect, col = "blue", cex = 0.1, add = TRUE)
# plot within smaller x/y limits if necessary to see if presence point 
# resolution matches pixel resolution:
plot(layers_cut[[1]], xlim = c(-84.5, -81.5), ylim = c(41, 44))
plot(pres_spat_vect, col = "blue", add = TRUE)

# IF NECESSARY, you can aggregate the layers, to e.g. a 5-times coarser resolution (choose the 'fact' value that best matches your presence data resolution to your variables' resolution):
# layers_aggr <- terra::aggregate(layers_cut, fact = 5, fun = mean)
# res(layers_aggr)
# plot(layers_aggr[[1]], xlim = range(presences$decimalLongitude), ylim = range(presences$decimalLatitude))
# plot(pres_spatial, col = "blue", cex = 0.1, add = TRUE)

# run the command below only if you did need to aggregate the layers:
#layers_cut <- layers_aggr


#' Have to add in non-presence data
#' 
dat <- fuzzySim::gridRecords(rst = layers_cut, 
                   pres.coords = presences[ , c("decimalLongitude", "decimalLatitude")])
head(dat)
table(dat$presence)


#' Map these data
plot(layers_cut[[1]], xlim = c(-84.5, -81.5), ylim = c(41, 44))
# plot the absences (pixels without presence records):
points(dat[dat$presence == 0, c("x", "y")], col = "red", cex = 0.5)
# plot the presences (pixels with presence records):
points(dat[dat$presence == 1, c("x", "y")], col = "blue", cex = 0.7)

#' Now, convert back to a spatial data frame
dat_spat <- SpatialPointsDataFrame(coords = dat[,c("x", "y")],
                                   data = dat,
                                   proj4string = crs("+proj=longlat"))


#' Finally, make a dataframe (which you'll need for modelling) of the species 
#' occurrence data gridded (thinned) to the resolution of the raster variables  
#' (i.e., one row per pixel with the values of the variables 
#' and the presence/absence of the species):
df.sdm <- sdm::sdmData(formula = presence ~ .,
                       train = dat_spat,
                  predictors = layers_cut)
df.sdm



#' _____________________________________________________________________________
#' 
#' ## 5. Run models and create a predicted distribution map
m1 <- sdm(presence ~ WC_alt  + I(WC_alt^2) + I(WC_bio14^2), 
          data = df.sdm, 
          methods = c("glm"))
m1
getVarImp(m1)
rcurve(m1)

#' .80 with just 5 variables

m3 <- sdm(presence ~  WC_alt  +   WC_bio9 + WC_bio10 + I(WC_bio10^2) + I(WC_bio11^2), 
          data = df.sdm, 
          methods = c("glm"))
m3
getVarImp(m3)
rcurve(m3)
plogis(getModelObject(m3, id = 1)[[1]])
 roc(m3)
#prediction map M3
p1 <- predict(m3, newdata = layers_cut, 
              filename='Chris/output/figures/p1.img', 
              overwrite=T) 
plot(studyarea, border = "red", lwd = 3)
plot(countries, border = "tan", add = T)
plot(p1, add = T)

#' Variable importance m3
#' 
vi <- getVarImp(m3)
vi
plot(vi)
#' View Coefficients m3
#' 
plogis(getModelObject(m3)[[1]])
#' m4 variable testing new high of AUC: .824 


m4 <- sdm(presence ~  WC_alt  + WC_bio10  + I(WC_bio10^2)  + WC_bio11 + I(WC_bio12^2) + WC_bio1 + I(WC_bio1^2) + WC_bio18 + I(WC_bio18^2)  + WC_bio15 + I(WC_bio15^2) , 
          data = df.sdm, 
          methods = c("glm"))
m4
getVarImp(m4)
roc(m4)
#' m5 variable testing works with or without WC_bio10 new high of .828
m5 <- sdm(presence ~  WC_alt + I(WC_bio10^2)  + WC_bio11 + I(WC_bio12^2) + WC_bio1 + I(WC_bio1^2) + WC_bio18 + I(WC_bio18^2)  + WC_bio15 + I(WC_bio15^2) + WC_bio14 + I(WC_bio14^2) , 
          data = df.sdm, 
          methods = c("glm"))
m5
getVarImp(m5)
roc(m5)
#' m6 variable testing new high AUC: .829
m6 <- sdm(presence ~  WC_alt  + WC_bio1  + I(WC_bio1^2) + WC_bio11 + WC_bio18 + I(WC_bio18^2) + I(WC_bio15^2) + WC_bio12 + I(WC_bio12^2)+ WC_bio2 +I(WC_bio2^2), 
          data = df.sdm, 
          methods = c("glm"))
m6
getVarImp(m6)
roc(m6)

#' m7 variable testing NEW HIGH AUC: .836 need to cull variables down from 13
m7 <- sdm(presence ~  WC_alt  + WC_bio1 + WC_bio4  + I(WC_bio1^2) + WC_bio5 +I(WC_bio5^2)+ WC_bio18 + I(WC_bio18^2) + I(WC_bio15^2) + WC_bio12 + I(WC_bio12^2)+ WC_bio2 +I(WC_bio2^2), 
        data = df.sdm, 
        methods = c("glm"))
m7
getVarImp(m7)
roc(m7)

#' attempting to cull variables while maintain auc of .836. Removing WC_bio12^2 increase by .001
m8 <- sdm(presence ~ WC_alt +  WC_bio1  + I(WC_bio1^2)+ WC_bio4  + WC_bio5 +I(WC_bio5^2)+ WC_bio12  + I(WC_bio15^2)+ WC_bio18+ I(WC_bio18^2)  + WC_bio2 +I(WC_bio2^2), 
          data = df.sdm, 
          methods = c("glm"))
m8
getVarImp(m8)
roc(m8)
#' m9 further cull attempts: was able to reduce to 11 variables and maintain .837 AUC
m9 <- sdm(presence ~ WC_alt +  WC_bio1  + I(WC_bio1^2)+ WC_bio4 +I(WC_bio5^2)+I(WC_bio15^2)+ WC_bio12  + WC_bio18 + I(WC_bio18^2)+ WC_bio2 +I(WC_bio2^2) , 
          data = df.sdm, 
          methods = c("glm"))
m9
getVarImp(m9)
roc(m9)





m1.quad <- sdm(presence ~ WC_alt  + WC_bio14 + WC_alt^2 + WC_Bio14^2, 
          data = df.sdm, 
          methods = c("glm"))
m1.quad
getVarImp(m1.quad)

m4 <- sdm(presence ~ WC_alt + WC_bio4 + WC_bio14, 
          data = df.sdm,
          methods = c("glm"))
m4
getVarImp(m4)
#' Prediction map
#' 
p1 <- predict(m2.select, newdata = layers_cut, 
              filename='Chris/output/figures/p1.img', 
              overwrite=T) 
plot(studyarea, border = "red", lwd = 3)
plot(countries, border = "tan", add = T)
plot(p1, add = T)

pres_countries <- countries[pres_spat_vect, ]
plot(pres_countries)
plot(pres_spat_vect, col = "blue", add = TRUE)
plot(p1, add = T)
#' Variable importance
#' 
vi <- getVarImp(m2.select)
vi
plot(vi)

rcurve(m2.select)
#' View Coefficients
#' 
plogis(getModelObject(m2.select)[[1]]) # transforming out of logit scale to more 
# sensical scales


#' Variable selection?
#' 
m2.select <- sdm(presence ~ WC_alt + I(WC_alt^2) + WC_bio4 + I(WC_bio4^2), 
                 data = df.sdm, methods = c("glm"), var.selection = T)
getModelObject(m2.select)[[1]]
getVarImp(m2.select)
plot(getVarImp(m2.select))
m2.select
roc(m2.select)

#' Based on these results, I will remove quadratic altitude term
m2.noalt <- sdm(presence ~ I(WC_alt^2) + WC_bio4 + I(WC_bio4^2), 
                 data = df.sdm, methods = c("glm"), var.selection = F)
m2.noalt
getVarImp(m2.noalt)


#' Cross-validation
#' 
m3.cv <- sdm(presence ~  WC_bio4 + I(WC_bio4^2), 
             data = df.sdm, methods = c("glm"), 
             replication = "cv", cv.folds = 4, n = 2) # n = 5 for your assignment
m3.cv
plogis(getModelObject(m3.cv, id = 1)[[1]])
getVarImp(m3.cv)
roc(m3.cv)



#' _____________________________________________________________________________
#' 
#' ### Footer
#' 
#' spin this with:
#' ezspin(file = "Chris/programs/20220406_example_SDM.R",out_dir = "Chris/output", fig_dir = "figures",keep_md = FALSE, keep_rmd = FALSE)
