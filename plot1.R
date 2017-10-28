plot1 <- function() {
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
  
  png(file="plot1.png", width=480, height=480)
  hist(subepc$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
  dev.off()
}