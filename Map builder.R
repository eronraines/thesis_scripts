rm(list=ls(all=T))
gc()
# .rs.restartR()
rm(list=ls(all=T))
gc()





# install.packages(c("rayshader", "raster", "sp"))
library(rayshader)
library(sp)
library(raster)
library(scales)
library(rayrender)
library(rayimage)

# this is for labels
tar_lat = list()
tar_long = list()
tar_lat[[1]] = -40.929936
tar_lat[[2]] = -40.903073
tar_lat[[3]] = -40.883089

tar_long[[1]] = 175.268228
tar_long[[2]] = 175.247841
tar_long[[3]] = 175.235626

tar1200_lat <- list()
tar1200_long <- list()
tar1200_lat[[1]] <- -40.929936
tar1200_long[[1]] <- 175.268228
## call in DEMS
extent(tar)
extent(tarb)
tar <- raster("/Volumes/WD_BLACK/Map building/DEM_for_TAR_for_map/nzdem-north-island-25-metre.tif")
tarb <-raster("/Volumes/WD_BLACK/NZ/TAR_B_for_plotting/nzdem-north-island-25-metre.tif")
sa_ext_box <- raster("/Volumes/WD_BLACK/NZ/SA_DEM_for_extent/nzdem-south-island-25-metre.tif")
sa <- raster("/Volumes/WD_BLACK/Map building/SA_DEM_for_mapping/nzdem-south-island-25-metre.tif")
## call in LANDSAT images
tar1_r = raster("/Volumes/WD_BLACK/Map building/tar_pt1/LC08_L1TP_072089_20210325_20210402_01_T1_B4.TIF")
tar1_g = raster("/Volumes/WD_BLACK/Map building/tar_pt1/LC08_L1TP_072089_20210325_20210402_01_T1_B3.TIF")
tar1_b = raster("/Volumes/WD_BLACK/Map building/tar_pt1/LC08_L1TP_072089_20210325_20210402_01_T1_B2.TIF")

tar2_r = raster("/Volumes/WD_BLACK/Map building/tar_pt2/LC08_L1TP_072088_20210325_20210402_01_T1_B4.TIF")
tar2_g = raster("/Volumes/WD_BLACK/Map building/tar_pt2/LC08_L1TP_072088_20210325_20210402_01_T1_B3.TIF")
tar2_b = raster("/Volumes/WD_BLACK/Map building/tar_pt2/LC08_L1TP_072088_20210325_20210402_01_T1_B2.TIF")


sa1_r = raster("/Volumes/WD_BLACK/Map building/sa_pt1/LC08_L1TP_075090_20210501_20210508_01_T1_B4.TIF")
sa1_g = raster("/Volumes/WD_BLACK/Map building/sa_pt1/LC08_L1TP_075090_20210501_20210508_01_T1_B3.TIF")
sa1_b = raster("/Volumes/WD_BLACK/Map building/sa_pt1/LC08_L1TP_075090_20210501_20210508_01_T1_B2.TIF")

sa2_r = raster("/Volumes/WD_BLACK/Map building/sa_pt2/LC08_L1TP_075091_20210501_20210508_01_T1_B4.TIF")
sa2_g = raster("/Volumes/WD_BLACK/Map building/sa_pt2/LC08_L1TP_075091_20210501_20210508_01_T1_B3.TIF")
sa2_b = raster("/Volumes/WD_BLACK/Map building/sa_pt2/LC08_L1TP_075091_20210501_20210508_01_T1_B2.TIF")

# combine LANDSAT color rasters
tar1_rgb = stack(tar1_r, tar1_g, tar1_b)
tar2_rgb = stack(tar2_r, tar2_g, tar2_b)

tar1_rgb[tar1_rgb==0]<-NA
tar2_rgb[tar2_rgb==0]<-NA
m_tar <- merge(tar1_rgb,tar2_rgb)
m_tar[m_tar==0]<-NA # this is the combined SA scene and is what is manipulated below


sa1_rgb = stack(sa1_r, sa1_g, sa1_b)
sa2_rgb = stack(sa2_r, sa2_g, sa2_b)
sa1_rgb[sa1_rgb==0]<-NA
sa2_rgb[sa2_rgb==0]<-NA
m <- merge(sa1_rgb,sa2_rgb)
m[m==0]<-NA # this is the combined SA scene and is what is manipulated below


# correct LANDSAT rasters
tar_rgb_corrected = sqrt(m_tar)

sa_rgb_corrected = sqrt(m)

