# this code trims compiles the NetCDFs of the lai and fapar data, converts them to rasters, trims the raster to the extent of New Zealand total solar radiation dataset, stacks the rasters, removes the na's, averages the raster cell values, then saves the raster

# LAI
# for trimming
trim <- raster("/Volumes/WD_BLACK/NZ/site_data/nzenvds-annual-potential-incoming-solar-radiation-v10.tif")

#find all ncs in your directory
dir<-"/Volumes/WD_BLACK/NZ_fAPAR_LAI/LAI"
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
    temp <- crop(temp,trim)
  }
  if(k!=1){
    
    temp2 <- brick(file,varname="LAI")
    temp2 <- crop(temp2,trim)
    temp <- stack(temp,temp2)
  }
  k = k + 1
}

# #removes NAs
temp[temp==65535] <-NA
#averages cell wise
rs1 <- calc(temp,mean,na.rm=TRUE)
#save raster
writeRaster(rs1,"/Volumes/WD_BLACK/Chapter 3 images/hillshade_maps/organisms/LAI.tif")

# fAPAR
# for trimming
trim <- raster("/Volumes/WD_BLACK/NZ/site_data/nzenvds-annual-potential-incoming-solar-radiation-v10.tif")
#find all ncs in your directory
dir<-"/Volumes/WD_BLACK/NZ_fAPAR_LAI/fAPAR"
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
    temp <- crop(temp,trim)
  }
  if(k!=1){
    temp2 <-brick(file,varname="fAPAR")
    temp2 <- crop(temp2,trim)
    temp <- stack(temp,temp2)
  }
  k = k + 1
}

# #removes NAs
temp[temp==65535] <-NA
#averages cell wise
rs1 <- calc(temp,mean,na.rm=TRUE)
#fix extent and resolution to match the other rasters used
writeRaster(rs1,"/Volumes/WD_BLACK/Chapter 3 images/hillshade_maps/organisms/fAPAR.tif")

  
  