###
# This code calculates Kn values from existing rasters, saves those values, and plots Kn as well as R. The modifications used herein are studied and the graphics used in the Kn file.
###
###

require(rgdal)
require(raster)
require(terra)
require(maps)



plot(MASRB, col =hcl.colors(100,"Temp"),
     plot.title = title(main ="Mean Annual Surface Radiation Budget"),
     xlab = "Longitude",
     ylab = "Latitude",
     useRaster=FALSE,
     box=FALSE)
map("world",add=T,fill=FALSE, interior = FALSE, lwd = 0.08)
mtext(expression("W m"^-2),4,5)
writeRaster(MASRB,"/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/MASRB_global.tif", overwrite = TRUE)
