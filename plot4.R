plot4 <- function() {
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
  
  png(file="plot4.png", width=480, height=480)
  par(mfcol=c(2,2), mar=c(4,4,2,1), oma=c(0,0,0,0))
  # Top-left
  plot(subepc$Global_active_power, xaxt="n", xlab="", ylab="Global Active Power", type="l")
  axis(1, at=c(1,length(subepc$Global_active_power)/2,length(subepc$Global_active_power)), labels=c("Thu","Fri","Sat"))
  
  # Bottom-left
  plot(subepc$Sub_metering_1, xaxt="n", xlab="", ylab="Energy sub metering", type="n")
  lines(subepc$Sub_metering_1, col="black")
  lines(subepc$Sub_metering_2, col="orange")
  lines(subepc$Sub_metering_3, col="blue")
  axis(1, at=c(1,length(subepc$Global_active_power)/2,length(subepc$Global_active_power)), labels=c("Thu","Fri","Sat"))
  legend("topright", bty="n", lty=1, col=c("black", "orange", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))  

  # Top-right
  plot(subepc$Voltage, xaxt="n", xlab="datetime", ylab="Voltage", type="l")
  axis(1, at=c(1,length(subepc$Global_active_power)/2,length(subepc$Global_active_power)), labels=c("Thu","Fri","Sat"))
  
  # Bottom-right
  plot(subepc$Global_reactive_power,  xaxt="n", xlab="datetime", ylab="Global_reactive_power", type="l")
  axis(1, at=c(1,length(subepc$Global_active_power)/2,length(subepc$Global_active_power)), labels=c("Thu","Fri","Sat"))

  dev.off()
}