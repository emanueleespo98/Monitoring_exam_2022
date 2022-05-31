#7th project: multivar 
# lesson lost, this is about multivar, ecography.
# ecological analysis are about multi dimensions, let's see what you can do
# install and load library, set wd
# install.packages("vegan")
library(vegan)

# setwd("path/lab")

# setwd for Windows
 setwd("C:/monitoring_lab/")

# setwd Mac
# setwd("/Users/yourname/lab/")

# Linux
#setwd("~/lab/")

load("biomes_multivar.RData")
ls()

# plot per species matrix
head(biomes)

multivar <- decorana(biomes)
multivar

plot(multivar)

# biomes names in the graph:
# with the following functions, when you have opened a plot you can modify it adding some useful elements
attach(biomes_types)
ordiellipse(multivar, type, col=c("black","red","green","blue"), kind = "ehull", lwd=3)
ordispider(multivar, type, col=c("black","red","green","blue"), label = T) 

# and in this way you create a pdf file with the work you've done
pdf("multivar.pdf")
plot(multivar)
ordiellipse(multivar, type, col=c("black","red","green","blue"), kind = "ehull", lwd=3)
ordispider(multivar, type, col=c("black","red","green","blue"), label = T) 
dev.off()