# clean up
rm(list=ls(all=T))
gc()
# .rs.restartR() #optional. recommended if performance degraded.
rm(list=ls(all=T))
gc()

# libraries used
library(rayshader)
library(raster)
library(hillshader)
library(leaflet)

##study sites
#tararua
TAR1200<-cbind(175.266686,-40.927239)
TAR800<-cbind(175.247841,-40.903073)
TAR400<-cbind(175.235790,-40.883049)
TAR <- rbind(TAR1200,TAR800,TAR400)
#southern alps
DOB1300<-cbind(169.977606,-43.810735)

## study area DEM
tar <-raster("/Volumes/WD_BLACK/NZ/TAR_B_for_plotting/nzdem-north-island-25-metre.tif")
sa <-raster("/Volumes/WD_BLACK/Map building/quick_call_rasters/sa_study_region.tif")

## convert DEM to hillshade
tar_slope <- terrain(tar,opt='slope')
tar_aspect <- terrain (tar, opt ='aspect')
tar_hill <-hillShade(tar_slope,tar_aspect,40,270)

sa_slope <- terrain(sa,opt='slope')
sa_aspect <- terrain (sa, opt ='aspect')
sa_hill <-hillShade(sa_slope,sa_aspect,40,270)

## create hillshade plots with sites in red for thesis
plot(tar_hill, col = grey(1:100/100), axes = FALSE, legend = FALSE, box = FALSE)
points(TAR, pch = 16,
       col = "red", cex = 1)

plot(sa_hill, col = grey(1:100/100), axes = FALSE, legend = FALSE, box = FALSE)
points(DOB1300, pch = 16,
       col = "red", cex = 1)

#MAT
mat <- raster("/Volumes/WD_BLACK/NZ/site_data/lenz-mean-annual-temperature.tif")

mat_tar <- crop(mat,tar)
mat_tar <- mat_tar/10

mat_sa <-crop(mat,sa)
mat_sa <- mat_sa/10

plot(tar_hill, col = grey(1:100/100), axes = FALSE, legend = FALSE, box = FALSE, main = "Mean annual temperature")
plot(mat_tar, add = TRUE,alpha=0.6, legend = FALSE)

points(TAR, pch = 16,
       col = "black", cex = 1)
plot(mat_tar, add = TRUE, legend.only = TRUE, 
     legend.args = list(text = '\u00B0C', 
                        side = 4,font = 2, line = 2.5, cex = 1),
     axis.args = list(at=seq(4, 12, 1),
                   labels=seq(4, 12, 1), 
                   cex.axis=1),
     smallplot=c(0.65,.68, .185+0.02,0.845-0.2))


plot(sa_hill, col = grey(1:100/100), axes = FALSE, legend = FALSE, box = FALSE, main = "Mean annual temperature")
plot(mat_sa, add = TRUE,alpha=0.6, legend = FALSE)

points(DOB1300, pch = 16,
       col = "black", cex = 1)

plot(mat_sa, add = TRUE, legend.only = TRUE, 
     legend.args = list(text = '\u00B0C', 
                        side = 4,font = 2, line = 2.5, cex = 1),
     axis.args = list(at=seq(0, 8, 1),
                      labels=seq(0, 8, 1), 
                      cex.axis=1),
     smallplot=c(0.65+.22,.68+.22, .185+0.02,0.845-0.2))


#MAP
map <- raster("/Volumes/WD_BLACK/NZ/site_data/nzenvds-total-annual-precipitation-v10.tif")

map_tar <- crop(map,tar)
map_sa <-crop(map,sa)



plot(tar_hill, col = grey(1:100/100), axes = FALSE, legend = FALSE, box = FALSE, main = "Mean annual precipitation")
plot(map_tar, add = TRUE,alpha=0.6, legend = FALSE)

points(TAR, pch = 16,
       col = "black", cex = 1)
plot(map_tar, add = TRUE, legend.only = TRUE, 
     legend.args = list(text = expression("mm yr"^-1), 
                        side = 4,font = 2, line = 3.5, cex = 1),
     axis.args = list(at=seq(1600, 2800, 200),
                      labels=seq(1600, 2800, 200), 
                      cex.axis=1),
     smallplot=c(0.65,.68, .185+0.02,0.845-0.2))


plot(sa_hill, col = grey(1:100/100), axes = FALSE, legend = FALSE, box = FALSE, main = "Mean annual precipitation")
plot(map_sa, add = TRUE,alpha=0.6, legend = FALSE)

points(DOB1300, pch = 16,
       col = "black", cex = 1)

plot(map_sa, add = TRUE, legend.only = TRUE, 
     legend.args = list(text = expression("mm yr"^-1), 
                        side = 4,font = 2, line = 3.2, cex = 1),
     axis.args = list(at=seq(4000, 6000, 300),
                      labels=seq(4000, 6000, 300), 
                      cex.axis=1),
     smallplot=c(0.65+.22,.68+.22, .185+0.02,0.845-0.2))

#Kn
Kn <- raster("/Volumes/WD_BLACK/NZ/site_data/nzenvds-rainfall-to-potential-evapotranspiration-ratio-v10.tif")


Kn_tar <- crop(Kn,tar)
Kn_sa <-crop(Kn,sa)



plot(tar_hill, col = grey(1:100/100), axes = FALSE, legend = FALSE, box = FALSE, main = "Effective precipitation")
plot(Kn_tar, add = TRUE,alpha=0.6, legend = FALSE)

points(TAR, pch = 16,
       col = "black", cex = 1)
plot(Kn_tar, add = TRUE, legend.only = TRUE, 
     legend.args = list(text = 'Kn', 
                        side = 4,font = 2, line = 2.5, cex = 1),
     axis.args = list(at=seq(3, 9, 1),
                      labels=seq(3, 9, 1), 
                      cex.axis=1),
     smallplot=c(0.65,.68, .185+0.02,0.845-0.2))


