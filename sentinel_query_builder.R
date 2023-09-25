
month = matrix(c("07","08","09","10","11","12","01","02","03","04"))
nominal_day =matrix(c("10","10","10","10","10","10","10","10","10","10",
                      "10","10","10","10","10","10","10","10","10","10",
                      "20","20","20","20","20","20","20","20","20","20",
                      "20","20","20","20","20","20","20","20","20","20"))
variable = (c("fapar","fapar","fapar","fapar","fapar","fapar","fapar","fapar","fapar","fapar",
              "lai","lai","lai","lai","lai","lai","lai","lai","lai","lai"))
# sentinel_3 ####
year_sentinel = matrix(c("2018","2018","2018","2018","2018","2018","2019","2019","2019","2019"))
num_year  <-1
num_month <-10
num_day   <- 2
num_variable <- 2
sent_3 = "sentinel_3"
long   <- num_month*num_day*num_year*num_variable
sent_3_store <- matrix(NA,long,6)


sent_3_store[,1] <-sent_3
sent_3_store[,2] <-month
sent_3_store[,3] <-nominal_day
sent_3_store[,4] <-year_sentinel
sent_3_store[,5] <-variable

for(i in 1:(long)){
sent_3_store[i,6]<-paste(sent_3_store[i,1],"_",sent_3_store[i,2],sent_3_store[i,3],sent_3_store[i,4],"_",sent_3_store[i,5],".zip",sep="")
}





###
###
# combine calls
###
###

call_table <- sent_3_store


###
###
# build dynamic call request
###
###

request <- array(NA, nrow(call_table))
for(i in 1:nrow(call_table)){
  request[i] <- matrix(paste("dynamic_request(satellite= '",call_table[i,1],"',month='",call_table[i,2],"',nominal_day = '",call_table[i,3],"',year= '",call_table[i,4],  "',variable='",call_table[i,5],"',target= '",call_table[i,6],"'),", sep = ""))
}




write.csv(request,"/Users/eronraines/Desktop/Kill_me/a.csv") # I save files I am going to delete soonafter to a very specific working directory. Once saved as csv, you copy + paste the info into the relevant query code

