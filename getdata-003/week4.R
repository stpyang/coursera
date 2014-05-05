download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",
              destfile="week4a.csv",
              method="curl")
data <- read.csv(file="week4a.csv")
print(strsplit(names(data),"wgtp")[123])

download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",
              destfile="week4b.csv",
              method="curl")
data <- read.csv(file="week4b.csv",skip=4)[1:190,]
gdp <- gsub(pattern = ",",
            replacement = "",
            x = data$X.4)
gdp <- gsub(pattern = " ",
            replacement = "",
            x = gdp)
gdp <- strtoi(gdp)
print(mean(gdp))

countryNames <- data$X.3
print(grep("^United", countryNames, value=TRUE))

download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",
              destfile="week4c.csv",
              method="curl")
download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",
              destfile="week4d.csv",
              method="curl")

gdp <- read.csv(file="week4c.csv", skip=4)[1:190,]
edu <- read.csv(file="week4d.csv")

data <- merge(x=gdp, y=edu, by.x="X", by.y="CountryCode")

fiscals <- grep("Fiscal year end",data$Special.Notes, value = TRUE)
print(length(grep("June", fiscals)))

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
samples <- grep("2012", sampleTimes, value=TRUE)
print(length(samples))
print(length(grep("Monday",weekdays(as.Date(samples)))))
