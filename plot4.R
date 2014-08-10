
getdt <- function(x, y){
  newDateTimeVec <- vector("numeric")
  class(newDateTimeVec) = "POSIXct"
  for(index in seq_along(x)){
    cdt <- paste(x[index], y[index], sep=" ")
    newDateTimeVec <- c(newDateTimeVec,
                        as.POSIXct(strptime(cdt, format="%d/%m/%Y %H:%M:%S")))
  }
  newDateTimeVec
}


row1 <- read.table("household_power_consumption.txt",
                   sep=";",na.strings="?", nrows=1, header=TRUE)
subtable <- read.table("household_power_consumption.txt", sep=";",
                       na.strings="?", skip=66637, nrows=2880, col.names=names(row1),
                       colClasses=c("character", "character", "numeric", "numeric",
                                    "numeric", "numeric", "numeric", "numeric", "numeric"))

newdtcol <- getdt(subtable[,1], subtable[,2])
subtable <- cbind(subtable, DateTime = newdtcol)

par(mfrow = c(2, 2))

with(subtable, {
  plot(DateTime, Global_active_power, xlab="", ylab="Global Active Power", type="l", col="black")
  
  plot(DateTime, Voltage, xlab="datetime", ylab="Voltage", type="l", col="black")
 
  plot(DateTime, Sub_metering_1, xlab="", ylab="Energy sub metering", type="l", col="black")
  lines(DateTime, Sub_metering_2, col="red")
  lines(DateTime, Sub_metering_3, col="blue")
  legend("topright", col = c("Black", "Red", "Blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, bty ="n")
  
  plot(DateTime, Global_reactive_power, xlab="datetime", ylab="Global_reactive_power",
       type="l", col="black")
})

dev.copy(png, file="plot4.png", width = 480, height = 480)
dev.off()
dev.off()