#matching extents
tar@crs@projargs
tar_rgb_corrected@crs@projargs # not the same crs as DEM so must transform

sa@crs@projargs
sa_rgb_corrected@crs@projargs # also not the same crs as DEM so must transform

#tar_rgb_corrected_TF = projectRaster(tar_rgb_corrected,crs = crs(tar),method = "bilinear")
#already saved, can just call to save time
tar_rgb_corrected_TF <- brick("/Volumes/WD_BLACK/Map building/quick_call_rasters/tar_rgb_ready_for_analysis.tif")

sa_rgb_corrected_TF = projectRaster(sa_rgb_corrected,crs = crs(sa),method = "bilinear")



#trimming DEM rasters to specified extent for mapping
tar_ext <- extent(tar)
tar_bottom_left <- c(x = min(tar_ext[1:2]), y = min(tar_ext[3:4]))
tar_top_right <- c(x = max(tar_ext[1:2]), y = max(tar_ext[3:4]))

tarb_ext <- extent(tarb)
tarb_bottom_left <- c(x = min(tarb_ext[1:2]), y = min(tarb_ext[3:4]))
tarb_top_right <- c(x = max(tarb_ext[1:2]), y = max(tarb_ext[3:4]))


sa_ext <- extent(sa)
sa_bottom_left <- c(x = min(sa_ext[1:2]), y = min(sa_ext[3:4]))
sa_top_right <- c(x = max(sa_ext[1:2]), y = max(sa_ext[3:4]))

#

tar_extent_latlong <- SpatialPoints(rbind(tar_bottom_left,tar_top_right),proj4string = crs(tar))
tar_extent_map = spTransform(tar_extent_latlong, crs(tar))

tarb_extent_latlong <- SpatialPoints(rbind(tarb_bottom_left,tarb_top_right),proj4string = crs(tarb))
tarb_extent_map = spTransform(tarb_extent_latlong, crs(tarb))




sa_extent_latlong <- SpatialPoints(rbind(sa_bottom_left,sa_top_right),proj4string = crs(sa))
sa_extent_map = spTransform(sa_extent_latlong, crs(sa))


e_tar = extent(tar_extent_map)
e_tarb = extent(tarb_extent_map)
e_sa = extent(sa_extent_map)

# trimming LANDSAT rasters to be same extent
tar_rgb_cropped <- crop(tar_rgb_corrected_TF,e_tar)
names(tar_rgb_cropped) = c("r","g","b")

tarb_rgb_cropped <- crop(tar_rgb_corrected_TF,e_tarb)
names(tarb_rgb_cropped) = c("r","g","b")

sa_rgb_cropped <- crop(sa_rgb_corrected_TF,e_sa)
names(sa_rgb_cropped) = c("r","g","b")

# tarb_stretch <-
#   raster::stretch(tarb_rgb_c,
#                   minq = .01,
#                   maxq = .99
#   )
# 
# scalebar(d=20, type='bar',xy = click(), divs = 2, below = "kilometers", 
#          lonlat = NULL, adj=c(1.5, -1.5), lwd = 2)

#converting to format for manipulation with functions from rayshader

###
###
# Tararua range

tarb_r_cropped = raster_to_matrix(tarb_rgb_cropped$r)
tarb_g_cropped = raster_to_matrix(tarb_rgb_cropped$g)
tarb_b_cropped = raster_to_matrix(tarb_rgb_cropped$b)

tarb_rgb_array = array(0, dim=c(nrow(tarb_r_cropped),ncol(tarb_r_cropped),3))

tarb_rgb_array[,,1] = tarb_r_cropped/255
tarb_rgb_array[,,2] = tarb_g_cropped/255
tarb_rgb_array[,,3] = tarb_b_cropped/255

tarb_matrix = raster_to_matrix(tarb)

tarb_rgb_array = aperm(tarb_rgb_array,c(2,1,3))
# adjust contrast for better image
tarb_rgb_contrast = scales::rescale(tarb_rgb_array,to=c(0,1))
max(tarb_rgb_contrast)


tarb_matrix %>%
  sphere_shade(zscale = 20, sunangle = 90+45, texture = "imhof3") %>%
  plot_3d(tarb_matrix,  zscale = 20,
          zoom=0.65,fov=70, shadowcolor = "#523e2b")

alt1 = c(1205,805,405)
alt2 = c(1245,845,445)

render_points(extent = attr(tarb,"extent"),
              lat = unlist(tar_lat), lon = unlist(tar_long),
              altitude = alt2,
              zscale=20, size = 10,
              col = 'red')
