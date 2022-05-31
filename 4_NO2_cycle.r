# 4th project
# this project is about chemical cycling studies 
# rasters time series of NO2 changes in Europe during the lockdown

# as usual when starting an R project, properly install and load the necessary packages

library (raster)

# Set the working directory
#setwd("~/lab/en/") # Linux 
 setwd("C:/monitoring_lab/en/")  # windows
# setwd("/Users/name/lab/en/") # mac

# into this new folder you have to insert the required images
# now, load it with the raster function
# raster function is used to load a single images, not composed by different layers/bands

en01 <- raster("EN_0001.png")
cl <- colorRampPalette(c('red','orange','yellow'))(100)

# plot the NO2 values of Jan 2020 as learned in previous lessons

plot(en01, col = cl)

# now an exercise: load the image of march NO2 values and plot it

en13 <- raster("EN_0013.png")
plot(en13, col=cl)

# build a multiframe window with par function, 2 rows and 1 column
# par function has as a factor mfrow, first row, then column

par(mfrow=c(2,1))
plot(en01, col=cl)
plot(en13, col=cl)

# now we are doing a very boring job: loading a set of different images
# for what we've learned at the moment, we have to manually add each image singularly
EN01 <- raster("EN_0001.png")
EN02 <- raster("EN_0002.png")
EN03 <- raster("EN_0003.png")
EN04 <- raster("EN_0004.png")
EN05 <- raster("EN_0005.png")
EN06 <- raster("EN_0006.png")
EN07 <- raster("EN_0007.png")
EN08 <- raster("EN_0008.png")
EN09 <- raster("EN_0009.png")
EN10 <- raster("EN_0010.png")
EN11 <- raster("EN_0011.png")
EN12 <- raster("EN_0012.png")
EN13 <- raster("EN_0013.png")

# and then plot it with par function
par(mfrow=c(4,4))
plot(EN01, col=cl)
plot(EN02, col=cl)
plot(EN03, col=cl)
plot(EN04, col=cl)
plot(EN05, col=cl)
plot(EN06, col=cl)
plot(EN07, col=cl)
plot(EN08, col=cl)
plot(EN09, col=cl)
plot(EN10, col=cl)
plot(EN11, col=cl)
plot(EN12, col=cl)
plot(EN13, col=cl)

# at this point you can do something really useful: creation of a stack
# a stack is like a brick, a set of different objects, in this case images, that are melted into a single objects
EN <- stack(EN01, EN02, EN03, EN04, EN05, EN06, EN07, EN08, EN09, EN10, EN11, EN12, EN13)

# now we plot the stack together

plot(EN, col = cl)

# if you'd like to separate the single elements in a plot you can use the $ sign
plot(EN$EN01, col = cl)

# example for a RGB plot
plotRGB(EN, r=1, g=7, b=13, stretch="lin")

# NOW we learn how to import a set of separate files with a similar pattern

rlist <- list.files(pattern ="EN")
rlist

# you have just saved a lot of time and patience!! Good job 
# rlist is an object that have inside a set of different rasters, you have to use raster function to properly work on them
# fortunately you can apply raster function to all the list
list_rast <- lapplay(rlist, raster)
list_ rast

# at this point you could create a stack and melt the properly loaded raster images in a single object

EN_stack <- stack(list_rast)
EN_stack

cl <- colorRampPalette(c('red','orange','yellow'))(100) # 
plot(EN_stack, col=cl)

# Exercise plot only the first image of the stack
plot(EN_stack$EN_0001, col=cl)

# difference
ENdif <- EN_stack$EN_0001 - EN_stack$EN_0013
cldif <- colorRampPalette(c('blue','white','red'))(100) # 
plot(ENdif, col=cldif)

# automated processing source function
source("name_of_your_file.r")