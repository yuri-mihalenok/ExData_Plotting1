cstod <- function(x){
  newDateVec <- vector("numeric")
  class(newDateVec) = "Date"
  for(britdate in x){
    newDateVec <- c(newDateVec, as.Date(britdate, "%d/%m/%Y"))
  }
  newDateVec
}
 

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
with(subtable, plot(DateTime, Global_active_power, xlab="",
                    ylab="Global active power (kilowatts)", type="l"))
dev.copy(png, file="plot2.png", width = 480, height = 480)
dev.off()s
dev.off()

