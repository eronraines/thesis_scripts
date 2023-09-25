require(raster)


GLiM <- raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/glims_025deg.tif")




GLiM[GLiM@data@values == -Inf]<-NA

table(GLiM@data@values)

GLiM@data@values
