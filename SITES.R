rm(list=ls(all=T))
gc()
# .rs.restartR()
rm(list=ls(all=T))
gc()

# set to where you want to save csvs to
setwd("/Users/eronraines/Desktop/Chapter 3 data/Results")


library(sp)
library(raster)
library(rgdal)
library(geodata)
library(sfheaders)
library(maps)
library(sf)
library(geobuffer)






###
###
# These coordinates are in WGS89. For the NZ tifs, NZTM is needed.
# building a Tararua range polygon
# these coordinates relate the spatial extent of the Tararua Range as observed using Google Earth Pro
tar_x_coords <- c(175.687867,175.378165,174.909617,175.083160,175.406016)
tar_y_coords <- c(-40.423299,-40.617964,-41.045280,-41.095103,-40.873529)
tar_extent <- cbind(tar_x_coords,tar_y_coords) # combining coordinates
tar_p <- Polygon(tar_extent)
tar_p <- Polygons(list(tar_p),1)
tar_p <- SpatialPolygons(list(tar_p))
# building Tararua range points
tar_lon2 <- runif(1000000, min(tar_x_coords),max(tar_x_coords)) # this generates longitude values within the coordinates to call the climate data from the Tararua Range
tar_lat2 <- runif(1000000, min(tar_y_coords),max(tar_y_coords)) # this generates latitude values within the coordinates to call the climate data from the Tararua Range
tar_points<-cbind(tar_lon2,tar_lat2) # for extracting from region to generate sample of local conditions
tar_points_SP <- data.frame(x=tar_points[,1],y=tar_points[,2]) 
tar_points_SP <- SpatialPoints(cbind(x=tar_points[,1],y=tar_points[,2]),
                             proj4string = CRS("+proj=longlat +datum=WGS84 +no_
                                               defs +ellps=WGS84 +towgs84=0,0,0
                                               "))

# Tararua sites
TAR1200<-cbind(175.268228,-40.929936)
TAR800<-cbind(175.247841,-40.903073)
TAR400<-cbind(175.235626,-40.883089)

TAR1200_SP <- data.frame(x=TAR1200[,1],y=TAR1200[,2]) 
TAR1200_SP <- SpatialPoints(cbind(x=TAR1200[,1],y=TAR1200[,2]),
                               proj4string = CRS("+proj=longlat +datum=WGS84 +no_
                                               defs +ellps=WGS84 +towgs84=0,0,0
                                               "))
r<-mask(tarb,TAR800_100m)
plot(r,xlim=c(175.247,175.25))
plot(TAR800_100m,col='black',add=TRUE)
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

TAR1200_100m <- geobuffer_pts(xy = tar1200pts, dist_m = 100)
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
SA_x_coords <- c(
  171.555570,171.056095,168.435137,166.885610,
  166.499775,166.733821,167.341592,167.792938,
  168.083233,169.096690,169.213165,169.998062,
  170.123559,170.623466,170.807136,171.407580,
  172.158162
)
SA_y_coords <- c(
  -42.833918,-42.976302,-44.188347,-45.270994,
  -46.006612,-46.187315,-45.974999,-45.322268,
  -45.359023,-44.701616,-44.465805,-44.216883,
  -43.898415,-43.786714,-43.871487,-43.405304,
  -43.099035
)
SA_extent <- cbind(SA_x_coords,SA_y_coords) # combining coordinates
SA_p <- Polygon(SA_extent)
SA_p <- Polygons(list(SA_p),1)
SA_p <- SpatialPolygons(list(SA_p))
# building SA range points
SA_lon2 <- runif(10000000, min(SA_x_coords),max(SA_x_coords)) # this generates longitude values within the coordinates to call the climate data from the Tararua Range
SA_lat2 <- runif(10000000, min(SA_y_coords),max(SA_y_coords)) # this generates latitude values within the coordinates to call the climate data from the Tararua Range
SA_points<-cbind(SA_lon2,SA_lat2)
SA_points_SP <- data.frame(x=SA_points[,1],y=SA_points[,2]) 
SA_points_SP <- SpatialPoints(cbind(x=SA_points_SP[,1],y=SA_points_SP[,2]),
                            proj4string = CRS("+proj=longlat +datum=WGS84 +no_
                                               defs +ellps=WGS84 +towgs84=0,0,0
                                               "))

# SA site
DOB1400<-cbind(169.977736,-43.810735)
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


###
###
# show sites - may work up better map time permitting. doesn't matter too much..
###


map('nz')
plot(tar_p, col = 'red', add = TRUE)
plot(SA_p, col = 'blue', add = TRUE)
###
###
# Files to be queried
# MAP <- raster("/Volumes/WD_BLACK/NZ/site_data/nzenvds-total-annual-precipitation-v10.tif")
# MAT <- raster("/Volumes/WD_BLACK/NZ/site_data/lenz-mean-annual-temperature.tif")
# MAT<-resample(MAT,MAP)

# Kn <- raster("/Volumes/WD_BLACK/NZ/site_data/nzenvds-rainfall-to-potential-evapotranspiration-ratio-v10.tif")
# Kn <- resample(Kn,MAP)
# MAET <- MAP/Kn
# MASun <- raster("/Volumes/WD_BLACK/NZ/site_data/nzenvds-annual-potential-incoming-solar-radiation-v10.tif")
# MASun <- resample(MASun, MAP)
# MASun <- MASun/(365*24) #Wh m^-2 yr ^-1 to W m^-2
# these are waiting some data from Ecopurnicus - the data downloaded is empty. Need to download the sentinel data set again.
# MAPAR <-MASun * 0.5 # assuming PAR is 50% of sunlight - note, this is adjusted for topography :D
# MAfAPAR <-raster("") # this is waiting on new sentinel data download
# MALAI <-raster("") # this is waiting on new sentinel data download
# area_ras <- area(MALAI) # this creates a raster where each xy's z is the cells area
# A <-MALAI * area_ras # this product yields the leaf area (km^2) per cell
# A <- A * 1000000 # leaf area (km^2) to (m^2) per cell
# B <- MAPAR * MAfAPAR # the PAR absorbed per m^2 leaf (W/m^2)
# C <- A * B # the W absorbed by plants
# D <- C/(area_ras*1000000) # the W/m^2 entering plants in the grid
# D[D[[1]]>134.2384] <- 134.2384 # ensures that no more that PAR entering plants cannot be larger than the total PAR entering the system
# Ebio <- brick(D)
# rock <-readOGR("/Volumes/WD_BLACK/NZ/lris-new-zealand-6layers-GTiff-JPEG-SHP/nzlri-rock/nzlri-rock.shp")
soil <- readOGR("/Volumes/WD_BLACK/NZ/mfe-fundamental-soil-layers-new-zealand-soil-classification-SHP/fundamental-soil-layers-new-zealand-soil-classification.shp")
# slope <- raster("/Volumes/WD_BLACK/NZ/site_data/lenz-slope.tif")
soil_C <- raster("/Volumes/WD_BLACK/NZ/site_data/smap-predicted-carbon-august-2022.tif")
soil_pH <- raster("/Volumes/WD_BLACK/NZ/site_data/smap-predicted-ph-august-2020.tif")
soil_AEC <-readOGR("/Volumes/WD_BLACK/NZ/site_data/fsl-phosphate-retention/fsl-phosphate-retention.shp")
soil_CEC <-readOGR("/Volumes/WD_BLACK/NZ/site_data/lris-fsl-cation-exchange-capacity-SHP/fsl-cation-exchange-capacity.shp")
#####
#####

# ### MAP
# #Tararuas
# TARARURA_MAP <- extract(MAP,tar_points) # in mm/yr
# TAR1200_MAP <- extract(MAP,TAR1200) # in mm/yr
# TAR800_MAP <- extract(MAP,TAR800) # in mm/yr
# TAR400_MAP <- extract(MAP,TAR400) # in mm/yr
# TM <- round(TARARURA_MAP,0)
# TM <- na.omit(TM)
# TM <- as.numeric(TM)
# a <- data.frame(table(TM))
# SUM <- sum(a[,2])
# a[,2] <- a[,2]/SUM*100
# colnames(a) <- c("mm/yr","%")
# write.csv(a,"TAR_MAP.csv")
# b<-cbind(TAR400_MAP,TAR800_MAP,TAR1200_MAP,DOB1400_MAP)
# colnames(b) <- c("TAR400_MAP_mm/yr","TAR800_MAP_mm/yr","TAR1200_MAP_mm/yr","DOB1400_mm/yr")
# write.csv(b,"NZ_SITES_MAP.csv")
# #Southern Alps
# ALPS_MAP <- extract(MAP, SA_points) # in mm/yr
# DOB1400_MAP <-extract(MAP,DOB1400) # in mm/yr
# ALPS <- round(ALPS_MAP,0)
# ALPS <- na.omit(ALPS)
# ALPS <- as.numeric(ALPS)
# alps <- data.frame(table(ALPS))
# SUM_alps <- sum(alps[,2])
# alps[,2] <- alps[,2]/SUM_alps*100
# colnames(alps) <- c("mm/yr","%")
# write.csv(alps,"SA_MAP.csv")
# 
### MAT
# # Tararuas
# TARARUA_MAT <- extract(MAT,tar_points)/10 # in C
# TAR1200_MAT <- extract(MAT,TAR1200)/10 # in C
# TAR800_MAT <- extract(MAT,TAR800)/10 # in C
# TAR400_MAT <- extract(MAT,TAR400)/10 # in C
# ALPS_MAT <- extract(MAT,SA_points)/10 # in C
# DOB1400_MAT <- extract(MAT,DOB1400)/10 # in C
# TM <- round(TARARUA_MAT,0)
# TM <- na.omit(TM)
# TM <- as.numeric(TM)
# a <- data.frame(table(TM))
# SUM <- sum(a[,2])
# a[,2] <- a[,2]/SUM*100
# colnames(a) <- c("C","%")
# write.csv(a,"TAR_MAT.csv")
# b<-cbind(TAR400_MAT,TAR800_MAT,TAR1200_MAT,DOB1400_MAT)
# colnames(b) <- c("TAR400_MAT_mm/yr","TAR800_MAT_mm/yr","TAR1200_MAT_mm/yr","DOB1400_mm/yr")
# write.csv(b,"NZ_SITES_MAT.csv")
# #Southern Alps
# 
# ALPS <- round(ALPS_MAT,0)
# ALPS <- na.omit(ALPS)
# ALPS <- as.numeric(ALPS)
# alps <- data.frame(table(ALPS))
# SUM_alps <- sum(alps[,2])
# alps[,2] <- alps[,2]/SUM_alps*100
# colnames(alps) <- c("mm/yr","%")
# write.csv(alps,"SA_MAT.csv")
### MAET
# TARARURA_MAET <- extract(MAET,tar_points) # in mm/yr
# TAR1200_MAET <- extract(MAET,TAR1200) # in mm/yr
# TAR800_MAET <- extract(MAET,TAR800) # in mm/yr
# TAR400_MAET <- extract(MAET,TAR400) # in mm/yr
# ALPS_MAET <- extract(MAET, SA_points) # in mm/yr
# DOB1400_MAET <-extract(MAET,DOB1400) # in mm/yr
# TM <- round(TARARUA_MAET,0)
# TM <- na.omit(TM)
# TM <- as.numeric(TM)
# a <- data.frame(table(TM))
# SUM <- sum(a[,2])
# a[,2] <- a[,2]/SUM*100
# colnames(a) <- c("C","%")
# write.csv(a,"TAR_MAET.csv")
# b<-cbind(TAR400_MAET,TAR800_MAET,TAR1200_MAET,DOB1400_MAET)
# colnames(b) <- c("TAR400_MAET_mm/yr","TAR800_MAET_mm/yr","TAR1200_MAET_mm/yr","DOB1400_mm/yr")
# write.csv(b,"NZ_SITES_MAET.csv")
# ALPS <- round(ALPS_MAET,0)
# ALPS <- na.omit(ALPS)
# ALPS <- as.numeric(ALPS)
# alps <- data.frame(table(ALPS))
# SUM_alps <- sum(alps[,2])
# alps[,2] <- alps[,2]/SUM_alps*100
# colnames(alps) <- c("mm/yr","%")
# write.csv(alps,"SA_MAET.csv")
### Kn
# TARARUA_Kn <- extract(Kn,tar_points) # in mm/yr
# TAR1200_Kn <- extract(Kn,TAR1200) # in mm/yr
# TAR800_Kn <- extract(Kn,TAR800) # in mm/yr
# TAR400_Kn <- extract(Kn,TAR400) # in mm/yr
# ALPS_Kn <- extract(Kn, SA_points) # in mm/yr
# DOB1400_Kn <-extract(Kn,DOB1400) # in mm/yr
# TM <- round(TARARUA_Kn,0)
# TM <- na.omit(TM)
# TM <- as.numeric(TM)
# a <- data.frame(table(TM))
# SUM <- sum(a[,2])
# a[,2] <- a[,2]/SUM*100
# colnames(a) <- c("Kn","%")
# write.csv(a,"TAR_Kn.csv")
# b<-cbind(TAR400_Kn,TAR800_Kn,TAR1200_Kn,DOB1400_Kn)
# colnames(b) <- c("TAR400_Kn","TAR800_Kn","TAR1200_Kn","DOB1400")
# write.csv(b,"NZ_SITES_Kn.csv")
# ALPS <- round(ALPS_Kn,0)
# ALPS <- na.omit(ALPS)
# ALPS <- as.numeric(ALPS)
# alps <- data.frame(table(ALPS))
# SUM_alps <- sum(alps[,2])
# alps[,2] <- alps[,2]/SUM_alps*100
# colnames(alps) <- c("Kn","%")
# write.csv(alps,"SA_Kn.csv")
# 
# #### MASun
# TARARUA_MASun <- extract(MASun,tar_points) # in W m^-2
# TAR1200_MASun <- extract(MASun,TAR1200) # in W m^-2
# TAR800_MASun <- extract(MASun,TAR800) # in W m^-2
# TAR400_MASun <- extract(MASun,TAR400) # in W m^-2
# ALPS_MASun<- extract(MASun,SA_points) # in W m^-2
# DOB1400_MASun<- extract(MASun,DOB1400) # in W m^-2
# TM <- round(TARARUA_MASun,0)
# TM <- na.omit(TM)
# TM <- as.numeric(TM)
# a <- data.frame(table(TM))
# SUM <- sum(a[,2])
# a[,2] <- a[,2]/SUM*100
# colnames(a) <- c("W m^-2","%")
# write.csv(a,"TAR_MASun.csv")
# b<-cbind(TAR400_MASun,TAR800_MASun,TAR1200_MASun,DOB1400_MASun)
# colnames(b) <- c("TAR400_MASun","TAR800_MASun","TAR1200_MASun","DOB1400")
# write.csv(b,"NZ_SITES_MASun.csv")
# ALPS <- round(ALPS_MASun,0)
# ALPS <- na.omit(ALPS)
# ALPS <- as.numeric(ALPS)
# alps <- data.frame(table(ALPS))
# SUM_alps <- sum(alps[,2])
# alps[,2] <- alps[,2]/SUM_alps*100
# colnames(alps) <- c("W m^-2","%")
# write.csv(alps,"SA_MASun.csv")
# 
# 
# 
# #### MAPAR
# TARARUA_MAPAR <- TARARUA_MASun*.5 # in W m^-2
# TAR1200_MAPAR <- TAR1200_MASun*0.5 # in W m^-2
# TAR800_MAPAR <- TAR800_MASun*.5 # in W m^-2
# TAR400_MAPAR <- TAR400_MASun*.5 # in W m^-2
# ALPS_MAPAR <- ALPS_MASun*.5# in W m^-2
# DOB1400_MAPAR <- DOB1400_MASun*.5# in W m^-2
# TM <- round(TARARUA_MAPAR,0)
# TM <- na.omit(TM)
# TM <- as.numeric(TM)
# a <- data.frame(table(TM))
# SUM <- sum(a[,2])
# a[,2] <- a[,2]/SUM*100
# colnames(a) <- c("W m^-2","%")
# write.csv(a,"TAR_MAPAR.csv")
# b<-cbind(TAR400_MAPAR,TAR800_MAPAR,TAR1200_MAPAR,DOB1400_MAPAR)
# colnames(b) <- c("TAR400_MAPAR","TAR800_MAPAR","TAR1200_MAPAR","DOB1400")
# write.csv(b,"NZ_SITES_MAPAR.csv")
# ALPS <- round(ALPS_MAPAR,0)
# ALPS <- na.omit(ALPS)
# ALPS <- as.numeric(ALPS)
# alps <- data.frame(table(ALPS))
# SUM_alps <- sum(alps[,2])
# alps[,2] <- alps[,2]/SUM_alps*100
# colnames(alps) <- c("W m^-2","%")
# write.csv(alps,"SA_MAPAR.csv")

# #### Ebio
# TARARUA_Ebio <- extract(Ebio,tar_points)# in W m^-2
# TAR1200_Ebio <- extract(Ebio,TAR1200)# in W m^-2
# TAR800_Ebio <- extract(Ebio,TAR800)# in W m^-2
# TAR400_Ebio <- extract(Ebio,TAR400)# in W m^-2
# ALPS_Ebio <-extract(Ebio, SA_points)# in W m^-2
# DOB1400_Ebio <-extract(Ebio, DOB1400)# in W m^-2
# 
# TM <- round(TARARUA_Ebio,0)
# TM <- na.omit(TM)
# TM <- as.numeric(TM)
# a <- data.frame(table(TM))
# SUM <- sum(a[,2])
# a[,2] <- a[,2]/SUM*100
# colnames(a) <- c("W m^-2","%")
# write.csv(a,"TAR_Ebio.csv")
# b<-cbind(TAR400_Ebio,TAR800_Ebio,TAR1200_Ebio,DOB1400_Ebio)
# colnames(b) <- c("TAR400_Ebio","TAR800_Ebio","TAR1200_Ebio","DOB1400_Ebio")
# write.csv(b,"NZ_SITES_Ebio.csv")
# ALPS <- round(ALPS_Ebio,0)
# ALPS <- na.omit(ALPS)
# ALPS <- as.numeric(ALPS)
# alps <- data.frame(table(ALPS))
# SUM_alps <- sum(alps[,2])
# alps[,2] <- alps[,2]/SUM_alps*100
# colnames(alps) <- c("W m^-2","%")
# write.csv(alps,"SA_Ebio.csv")

# ### rock
# TARARUA_rock <- over(tar_points_SP,rock)
# TAR1200_rock <- over(TAR1200_SP,rock)
# TAR800_rock <- over(TAR800_SP,rock)
# TAR400_rock <- over(TAR400_SP,rock)
# ALPS_rock <- over(SA_points_SP,rock)
# DOB1400_rock <- over(DOB1400_SP,rock)
# 
# TAR1200_rock<-TAR1200_rock[,3]
# TAR800_rock<-TAR800_rock[,3]
# TAR400_rock<-TAR400_rock[,3]
# DOB1400_rock<-DOB1400_rock[,3]
# TARARUA_rock <- TARARUA_rock[,3]
# ALPS_rock <-ALPS_rock[,3]
# TM <- na.omit(TARARUA_rock)
# a <- data.frame(table(TM))
# SUM <- sum(a[,2])
# a[,2] <- a[,2]/SUM*100
# colnames(a) <- c("rock type","%")
# write.csv(a,"TAR_rock.csv")
# b<-cbind(TAR400_rock,TAR800_rock,TAR1200_rock,DOB1400_rock)
# colnames(b) <- c("TAR400_rock","TAR800_rock","TAR1200_rock","DOB1400_rock")
# write.csv(b,"NZ_SITES_rock.csv")
# ALPS <- na.omit(ALPS_rock)
# alps <- data.frame(table(ALPS))
# SUM_alps <- sum(alps[,2])
# alps[,2] <- alps[,2]/SUM_alps*100
# colnames(alps) <- c("rock_type","%")
# write.csv(alps,"SA_rock.csv")

### soil
# buffers
dob1400 <- over(Dob1400_SP,soil)
tar1200 <- over(Tar1200_SP,soil)
tar800  <- over(Tar800_SP,soil)
tar400  <- over(Tar400_SP,soil)
# 
# ## the remaining portion of this section calls the soil type by point for each region as well as for each site. Also, the datae obtained is tabulated and saved as a csv.
# TARARUA_soil <- over(tar_points_SP,soil)
TAR1200_soil <-over(TAR1200_SP,soil)
TAR800_soil <- over(TAR800_SP,soil)
TAR400_soil <- over(TAR400_SP,soil)
# ALPS_soil <- over(SA_points_SP,soil)
DOB1400_soil <- over(DOB1400_SP,soil)
# TM <- na.omit(TARARUA_soil[,2])
# a <- data.frame(table(TM))
# SUM <- sum(a[,2])
# a[,2] <- a[,2]/SUM*100
# colnames(a) <- c("soil","%")
# write.csv(a,"TAR_soil.csv")
# # ssving region data, e.g., within the radius of 100m buffer
# ###TAR400
t400<-data.frame(table(na.omit(tar400[,2])))
SUM <- sum(t400[,2])
t400[,2] <- t400[,2]/SUM*100
colnames(t400) <- c("soil","%")
write.csv(t400,"t400_soil_in_100m_radius_buffer.csv")
# ###TAR 800
# t800<-data.frame(table(na.omit(tar800[,2])))
# SUM <- sum(t800[,2])
# t800[,2] <- t800[,2]/SUM*100
# colnames(t800) <- c("soil","%")
# write.csv(t800,"t800_soil_in_100m_radius_buffer.csv")
# ###TAR 1200
# t1200<-data.frame(table(na.omit(tar1200[,2])))
# SUM <- sum(t1200[,2])
# t1200[,2] <- t1200[,2]/SUM*100
# colnames(t1200) <- c("soil","%")
# write.csv(t1200,"t1200_soil_in_100m_radius_buffer.csv")
# ###DOB 1400
# d1400<-data.frame(table(na.omit(dob1400[,2])))
# SUM <- sum(d1400[,2])
# d1400[,2] <- d1400[,2]/SUM*100
# colnames(d1400) <- c("soil","%")
# write.csv(d1400,"t1400_soil_in_100m_radius_buffer.csv")
# #this combines the site data and saves it as csv
# b<-cbind(TAR400_soil,TAR800_soil,TAR1200_soil,DOB1400_soil)
# colnames(b) <- c("TAR400_soil","TAR800_soil","TAR1200_soil","DOB1400")
# write.csv(b,"NZ_SITES_soil.csv")
# # this is the regional data for the Southern Alps combined and saved as csv
# ALPS <- na.omit(ALPS_soil[,2])
# alps <- data.frame(table(ALPS))
# SUM_alps <- sum(alps[,2])
# alps[,2] <- alps[,2]/SUM_alps*100
# colnames(alps) <- c("soil","%")
# write.csv(alps,"SA_soil.csv")
# ### slope
# #places the data into variables for manipulations
# TAR1200_slope_in_circular_area_radius_100m <- extract(slope,Tar1200_SP)
# TAR800_slope_in_circular_area_radius_100m <- extract(slope,Tar800_SP)
# TAR400_slope_in_circular_area_radius_100m <- extract(slope,Tar400_SP)
# DOB1400_slope_in_circular_area_radius_100m <-extract(slope,Dob1400_SP)
# TARARUA_slope <- extract(slope,tar_points)
# TAR1200_slope <- extract(slope,TAR1200)
# TAR800_slope <- extract(slope,TAR800)
# TAR400_slope <- extract(slope,TAR400)
# ALPS_slope <- extract(slope, SA_points)
# DOB1400_slope <-extract(slope,DOB1400)
# #organizes region slope data for Tararuas and saves as csv
# TM <- round(TARARUA_slope,0)
# TM <- na.omit(TM)
# TM <- as.numeric(TM)
# a <- data.frame(table(TM))
# SUM <- sum(a[,2])
# a[,2] <- a[,2]/SUM*100
# colnames(a) <- c("degree","%")
# write.csv(a,"TAR_slope.csv")
# # saving region data, e.g., within the radius of 100m buffer
# ###TAR400
# t400<-data.frame(table((TAR400_slope_in_circular_area_radius_100m)))
# SUM <- sum(t400[,2])
# t400[,2] <- t400[,2]/SUM*100
# colnames(t400) <- c("slope","%")
# write.csv(t400,"t400_slope_in_100m_radius_buffer.csv")
# ###TAR 800
# t800<-data.frame(table(na.omit(TAR800_slope_in_circular_area_radius_100m)))
# SUM <- sum(t800[,2])
# t800[,2] <- t800[,2]/SUM*100
# colnames(t800) <- c("slope","%")
# write.csv(t800,"t800_slope_in_100m_radius_buffer.csv")
# ###TAR 1200
# t1200<-data.frame(table(na.omit(TAR1200_slope_in_circular_area_radius_100m)))
# SUM <- sum(t1200[,2])
# t1200[,2] <- t1200[,2]/SUM*100
# colnames(t1200) <- c("slope","%")
# write.csv(t1200,"t1200_slope_in_100m_radius_buffer.csv")
# ###DOB 1400
# d1400<-data.frame(table(na.omit(DOB1400_slope_in_circular_area_radius_100m)))
# SUM <- sum(d1400[,2])
# d1400[,2] <- d1400[,2]/SUM*100
# colnames(d1400) <- c("slope","%")
# write.csv(d1400,"t1400_slope_in_100m_radius_buffer.csv")
# # this chunk of code organizes slope by site and saves the information into one csv
# b<-cbind(TAR400_slope,TAR800_slope,TAR1200_slope,DOB1400_slope)
# colnames(b) <- c("TAR400_slope","TAR800_slope","TAR1200_slope","DOB1400_slope")
# write.csv(b,"NZ_SITES_slope.csv")
# ALPS <- round(ALPS_slope,0)
# ALPS <- na.omit(ALPS)
# ALPS <- as.numeric(ALPS)
# alps <- data.frame(table(ALPS))
# SUM_alps <- sum(alps[,2])
# alps[,2] <- alps[,2]/SUM_alps*100
# colnames(alps) <- c("degree","%")
# write.csv(alps,"SA_slope.csv")
# 
# 
# ##soil C
# TAR1200_soil_C_in_circular_area_radius_100m <- extract(soil_C,Tar1200_SP)
# TAR800_soil_C_in_circular_area_radius_100m <- extract(soil_C,Tar800_SP)
# TAR400_soil_C_in_circular_area_radius_100m <- extract(soil_C,Tar400_SP)
# DOB1400_soil_C_in_circular_area_radius_100m <-extract(soil_C,Dob1400_SP)
# TARARUA_soil_C <- extract(soil_C,tar_points)
# TAR1200_soil_C <- extract(soil_C,TAR1200)
# TAR800_soil_C <- extract(soil_C,TAR800)
# TAR400_soil_C <- extract(soil_C,TAR400)
# ALPS_soil_C <- extract(soil_C, SA_points)
# DOB1400_soil_C <-extract(soil_C,DOB1400)
# #organizes region soil_C data for Tararuas and saves as csv
# TM <- round(TARARUA_soil_C,0)
# TM <- na.omit(TM)
# TM <- as.numeric(TM)
# a <- data.frame(table(TM))
# SUM <- sum(a[,2])
# a[,2] <- a[,2]/SUM*100
# colnames(a) <- c("%","%")
# write.csv(a,"TAR_soil_C.csv")
# # saving region data, e.g., within the radius of 100m buffer
# ###TAR400
# t400<-data.frame(table((TAR400_soil_C_in_circular_area_radius_100m)))
# SUM <- sum(t400[,2])
# t400[,2] <- t400[,2]/SUM*100
# colnames(t400) <- c("soil_C","%")
# write.csv(t400,"t400_soil_C_in_100m_radius_buffer.csv")
# ###TAR 800
# t800<-data.frame(table(na.omit(TAR800_soil_C_in_circular_area_radius_100m)))
# SUM <- sum(t800[,2])
# t800[,2] <- t800[,2]/SUM*100
# colnames(t800) <- c("soil_C","%")
# write.csv(t800,"t800_soil_C_in_100m_radius_buffer.csv")
# ###TAR 1200
# t1200<-data.frame(table(na.omit(TAR1200_soil_C_in_circular_area_radius_100m)))
# SUM <- sum(t1200[,2])
# t1200[,2] <- t1200[,2]/SUM*100
# colnames(t1200) <- c("soil_C","%")
# write.csv(t1200,"t1200_soil_C_in_100m_radius_buffer.csv")
# ###DOB 1400
# d1400<-data.frame(table(na.omit(DOB1400_soil_C_in_circular_area_radius_100m)))
# SUM <- sum(d1400[,2])
# d1400[,2] <- d1400[,2]/SUM*100
# colnames(d1400) <- c("soil_C","%")
# write.csv(d1400,"t1400_soil_C_in_100m_radius_buffer.csv")
# # this chunk of code organizes soil_C by site and saves the information into one csv
# b<-cbind(TAR400_soil_C,TAR800_soil_C,TAR1200_soil_C,DOB1400_soil_C)
# colnames(b) <- c("TAR400_soil_C","TAR800_soil_C","TAR1200_soil_C","DOB1400_soil_C")
# write.csv(b,"NZ_SITES_soil_C.csv")
# # soil C for the southern alps study region
# ALPS <- round(ALPS_soil_C,0)
# ALPS <- na.omit(ALPS)
# ALPS <- as.numeric(ALPS)
# alps <- data.frame(table(ALPS))
# SUM_alps <- sum(alps[,2])
# alps[,2] <- alps[,2]/SUM_alps*100
# colnames(alps) <- c("%","%")
# write.csv(alps,"SA_soil_C.csv")


# #soil pH
# TAR1200_soil_pH_in_circular_area_radius_100m <- extract(soil_pH,Tar1200_SP)
# TAR800_soil_pH_in_circular_area_radius_100m <- extract(soil_pH,Tar800_SP)
# TAR400_soil_pH_in_circular_area_radius_100m <- extract(soil_pH,Tar400_SP)
# DOB1400_soil_pH_in_circular_area_radius_100m <-extract(soil_pH,Dob1400_SP)
# TARARUA_soil_pH <- extract(soil_pH,tar_points)
# TAR1200_soil_pH <- extract(soil_pH,TAR1200)
# TAR800_soil_pH <- extract(soil_pH,TAR800)
# TAR400_soil_pH <- extract(soil_pH,TAR400)
# ALPS_soil_pH <- extract(soil_pH, SA_points)
# DOB1400_soil_pH <-extract(soil_pH,DOB1400)
# #organizes region soil_pH data for Tararuas and saves as csv
# TM <- round(TARARUA_soil_pH,1)
# TM <- na.omit(TM)
# TM <- as.numeric(TM)
# a <- data.frame(table(TM))
# SUM <- sum(a[,2])
# a[,2] <- a[,2]/SUM*100
# colnames(a) <- c("pH","%")
# write.csv(a,"TAR_soil_pH.csv")
# # saving region data, e.g., within the radius of 100m buffer
# ###TAR400
# t400<-data.frame(table((round(TAR400_soil_pH_in_circular_area_radius_100m,1))))
# SUM <- sum(t400[,2])
# t400[,2] <- t400[,2]/SUM*100
# colnames(t400) <- c("soil_pH","%")
# write.csv(t400,"t400_soil_pH_in_100m_radius_buffer.csv")
# ###TAR 800
# t800<-data.frame(table(na.omit(round(TAR800_soil_pH_in_circular_area_radius_100m,1))))
# SUM <- sum(t800[,2])
# t800[,2] <- t800[,2]/SUM*100
# colnames(t800) <- c("soil_pH","%")
# write.csv(t800,"t800_soil_pH_in_100m_radius_buffer.csv")
# ###TAR 1200
# t1200<-data.frame(table(na.omit(round(TAR1200_soil_pH_in_circular_area_radius_100m,1))))
# SUM <- sum(t1200[,2])
# t1200[,2] <- t1200[,2]/SUM*100
# colnames(t1200) <- c("soil_pH","%")
# write.csv(t1200,"t1200_soil_pH_in_100m_radius_buffer.csv")
# ###DOB 1400
# d1400<-data.frame(table(na.omit(round(DOB1400_soil_pH_in_circular_area_radius_100m,1))))
# SUM <- sum(d1400[,2])
# d1400[,2] <- d1400[,2]/SUM*100
# colnames(d1400) <- c("soil_pH","%")
# write.csv(d1400,"t1400_soil_pH_in_100m_radius_buffer.csv")
# # this chunk of code organizes soil_pH by site and saves the information into one csv
# b<-round(cbind(TAR400_soil_pH,TAR800_soil_pH,TAR1200_soil_pH,DOB1400_soil_pH),1)
# colnames(b) <- c("TAR400_soil_pH","TAR800_soil_pH","TAR1200_soil_pH","DOB1400_soil_pH")
# write.csv(b,"NZ_SITES_soil_pH.csv")
# # soil pH for the southern alps study region
# ALPS <- round(ALPS_soil_pH,1)
# ALPS <- na.omit(ALPS)
# ALPS <- as.numeric(ALPS)
# alps <- data.frame(table(ALPS))
# SUM_alps <- sum(alps[,2])
# alps[,2] <- alps[,2]/SUM_alps*100
# colnames(alps) <- c("soil pH","%")
# write.csv(alps,"SA_soil_pH.csv")


# ##soil_CEC
# TAR1200_soil_CEC_in_circular_area_radius_100m <- over(Tar1200_SP,soil_CEC) # in cmol/kg soil
# TAR800_soil_CEC_in_circular_area_radius_100m <-  over(Tar800_SP,soil_CEC) # in cmol/kg soil
# TAR400_soil_CEC_in_circular_area_radius_100m <- over(Tar400_SP,soil_CEC) # in cmol/kg soil
# DOB1400_soil_CEC_in_circular_area_radius_100m <- over(Dob1400_SP,soil_CEC) # in cmol/kg soil
# TARARUA_soil_CEC <- over(tar_points_SP,soil_CEC) # in cmol/kg soil
# TAR1200_soil_CEC <- over(TAR1200_SP,soil_CEC) # in cmol/kg soil
# TAR800_soil_CEC <- over(TAR800_SP,soil_CEC) # in cmol/kg soil
# TAR400_soil_CEC <- over(TAR400_SP,soil_CEC) # in cmol/kg soil
# ALPS_soil_CEC <- over(SA_points_SP,soil_CEC) # in cmol/kg soil
# DOB1400_soil_CEC <-over(DOB1400_SP,soil_CEC) # in cmol/kg soil
# # #organizes region soil_pH data for Tararuas and saves as csv
# TM <- TARARUA_soil_CEC[,10] # the expected CEC
# TM <- na.omit(TM)
# TM <- as.numeric(TM)
# a <- data.frame(table(TM))
# SUM <- sum(a[,2])
# a[,2] <- a[,2]/SUM*100
# colnames(a) <- c("soil_CEC","%")
# write.csv(a,"TAR_soil_CEC.csv")
# # saving region data, e.g., within the radius of 100m buffer
# ###TAR400
# t400<-data.frame(table(((TAR400_soil_CEC_in_circular_area_radius_100m[,10]))))
# SUM <- sum(t400[,2])
# t400[,2] <- t400[,2]/SUM*100
# colnames(t400) <- c("soil_CEC","%")
# write.csv(t400,"t400_soil_CEC_in_100m_radius_buffer.csv")
# ###TAR 800
# t800<-data.frame(table(na.omit(TAR800_soil_CEC_in_circular_area_radius_100m[,10])))
# SUM <- sum(t800[,2])
# t800[,2] <- t800[,2]/SUM*100
# colnames(t800) <- c("soil_CEC","%")
# write.csv(t800,"t800_soil_CEC_in_100m_radius_buffer.csv")
# ###TAR 1200
# t1200<-data.frame(table(na.omit((TAR1200_soil_CEC_in_circular_area_radius_100m[,10]))))
# SUM <- sum(t1200[,2])
# t1200[,2] <- t1200[,2]/SUM*100
# colnames(t1200) <- c("soil_CEC","%")
# write.csv(t1200,"t1200_soil_CEC_in_100m_radius_buffer.csv")
# ###DOB 1400
# d1400<-data.frame(table(na.omit(DOB1400_soil_CEC_in_circular_area_radius_100m[,10])))
# SUM <- sum(d1400[,2])
# d1400[,2] <- d1400[,2]/SUM*100
# colnames(d1400) <- c("soil_CEC","%")
# write.csv(d1400,"t1400_soil_CEC_in_100m_radius_buffer.csv")
# # this chunk of code organizes soil_CEC by site and saves the information into one csv
# b<-cbind(TAR400_soil_CEC[,10],TAR800_soil_CEC[,10],TAR1200_soil_CEC[,10],DOB1400_soil_CEC[,10])
# colnames(b) <- c("TAR400_soil_CEC","TAR800_soil_CEC","TAR1200_soil_CEC","DOB1400_soil_CEC")
# write.csv(b,"NZ_SITES_soil_CEC.csv")
# # soil pH for the southern alps study region
# ALPS <- ALPS_soil_CEC[,10] # the min CEC
# ALPS <- na.omit(ALPS)
# ALPS <- as.numeric(ALPS)
# alps <- data.frame(table(ALPS))
# SUM_alps <- sum(alps[,2])
# alps[,2] <- alps[,2]/SUM_alps*100
# colnames(alps) <- c("soil_CEC","%")
# write.csv(alps,"SA_soil_CEC.csv")
##soil_AEC
# TAR1200_soil_AEC_in_circular_area_radius_100m <- over(Tar1200_SP,soil_AEC) # in %
# TAR800_soil_AEC_in_circular_area_radius_100m <-  over(Tar800_SP,soil_AEC) # in %
# TAR400_soil_AEC_in_circular_area_radius_100m <- over(Tar400_SP,soil_AEC) # in %
# DOB1400_soil_AEC_in_circular_area_radius_100m <- over(Dob1400_SP,soil_AEC) # in %
# TARARUA_soil_AEC <- over(tar_points_SP,soil_AEC) # in %
# TAR1200_soil_AEC <- over(TAR1200_SP,soil_AEC) # in %
# TAR800_soil_AEC <- over(TAR800_SP,soil_AEC) # in %
# TAR400_soil_AEC <- over(TAR400_SP,soil_AEC) # in %
# ALPS_soil_AEC <- over(SA_points_SP,soil_AEC) # in %
# DOB1400_soil_AEC <-over(DOB1400_SP,soil_AEC) # in %
# # #organizes region soil_pH data for Tararuas and saves as csv
# TM <- TARARUA_soil_AEC[,10] # the expected phosphorus retention
# TM <- na.omit(TM)
# TM <- as.numeric(TM)
# a <- data.frame(table(TM))
# SUM <- sum(a[,2])
# a[,2] <- a[,2]/SUM*100
# colnames(a) <- c("PRET%","%")
# write.csv(a,"TAR_soil_PRET.csv")
# # saving region data, e.g., within the radius of 100m buffer
# ###TAR400
# t400<-data.frame(table(((TAR400_soil_AEC_in_circular_area_radius_100m[,10]))))
# SUM <- sum(t400[,2])
# t400[,2] <- t400[,2]/SUM*100
# colnames(t400) <- c("PRET%","%")
# write.csv(t400,"t400_soil_PRET_in_100m_radius_buffer.csv")
# ###TAR 800
# t800<-data.frame(table(na.omit(TAR800_soil_AEC_in_circular_area_radius_100m[,10])))
# SUM <- sum(t800[,2])
# t800[,2] <- t800[,2]/SUM*100
# colnames(t800) <- c("PRET%","%")
# write.csv(t800,"t800_soil_PRET_in_100m_radius_buffer.csv")
# ###TAR 1200
# t1200<-data.frame(table(na.omit((TAR1200_soil_AEC_in_circular_area_radius_100m[,10]))))
# SUM <- sum(t1200[,2])
# t1200[,2] <- t1200[,2]/SUM*100
# colnames(t1200) <- c("PRET%","%")
# write.csv(t1200,"t1200_soil_PRET_in_100m_radius_buffer.csv")
# ###DOB 1400
# d1400<-data.frame(table(na.omit(DOB1400_soil_AEC_in_circular_area_radius_100m[,10])))
# SUM <- sum(d1400[,2])
# d1400[,2] <- d1400[,2]/SUM*100
# colnames(d1400) <- c("PRET%","%")
# write.csv(d1400,"t1400_soil_PRET_in_100m_radius_buffer.csv")
# # this chunk of code organizes soil_AEC by site and saves the information into one csv
# b<-(cbind(TAR400_soil_AEC[,10],TAR800_soil_AEC[,10],TAR1200_soil_AEC[,10],DOB1400_soil_AEC[,10]))
# colnames(b) <- c("TAR400_soil_PRET","TAR800_soil_PRET","TAR1200_soil_PRET","DOB1400_soil_PRET")
# write.csv(b,"NZ_SITES_soil_PRET.csv")
# # soil pH for the southern alps study region
# ALPS <- ALPS_soil_AEC[,10] # the min AEC
# ALPS <- na.omit(ALPS)
# alps <- data.frame(table(ALPS))
# SUM_alps <- sum(alps[,2])
# alps[,2] <- alps[,2]/SUM_alps*100
# colnames(alps) <- c("PRET%","%")
# write.csv(alps,"SA_soil_PRET.csv")


