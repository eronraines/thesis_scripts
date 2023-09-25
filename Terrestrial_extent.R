###
###
# Keeping tidy

# rm(list=ls(all=T))
# gc()
# .rs.restartR()
# rm(list=ls(all=T))
# gc()

library(spatialEco)
library(sf)
library(ggOceanMaps)
library(rgeos)
library(scattermore)
library(maptools)
require(rgdal)
library(sp)
library(plyr)
library(dplyr)
library(raster)
library(rgdal)
library(geodata)
library(exactextractr)


# where data is stored
NEDPath <- outPath <- "/Users/eronraines/Desktop/Chapter 3 data/global_landcover_data/"
# 
# # call in the world's terrestrial surface
# continental <- st_read(file.path(NEDPath, "ne_10m_land/ne_10m_land.shp"))
# islands <- st_read(file.path(NEDPath, "ne_10m_minor_islands/ne_10m_minor_islands.shp"))
# world <- rbind(continental,islands)
# dd_land <- clip_shapefile(world, c(-180, 180, -90, 90))
# save(dd_land, file = paste(outPath, "ggOceanMapsData/dd_land.rda", sep = "/"), compress = "xz")
# 
# # call in glacier coverage
# glaciers <- st_read(file.path(NEDPath, "ne_10m_glaciated_areas/ne_10m_glaciated_areas.shp"))
# glaciers <- as_Spatial(glaciers)
# glaciers <- gBuffer(glaciers, byid = TRUE, width = 0)
# dd_glacier <- clip_shapefile(glaciers, c(-180, 180, -90, 90))
# dd_glacier <- gBuffer(dd_glacier, byid = FALSE, width = 0.1)
# dd_glacier <- gBuffer(dd_glacier, byid = FALSE, width = -0.1)
# save(dd_glacier, file = paste(outPath, "ggOceanMapsData/dd_glacier.rda", sep = "/"), compress = "xz")
# 
# # call in lakes
# lake <- st_read(file.path(NEDPath, "ne_10m_lakes/ne_10m_lakes.shp"))
# lake <- as_Spatial(lake)
# lake <- gBuffer(lake, byid = TRUE, width = 0)
# dd_lake <- clip_shapefile(lake, c(-180, 180, -90, 90))
# dd_lake <- gBuffer(dd_lake, byid = FALSE, width = 0.1)
# dd_lake <- gBuffer(dd_lake, byid = FALSE, width = -0.1)
# save(dd_lake, file = paste(outPath, "ggOceanMapsData/dd_lake.rda", sep = "/"), compress = "xz")
# 
# # isolating extent of world's surface not covered by ice or water
# terrestrial <- gDifference(dd_land, dd_lake)
# terrestrial_ice_free <- gDifference(terrestrial, dd_glacier)
# save(terrestrial_ice_free, file = paste(outPath, "ggOceanMapsData/landsurface.rda", sep = "/"), compress = "xz")

# call the files if saved already
load(file = paste(outPath, "ggOceanMapsData/dd_land.rda", sep = "/"))
load(file = paste(outPath, "ggOceanMapsData/dd_glacier.rda", sep = "/"))
load(file = paste(outPath, "ggOceanMapsData/dd_lake.rda", sep = "/"))
load(file = paste(outPath, "ggOceanMapsData/landsurface.rda", sep = "/"))

# for convenience
land<-terrestrial_ice_free

