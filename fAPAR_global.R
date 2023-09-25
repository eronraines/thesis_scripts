rm(list=ls(all=T))
gc()
.rs.restartR()
rm(list=ls(all=T))
gc()

require(ncdf4)
require(maps)
require(rgdal)
require(raster)

#find all ncs in your directory
dir<-"/Volumes/WD_BLACK/fAPAR"
#get a list of all files with LAI in the name in your directory
files<-list.files(path=dir, pattern='.nc', full.names = TRUE)
#for calls
setwd(dir)
k = 1 # organization index
# this cycles through all files of indicated extension and pulls necessary data
for (file in files){ #this loop translates netcdf stored info into rasters
  print(k) #sometimes, you just gotta know...
  if(k==1){
    temp <- brick(file,varname="fAPAR")
    temp[temp==65535] <- NA # na values are set to 65535, this replaces them
  }
  if(k!=1){
    temp2 <-brick(file,varname="fAPAR")
    temp2[temp2==65535] <- NA # na values are set to 65535, this replaces them
    temp <- stack(temp,temp2)
  }
  k = k + 1
}


# average cell-wise
rs1 <- calc(temp,mean,na.rm=TRUE)
#fix extent and resolution to match the other rasters used
MAP<-raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/MAP_global.tif")
rs1 <- resample(rs1,MAP)
#clip to terrestrial surface (have to run Global parameters.R first)
rs2 <- mask(rs1,land)
#plot that mess
plot(rs2, col =hcl.colors(12*10,"Temps"),
     plot.title = title(main = "fraction Absorped Photosynthetically Active Radiation"),
     xlab = "Longitude",
     ylab = "Latitude",
     useRaster=F)
# map("world",add=T,fill=FALSE)
# mtext(expression("W m"^-2),4,5)
writeRaster(rs2,"/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/fAPAR_global.tif")