render_points(extent = attr(tarb,"extent"),
              lat = unlist(tar_lat), lon = unlist(tar_long),
              altitude = alt1,
              zscale=20, size = 10,
              col = 'black')


render_camera(theta=-360,phi=45,zoom=0.45,fov=125)
render_snapshot()


###
###
# TARARUA STUDY REGION

# tarb_r_cropped = raster_to_matrix(tarb_rgb_cropped$r)
# tarb_g_cropped = raster_to_matrix(tarb_rgb_cropped$g)
# tarb_b_cropped = raster_to_matrix(tarb_rgb_cropped$b)
# 
# tarb_rgb_array = array(0, dim=c(nrow(tarb_r_cropped),ncol(tarb_r_cropped),3))
# 
# tarb_rgb_array[,,1] = tarb_r_cropped/255
# tarb_rgb_array[,,2] = tarb_g_cropped/255
# tarb_rgb_array[,,3] = tarb_b_cropped/255
# 
# tarb_matrix = raster_to_matrix(tarb)
# 
# tarb_rgb_array = aperm(tarb_rgb_array,c(2,1,3))
# # adjust contrast for better image
# tarb_rgb_contrast = scales::rescale(tarb_rgb_array,to=c(0,1))
# max(tarb_rgb_contrast)
# 
# 
# tarb_matrix %>%
#   sphere_shade(zscale = 20, sunangle = 90+45, texture = "imhof3") %>%
#   plot_3d(tarb_matrix,  zscale = 20,
#           zoom=0.65,fov=70, shadowcolor = "#523e2b")
# 
# alt1 = c(1205,805,405)
# alt2 = c(1245,845,445)
# 
# render_points(extent = attr(tarb,"extent"),
#               lat = unlist(tar_lat), lon = unlist(tar_long), 
#               altitude = alt2,
#               zscale=20, size = 10,
#               col = 'red')
# render_points(extent = attr(tarb,"extent"),
#               lat = unlist(tar_lat), lon = unlist(tar_long), 
#               altitude = alt1,
#               zscale=20, size = 10,
#               col = 'black')
# 
# 
# render_camera(theta=-360,phi=45,zoom=0.45,fov=125)
# render_snapshot()


###
###
# TAR1200 500m buffer


TAR1200_500m <- geobuffer_pts(xy = tar1200pts, dist_m = 500)
e_TAR1200_500m <- extent(TAR1200_500m)
TAR1200_rgb_500m_buf <- crop(tar_rgb_corrected_TF,e_TAR1200_500m)
names(TAR1200_rgb_500m_buf) = c("r","g","b")




tar1200_r_cropped = raster_to_matrix(TAR1200_rgb_500m_buf$r)
tar1200_g_cropped = raster_to_matrix(TAR1200_rgb_500m_buf$g)
tar1200_b_cropped = raster_to_matrix(TAR1200_rgb_500m_buf$b)

tar1200_rgb_array = array(0, dim=c(nrow(tar1200_r_cropped),ncol(tar1200_r_cropped),3))

tar1200_rgb_array[,,1] = tar1200_r_cropped/255
tar1200_rgb_array[,,2] = tar1200_g_cropped/255
tar1200_rgb_array[,,3] = tar1200_b_cropped/255

t1200<- crop(tarb,TAR1200_500m)

tar1200_matrix = raster_to_matrix(t1200)

tar1200_rgb_array = aperm(tar1200_rgb_array,c(2,1,3))
# adjust contrast for better image
tar1200_rgb_contrast = scales::rescale(tar1200_rgb_array,to=c(0,1))


tar1200_matrix %>%
  sphere_shade(zscale = 20, sunangle = 90+45, texture = "imhof3") %>%
  plot_3d(tar1200_matrix,  zscale = 20,
          zoom=0.65,fov=70, shadowcolor = "#523e2b")
render_camera(theta=0,phi=65,zoom=0.45,fov=125)
render_compass()

alt1 = c(1205)
alt2 = c(1215)


render_points(extent = extent(TAR1200_500m),
              lat = unlist(tar1200_lat),long = unlist(tar1200_long),
              altitude = alt2,
              zscale=20, size = 10,
              col = 'red')
render_points(extent = extent(TAR1200_500m),
              lat = unlist(tar1200_lat),long = unlist(tar1200_long),
              altitude = alt1,
              zscale=20, size = 10,
              col = 'black')

render_compass()

render_snapshot()
render_highquality()
