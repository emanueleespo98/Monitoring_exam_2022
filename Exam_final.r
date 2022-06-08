# good morning and welcome to my first real project in R.
# what I planned to do is a Species distribution model of H. neanderthalensis
# to do so, I am getting some inspiration from a scientific paper
# from that i got all the data needed 
# to create a SDM you need data about the presence/absence of a specie and predictors

# let's start!!

# as usual, when starting an R project you must load/install the packages and set the WD
# in my project i need to analyse rasters, create a SDM, so i will load:

library(raster)
library(rgdal)
library(sdm)
# sf & sp packages are needed to create the shapefile of occurrences starting from the paper's additional data
library(sp)
library(sf)
# dismo package is needed for the MaxEnt model. 
library(dismo)

# then I will set the WD
setwd("C:/monitoring_exam")

# into the WD I loaded the raster files of the predictors
# in my first try I needed to import the location data from the paper into R
# after doing so, I created a table, and converted it into a spatial dataframe then into a shapefile, which i need for my SDM
# I won't write in this code all the previous raws, just to have a cleaner version

# at this point I have everything I need: predictors, and a working shapefile 
# I couldn't add occurrences into my shp from R, so i modified it in QGIS


# first of all let's load the predictors. the necessary files are in the wd, .bil

lst<- list.files(pattern='bil', full.names = T)
predictors <- stack(lst)

# downloaded predictors are covering all the world. I'm interested only in Europe, so i crop the rasters according to the article.
new.extent <- extent(-10, 70, 20, 70)
preds.crop<- crop(x=predictors, y = new.extent)

# let's create a scientific palette: to better visualize my analysis i will put light, high contrasting colours at the borders and a dark color in the middle
cl <- colorRampPalette(c('light green', 'dark green', ' yellow')) (100)

#plot(predictors$lig_30s_bio_5, col = cl)

# now we start with the sdm creation
# in order to create a sdm you need occurrences shapefile and predictors. 

species <- shapefile("neanderthal_shp.shp")

datasdm <- sdmData(train=species, predictors=preds.crop)

# model. I am going to use MaxEnt since i only have presences, not absences. 
#m1 <- sdm(Occurrence~lig_30s_bio_5+lig_30s_bio_5+lig_30s_bio_12+lig_30s_bio_18, data=datasdm, methods="bioclim")
# since this is not working, i will use maxent. to use maxent Java is needed, and also dismo package
m2 <- maxent(preds.crop, species)
#memory.limit()

# map probability of the maxent model
p1 <- predict(m2, preds.crop)

# i want to try to extract the raster and save it
#writeRaster(p1, "Neanderthal_maxent.grd")

stack_1<- stack(preds.crop, p1) 
names(stack_1)<- c('Annual precipitation', 'Precipitation of warmest quarter', 'Maximum temperature of warmest month', 'Minimum temperature of coldest month', 'Probability')
plot(stack_1, col = cl)

# this is the final plot, probability map and fossil sites used to create the model.
plot(stack_1$Probability, col = cl)
points(species, pch=19)
#final operations
pdf("Neanderthal_maxent.pdf")
par(mfrow=c(3,2))
plot(stack_1$Probability, col = cl)
points(species, pch = 19)
plot(preds.crop, col = cl)
dev.off()
