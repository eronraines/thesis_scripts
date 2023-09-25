require(raster)


fAPAR2<-raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/fAPAR2_global.tif")
fAPAR3<-raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/fAPAR3_global.tif")
fAPAR4<-raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/fAPAR4_global.tif")
fAPAR5<-raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/fAPAR5_global.tif")
fAPAR6<-raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/fAPAR6_global.tif")



fAPAR <-stack(fAPAR2,fAPAR3,fAPAR4,fAPAR5,fAPAR6)
MAfAPAR <- calc(fAPAR,mean,na.rm=TRUE)
  
  
#the SET raster is too high resolution - it differs from the other maps used. setting resolution to MAP raster (which is what all others are set to). Will need to run global_MAP.R before this section works
MAP <- raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/MAP_global.tif")
MAfAPAR <- resample(MAfAPAR,MAP)
#have to run Global parameter.R to get land mask
MAfAPAR <- mask(MAfAPAR,land)
plot(MAfAPAR, col =hcl.colors(100,"Temp"),
     plot.title = title(main ="Mean Annual fraction Absorbed Photosynthetically Active Radiation"),
     xlab = "Longitude",
     ylab = "Latitude",
     useRaster=FALSE,
     box=FALSE)
map("world",add=T,fill=FALSE, interior = FALSE, lwd = 0.08)
writeRaster(MAfAPAR,"/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/MAfAPAR_global.tif", overwrite = TRUE)
