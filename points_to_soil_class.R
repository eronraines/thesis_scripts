

### 
###
# This code pulls the FAO soil taxonomy information for a set of spatial   # points
###
###

require(rgdal)

# this is the shapefile of FAO-UNESCO soil map, download ESRI shapfile, put # in directory, point here
global_soils <-readOGR("/Users/eronraines/Desktop/Chapter 3 data/DSMW/DSMW.shp") 

# converts the shapefile to a format that can be queried with points 
datapol <- data.frame(global_soils)  


# assigning spatial points to query the shapefile with
# these coordinates roughly relate the spatial extent of the Tararua Range # as observed using Google Earth Pro
tar_x_coords <- c(175.687867,175.415374, 175.004008,175.083160,175.406016)
tar_y_coords <- c(-40.423299,-40.630564, -41.020848,-41.095103,-40.873529)

extent <- cbind(tar_x_coords,tar_y_coords)

# this generates longitude/latitude values within the coordinates to call  # the climate data from the Tararua Range
set.seed(1)
lon2 <- runif(1000000, min(tar_x_coords),max(tar_x_coords)) 
lat2 <- runif(1000000, min(tar_y_coords),max(tar_y_coords)) 
points<-cbind(lon2,lat2)


##
## this chunk manipulates points and soil map data
##


# converts points to format that can query datapol

pointtoplot <- data.frame(x=points[,1],y=points[,2]) 
coordinates(pointtoplot) <- ~x+y
test <- data.frame(xx=over(global_soils,pointtoplot))
combine_soil <- cbind(test,datapol$FAOSOIL) # pulls FAO classifications for points


table(combine_soil$`datapol$FAOSOIL`)







combine <- na.omit(combine) # need to remove NAs

# this variable contains the soil classifications falling within the 
# bounding box

combine
