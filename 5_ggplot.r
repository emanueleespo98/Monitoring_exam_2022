#5th code: uploading and visualization of copernicus data in R
# as usual, installation of packages and library loading 
# install.packages("ncdf4")
# install.packages("viridis")
library(ncdf4)
library(raster)
library(RStoolbox)
library(viridis)
library(ggplot2)
library(patchwork)

# set the wd
# setwd("~/lab/copernicus/") # Linux 
 setwd("C:/monitoring_lab/copernicus/")  # windows
# setwd("/Users/name/lab/copernicus/") # mac

# now we are going to upload the first raster

snow20211214 <- raster("c_gls_SCE_202112140000_NHEMI_VIIRS_V1.0.1.nc")
# to see how many layers are inside Copernicus data you need to create a new object with brick function:
 snow20211214_ <- brick("c_gls_SCE_202112140000_NHEMI_VIIRS_V1.0.1.nc")
# then you can visualize differences 
snow20211214
snow20211214_
# and finally you can create a plot
plot(snow20211214)
# as usual, we prefer to visualize rasters with a personal color palette
cl <- colorRampPalette(c("dark blue","blue","light blue"))(100)
plot(snow20211214, col=cl)

# this is a bad example, there are some rules that should be followed to better visualize informations!
cl <- colorRampPalette(c("blue","green","red"))(100)
plot(snow20211214, col=cl)

#########à
# ggplot function
# gg plot is a very useful package to create powerful graphs
ggplot() + 
geom_raster(snow20211214, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent))  

# ggplot function with viridis
ggplot() + 
geom_raster(snow20211214, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent)) +
scale_fill_viridis() 

ggplot() + 
geom_raster(snow20211214, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent)) +
scale_fill_viridis(option="cividis") 

ggplot() + 
geom_raster(snow20211214, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent)) +
scale_fill_viridis(option="cividis") + 
ggtitle("cividis palette")


#################################################### day 2

# importing all the data together with the lapply function
# we have already done this operation
# first: load within a list object, a set of data with a similar pattern
rlist <- list.files(pattern="SCE")
rlist
# second: lapply function to load each file as a proper raster
list_rast <- lapply(rlist, raster)
list_rast
# third: stack all the rasters all together 
snowstack <- stack(list_rast)
snowstack

#we can separate summer and winter images creating new objects
ssummer <- snowstack$Snow.Cover.Extent.1
swinter <- snowstack$Snow.Cover.Extent.2

ggplot() + 
geom_raster(ssummer, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.1)) +
scale_fill_viridis(option="viridis") +
ggtitle("Snow cover during my birthday!")

ggplot() + 
geom_raster(swinter, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.2)) +
scale_fill_viridis(option="viridis") +
ggtitle("Snow cover during freezing winter!")

# let's patchwork them together

p1 <- ggplot() + 
geom_raster(ssummer, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.1)) +
scale_fill_viridis(option="viridis") +
ggtitle("Snow cover during my birthday!")

p2 <- ggplot() + 
geom_raster(swinter, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.2)) +
scale_fill_viridis(option="viridis") +
ggtitle("Snow cover during freezing winter!")

analysis1 <- p1 / p2


# you can crop your image on a certain area
# this is very useful especially when raster images are too heavy or you are interested in an analysis of a small area
# you can save time and stress on you PC!


# longitude from 0 to 20
# latitude from 30 to 50

# crop the stack to the extent of Sicily
ext <- c(0, 20, 30, 50)
# stack_cropped <- crop(snowstack, ext) # this will crop the whole stack, and then single variables (layers) can be extracted

ssummer_cropped <- crop(ssummer, ext)
swinter_cropped <- crop(swinter, ext)

p1 <- ggplot() + 
geom_raster(ssummer_cropped, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.1)) +
scale_fill_viridis(option="viridis") +
ggtitle("Snow cover during my birthday!")

p2 <- ggplot() + 
geom_raster(swinter_cropped, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.2)) +
scale_fill_viridis(option="viridis") +
ggtitle("Snow cover during freezing winter!")

 analysis2 <- p1 / p2

# the result is going to be the same as before, but with a cropped image. 

# if you want to see the differences:

par(mfrow = c(1,2))
plot(analysis1)
plot(analysis2)












