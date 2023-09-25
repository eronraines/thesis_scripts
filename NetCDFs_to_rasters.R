# this code calls in ncdf files containing 3 hr daily PAR measurements for the global surface at 10km horizontal resolution. Once called, the netcdfs are converted to rasters, stacked, and then averaged to create a global PAR surface over the time period 1982-2018. Because of memory constraints on my machine, I had to add some loop structures that saved the netcdf to tifs then purged the memory. The loops index where in the process the next iteration needed to pick up from.
require(ncdf4)
require(maps)
require(rgdal)
require(raster)
require(terra)

# the function used herein
mean_nc <- function(files){
  utils::txtProgressBar
  n = 0
  first=TRUE
  for(file in files){
    nc = nc_open(file)
    total_par = ncvar_get(nc, "total_par")
    nc_close(nc) # release
    if(first){
      m = matrix(0, nrow=nrow(total_par), ncol=ncol(total_par))
      first = FALSE
    }
    n = n + 1
    m = (1/n) * total_par + ((n-1)/n) * m
  }
  return(m)
}
years <- seq(1984,2018)
for(year in years){
  #find all ncs in your directory
  dir<-paste("/Volumes/WD_BLACK/PAR/",year,sep="")
  files<-list.files(path=dir, pattern='.nc', full.names = TRUE)
  mn <- mean_cdf(files)
  test <- rast(t(mn))
  ext(test)=c(-180, 180, -90, 90)
  crs(test) = "epsg:4326"
  save <- brick(test) 
  writeRaster(save,paste("/Volumes/WD_BLACK/PAR/rasters/",year,".tif",sep=""))
}



