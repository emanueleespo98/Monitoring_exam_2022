#  in this files i'm going to put all the lesson in a more functional way.
# the very first project we create is about objects. objects are the R virtual entities we use to do our nerd things


# first of all we need some data. Costanza is providing us some data about streams
# Costanza data on streams. this is our first input
water <- c(100, 200, 300, 400, 500)
water

# then, we add Marta's data on fishes genomes. second example
fishes <- c(10, 50, 60, 100, 200)
fishes

# at this point we have two objects: vectors. vectors are unidimensional 
# plot the diversity of fishes (y) versus the amount of water (x)
# plot is our first R function. in order to work, a function needs arguments: 
# our arguments are the input data previously created
plot(water, fishes)

# the data we have developed can be stored in a table
# a table in R is called data frame. this is the first structure we create

streams <- data.frame(water, fishes)
streams


# From now on, we are going to import and/or export data!
# Importing data and exporting them is very useful. To do that, you need to create a working directory: wd

# For Linux (Ubuntu, Fedora, Debian, Mandriva) users
# setwd("~/lab/")

# setwd for Windows
 setwd("C:/monitoring_lab/")

# setwd Mac
# setwd("/Users/yourname/lab/")

# how to save a table? write.table function
# https://www.rdocumentation.org/packages/utils/versions/3.6.2/topics/write.table
write.table(streams, file="my_first_table.txt")

# Some colleagues did send us a table How to import it in R?
# read.table function: the most useful way to import a table
read.table("my_first_table.txt")
# let's assign it to an object inside R
table1 <- read.table("my_first_table.txt")

# the first statistics for lazy beautiful people
summary(table1)

# you can extract informations about a spefic raw/column. To do that you use $ sign.
summary(table1$fishes)

# histogram
# hist function is the easier way to create our first graph
hist(table1$fishes)
hist(table1$water)


