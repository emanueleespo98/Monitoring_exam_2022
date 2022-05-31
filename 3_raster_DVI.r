#third prokect: energy budget analysis with rasters
#as steted in the previous lessons, first of all you need to install, if you already haven', the packages
# install.packages("raster")
# install.packages("rgdal")

#then you set the library
library(raster)
library(rgdal)

# then the working directory
#setwd("~/lab/") # Linux 
 setwd("C:/monitoring_lab/")  # windows
# setwd("/Users/name/lab/") # mac

# first of all: importing the data
# brick function, used to load a raster/set of different raster layers
l1992 <- brick("defor1_.jpg") # image of 1992
l1992 

# Bands: defor1_.1, defor1_.2, defor1_.3 
# the image loaded have, inside, three different images for different bands
# plotRGB: you can plot different images into only one
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")

# defor1_.1 = NIR
# defor1_.2 = red
# defor1_.3 = green

# you can play in order to visualize different details
plotRGB(l1992, r=2, g=1, b=3, stretch="Lin")
plotRGB(l1992, r=2, g=3, b=1, stretch="Lin")


# day 2

l2006 <- brick("defor2_.jpg")

l2006 
# plotting the imported image
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")

# defor1_.1 = NIR
# defor1_.2 = red
# defor1_.3 = green

# par

par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")

# let's calculate energy in 1992
dev.off()
# DVI is a theoretical ecological index used to measure energy of a plant ecosystem
# DVI = NIR - red band
dvi1992 <- l1992$defor1_.1 - l1992$defor1_.2
# specifying a color palette
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) 
plot(dvi1992, col=cl)

# calculate energy in 2006
# same operations as before: DVI calculation, color palette, plot
dvi2006 <- l2006$defor2_.1 - l2006$defor2_.2
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
plot(dvi2006, col=cl)

# differencing two images of energy in two different times: this way you can find the differences of DVI in two periods
dvidif <- dvi1992 - dvi2006
# plot the results
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(dvidif, col=cld)

# final plot: original images, dvis, final dvi difference
par(mfrow=c(3,2))
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)
plot(dvidif, col=cld)

pdf("energy.pdf")
par(mfrow=c(3,2))
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)
plot(dvidif, col=cld)
dev.off() 

pdf("dvi.pdf")
par(mfrow=c(3,1))
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)
plot(dvidif, col=cld)
dev.off() 


















