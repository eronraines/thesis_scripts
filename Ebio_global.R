###
# This code calculates Kn values from existing rasters, saves those values, and plots Kn as well as R. The modifications used herein are studied and the graphics used in the Kn file.
###
###

require(rgdal)
require(raster)
require(terra)
require(maps)

MAPAR<- raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/MAPAR_global.tif")
MALAI<-raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/MALAI_global.tif")
MAfAPAR<-raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/MAfAPAR_global.tif")
area_ras <- area(MALAI) # this creates a raster where each xy's z is the cells area
A <-MALAI * area_ras # this product yields the leaf area (km^2) per cell
A <- A * 1000000 # leaf area (km^2) to (m^2) per cell
B <- MAPAR * MAfAPAR # the PAR absorbed per m^2 leaf (W/m^2)
C <- A * B # the W absorbed by plants
D <- C/(area_ras*1000000) # the W/m^2 entering plants in the grid
D[D[[1]]>134.2384] <- 134.2384 # ensures that no more that PAR entering plants cannot be larger than the total PAR entering the system
Ebio <- brick(D)

plot(Ebio, col =hcl.colors(100,"Turku"),
     plot.title = title(main =expression("E"["bio"]),
     xlab = "Longitude",
     ylab = "Latitude",
     ylim = c(-90,90),
     xlim = c(-180,180),
     useRaster=FALSE,
     box=FALSE))
map("world",add=T,fill=FALSE, interior = FALSE, lwd = 0.08)
mtext(expression("W m"^-2),4,5)
writeRaster(Ebio,"/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/Ebio_global.tif", overwrite = TRUE)
