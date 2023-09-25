require(ncdf4)
require(maps)
require(rgdal)
require(raster)
#find all ncs in your directory
dir<-"/Volumes/WD_BLACK/NZ_fAPAR_LAI/fAPAR"
#get a list of all files with LAI in the name in your directory
files<-list.files(path=dir, pattern='.nc', full.names = TRUE)
#for calls
setwd(dir)

ncin <- nc_open(files)
k = 1 # organization index
# this cycles through all files of indicated extension and pulls necessary data
for (file in files){ #this loop translates netcdf stored info into rasters
  print(k) #sometimes, you just gotta know...
  if(k==1){
    temp <- brick(file,varname="fAPAR")
  }
  if(k!=1){
    temp2 <-brick(file,varname="fAPAR")
    temp <- stack(temp,temp2)
  }
  k = k + 1
}
k = k - 1 # will be one extra so deal with it
for (i in 1:k){ # this loopy loop places NAs where they're flaggedy flagged
  print(i)#something real pretty to look at
  temp[[i]][temp[[i]]==-10000] <- NA # na values are set to 65535, this replaces them
}
#removes NAs
rs1 <- calc(temp,mean,na.rm=TRUE)

# need to flip map hemispheres. bounding main raster to make two sub rasters
crop_bound_L <- extent(0,180,-90,90)
crop_bound_R <- extent(180,360,-90,90)
r_crop_L <- crop(x = rs1, y = crop_bound_L)
r_crop_R <- crop(x = rs1, y = crop_bound_R)

#adjusting the extents to reorient the hemispheres
r_crop_L@extent = extent(180,360,-90,90) 
r_crop_R@extent = extent(0,180,-90,90) 

# merging the two hemispheres
r_merge <- merge(r_crop_L,r_crop_R)



#strip away oceans, surface water, and glaciers
rs3 <-mask(rs2,land)

#plot that mess
plot(rs3, col =hcl.colors(12*10,"Temps"),
     plot.title = title(main = "Mean Annual Photosynthetically Active Radiation"),
     xlab = "Longitude",
     ylab = "Latitude",
     useRaster=F)
map("world",add=T,fill=FALSE,lwd=0.1)
mtext(expression(paste("W m"^-2,sep="")),4,5)
writeRaster(rs3,"/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/MAPAR_global.tif")
