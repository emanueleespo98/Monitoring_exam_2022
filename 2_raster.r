# this course is mainly about using R to do remote sensing analysis
# in this way you can very easily put toghether Statistical analysis and RS
# GIS is maybe easier to use, but you have to integrate statistics in other ways

# to elaborate and visualize rasters you have to install and additional package
install.packages("raster")

#once you have installed a package you don't need to install them another time, but you must load it
#library: you must set the library with all the packages you are going to need at the beginning of the project

library(raster)

# then you set the WD
#setwd("~/lab/") # Linux 
 setwd("C:/monitoring_lab/")  # windows
# setwd("/Users/name/lab/") # mac

# Rasters, usually are from satellite images
# objects cannot be numbers!!!
l2011 <- brick("p224r63_2011.grd")

l2011

#a grd file is a set of different raster images. there are different layers, you can extract them
# to visualize each image separately you can use plot function
 plot(l2011)

# B1 is the reflectance in the blue band
# B2 is the reflectance in the green band
# B3 is the reflectance in the red band

#colours are very important in science. there is a scientific way to set the colours of graph
#with the following function you can create your own color palette
cl <- colorRampPalette(c("black","grey","light grey"))(100)
plot(l2011, col=cl)

plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")

#----------------- day 2

# B1 is the reflectance in the blue band
# B2 is the reflectance in the green band
# B3 is the reflectance in the red band
# B4 is the reflectance in the NIR band

# as learned in the previous lesson, we can separate elements with $
#let's plot the green band
plot(l2011$B2_sre)

cl <- colorRampPalette(c("black","grey","light grey"))(100)
plot(l2011$B2_sre, col=cl)

# change the colorRampPalette with dark green, green, and light green, e.g. clg 
clg <- colorRampPalette(c("dark green","green","light green"))(100)
plot(l2011$B2_sre, col=clg)

# do the same for the blue band using "dark blue", "blue", and "light blue"
# B1
clb <- colorRampPalette(c("dark blue","blue","light blue"))(100)
plot(l2011$B1_sre, col=clb)

# plot both images in just one multiframe graph
par(mfrow=c(1,2)) # the first number is the number of rows in the multiframe, while the second one is the mnumber of columns
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)

# plot both images in just one multiframe graph with two rows and just one column
par(mfrow=c(2,1))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)


#--- day 3

plot(l2011$B1_sre)

# plot the blue band using a blue colorRampPalette
clb <- colorRampPalette(c("dark blue","blue","light blue"))(100)
plot(l2011$B1_sre, col=clb)

# multiframe
# the first number is the number of rows in the multiframe, while the second one is the mnumber of columns
par(mfrow=c(1,2)) 
#by doing so, you create a multiframe with one row and two columns. 

# plot the blue and the green besides, with different colorRampPalette
clb <- colorRampPalette(c("dark blue","blue","light blue"))(100)
plot(l2011$B1_sre, col=clb)

clg <- colorRampPalette(c("dark green","green","light green"))(100)
plot(l2011$B2_sre, col=clg)

# Exercirse: put the plots one on top of the other
# invert the number of rows and the number of columns
# the first number is the number of rows in the multiframe, while the second one is the number of columns
par(mfrow=c(2,1)) 
#opposite of what we did previously, first number for rows, second columns.
#multiframe will have one column and two rows. 

# plot the blue and the green besides, with different colorRampPalette
#we are playing with colours: creation of different palette for each color band. 
clb <- colorRampPalette(c("dark blue","blue","light blue"))(100)
plot(l2011$B1_sre, col=clb)

clg <- colorRampPalette(c("dark green","green","light green"))(100)
plot(l2011$B2_sre, col=clg)

# Exercise: plot the first four bands with two rows and two columns
par(mfrow=c(2,2)) # the first number is the number of rows in the multiframe, while the second one is the mnumber of columns

clb <- colorRampPalette(c("dark blue","blue","light blue"))(100)
plot(l2011$B1_sre, col=clb)

clg <- colorRampPalette(c("dark green","green","light green"))(100)
plot(l2011$B2_sre, col=clg)

clr <- colorRampPalette(c("dark red","red","pink"))(100)
plot(l2011$B3_sre, col=clr)
  
clnir <- colorRampPalette(c("red","orange","yellow"))(100)
plot(l2011$B4_sre, col= clnir)
  
# dev.off()
 
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")  # natural colours
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")  # false colours
plotRGB(l2011, r=3, g=4, b=2, stretch="Lin")  # false colours
plotRGB(l2011, r=3, g=2, b=4, stretch="Lin")  # false colours

par(mfrow=c(2,2))
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")  # natural colours
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")  # false colours
plotRGB(l2011, r=3, g=4, b=2, stretch="Lin")  # false colours
plotRGB(l2011, r=3, g=2, b=4, stretch="Lin")  # false colours
  
# last day with this very first raster analysis 

plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")  
plotRGB(l2011, r=4, g=3, b=2, stretch="Hist") 
  
# Importing past data
#setwd("~/lab/") # in case you are on a new R session
l1988 <- brick("p224r63_1988.grd")  
l1988
  
par(mfrow=c(2,1))
plotRGB(l1988, r=4, g=3, b=2, stretch="Lin")  
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")  

# Put the NIR in the blue channel
plotRGB(l1988, r=2, g=3, b=4, stretch="Lin")  
plotRGB(l2011, r=2, g=3, b=4, stretch="Lin") 