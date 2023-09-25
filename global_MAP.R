require(ncdf4)
require(maps)
require(rgdal)
require(raster)
#find all ncs in your directory
dir <-"/Users/eronraines/Desktop/Chapter 3 data/dataset-insitu-gridded-observations-global-and-regional-ff5ebe51-ad49-435f-9674-ea1d11e8beb1"
#get a list of all files with ncs in the name in your directory
files<-list.files(path=dir, pattern='.nc', full.names = TRUE)
#for calls
setwd(dir)

k = 1 # organization index
# this cycles through all files of indicated extension and pulls necessary data
for (file in files){ #this loop translates netcdf stored info into rasters
  print(k) #sometimes, you just gotta know...
  if(k == 1){
  year = 1982 # have to tell R where to start
    name<-paste("/Users/eronraines/Desktop/Chapter 3 data/dataset-insitu-gridded-observations-global-and-regional-ff5ebe51-ad49-435f-9674-ea1d11e8beb1/GPCC_total_precipitation_mon_0.25x0.25_global_",year,"_v2020.0.nc",sep="")
    rast <-brick(name,varname="pr")
       for(j in 1:12){
         if(j==1){
         temp <- stack(rast[[j]])
         }
         if(j!=1){
           temp <- stack(temp,rast[[j]])
         }
       }
  } 
  if(k!=1){
      year=year+1
      name<-paste("/Users/eronraines/Desktop/Chapter 3 data/dataset-insitu-gridded-observations-global-and-regional-ff5ebe51-ad49-435f-9674-ea1d11e8beb1/GPCC_total_precipitation_mon_0.25x0.25_global_",year,"_v2020.0.nc",sep="")
      rast <-brick(name,varname="pr")
      for(j in 1:12){
       if(j==1){
        temp<-stack(temp,rast[[j]])
       }
        if(j!=1){
          temp2<-stack(temp,rast[[j]])
        }
      }
    }
     k = k + 1
}




  for (i in 1:50){ # this loop places NAs where they're flagged
  print(i)#something real pretty to look at
  temp2[[i]][temp2[[i]]==3e+33] <- NA # na values are set to -9999, this replaces them
}

#removes NAs and takes monthly mean
rs1 <- calc(temp2,mean,na.rm=TRUE)
#converts to MAP
fun <- function(x) { x * 12 } 
rs1 <- calc(rs1, fun)
#forces to terrestrial, non-ice covered surface (have to run Global parameters.R)
rs2 <- mask(rs1,land)
#plot that mess
plot(log10(map), col =hcl.colors(100,"Temps"),
     plot.title = title(main = "Mean Annual Precipitation"),
     xlab = "Longitude",
     ylab = "Latitude",
     useRaster=FALSE,
     box=FALSE)
map("world",add=T,fill=FALSE, interior = FALSE, lwd = 0.08)
mtext(expression("m yr"^-1),4,5.5)
writeRaster(rs2,"/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/MAP_global.tif",overwrite=TRUE)

map <- raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/MAP_global.tif")


r<-map*1000