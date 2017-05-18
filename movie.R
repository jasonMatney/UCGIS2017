rm(list=ls())
library("rlas")
library(rgl)
library(colorspace)
setwd("/Users/jason/Desktop/UCGIS2017/project/UIUC")
list.files()
temp = list.files(pattern="*.las")
las.files = lapply(temp, readlasdata)
# 3d plotlist.
nbcol = 100
color = rev(rainbow(nbcol, start = 0/6, end = 4/6))

open3d()

for (i in 1:6) {
  zcol  = with(las.files[[i]], cut(Z, nbcol))
  with(las.files[[i]], plot3d(X,Y,Z, col=color[zcol]))
  movie3d(spin3d(axis = c(0,0,1), rpm = 10), duration=6)
  next3d()
}

