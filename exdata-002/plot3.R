data <- read.csv(file="household_power_consumption.txt.gz",
                 sep=";",
                 na.strings="?",
                 colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

data <- data[data$Date=="1/2/2007"|data$Date=="2/2/2007",]
dateStr <- paste(data$Date, data$Time)
datetime <- strptime(dateStr, format="%d/%m/%Y %H:%M:%S")

plot(datetime,   data$Sub_metering_1, type="l", col="black", ylab="Energy sub metering")
points(datetime, data$Sub_metering_2, type="l", col="red")
points(datetime, data$Sub_metering_3, type="l", col="blue")
legend("topright", 
       lwd=c(1, 1, 1),
       col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       border=c(1,4,1,1))
dev.copy(png, file="plot3.png")
dev.off()
