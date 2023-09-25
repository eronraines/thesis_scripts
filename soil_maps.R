# clean up
rm(list=ls(all=T))
gc()
# .rs.restartR() #optional. recommended if performance degraded.
rm(list=ls(all=T))
gc()

# libraries used
library(raster)
library(leaflet)
library(rgdal)
library(geobuffer)
library(terra)
library(sf)
library(beepr)
beep(3)
# data of interest
soil <-readOGR("/Volumes/WD_BLACK/NZ/mfe-fundamental-soil-layers-new-zealand-soil-classification-SHP/fundamental-soil-layers-new-zealand-soil-classification.shp") 

## site coordinates
#tararua
TAR1200<-cbind(175.266686,-40.927239)
TAR800<-cbind(175.247841,-40.903073)
TAR400<-cbind(175.235790,-40.883049)
TAR <- rbind(TAR1200,TAR800,TAR400)
#southern alps
DOB1400<-cbind(169.977606,-43.810735)
## study area DEM
tar <-raster("/Volumes/WD_BLACK/NZ/TAR_B_for_plotting/nzdem-north-island-25-metre.tif")
sa <-raster("/Volumes/WD_BLACK/Map building/quick_call_rasters/sa_study_region.tif")


###
###
# These coordinates are in WGS89. For the NZ tifs, NZTM is needed.
# building a Tararua range polygon
# these coordinates relate the spatial extent of the Tararua Range as observed using Google Earth Pro
tar_x_coords <- c(extent(tar)[1],extent(tar)[2])
tar_y_coords <- c(extent(tar)[3],extent(tar)[4])
tar_extent <- cbind(tar_x_coords,tar_y_coords) # combining coordinates
tar_p <- Polygon(tar_extent)
tar_p <- Polygons(list(tar_p),1)
tar_p <- SpatialPolygons(list(tar_p))
tar_p@proj4string<-crs(tar)
# building Tararua range points
tar_lon2 <- runif(100000000, min(tar_x_coords),max(tar_x_coords)) # this generates longitude values within the coordinates to call the climate data from the Tararua Range
tar_lat2 <- runif(100000000, min(tar_y_coords),max(tar_y_coords)) # this generates latitude values within the coordinates to call the climate data from the Tararua Range
tar_points<-cbind(tar_lon2,tar_lat2) # for extracting from region to generate sample of local conditions
tar_points_SP <- data.frame(x=tar_points[,1],y=tar_points[,2]) 
tar_points_SP <- SpatialPoints(cbind(x=tar_points[,1],y=tar_points[,2]),
                               proj4string = CRS("+proj=longlat +datum=WGS84 +no_
                                               defs +ellps=WGS84 +towgs84=0,0,0
                                               "))

# Tararua sites
TAR1200_SP <- data.frame(x=TAR1200[,1],y=TAR1200[,2]) 
TAR1200_SP <- SpatialPoints(cbind(x=TAR1200[,1],y=TAR1200[,2]),
                            proj4string = CRS("+proj=longlat +datum=WGS84 +no_
                                               defs +ellps=WGS84 +towgs84=0,0,0
                                               "))

TAR800_SP <- data.frame(x=TAR800[,1],y=TAR800[,2]) 
TAR800_SP <- SpatialPoints(cbind(x=TAR800[,1],y=TAR800[,2]),
                           proj4string = CRS("+proj=longlat +datum=WGS84 +no_
                                               defs +ellps=WGS84 +towgs84=0,0,0
                                               "))
TAR400_SP <- data.frame(x=TAR400[,1],y=TAR400[,2]) 
TAR400_SP <- SpatialPoints(cbind(x=TAR400[,1],y=TAR400[,2]),
                           proj4string = CRS("+proj=longlat +datum=WGS84 +no_
                                               defs +ellps=WGS84 +towgs84=0,0,0
                                               "))

# builds radius = 100m circular buffers around points
#TAR1200
tar1200pts <- SpatialPoints(TAR1200,
                            proj4string = CRS("+proj=longlat +datum=WGS84 +no_
                                               defs +ellps=WGS84 +towgs84=0,0,0
                                               "))

TAR1200_100m <- geobuffer_pts(xy = tar1200pts, dist_m = 500)
tar1200_lon <- runif(10000, TAR1200_100m@bbox[1,1],TAR1200_100m@bbox[1,2]) # this generates longitude values within the coordinates to call the climate data from the Tararua Range
tar1200_lat <- runif(10000, TAR1200_100m@bbox[2,1],TAR1200_100m@bbox[2,2]) # this generates latitude values within the coordinates to call the climate data from the Tararua Range
Tar1200_points<-cbind(tar1200_lon,tar1200_lat)
Tar1200_df <- data.frame(x=Tar1200_points[,1],y=Tar1200_points[,2])
Tar1200_SP <- SpatialPoints(cbind(x=Tar1200_df[,1],y=Tar1200_df[,2]),
                            proj4string = CRS("+proj=longlat +datum=WGS84 +no_
                                               defs +ellps=WGS84 +towgs84=0,0,0
                                               "))
#TAR800
tar800pts <- SpatialPoints(TAR800,
                           proj4string = CRS("+proj=longlat +datum=WGS84 +no_
                                               defs +ellps=WGS84 +towgs84=0,0,0
                                               "))

TAR800_100m <- geobuffer_pts(xy = tar800pts, dist_m = 100)
tar800_lon <- runif(10000, TAR800_100m@bbox[1,1],TAR800_100m@bbox[1,2]) # this generates longitude values within the coordinates to call the climate data from the Tararua Range
tar800_lat <- runif(10000, TAR800_100m@bbox[2,1],TAR800_100m@bbox[2,2]) # this generates latitude values within the coordinates to call the climate data from the Tararua Range
Tar800_points<-cbind(tar800_lon,tar800_lat)
Tar800_df <- data.frame(x=Tar800_points[,1],y=Tar800_points[,2])
Tar800_SP <- SpatialPoints(cbind(x=Tar800_df[,1],y=Tar800_df[,2]),
                           proj4string = CRS("+proj=longlat +datum=WGS84 +no_
                                               defs +ellps=WGS84 +towgs84=0,0,0
                                               "))
## building buffers
#TAR400
tar400pts <- SpatialPoints(TAR400,
                           proj4string = CRS("+proj=longlat +datum=WGS84 +no_
                                               defs +ellps=WGS84 +towgs84=0,0,0
                                               "))

TAR400_100m <- geobuffer_pts(xy = tar400pts, dist_m = 100)
tar400_lon <- runif(10000, TAR400_100m@bbox[1,1],TAR400_100m@bbox[1,2]) # this generates longitude values within the coordinates to call the climate data from the Tararua Range
tar400_lat <- runif(10000, TAR400_100m@bbox[2,1],TAR400_100m@bbox[2,2]) # this generates latitude values within the coordinates to call the climate data from the Tararua Range
Tar400_points<-cbind(tar400_lon,tar400_lat)
Tar400_df <- data.frame(x=Tar400_points[,1],y=Tar400_points[,2])
Tar400_SP <- SpatialPoints(cbind(x=Tar400_df[,1],y=Tar400_df[,2]),
                           proj4string = CRS("+proj=longlat +datum=WGS84 +no_
                                               defs +ellps=WGS84 +towgs84=0,0,0
                                               "))


# building a Southern Alps polygon
# these coordinates relate the spatial extent of the Southern Alps as observed using Google Earth Pro
SA_x_coords <- c(extent(sa)[1],extent(sa)[2])
SA_y_coords <- c(extent(sa)[3],extent(sa)[4])
SA_extent <- cbind(SA_x_coords,SA_y_coords) # combining coordinates
SA_p <- Polygon(SA_extent)
SA_p <- Polygons(list(SA_p),1)
SA_p <- SpatialPolygons(list(SA_p))
SA_p@proj4string <- crs(sa)
# building SA range points
SA_lon2 <- runif(100000000, min(SA_x_coords),max(SA_x_coords)) # this generates longitude values within the coordinates to call the climate data from the Tararua Range
SA_lat2 <- runif(100000000, min(SA_y_coords),max(SA_y_coords)) # this generates latitude values within the coordinates to call the climate data from the Tararua Range
SA_points<-cbind(SA_lon2,SA_lat2)
SA_points_SP <- data.frame(x=SA_points[,1],y=SA_points[,2]) 
SA_points_SP <- SpatialPoints(cbind(x=SA_points_SP[,1],y=SA_points_SP[,2]),
                              proj4string = CRS("+proj=longlat +datum=WGS84 +no_
                                               defs +ellps=WGS84 +towgs84=0,0,0
                                               "))

# SA site
DOB1400_SP <- data.frame(x=DOB1400[,1],y=DOB1400[,2]) 
DOB1400_SP <- SpatialPoints(cbind(x=DOB1400[,1],y=DOB1400[,2]),
                            proj4string = CRS("+proj=longlat +datum=WGS84 +no_
                                               defs +ellps=WGS84 +towgs84=0,0,0
                                               "))

## builds 100m radius circular buffers around site
#DOB1400
dob1400pts <- SpatialPoints(DOB1400,
                            proj4string = CRS("+proj=longlat +datum=WGS84 +no_
                                               defs +ellps=WGS84 +towgs84=0,0,0
                                               "))
DOB1400_100m <- geobuffer_pts(xy = dob1400pts, dist_m = 100)
dob1400_lon <- runif(10000, DOB1400_100m@bbox[1,1],DOB1400_100m@bbox[1,2]) # this generates longitude values within the coordinates to call the climate data from the Tararua Range
dob1400_lat <- runif(10000, DOB1400_100m@bbox[2,1],DOB1400_100m@bbox[2,2]) # this generates latitude values within the coordinates to call the climate data from the Tararua Range
Dob1400_points<-cbind(dob1400_lon,dob1400_lat)
Dob1400_df <- data.frame(x=Dob1400_points[,1],y=Dob1400_points[,2])
Dob1400_SP <- SpatialPoints(cbind(x=Dob1400_df[,1],y=Dob1400_df[,2]),
                            proj4string = CRS("+proj=longlat +datum=WGS84 +no_
                                               defs +ellps=WGS84 +towgs84=0,0,0
                                               "))



## soil for regions
SA_SOILS <- over(SA_points_SP,soil)
TAR_SOILS <- over(tar_points_SP,soil)
 
SA_table <- data.frame(table(SA_SOILS))
TAR_table <- data.frame(table(TAR_SOILS))

write.csv(SA_table,"/Users/eronraines/Desktop/Chapter 3 data/table building/sa_soils.csv")
write.csv(TAR_table,"/Users/eronraines/Desktop/Chapter 3 data/table building/tar_soils.csv")
## soil for buffers

t400_100m<-over(Tar400_SP,soil)
t800_100m<-over(Tar800_SP,soil)
t1200_100m<-over(Tar1200_SP,soil)
t400_tab <- data.frame(table(t400_100m))
t800_tab <- data.frame(table(t800_100m))
t1200_tab <- data.frame(table(t1200_100m))


write.csv(t400_tab,"/Users/eronraines/Desktop/Chapter 3 data/table building/t400buff_soils.csv")
write.csv(t800_tab,"/Users/eronraines/Desktop/Chapter 3 data/table building/t800buff_soils.csv")
write.csv(t1200_tab,"/Users/eronraines/Desktop/Chapter 3 data/table building/t1200buff_soils.csv")


dob1300_100m<-over(Dob1400_SP,soil)
d1300_tab <- data.frame(table(dob1300_100m))


write.csv(dob1300_tab,"/Users/eronraines/Desktop/Chapter 3 data/table building/d1300buff_soils.csv")

## soil for points

t400 <- over(TAR400_SP,soil)
t800 <- over(TAR800_SP,soil)
t1200 <- over(TAR1200_SP,soil)
d1300 <- over(DOB1400_SP,soil)










