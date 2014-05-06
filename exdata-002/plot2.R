data <- read.csv(file="household_power_consumption.txt.tz",
                 sep=";",
                 na.strings="?",
                 colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

data <- data[data$Date=="1/2/2007"|data$Date=="2/2/2007",]
dateStr <- paste(data$Date, data$Time)
dateTime <- strptime(dateStr, format="%d/%m/%Y %H:%M:%S")
gas <- data$Global_active_power

plot(dateTime, gas, type="l", xlab="", ylab="Global Active Power(kilowatts)")
dev.copy(png, file="plot2.png")
dev.off()
