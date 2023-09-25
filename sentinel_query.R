rm(list=ls(all=T))
gc()
.rs.restartR()
rm(list=ls(all=T))
gc()


library(beepr)
library(ecmwfr)
# your keys, please
ecmwfr::wf_set_key(user = "150503",
                   key = "2c24fcba-0fba-4181-88f5-59d3606d87f4",
                   service = "cds")
# this sets where the downloaded data will be stored
dir <-"/Volumes/WD_BLACK/NZ_fAPAR_LAI"
setwd(dir)

# general request sent to copernicus

request <- 
  dynamic_request <- wf_archetype(
    request = list(
      format = "zip",
      horizontal_resolution = "300m",
      satellite = "sentinel_3",
      sensor = "olci_and_slstr",
      variable = "fapar",
      product_version = "V4",
      year = "2018",
      month = "07",
      nominal_day = "10",
      dataset_short_name = "satellite-lai-fapar",
      target = "download.zip"),
    dynamic_fields = c("year","month","nominal_day","satellite","target","variable"))

    
batch_request <- list(

  # dynamic_request(satellite= 'sentinel_3',month='07',nominal_day = '10',year= '2018',variable='fapar',target= 'sentinel_3_07102018_fapar.zip'),
  # dynamic_request(satellite= 'sentinel_3',month='08',nominal_day = '10',year= '2018',variable='fapar',target= 'sentinel_3_08102018_fapar.zip'),
  dynamic_request(satellite= 'sentinel_3',month='09',nominal_day = '10',year= '2018',variable='fapar',target= 'sentinel_3_09102018_fapar.zip'),
  dynamic_request(satellite= 'sentinel_3',month='10',nominal_day = '10',year= '2018',variable='fapar',target= 'sentinel_3_10102018_fapar.zip'),
  dynamic_request(satellite= 'sentinel_3',month='11',nominal_day = '10',year= '2018',variable='fapar',target= 'sentinel_3_11102018_fapar.zip'),
  dynamic_request(satellite= 'sentinel_3',month='12',nominal_day = '10',year= '2018',variable='fapar',target= 'sentinel_3_12102018_fapar.zip'),
  dynamic_request(satellite= 'sentinel_3',month='01',nominal_day = '10',year= '2019',variable='fapar',target= 'sentinel_3_01102019_fapar.zip'),
  dynamic_request(satellite= 'sentinel_3',month='02',nominal_day = '10',year= '2019',variable='fapar',target= 'sentinel_3_02102019_fapar.zip'),
  # dynamic_request(satellite= 'sentinel_3',month='03',nominal_day = '10',year= '2019',variable='fapar',target= 'sentinel_3_03102019_fapar.zip'),
  # dynamic_request(satellite= 'sentinel_3',month='04',nominal_day = '10',year= '2019',variable='fapar',target= 'sentinel_3_04102019_fapar.zip'),
  dynamic_request(satellite= 'sentinel_3',month='07',nominal_day = '20',year= '2018',variable='fapar',target= 'sentinel_3_07202018_fapar.zip'),
  # dynamic_request(satellite= 'sentinel_3',month='08',nominal_day = '20',year= '2018',variable='fapar',target= 'sentinel_3_08202018_fapar.zip'),
  dynamic_request(satellite= 'sentinel_3',month='09',nominal_day = '20',year= '2018',variable='fapar',target= 'sentinel_3_09202018_fapar.zip'),
  dynamic_request(satellite= 'sentinel_3',month='10',nominal_day = '20',year= '2018',variable='fapar',target= 'sentinel_3_10202018_fapar.zip'),
  dynamic_request(satellite= 'sentinel_3',month='11',nominal_day = '20',year= '2018',variable='fapar',target= 'sentinel_3_11202018_fapar.zip'),
  dynamic_request(satellite= 'sentinel_3',month='12',nominal_day = '20',year= '2018',variable='fapar',target= 'sentinel_3_12202018_fapar.zip'),
  dynamic_request(satellite= 'sentinel_3',month='01',nominal_day = '20',year= '2019',variable='fapar',target= 'sentinel_3_01202019_fapar.zip'),
  # dynamic_request(satellite= 'sentinel_3',month='02',nominal_day = '20',year= '2019',variable='fapar',target= 'sentinel_3_02202019_fapar.zip'),
  # dynamic_request(satellite= 'sentinel_3',month='03',nominal_day = '20',year= '2019',variable='fapar',target= 'sentinel_3_03202019_fapar.zip'),
  dynamic_request(satellite= 'sentinel_3',month='04',nominal_day = '20',year= '2019',variable='fapar',target= 'sentinel_3_04202019_fapar.zip'),
  
  # dynamic_request(satellite= 'sentinel_3',month='07',nominal_day = '10',year= '2018',variable='lai',target= 'sentinel_3_07102018_lai.zip'),
  # dynamic_request(satellite= 'sentinel_3',month='08',nominal_day = '10',year= '2018',variable='lai',target= 'sentinel_3_08102018_lai.zip'),
  dynamic_request(satellite= 'sentinel_3',month='09',nominal_day = '10',year= '2018',variable='lai',target= 'sentinel_3_09102018_lai.zip'),
  dynamic_request(satellite= 'sentinel_3',month='10',nominal_day = '10',year= '2018',variable='lai',target= 'sentinel_3_10102018_lai.zip'),
  dynamic_request(satellite= 'sentinel_3',month='11',nominal_day = '10',year= '2018',variable='lai',target= 'sentinel_3_11102018_lai.zip'),
  # dynamic_request(satellite= 'sentinel_3',month='12',nominal_day = '10',year= '2018',variable='lai',target= 'sentinel_3_12102018_lai.zip'),
  # dynamic_request(satellite= 'sentinel_3',month='01',nominal_day = '10',year= '2019',variable='lai',target= 'sentinel_3_01102019_lai.zip'),
  dynamic_request(satellite= 'sentinel_3',month='02',nominal_day = '10',year= '2019',variable='lai',target= 'sentinel_3_02102019_lai.zip'),
  dynamic_request(satellite= 'sentinel_3',month='03',nominal_day = '10',year= '2019',variable='lai',target= 'sentinel_3_03102019_lai.zip'),
  dynamic_request(satellite= 'sentinel_3',month='04',nominal_day = '10',year= '2019',variable='lai',target= 'sentinel_3_04102019_lai.zip'),

  
  dynamic_request(satellite= 'sentinel_3',month='07',nominal_day = '20',year= '2018',variable='lai',target= 'sentinel_3_07202018_lai.zip'),
  # dynamic_request(satellite= 'sentinel_3',month='08',nominal_day = '20',year= '2018',variable='lai',target= 'sentinel_3_08202018_lai.zip')
  dynamic_request(satellite= 'sentinel_3',month='09',nominal_day = '20',year= '2018',variable='lai',target= 'sentinel_3_09202018_lai.zip'),
  dynamic_request(satellite= 'sentinel_3',month='10',nominal_day = '20',year= '2018',variable='lai',target= 'sentinel_3_10202018_lai.zip'),
  dynamic_request(satellite= 'sentinel_3',month='11',nominal_day = '20',year= '2018',variable='lai',target= 'sentinel_3_11202018_lai.zip'),
  # dynamic_request(satellite= 'sentinel_3',month='12',nominal_day = '20',year= '2018',variable='lai',target= 'sentinel_3_12202018_lai.zip'),
  dynamic_request(satellite= 'sentinel_3',month='01',nominal_day = '20',year= '2019',variable='lai',target= 'sentinel_3_01202019_lai.zip'),
  dynamic_request(satellite= 'sentinel_3',month='02',nominal_day = '20',year= '2019',variable='lai',target= 'sentinel_3_02202019_lai.zip'),
  # dynamic_request(satellite= 'sentinel_3',month='03',nominal_day = '20',year= '2019',variable='lai',target= 'sentinel_3_03202019_lai.zip'),
  dynamic_request(satellite= 'sentinel_3',month='04',nominal_day = '20',year= '2019',variable='lai',target= 'sentinel_3_04202019_lai.zip')
   
  )
time_out = 3600
workers = 20
# calls the request and points to where the data is stored.
wf_request_batch(request=batch_request,
                 path = dir,
                 workers = workers,
                 time_out = time_out,
                 total_timeout = 20*time_out/workers)