plot(sa_hill, col = grey(1:100/100), axes = FALSE, legend = FALSE, box = FALSE, main = "Effective precipitation")
plot(Kn_sa, add = TRUE,alpha=0.6, legend = FALSE)

points(DOB1300, pch = 16,
       col = "black", cex = 1)

plot(Kn_sa, add = TRUE, legend.only = TRUE, 
     legend.args = list(text = 'Kn', 
                        side = 4,font = 2, line = 2.8, cex = 1),
     axis.args = list(at=seq(9, 21, 2),
                      labels=seq(9, 21, 2), 
                      cex.axis=1),
     smallplot=c(0.65+.22,.68+.22, .185+0.02,0.845-0.2))








#MAET
maet <- map/Kn

maet_tar <- crop(maet,tar)
maet_sa <-crop(maet,sa)



plot(tar_hill, col = grey(1:100/100), axes = FALSE, legend = FALSE, box = FALSE, main = "Mean annual evapotranspiration")
plot(maet_tar, add = TRUE,alpha=0.6, legend = FALSE)

points(TAR, pch = 16,
       col = "black", cex = 1)
plot(maet_tar, add = TRUE, legend.only = TRUE, 
     legend.args = list(text = expression("mm yr"^-1), 
                        side = 4,font = 2, line = 3.3, cex = 1),
     axis.args = list(at=seq(300, 500, 20),
                      labels=seq(300, 500, 20), 
                      cex.axis=1),
     smallplot=c(0.65,.68, .185+0.02,0.845-0.2))


plot(sa_hill, col = grey(1:100/100), axes = FALSE, legend = FALSE, box = FALSE, main = "Mean annual evapotranspiration")
plot(maet_sa, add = TRUE,alpha=0.6, legend = FALSE)

points(DOB1300, pch = 16,
       col = "black", cex = 1)

plot(maet_sa, add = TRUE, legend.only = TRUE, 
     legend.args = list(text = expression("mm yr"^-1), 
                        side = 4,font = 2, line = 3.2, cex = 1),
     axis.args = list(at=seq(270, 430, 20),
                      labels=seq(270, 430, 20), 
                      cex.axis=1),
     smallplot=c(0.65+.22,.68+.22, .185+0.02,0.845-0.2))

  
#MA_rad
ma_rad <- raster("/Volumes/WD_BLACK/NZ/site_data/nzenvds-annual-potential-incoming-solar-radiation-v10.tif")
ma_rad <- ma_rad/(365*24) # converting from Wh m^2 yr to W m^2
ma_rad_tar <- crop(ma_rad,tar)
ma_rad_sa <-crop(ma_rad,sa)



plot(tar_hill, col = grey(1:100/100), axes = FALSE, legend = FALSE, box = FALSE, main = "Mean annual solar radiation")
plot(ma_rad_tar, add = TRUE,alpha=0.6, legend = FALSE)

points(TAR, pch = 16,
       col = "black", cex = 1)
plot(ma_rad_tar, add = TRUE, legend.only = TRUE, 
     legend.args = list(text = expression("W m"^-2), 
                        side = 4,font = 2, line = 3.3, cex = 1),
     axis.args = list(at=seq(110, 310, 40),
                      labels=seq(300, 500, 40), 
                      cex.axis=1),
     smallplot=c(0.65,.68, .185+0.02,0.845-0.2))


plot(sa_hill, col = grey(1:100/100), axes = FALSE, legend = FALSE, box = FALSE, main = "Mean annual solar radiation")
plot(ma_rad_sa, add = TRUE,alpha=0.6, legend = FALSE)

points(DOB1300, pch = 16,
       col = "black", cex = 1)

plot(ma_rad_sa, add = TRUE, legend.only = TRUE, 
     legend.args = list(text = expression("W m"^-2), 
                        side = 4,font = 2, line = 3.2, cex = 1),
     axis.args = list(at=seq(90, 310, 40),
                      labels=seq(90, 310, 40), 
                      cex.axis=1),
     smallplot=c(0.65+.22,.68+.22, .185+0.02,0.845-0.2))




#MA_PAR

ma_par <- ma_rad * 0.5




DOB1300_SP <- data.frame(x=DOB1300[,1],y=DOB1300[,2]) 
DOB1300_SP <- SpatialPoints(cbind(x=DOB1300[,1],y=DOB1300[,2]),
                            proj4string = CRS("+proj=longlat +datum=WGS84 +no_
                                               defs +ellps=WGS84 +towgs84=0,0,0
                                               "))


test <- crop(Kn, sa_trim)
test2 <- crop(Kn, tar)
plot(test2, add = TRUE)

points(TAR400,pch = 16,
       col = "red", cex = 2 )
points(TAR800,pch = 16,
       col = "red", cex = 2 )
points(TAR1200,pch = 16,
       col = "red", cex = 2 )









tar800pts <- SpatialPoints(TAR800,
                           proj4string = CRS("+proj=longlat +datum=WGS84 +no_
                                               defs +ellps=WGS84 +towgs84=0,0,0
                                               "))
TAR800_500m <- geobuffer_pts(xy = tar800pts, dist_m = 500)
e_TAR800_500m <- extent(TAR800_500m)



mat_tar800_5 <- crop(mat,e_TAR800_500m)
hill_tar800_5 <- crop(tar_hill,e_TAR800_500m)

plot(hill_tar800_5, col = grey(1:100/100), axes = FALSE, legend = FALSE, box = FALSE)
plot(mat_tar800_5,alpha = 0.5, add = TRUE)
points(TAR800, col = "black", cex = 2, pch = 16)
