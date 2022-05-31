#install.packages("sdm")
#install.packages("rgdal")
#install.packages("raster")

library(sdm)
library(rgdal)
library(raster)
#when you load a packages some files are inside it. we change name for this file
file <- system.file("external/species.shp", package="sdm")

file
#shapefile function works exactly as the raster function
species <- shapefile(file) 

species
species$Occurrence
# how many occurrences are there?
#to count something inside an object you start with [], then you use the dollar and double ==
species[species$Occurrence == 1,]
presences <- species[species$Occurrence == 1,]
absences <- species[species$Occurrence == 0,] 

plot(species[species$Occurrence == 1,], col = 'blue', pch=16)
#this is the same
plot(presences, col = 'blue', pch=16)
points(absences, col = 'red', pch=16)
#we want to plot the probability to find a species or not. this is called species distribution modelling
#we are using predictors
path <- system.file("external", package = "sdm") 
path

#lapply can be used only with rasters,
lst <- list.files(path, pattern = 'asc', full.names = T)

preds <- stack(lst)

cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)

plot(preds, col = cl)

plot(preds$elevation, col=cl)
points(presences, pch=19)

plot(preds$temperature, col=cl)
points(presences, pch=19)

plot(preds$vegetation, col=cl)
points(presences, pch=19)

#day 2 and day 3

setwd("C:/monitoring_lab/")

#setting the source
source("R_code_source_sdm.r")
#we should announce train and predictors 
datasdm <- sdmData(train=species, predictors=preds)

#model sdm(formula= , data = , methods ="")
m1 <- sdm(Occurrence~temperature+elevation+precipitation+vegetation, data=datasdm, methods="glm")

#make the raster output layer
p1 <- predict(m1, newdata = preds)

#final plotting with model and prediction al together
plot(p1, col=cl)
#add the points
points(presences, pch= 19)

#stack everything together
s1 <- stack (preds, p1)
plot (s1, col = cl)
#rename model in the graph
names(s1) <- c('elevation', 'precipitation', 'temperature', 'vegetation', 'distribution_model')

plot (s1, col = cl)
