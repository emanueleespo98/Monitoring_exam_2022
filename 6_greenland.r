#6th file: time series analysis of Greenland increase of temperature

# same first steps: install packages, load library, set wd
# install.packages("raster")
# install.packages("rasterVis")
library(raster)
#library(rasterVis) 
library(patchwork)
# library(rgdal)

# setwd("~/lab/greenland") # Linux
setwd("C:/monitoring_lab/greenland") # Windows
# setwd("/Users/name/Desktop/lab/greenland") # Mac 

#now we are going to load the data
# list f files: creation of the list, you load the files with a similar pattern
rlist <- list.files(pattern="lst")
rlist

# proper load of rasters with lapply
import <- lapply(rlist,raster)
import

# finally: you can stack all the rasters in a single object, then yoy plot it
TGr <- stack(import)
TGr
plot(TGr)

#levelplot(TGr)
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
plot(TGr, col=cl)

# you can personalize the plot for an improved visualization!
plot(TGr,col=cl, names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))

plot(TGr,col.regions=cl, main="LST variation in time", names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))

p1 <- ggplot() + 
geom_raster(TGr$lst_2000, mapping = aes(x=x, y=y, fill=lst_2000)) +
scale_fill_viridis(option="magma") 
# ggtitle("cividis palette")

p2 <- ggplot() + 
geom_raster(TGr$lst_2015, mapping = aes(x=x, y=y, fill=lst_2015)) +
scale_fill_viridis(option="magma") 

p1+p2

# stats

plot(TGr$lst_2000, TGr$lst_2015)
abline(0,1,col="red")

pairs(TGr)


