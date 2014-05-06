data <- read.csv(file="household_power_consumption.txt.gz",
                 sep=";",
                 na.strings="?",
                 colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

data <- data[data$Date=="1/2/2007"|data$Date=="2/2/2007",]

hist(x = data$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power(kilowatts)",
     ylab = "Frequency"
     )
dev.copy(png, file="plot1.png")
dev.off()
