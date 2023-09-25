### 
###
# This code pulls the soil carbon information for a set of spatial points
###
###

require(raster)

# this is the tiff of NZ carbon, download tif from landcare, 
#put in directory, point here
NZ_carbon <-raster("/Users/eronraines/Desktop/Chapter 3 data/lris-smap-predicted-carbon-august-2022-GTiff/smap-predicted-carbon-august-2022.tif") 

# assigning spatial points to query the shapefile with
# these coordinates roughly relate the spatial extent of the Tararua Range as 
# observed using Google Earth Pro
# in WGS 1984
tar_x_coords <- c(175.687867,175.415374, 175.004008,175.083160,175.406016)
tar_y_coords <- c(-40.423299,-40.630564, -41.020848,-41.095103,-40.873529)

extent <- cbind(tar_x_coords,tar_y_coords) 

# this generates longitude/latitude values within the coordinates to call the 
# climate data from the Tararua Range
set.seed(1)
lon2 <- runif(1000000, min(tar_x_coords),max(tar_x_coords)) 
lat2 <- runif(1000000, min(tar_y_coords),max(tar_y_coords)) 
points<-cbind(lon2,lat2)


##
## this chunk manipulates points and soil map data
##

# converts points to format that can query
pointtoplot <- data.frame(x=points[,1],y=points[,2]) 

pointtoplot <- SpatialPoints(cbind(x=points[,1],y=points[,2]),
                             proj4string = CRS("+proj=longlat +datum=WGS84 +no_
                                               defs +ellps=WGS84 +towgs84=0,0,0
                                               "))

combine_carbon <-extract(NZ_carbon,pointtoplot)

