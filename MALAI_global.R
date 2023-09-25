require(raster)


LAI2<-raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/LAI2_global.tif")
LAI3<-raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/LAI3_global.tif")
LAI4<-raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/LAI4_global.tif")
LAI5<-raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/LAI5_global.tif")
LAI6<-raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/LAI6_global.tif")

LAI <-stack(LAI2,LAI3,LAI4,LAI5,LAI6)
LAI <-brick(LAI)
MALAI <- brick(mean(LAI))
#the SET raster is too high resolution - it differs from the other maps used. setting resolution to MAP raster (which is what all others are set to). Will need to run global_MAP.R before this section works
MAP <- raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/MAP_global.tif")
MALAI <- resample(MALAI,MAP)
#have to run Global parameter.R to get land mask
MALAI <- mask(LAI,land)
plot(MALAI, col =hcl.colors(100,"Temp"),
     plot.title = title(main ="Mean Annual Leaf Area Index"),
     xlab = "Longitude",
     ylab = "Latitude",
     useRaster=FALSE,
     box=FALSE)
map("world",add=T,fill=FALSE, interior = FALSE, lwd = 0.08)
writeRaster(MALAI,"/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/MALAI_global.tif", overwrite = TRUE)
