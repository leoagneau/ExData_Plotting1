plot2 <- function() {
  library(dplyr)
  datafile <- "household_power_consumption.txt"
  zipfile <- "household_power_consumption.zip"
  if (!file.exists(datafile)) {
    if (!file.exists("household_power_consumption.zip")) {
      download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", zipfile, method = "curl")
    }
    unzip(zipfile, datafile)
    file.remove(zipfile)
  }
  epc <- read.table(datafile, sep=";", header=T, na.strings = "?")
  epc$Date <- as.Date(epc$Date, "%d/%m/%Y")
  subepc <- filter(epc, (epc$Date == "2007-02-01")|(epc$Date == "2007-02-02"))
  rm(epc)
  
  png(file="plot2.png", width=480, height=480)
  plot(subepc$Global_active_power, xaxt="n", xlab="", ylab="Global Active Power (kilowatts)", type="l")
  axis(1, at=c(1,length(subepc$Global_active_power)/2,length(subepc$Global_active_power)), labels=c("Thu","Fri","Sat"))
  dev.off()
}