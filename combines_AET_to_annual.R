require(terra)
require(raster)
# data obtained from Elnashar Abdelrazek and stored in working directory
raster <- raster::stack(
  "/Users/eronraines/Desktop/Chapter 3 data/SET/raw data/SET_mean_1982_2019_1.tif",
  "/Users/eronraines/Desktop/Chapter 3 data/SET/raw data/SET_mean_1982_2019_2.tif",
  "/Users/eronraines/Desktop/Chapter 3 data/SET/raw data/SET_mean_1982_2019_3.tif",
  "/Users/eronraines/Desktop/Chapter 3 data/SET/raw data/SET_mean_1982_2019_4.tif",
  "/Users/eronraines/Desktop/Chapter 3 data/SET/raw data/SET_mean_1982_2019_5.tif",
  "/Users/eronraines/Desktop/Chapter 3 data/SET/raw data/SET_mean_1982_2019_6.tif",
  "/Users/eronraines/Desktop/Chapter 3 data/SET/raw data/SET_mean_1982_2019_7.tif",
  "/Users/eronraines/Desktop/Chapter 3 data/SET/raw data/SET_mean_1982_2019_8.tif",
  "/Users/eronraines/Desktop/Chapter 3 data/SET/raw data/SET_mean_1982_2019_9.tif",
  "/Users/eronraines/Desktop/Chapter 3 data/SET/raw data/SET_mean_1982_2019_10.tif",
  "/Users/eronraines/Desktop/Chapter 3 data/SET/raw data/SET_mean_1982_2019_11.tif",
  "/Users/eronraines/Desktop/Chapter 3 data/SET/raw data/SET_mean_1982_2019_12.tif"
)
# convert to spatraster
SET_stack <- rast(raster)

## the following operations will take some time to do, that is normal
#NAs were stored as -9999, need to reassign to strip NAs
SET_stack[SET_stack==-9999] <-NA
#removes NAs
SET_stack <- na.omit(SET_stack)
#averages each global point
SET_mu <- mean(SET_stack)
#reformats the values so that what is stored is the mean annual ET value
SET_global <- (SET_mu/1000*12)# divide by 1000 because of how data stored, multiply by 12 to get mean annual
rs1 <- brick(SET_global) # gotta brick it to resample it
#the SET raster is too high resolution - it differs from the other maps used. setting resolution to MAP raster (which is what all others are set to). Will need to run global_MAP.R before this section works
MAP <- raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/MAP_global.tif")
rs2 <- resample(rs1,MAP)
#have to run Global parameter.R to get land mask
rs3 <- mask(rs2,land)
#plot that mess
plot(rs3, col =hcl.colors(12*12,"Temps"),
     plot.title = title(main = "Mean Annual Evapotranspiration"),
     xlab = "Longitude",
     ylab = "Latitude",
     useRaster=FALSE,
     box=FALSE)
map("world",add=T,fill=FALSE, interior = FALSE, lwd = 0.08)
mtext(expression("mm yr"^-1),4,6)
#writes the new raster to some working directory
writeRaster(rs3,"/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/MAET_global.tif", overwrite = TRUE)

