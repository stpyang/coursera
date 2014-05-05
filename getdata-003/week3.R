download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",
              destfile="week3a.csv",
              method="curl")
data <- read.csv(file="week3a.csv")
agricultureLogical <- data$ACR==3&data$AGS==6
print(which(agricultureLogical==TRUE))

library(jpeg)
download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg",
              destfile="week3.jpg",
              method="curl")
data <- readJPEG(source="week3.jpg", native=TRUE)
print(quantile(ftable(data), probs=c(0.3, 0.8)))

download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",
              destfile="week3b.csv",
              method="curl")
download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",
              destfile="week3c.csv",
              method="curl")

gdp <- read.csv(file="week3b.csv",skip=5,header=FALSE)[1:190,]
edu <- read.csv(file="week3c.csv")

gdp$grank <- strtoi(gdp$V2)
edu$ifact <- factor(edu$Income.Group)

data <- merge(x=gdp, y=edu, by.x="V1", by.y="CountryCode")
print(data[order(data$grank,decreasing=TRUE,na.last=TRUE),][13,])
# ANSWER IS 189, St. Kitts and Nevis???

print(tapply(data$grank, data$ifact, mean))

data$quintile <- cut(data$grank, breaks=quantile(data$grank, probs=seq(0, 1, length=6)))
print(table(data$quintile, data$ifact))
