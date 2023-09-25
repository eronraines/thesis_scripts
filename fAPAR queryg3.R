rm(list=ls(all=T))
gc()
.rs.restartR()
rm(list=ls(all=T))
gc()



# devtools::install_github("bluegreen-labs/ecmwfr")

# your keys please
ecmwfr::wf_set_key(user = "USER DEFINED",
                   key = "USER DEFINED",
                   service = "cds")
# this sets where the downloaded data will be stored
dir <-"USER DEFINED"
setwd(dir)

request <- list(
  variable = "fapar",
  satellite = c("noaa_11", "noaa_14", "noaa_16", "noaa_17", "noaa_7", "noaa_9"),
  sensor = "avhrr",
  horizontal_resolution = "4km",
  product_version = "V3",
  year = c("1981", "1982", "1983", "1984", "1985", "1986", "1987", "1988", "1989", "1990", "1991", "1992", "1993", "1994", "1995", "1996", "1997", "1998", "1999", "2000", "2001", "2002", "2003", "2004", "2005"),
  month = c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"),
  nominal_day = c("10", "20"),
  format = "zip",
  dataset_short_name = "satellite-lai-fapar",
  target = "download.zip")



wf_request(request=request,
           transfer= TRUE,
           path = dir,
           verbose = FALSE
                )


