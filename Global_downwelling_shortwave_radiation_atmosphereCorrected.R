require(ncdf4)
require(maps)
require(rgdal)
require(raster)
#find all ncs in your directory
dir<-"/Users/eronraines/Desktop/Chapter 3 data/SDSF"
#get a list of all files with ndvi in the name in your directory
files<-list.files(path=dir, pattern='.nc', full.names = TRUE)
#for calls
setwd(dir)
k = 1 # organization index
# this cycles through all files of indicated extension and pulls necessary data
for (file in files){ #this loop translates netcdf stored info into rasters
  print(k) #sometimes, you just gotta know...
  if(k==1){
    temp <- brick(file,varname="SIS")
  }
  if(k!=1){
    temp2 <-brick(file,varname="SIS")
    temp <- stack(temp,temp2)
  }
  k = k + 1
}
k = k - 1 # will be one extra so deal with it
for (i in 1:k){ # this loop places NAs where they're flagged
  print(i)#something real pretty to look at
  temp[[i]][temp[[i]]==1e+30] <- NA # na values are set to 1e+30, this replaces them
}
#removes NAs 
rs1 <- calc(temp,mean,na.rm=TRUE)
# fix extent
MAP<-raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/MAP_global.tif")
rs1 <- resample(rs1,MAP)

#clip to terrestrial surface (have to run Global parameters.R first)
rs2 <- mask(rs1,land)
#plot that mess

plot(rs2, col =hcl.colors(12*10,"Temps"),
     plot.title = title(main = "Mean Annual Downwelling Shortwave Radation"),
     xlab = "Longitude",
     ylab = "Latitude",
     useRaster=F)
# map("world",add=T,fill=FALSE)
mtext(expression("W m"^-2),4,5)
writeRaster(rs2,"/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/MADSR_global.tif")



