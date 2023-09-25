# this code calls in ncdf files containing 3 hr daily PAR measurements for the global surface at 10km horizontal resolution. Once called, the netcdfs are converted to rasters, stacked, and then averaged to create a global PAR surface over the time period 1982-2018. Because of memory constraints on my machine, I had to add some loop structures that saved the netcdf to tifs then purged the memory. The loops index where in the process the next iteration needed to pick up from.
require(ncdf4)
require(maps)
require(rgdal)
require(raster)
require(terra)
years <- seq(1984,2018)
file_start_k = 0 # this is used to select the proper starting file following the garbage dump
for(year in years){
#find all ncs in your directory
dir<-paste("/Volumes/WD_BLACK/PAR/",year,sep="")
#get a list of all files with LAI in the name in your directory
files<-list.files(path=dir, pattern='.nc', full.names = TRUE)
#for calls
setwd(dir)
k = 1 # organization index
# this cycles through all files of indicated extension and pulls necessary data
if(file_start_k!=0){ # this determines which file within files to start with following the garbage dump
  files <- files[files[(file_start_k+1):length(files)]]
}
for (file in files){ #this loop translates netcdf stored info into rasters
  print(k) #sometimes, you just gotta know...
  if(k==1){
    nc = nc_open(file)
    total_par = ncvar_get(nc, "total_par")
    z = flip(rast(t(total_par)))
    ext(z)=c(-180, 180, -90, 90)
    crs(z) = "epsg:4326"
    temp <- brick(z)
  }
  if(k!=1){
    nc = nc_open(file)
    total_par = ncvar_get(nc, "total_par")
    z = flip(rast(t(total_par)))
    ext(z)=c(-180, 180, -90, 90)
    crs(z) = "epsg:4326"
    temp2 <-brick(z)
    temp <- stack(temp,temp2)
  }
  k = k + 1
  
  if (k > 500){ # this loop is necessary because of memory constraints on my machine
    #removes NAs and averages rasters by year
    yr_ct_dir<-"/Volumes/WD_BLACK/PAR/counts/"
    write.csv(1,paste(yr_ct_dir,Sys.time(),".csv",sep="")) # this acts as within year index as reference for next iteration year used
    write.csv(1,paste(dir,"/",Sys.time(),".csv",sep="")) # this acts as within year index to reference starting file
    rs1 <- calc(temp,mean,na.rm=TRUE) # this creates a single tif which is the average of all files in the 500 stack
    writeRaster(rs1,paste(dir, "/",year,"_",file_start_k,".tif",sep="")) # this saves the tif locally
    # have to clear memory. so, built indexing system to recall where the process was
    # clean up
    rm(list=ls(all=T))
    gc()
    .rs.restartR() 
    rm(list=ls(all=T))
    gc()
    
    # this chunk of black magic points the code to the proper directories and files to pick up from where the garbage dump above occurred.
    yr_ct_dir<-"/Volumes/WD_BLACK/PAR/counts/" # csvs are saved in this file to signify the progression of years through the loop iterations
    year_csvs<-list.files(path=yr_ct_dir, pattern='.csv', full.names = TRUE) # this calls the above csvs for counting
    quot <- trunc(length(year_csvs)/5,0) #number of counts divided by 5. after 5, the year advances by one. removing the remainder provides the additive factor that modifies the minimum year of the year range such that it progresses every 5th 500th iteration
    years = seq(1984 + quot, 2018) # takes above additive factor and corrects age when necessary
    year = min(years)
    dir <- paste("/Volumes/WD_BLACK/PAR/",min(years),sep="")
    files_csvs <- list.files(path=dir, pattern='.csv', full.names = TRUE)
    file_start_k <- length(files_csvs) * 500 # used to strip the files already ready from the files variable used to call each file 
    
    if(length(year_csvs) %% 5 == 0){ # this sets the file_start_k to 0 when a year step has been made - this is necessary to do because of the indexing architecture of the above code
      file_start_k = 0
    }
    k = 1
  }
  
}
}


