## A QUICK NOTE TO MY PEERS
##
## There are a number of "better" solutions for reading in this large file found
## in this online discussion:
##
##    https://class.coursera.org/exdata-002/forum/thread?thread_id=19
##
## Peter Huber's solution is popular and uses very little memory, but I chose
## not to use it because I find it to be overkill for this assignment.  I also
## chose not to skip a fixed amount of rows because I do not assume that the
## date column is in chronological order.  If you don't know what I'm talking
## about then ignore me. For me, the fastest and simplest solution was to read
## in the entire file using fread and go from there.
##
## When I am grading your homework, I don't care how you read the file or what
## your coding style is.  As long as the picture is made I what I give full
## points.

library(data.table)
myColClasses = rep("characters", 9)
dt <- fread("gunzip -c household_power_consumption.txt.gz",
            sep=";",
            na.strings="?",
            colClasses=myColClasses, ## just read the file, I'll coerce later
            verbose=FALSE)
dt$Date <- as.Date(dt$Date, format="%d/%m/%Y")
dt <- dt[dt$Date==as.Date("2007-02-01")|dt$Date==as.Date("2007-02-02"),]

## Create a timestamp from the Date and Time columns
dateStr <- paste(dt$Date, dt$Time)
datetime <- strptime(dateStr, format="%Y-%m-%d %H:%M:%S")

## Plot a timeseries of different submetering readings and save it to a file
sm1 <- as.numeric(dt$Sub_metering_1)
sm2 <- as.numeric(dt$Sub_metering_2)
sm3 <- as.numeric(dt$Sub_metering_3)
png(filename="plot3.png", width=500, height=500, bg="transparent")
plot(datetime,   sm1, type="l", col="black", xlab="", ylab="Energy sub metering")
points(datetime, sm2, type="l", col="red")
points(datetime, sm3, type="l", col="blue")
legend("topright",
       lwd=c(1, 1, 1),
       col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       border=c(1,4,1,1))
dev.off()
