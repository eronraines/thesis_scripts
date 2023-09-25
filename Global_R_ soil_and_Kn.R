###
# This code calculates Kn values from existing rasters, saves those values, and plots Kn as well as R
###
###

require(rgdal)
require(raster)
require(terra)
require(maps)

MAP<- raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/MAP_global.tif")
MAET_global<-raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/MAET_global.tif")
MASRB_raster<-raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/MASRB_global.tif")
#MAET is different extent, have to resample
MAET_global<-resample(MAET_global,MAP)
#MASRB is different extent, have to resample
MASRB<-resample(MASRB_raster,MAP)
#Kn is calculated by Volobuev as MAP/En where En is evaporability - a term analogous to evapotranspiration (see Volobuev 1965 "Ecology of Soils")
Kn<-MAP/MAET_global

# Kn includes deserts which will potentially make Kn much larger, will strip out extreme conditions and store as Kn2. Stripping out MAP and MAET that are < 250 mm year^-1
MAP2 <- MAP
MAP2[MAP2@data@values < 50] <- NA
MAET2 <- MAET_global
MAET2[MAET2@data@values < 50] <- NA
Kn2 <- MAP2/MAET2

# logging Kn for plotting
Kn_log <- log10(Kn2)
# ensureing Kn is only for terrestrial
Kn_mask <- mask(Kn, land)

# this is the Kn value plotted that includes the extremely dry conditions
plot(Kn, col =hcl.colors(100,"Turku"),
     plot.title = title(main = "Kn"),
     xlab = "Longitude",
     ylab = "Latitude",
     useRaster=FALSE,
     box=FALSE)
map("world",add=T,fill=FALSE, interior = FALSE, lwd = 0.08)
# this the Kn value plotted that does not include the extremely dry conditions
plot(Kn2, col =hcl.colors(100,"Turku"),
     plot.title = title(main ="Kn"),
     xlab = "Longitude",
     ylab = "Latitude",
     useRaster=FALSE,
     box=FALSE)
map("world",add=T,fill=FALSE)
writeRaster(Kn,"/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/Kn_all_global.tif")
writeRaster(Kn2,"/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/Kn_250mmyr_stripped_global.tif")











#Volobuev's R is the surface net radiation balance
#this will correspond to the Kn with all
MASRB_globe <- MASRB
MASRB_globe[MASRB_globe]

plot(MASRB_globe, col =hcl.colors(12*10,"Temps"),
     plot.title = title(main = "R"),
     xlab = "Longitude",
     ylab = "Latitude",
     useRaster=F)
# map("world",add=T,fill=FALSE)
mtext(expression("W m"^-2),4,5)


# plotting the negative MSRBS only
MASRB2 <- MASRB
MASRB2[MASRB2@data@values>0]<-NA

plot(MASRB2, col =hcl.colors(12,"Temps"),
     plot.title = title(main = "MASRB < 0"),
     xlab = "Longitude",
     ylab = "Latitude",
     useRaster=F)
map("world",add=T,fill=FALSE, interior = FALSE, lwd = 0.08)

