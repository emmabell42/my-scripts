## This script makes a silly Venn diagram. 
## It is adapted from https://www.r-graph-gallery.com/14-venn-diagramm.html

# Load libraries
library(VennDiagram)
library(viridis)

# Generate 3 sets of 200 words
set1 <- paste(rep("word_" , 200) , sample(c(1:1000) , 200 , replace=F) , sep="")
set2 <- paste(rep("word_" , 200) , sample(c(1:1000) , 200 , replace=F) , sep="")
set3 <- paste(rep("word_" , 200) , sample(c(1:1000) , 200 , replace=F) , sep="")

# Prepare a palette of 3 colors with R colorbrewer:
myCol <- inferno(n = 3, begin = 0.2, end = 0.8)
myCol.alpha <- inferno(n = 3, begin = 0.2, end = 0.8, alpha = 0.3)

# Chart
venn.diagram(
  x = list(set1, set2, set3),
  category.names = c("Checking who\nwon Pennsylvania" , "Slowing the spread\nof coronavirus " , "Making a venn diagram"),
  filename = '#14_venn_diagramm.png',
  output=TRUE,
  imagetype="png" ,
  height = 480 , 
  width = 480 , 
  resolution = 300,
  compression = "lzw",
  lwd = 1,
  col = myCol,
  fill = myCol.alpha,
  cex = 0,
  fontfamily = "sans",
  cat.cex = 0.3,
  cat.default.pos = "text",
  cat.pos = c(0, 0, 180),
  cat.dist = c(0.035, 0.035, -0.015),
  cat.fontfamily = "sans",
  cat.col = myCol,
  rotation = 1,
  main = "Control R",
  main.pos = c(0.5,0.55),
  main.col = "chocolate",
  main.cex = 0.35,
  main.fontfamily = "sans"
)
