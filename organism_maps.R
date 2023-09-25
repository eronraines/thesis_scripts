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



## site coordinates

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
       col = "black", cex = 1)

plot(sa_hill, col = grey(1:100/100), axes = FALSE, legend = FALSE, box = FALSE)
points(DOB1300, pch = 16,
       col = "red", cex = 1)




LAI <- raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/MALAI_global.tif")
ma_rad <- raster("/Volumes/WD_BLACK/NZ/site_data/nzenvds-annual-potential-incoming-solar-radiation-v10.tif")
ma_rad <- ma_rad/(365*24) # converting from Wh m^2 yr to W m^2

pot_veg_shp <- readOGR("/Volumes/WD_BLACK/NZ/lris-potential-vegetation-of-new-zealand-SHP/potential-vegetation-of-new-zealand.shp")
pot_veg_ras <- raster("/Volumes/WD_BLACK/NZ/lris-new-zealand-potential-vegetation-grid-version-GTiff (1)/new-zealand-potential-vegetation-grid-version.tif")

pv_tar_shp <- crop(pot_veg_shp,tar)
pv_tar_ras <- crop(pot_veg_ras,tar)

tab <-table(pv_tar_ras@data@values)
pot_veg_shp$Vege_type
plot(tar_hill, col = grey(1:100/100), axes = FALSE, legend = FALSE, box = FALSE)
plot(veg_tar_shp, lwd = 1,  add = TRUE)

plot(pv_tar_ras, alpha = 0.6, add = TRUE, legend = FALSE)
plot(pv_tar_shp, lwd = 0.3,  add = TRUE)
points(TAR, pch = 16,
       col = "black", cex = 1)



LAI_tar <- crop(LAI,tar)
ma_rad_sa <-crop(ma_rad,sa)

mafapar_tar <- crop(MAfAPAR,tar)
mafapar_sa <- crop(MAfAPAR,ma_rad_sa)

MAfAPAR_tar <- mafapar_tar * ma_rad_tar


plot(mafapar_tar, alpha = 0.6, add = TRUE)



