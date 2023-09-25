

### 
###
# This code pulls the FAO soil taxonomy information for a set of spatial   # points
###
###
require(sf)
require(rgdal)
require(raster)
require(terra)
require(maps)
####
####
# Call in the rasters used
####
####
MAP<- raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/MAP_global.tif")
MAET_global<-raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/MAET_global.tif")
MASRB_raster<-raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/MASRB_global.tif")

plot(MASRB_raster)
#MAET is different extent, have to resample
MAET<-resample(MAET_global,MAP)
#MASRB is different extent, have to resample
MASRB<-resample(MASRB_raster,MAP)

Ebio <-raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/Ebio_global.tif")
Ebio <- resample(Ebio, MAP)
#removes MAET and MAP values less than 100 and MASRB values >200
#see study on effects this has on the global Kn graphs (deserts had Kns that were far too large to be reasonable)
MAET[MAET@data@values<100] <- NA
MAP[MAP@data@values<100] <-NA
MASRB[MASRB@data@values>200]<-NA
Kn2 <- MAP/MAET

####
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




plot(log10(stack$layer),stack$MASRB_global, pch=".", maxpixels=10000000,xlab="Kn",ylab="MASRB (W m^-2")


points(gs_df, pch=".", col="red",add=TRUE)


plot(stack)



# all values
stack <-stack(Kn,MASRB,global_soils)
df <- as.data.frame(stack, xy = TRUE) # this works with Raster* objects as well
Kn<-df$layer
MASRB<-df$MASRB
plot(Kn,MASRB, pch=".", main = expression(paste("K"[n], "vs MASRB")))
