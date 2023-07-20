require(ncdf4)
require(maps)
require(rgdal)
require(raster)
#find all ncs in your directory
dir<-"YOUR WD HERE"
#get a list of all files with LAI in the name in your directory
files<-list.files(path=dir, pattern='.nc', full.names = TRUE)
#for calls
setwd(dir)
k = 1 # organization index
# this cycles through all files of indicated extension and pulls necessary data
for (file in files){ #this loop translates netcdf stored info into rasters
  print(k) #sometimes, you just gotta know...
  if(k==1){
    temp <- brick(file,varname="LAI")
  }
  if(k!=1){
    temp2 <-brick(file,varname="LAI")
    temp <- stack(temp,temp2)
  }
  k = k + 1
}

# #removes NAs
# temp[temp==65535] <-NA
#averages cell wise
rs1 <- calc(temp,mean,na.rm=TRUE)
#fix extent and resolution to match the other rasters used
MAP<-raster("YOUR WD HERE/MAP_global.tif")
rs1 <- resample(rs1,MAP)
#clip to terrestrial surface (have to run Global parameters.R first)
rs2 <- mask(rs1,land)
#plot that mess
plot(rs2, col =hcl.colors(12*10,"Temps"),
     plot.title = title(main = "Leaf Area Index"),
     xlab = "Longitude",
     ylab = "Latitude",
     useRaster=F)
map("world",add=T,fill=FALSE,lwd=0.1)
mtext(expression(paste("leaf-m"^2,"soil-m"^-2,sep="")),4,5)
writeRaster(rs2,"YOUR WD HERE/LAI_global.tif")
