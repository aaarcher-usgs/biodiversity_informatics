#' # Guided tour of movement data with Motus package
#' 
#' Biodiversity Informatics (BIOL 475/575)
#' 
#' March 16, 2022
#' 
#' Programmer: Jenna
#' 
#' **Important** - The answers to the 10 questions below can be figured out by
#' working through the online guide to Motus in R, which is at motuswts.github.io
#' and linked through D2L. (Although a couple questions ask you to interpret code
#' or change code using common sense or by googling how to do things or by asking
#' a friend.)
#' 
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
#' 
#' ## 1. Load libraries from new sources (ch 2)
#' 
#' Install "remotes" package
install.packages("remotes")
library(remotes)
update_packages()

install.packages(c("motus", "motusData"),
                 repos = c(birdscanada = 'https://birdscanada.r-universe.dev',
                           CRAN = 'https://cloud.r-project.org'))

install.packages(c("rnaturalearthhires", "rnaturalearthdata"),
                 repos = c(ropensci = 'https://ropensci.r-universe.dev',
                           CRAN = 'https://cloud.r-project.org'))

#' Load the packages for use
library(motus)
library(motusData)
library(tidyverse)
library(DBI)
library(RSQLite)
library(lubridate)
library(rnaturalearth)

#' Set the system environment time to "UTC"
#' 
Sys.setenv(TZ = "UTC")

#' **Q1** What time zone is UTC?
#' 
#' > Answer: UTC stands for Coordinated Universal Time. It is the standard clock 
#' time that all time zones are based off of. This time is based on the mean solar
#' time at the prime meridian and every 15 degrees longitude (east or west) time 
#' changes one hour.
#' 
#' **Q2** Why is this important?
#' 
#' > Answer: This is important to recognize because depending on where you are 
#' conducting your research using motus, you may want to change the time zone
#' to get an accurate read on time of burst intervals.
#' 

#' _____________________________________________________________________________
#' 
#' ## 2. Download sample dataset (Ch 3)
#' 
#' **Important** - First, make a folder named "motus" in the same place as your
#' folder named "biodiversity_informatics"
#' 
#' Set project number
#' 
proj.num <- 176

#' Download the data
#' 
sql.motus <- tagme(projRecv = proj.num, 
                   new = TRUE, 
                   update = TRUE,
                   dir = "../motus")
# Log in name and password are: motus.sample

#' **Important** After first download, comment out the code above and use this:
#' 
sql.motus <- tagme(projRecv = proj.num, 
                   new = FALSE, 
                   update = TRUE,
                   dir = "../motus")
# Log in name and password are: motus.sample


#' _____________________________________________________________________________
#' 
#' ## 3. Explore data that were downloaded (ch 3)
#' 
#' Specify the filename of where your data were downloaded
file.name <- dbConnect(SQLite(), "../motus/project-176.motus")

#' Get a list of tables that were downloaded
#' 
dbListTables(file.name)

#' **Q3** What type of information is in the "projs" table?
#' 
#' > Answer: 
#' 

#' Get a list of fields (column names) in the table "species"
#' 
dbListFields(file.name, "species") 

#' **Q4** How many fields are in the "species" table?
#' 
#' > Answer: 
#' 


#' 
#' Retrieve the virtual "alltags" table from the SQLite file
#' 
tbl.alltags <- tbl(sql.motus, "alltags")

#' This is in a different format (list) than we are used to (data.frames). We can 
#' use str() to see what this different format contains:
#' 
str(tbl.alltags)

#' 
#' The first part of the list, src, is a list that provides details of the 
#' SQLiteConnection, including the directory where the database is stored. 
#' The second part is a list that includes the underlying table. 
#' Thus, the R object alltags is a virtual table that stores the database 
#' structure and information required to connect to the underlying data in 
#' the .motus file. 
#' 

#' 
#' We can use fairly straightforward commands to explore the table without changing
#' its format. Later, we will convert a subset of this to a data.frame. For now, 
#' let's keep looking at it in the SQL format, which allows for faster processing.
#' 
tbl.alltags %>%
  collect() %>% 
  names()

#' **Q5** Compare this list to the one made when we just look at the field 
#' names directly (below). Which way was faster to process (if you can tell)?
#' 
#' > Answer: 
#' 
dbListFields(file.name, "alltags")

#' Now, let's convert that to a "flat" data.frame so that we can start exploring 
#' where these birds were detected!
#' 
df.alltags <- tbl.alltags %>% 
  collect() %>% 
  as.data.frame() %>%     # for all fields in the df (data frame)
  mutate(time = as_datetime(ts))

#' Again, another way to see the column names:
#' 
names(df.alltags)

#' **Q6** How many observations are there in this table?
#' 
#' > Answer: 
#' 

#' Let's select only a couple specific tag IDs. (The
#' tag IDs are the IDs that each individual bird has)
#' 
df.alltagsSub <- tbl.alltags %>%
  filter(motusTagID %in% c(16011, 23316)) %>% 
  collect() %>% 
  as.data.frame() %>%    
  mutate(time = as_datetime(ts))  
table(df.alltagsSub$motusTagID)

#' **Q7** How many records are associated with each of the two tags?
#' 
#' > Answer: 
#' 
 

#' _____________________________________________________________________________
#' 
#' ## 4. Explore detections (Ch 5)
#' 
#' First, we'll just use the filtering function provided by Motus for this sample 
#' data. The details don't matter, we are just taking out any signals that are 
#' ambiguous or not biologically sensical.
#' 
tbl.alltags <- tbl(sql.motus, "alltagsGPS")

# obtain a table object of the filter


