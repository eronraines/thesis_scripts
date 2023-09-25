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
tar <-raster("/Volumes/WD_BLACK/NZ/TAR_B_for_plotting/
             nzdem-north-island-25-metre.tif")
sa <-raster("/Volumes/WD_BLACK/Map building/quick_call_rasters/
            sa_study_region.tif")

## convert DEM to hillshade
tar_slope <- terrain(tar,opt='slope')
tar_aspect <- terrain(tar, opt ='aspect')
tar_hill <-hillShade(tar_slope,tar_aspect,0,270)

sa_slope <- terrain(sa,opt='slope')
sa_aspect <- terrain (sa, opt ='aspect')
sa_hill <-hillShade(sa_slope,sa_aspect,40,270)

tar_slope_deg <- tar_slope *(180/3.1415)
sa_slope_deg <- sa_slope * (180/3.1415)

tar_aspect_deg <- tar_aspect * (180/3.1415)
sa_aspect_deg <- sa_aspect * (180/3.1415)


## create hillshade plots 
# plot(tar_hill, col = grey(1:100/100), axes = FALSE, legend = FALSE, 
# box = FALSE)


#slope
plot(tar_slope_deg, col = grey(100:1/100), axes = FALSE,  box = FALSE, 
     legend= FALSE, main = "Slope")
plot(tar_slope_deg, alpha  = 0.5, add = TRUE, legend = FALSE)
points(TAR, pch = 16,
       col = "red", cex = 1)

plot(tar_slope_deg, col = grey(100:1/100), add = TRUE, legend.only = TRUE, 
     legend.args = list(text = expression(paste("degree (",degree,")",sep="")), 
                        side = 4,font = 2, line = 2.5, cex = 1),
     axis.args = list(at=seq(0, 55, 10),
                      labels=seq(0, 55, 10), 
                      cex.axis=1),
     smallplot=c(0.65+0.07,.68+0.07, .185+0.02,0.845-0.2))

plot(tar_slope_deg, add = TRUE, alpha = 0.5, legend.only = TRUE, 
     legend.args = list(text = expression(paste("degree (",degree,")",sep="")), 
                        side = 4,font = 2, line = 2.5, cex = 1),
     axis.args = list(at=seq(0, 55, 10),
                      labels=seq(0, 55, 10), 
                      cex.axis=1),
     smallplot=c(0.65+0.07,.68+0.07, .185+0.02,0.845-0.2))



#aspect
plot(tar_aspect_deg, legend = FALSE, axes = FALSE,box=FALSE, main = "Aspect", 
     col = (rainbow(720)))
points(TAR, pch = 16,
       col = "white", bg="yellow", cex = 1)



plot(tar_aspect_deg, add = TRUE, legend.only = TRUE, col = rainbow(720),
     legend.args = list(text = expression(paste("degree (",degree,")",sep="")), 
                        side = 4,font = 2, line = 2.5, cex = 1),
     axis.args = list(at=seq(0, 360, 90),
                      labels=seq(0, 360, 90), 
                      cex.axis=1),
     smallplot=c(0.65+0.07,.68+0.07, .185+0.02,0.845-0.2))

plot(sa_slope_deg, col = grey(100:1/100), axes =FALSE, box =FALSE, 
     legend = FALSE)
title("Slope", line = -1)
plot(sa_slope_deg, alpha = 0.5, add = TRUE, legend = FALSE)
points(DOB1300, pch = 16,
       col = "red", cex = 1)


plot(sa_slope_deg, col= grey(100:1/100),add = TRUE, legend.only = TRUE, 
     legend.args = list(text = expression(paste("degree (",degree,")",sep="")), 
                        side = 4,font = 2, line = 2.5, cex = 1),
     axis.args = list(at=seq(0, 75, 15),
                      labels=seq(0, 75, 15), 
                      cex.axis=1),
     smallplot=c(0.65+.22,.68+.22, .185+0.08,0.845-0.2))



plot(sa_slope_deg, add = TRUE, alpha = 0.5, legend.only = TRUE, 
     legend.args = list(text = expression(paste("degree (",degree,")",sep="")), 
                        side = 4,font = 2, line = 2.5, cex = 1),
     axis.args = list(at=seq(0, 75, 15),
                      labels=seq(0, 75, 15), 
                      cex.axis=1),
     smallplot=c(0.65+.22,.68+.22, .185+0.08,0.845-0.2))


 ### SA aspect


plot(sa_aspect_deg, legend = FALSE, axes = FALSE,box=FALSE, main = "Aspect", 
     col = (rainbow(360)))

points(DOB1300, pch = 16,
       col = "black", cex = 1)


plot(sa_aspect_deg, add = TRUE, legend.only = TRUE,col = rainbow(360),
     legend.args = list(text = expression(paste("degree (",degree,")",sep="")), 
                        side = 4,font = 2, line = 2.5, cex = 1),
     axis.args = list(at=seq(0, 360, 90),
                      labels=seq(0, 360, 90),  
                      cex.axis=1),
     smallplot=c(0.65+.22,.68+.22, .185+0.08,0.845-0.2))

plot(tar_aspect_deg, add = TRUE, legend.only = TRUE, col = rainbow(720),
     legend.args = list(text = expression(paste("degree (",degree,")",sep="")), 
                        side = 4,font = 2, line = 2.5, cex = 1),
     axis.args = list(at=seq(0, 360, 90),
                      labels=seq(0, 360, 90), 
                      cex.axis=1),
     smallplot=c(0.65+0.07,.68+0.07, .185+0.02,0.845-0.2))