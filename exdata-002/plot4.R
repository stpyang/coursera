data <- read.csv(file="household_power_consumption.txt.gz",
                 sep=";",
                 na.strings="?",
                 colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

data <- data[data$Date=="1/2/2007"|data$Date=="2/2/2007",]
dateStr <- paste(data$Date, data$Time)
data$datetime <- strptime(dateStr, format="%d/%m/%Y %H:%M:%S")

par(mfrow=c(2, 2))
with(data, {
    plot(datetime, gas, type="l", xlab="", ylab="Global Active Power")
    
    plot(datetime, Voltage, type="l")
    
    plot(datetime,   Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
    points(datetime, Sub_metering_2, type="l", col="Red")
    points(datetime, Sub_metering_3, type="l", col="blue")
    
    plot(datetime, Global_reactive_power, type="l")
})
dev.copy(png, file="plot4.png")
dev.off()