# filter and convert the table into a dataframe, with a few modications
df.alltags.sub <- tbl.alltags %>% 
  filter(motusFilter == 1) %>%
  select(-noise, -slop, -burstSlop, -done, -bootnum, -codeSet, 
         -mfg, -nomFreq, -markerNumber, -markerType, -tagDepComments, 
         -fullID, -deviceID, -recvDeployAlt, 
         -speciesGroup, -gpsLat, -gpsLon, -recvSiteName) %>%
  collect() %>%
  mutate(time = as_datetime(ts),  # work with times AFTER transforming to flat file
         tagDeployStart = as_datetime(tagDeployStart),
         tagDeployEnd = as_datetime(tagDeployEnd),
         recvDeployName = if_else(is.na(recvDeployName), 
                                  paste(recvDeployLat, recvDeployLon, sep=":"), 
                                  recvDeployName))

#' Ok, now we can make some graphs and maps!
#' 
#' Let's see what time of day the different species of birds are usually detected during.
#' 
#' First, clean data up a little bit and round everything to the nearest hour of the day
df.alltags.sub.2 <- df.alltags.sub %>%
  mutate(hour = lubridate::hour(time),
         year = lubridate::year(time),
         doy = lubridate::yday(time)) %>% 
  select(motusTagID, port, tagDeployStart, tagDepLat, tagDepLon, 
         recvDeployLat, recvDeployLon, recvDeployName, antBearing, speciesEN, year, doy, hour) %>% 
  distinct()

#' Then graph it!
#' 
#+ motusHOD
ggplot(data = filter(df.alltags.sub.2, year(tagDeployStart) == 2016), 
       aes(x = hour, y = as.factor(motusTagID), colour = speciesEN)) +
  theme_bw() + 
  geom_point() +
  labs(x = "Hour", y = "MotusTagID") +
  scale_colour_discrete(name = "Species")

#' **Q8** Which two species of bird seem to be active only in the mornings and nights and 
#' not during the mid-day?
#' 
#' > Answer:
#' 
#' 

#' Simplify the data by summarizing by the runID so that we can map the detections
#' 

# function to summarize data
fun.getpath <- function(df) {
  df %>%
    filter(tagProjID == 176, # keep only tags registered to the sample project
           !is.na(recvDeployLat) | !(recvDeployLat == 0)) %>% 
    group_by(motusTagID, runID, recvDeployName, ambigID, 
             tagDepLon, tagDepLat, recvDeployLat, recvDeployLon) %>%
    summarize(max.runLen = max(runLen), time = mean(time), .groups = "drop") %>%
    arrange(motusTagID, time) %>%
    data.frame()
} # end of function call

# applying function
df.alltags.path <- fun.getpath(df.alltags.sub)

#' Subset the cleaned data
df.alltags.sub.path <- df.alltags.sub %>%
  filter(tagProjID == 176) %>% # only tags registered to project
  arrange(motusTagID, time) %>%       # order by time stamp for each tag
  mutate(date = as_date(time)) %>%    # create date variable
  group_by(motusTagID, date, recvDeployName, ambigID, 
           tagDepLon, tagDepLat, recvDeployLat, recvDeployLon)

# Final data ready for plotting
df.alltags.path <- fun.getpath(df.alltags.sub.path)

#' Load some shapefiles to map
world <- ne_countries(scale = "medium", returnclass = "sf") 
# Run these two lines for the first time, then the subsequent lines every time after
# lakes <- ne_download(scale = "medium", type = 'lakes', category = 'physical',
#                               returnclass = "sf", destdir = "map-data")
lakes <- ne_load(type = "lakes", scale = "medium", category = 'physical',
                 returnclass = "sf",
                 destdir = "map-data") # use this if already downloaded shapefiles

#' 
#' We will just use the tags that have been examined carefully and filtered 
df.tmp <- df.alltags.path %>%
  filter(motusTagID %in% c(16011, 16035, 16036, 16037, 16038, 16039)) %>%
  arrange(time)  %>% # arrange by hour
  as.data.frame()

#' Set limits to map based on locations of detections, ensuring they include the
#' deployment locations
#' 
xmin <- min(df.tmp$recvDeployLon, na.rm = TRUE) - 2
xmax <- max(df.tmp$recvDeployLon, na.rm = TRUE) + 2
ymin <- min(df.tmp$recvDeployLat, na.rm = TRUE) - 1
ymax <- max(df.tmp$recvDeployLat, na.rm = TRUE) + 1

#' **Q9** What would you change above to zoom out on this map?
#' 
#' > Answer:
#' 

#' 
#' And now we can map the detections!
#+ motusMap
ggplot(data = world) + 
  geom_sf(colour = NA) +
  geom_sf(data = lakes, colour = NA, fill = "white") +
  coord_sf(xlim = c(xmin, xmax), ylim = c(ymin, ymax), expand = FALSE) +
  theme_bw() + 
  labs(x = "", y = "") +
  geom_path(data = df.tmp, 
            aes(x = recvDeployLon, y = recvDeployLat, 
                group = as.factor(motusTagID), colour = as.factor(motusTagID))) +
  geom_point(data = df.tmp, aes(x = recvDeployLon, y = recvDeployLat), 
             shape = 16, colour = "black") +
  geom_point(data = df.tmp, 
             aes(x = tagDepLon, y = tagDepLat), colour = "red", shape = 4) +
  scale_colour_discrete("motusTagID") 

#' **Q10** Duplicate the map below (two maps in final html), but change these items:
#' 
#' - Make the lake filled with "blue" instead of white
#' - Label x with "Longitude" and y with "Latitude"
#' 

#' _____________________________________________________________________________
#' 
#' ### Footer
#' 
#' spin this with:
#' ezspin(file = "aaarcher/programs/20220316_Motus_lab.R",out_dir = "aaarcher/output", fig_dir = "figures",keep_md = FALSE, keep_rmd = FALSE)
