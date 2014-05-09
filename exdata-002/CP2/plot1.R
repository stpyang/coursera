NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")

## Have total emissions from PM2.5 decreased in the United States from 1999 to
## 2008? Using the base plotting system, make a plot showing the total PM2.5
## emission from all sources for each of the years 1999, 2002, 2005, and 2008.

## Sum by year
library(plyr)
df <- ddply(.data=data.frame(NEI$Emissions), .variables=.(NEI$year), colwise(sum))
names(df) <- c("year", "emissions")

## Plot and save
plot(df$year, df$emissions, type="b",
     main="Total PM2.5 emissions in the United States",
     xlab="Year",
     ylab="Total emissions (tons)")
dev.copy(png, file="plot1.png")
dev.off()
