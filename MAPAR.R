###
# This code calculates Kn values from existing rasters, saves those values, and plots Kn as well as R. The modifications used herein are studied and the graphics used in the Kn file.
###
###

require(rgdal)
require(raster)
require(terra)
require(maps)

MAP<- raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/MAP_global.tif")
MAPAR<-brick("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/MAPAR_global.tif")
#MASRB is different extent, have to resample
MAPAR<-resample(MAPAR,MAP)

# trims to land surface
MAPAR <- mask(MAPAR,land)

MAPAR<-na.omit(MAPAR)



plot(MAPAR, col =hcl.colors(100,"Temp"),
     plot.title = title(main ="Mean Annual Photosynthetically Active Radiation"),
     xlab = "Longitude",
     ylab = "Latitude",
     useRaster=FALSE,
     box=FALSE)
map("world",add=T,fill=FALSE, interior = FALSE, lwd = 0.08)
mtext(expression("W m"^-2),4,5)
writeRaster(MAPAR,"/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/MAPAR_global.tif", overwrite = TRUE)
