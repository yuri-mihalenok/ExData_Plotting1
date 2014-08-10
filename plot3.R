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
with(subtable, {
  plot(DateTime, Sub_metering_1, xlab="", ylab="Energy sub metering", type="l", col="black")
  lines(DateTime, Sub_metering_2, col="red")
  lines(DateTime, Sub_metering_3, col="blue")
  legend("topright",  lty=c(1,1,1), lwd=2, , col=c("black", "red", "blue"),legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})
dev.copy(png, file="plot3.png", width = 480, height = 480)
dev.off()
dev.off()

