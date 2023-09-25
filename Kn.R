###
# This code calculates Kn values from existing rasters, saves those values, and plots Kn as well as R. The modifications used herein are studied and the graphics used in the Kn file.
###
###

require(rgdal)
require(raster)
require(terra)
require(maps)

MAP<- raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/MAP_global.tif")
MAET<-raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/MAET_global.tif")
#removes MAET and MAP values less than 100 and MASRB values >200
#see study on effects this has on the global Kn graphs (deserts had Kns that were far too large to be reasonable)
MAET[MAET@data@values<0.1] <- NA 
MAP[MAP@data@values<0.1] <-NA
Kn <- MAP/MAET

plot(Kn, col =hcl.colors(100,"Turku"),
     plot.title = title(main ="Kn"),
     xlab = "Longitude",
     ylab = "Latitude",
     useRaster=FALSE,
     box=FALSE)
map("world",add=T,fill=FALSE, interior = FALSE, lwd = 0.08)
writeRaster(Kn,"/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/Kn_global.tif", overwrite = TRUE)


NZ_p <- spPolygons(NZ_poly)

test <- clip(Kn, NZ_p)



