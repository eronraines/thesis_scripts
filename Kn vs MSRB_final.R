




###
# This code calculates Kn values from existing rasters, saves those values, and plots Kn as well as R. The modifications used herein are studied and the graphics used in the Kn file.
###
###

require(rgdal)
require(raster)
require(terra)
require(maps)
require(sf)
require(rgdal)
library(sp)


MAP<- raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/MAP_global.tif")
MAET_global<-raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/MAET_global.tif")
MASRB_raster<-raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/MASRB_global.tif")
Ebio <- raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/Ebio_global.tif")
#MAET is different extent, have to resample
MAET<-resample(MAET_global,MAP)
#MASRB is different extent, have to resample
MASRB<-resample(MASRB_raster,MAP)
# doing same to Ebio
Ebio<-resample(Ebio,MAP)

#Kn is calculated by Volobuev as MAP/En where En is evaporability - a term analogous to evapotranspiration (see Volobuev 1965 "Ecology of Soils")


Kn<-MAP/MAET
#removes MAET and MAP values less than 100 and MASRB values >200
#see study on effects this has on the global Kn graphs (deserts had Kns that were far too large to be reasonable)
MAET[MAET@data@values<100] <- NA
MAP[MAP@data@values<100] <-NA
MASRB[MASRB@data@values>200]<-NA
Kn2 <- MAP/MAET

stack <-stack(Kn2,MASRB,Ebio)



df <- as.data.frame(stack, xy = TRUE) # this works with Raster* objects as well

plot(log10(df$layer),df$MASRB_global, pch=".",xlab=expression(paste("log10(K"[n],")")),ylab=expression(paste("MASRB (W m"^-2,")")), bty ="n",main = expression(paste("K"[n]," vs MASRB")))








####
#Call in the spatial polygon used
####
####

# this is the shapefile of FAO-UNESCO soil map, download ESRI shapfile, put # in directory, point here
global_soils2<- readOGR("/Users/eronraines/Desktop/Chapter 3 data/DSMW/DSMW.shp") 


gs <- global_soils2


sum(gs$DOMSOI=="Nd")
gs2 <- (gs[gs$DOMSOI == 'Nd',])
stack <- stack(Kn2,MASRB)

Nd <- extract(stack, gs2)
gs_df<-do.call(rbind.data.frame, Nd)

gs_df<-na.omit(gs_df)
points(log10(gs_df$layer),gs_df$MASRB_global, pch=".", col="red")

ARB_gs2 <- extract(MASRB, gs2)



# all values
stack <-stack(Kn,MASRB,global_soils)
df <- as.data.frame(stack, xy = TRUE) # this works with Raster* objects as well
Kn<-df$layer
MASRB<-df$MASRB
plot(Kn,MASRB, pch=".", main = expression(paste("K"[n], "vs MASRB")))









plot(Kn2, col =hcl.colors(100,"Turku"),
     plot.title = title(main ="Kn"),
     xlab = "Longitude",
     ylab = "Latitude",
     useRaster=FALSE,
     box=FALSE)
map("world",add=T,fill=FALSE, interior = FALSE, lwd = 0.08)
