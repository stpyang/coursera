download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",
              destfile="week1.csv",
              method="curl")
data <- read.csv("week1.csv")
print(sum(data$VAL[!is.na(data$VAL)] >= 24))

library(xlsx)
download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx ",
              destfile="week1.xlsx",
              method="curl")
dat <- read.xlsx(file="week1.xlsx",
                  sheetIndex=1,
                  rowIndex=18:23,
                  colIndex=7:15)
print(sum(dat$Zip*dat$Ext,na.rm=T))

library(XML)
download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml",
              destfile="week1.xml",
              method="curl")
doc <- xmlTreeParse("week1.xml", useInternal=TRUE)
rootNode <- xmlRoot(doc)
print(sum(xpathSApply(rootNode, "//zipcode", xmlValue) == "21231"))

library(data.table)
download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",
              destfile="week1b.csv",
              method="curl")
DT <- fread("week1b.csv")
print(DT[,mean(pwgtp15),by=SEX])