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

## Plot a timeseries of Global Active Power and save it to a file
gap <- as.numeric(dt$Global_active_power)
png(filename="plot2.png", width=502, height=502, bg="transparent")
plot(datetime, gap, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
