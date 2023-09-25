library(raster)
library(tidyverse)
library(ggtern)
library(plotly)
library(readr)
library(dplyr)
library(tidyr)

Kn <- raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/Kn_global.tif")
Ebio <- raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/Ebio_global.tif")
MASRB <- raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/MASRB_global.tif")

ras_stack <- stack(Kn,Ebio,MASRB,XY=TRUE)

Kn_df <- ras_stack$Kn_global
Ebio_df <- ras_stack$Ebio_global
MASRB_df <- ras_stack$MASRB_global

Kn_df2 <- as.data.frame(Kn_df)
Ebio_df2 <- as.data.frame(Ebio_df)
MASRB_df2 <- as.data.frame(MASRB_df)

DF <-data.frame(cbind(Kn_df2$Kn_global,Ebio_df2$Ebio_global,MASRB_df2$MASRB_global))
colnames(DF)<-c("Kn","Ebio","MASRB")
# building static ternary plot
ggtern(data=DF, aes(x=Kn,y=Ebio,z=MASRB)) +
  geom_point(pch=".")
DF2 <-na.omit(DF)





Ebio <- raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/Ebio_global.tif")
MAP<- raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/MAP_global.tif")
MAET<-raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/MAET_global.tif")
MASRB<-raster("/Users/eronraines/Desktop/Chapter 3 data/Rasters_for_analysis/MASRB_global.tif")
MAET[MAET<100] <- NA
MAP[MAP<100] <-NA
MASRB[MASRB > 180] <-NA
MASRB[MASRB@data@values>180]<-NA
Kn2 <- MAP/MAET

stack <-stack(Kn2,MASRB,Ebio)

df <- as.data.frame(stack, xy = TRUE) # this works with Raster* objects as well

plot(log10(df$layer),df$MASRB_global, pch=".",xlab=expression(paste("log10(K"[n],")")),ylab=expression(paste("MASRB (W m"^-2,")")), bty ="n",main = expression(paste("K"[n]," vs MASRB")))
plot(df$Ebio_global, df$MASRB_global, pch = ".")



