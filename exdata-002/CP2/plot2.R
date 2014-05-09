NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")

## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
## (fips == "24510") from 1999 to 2008? Use the base plotting system to make a
## plot answering this question.

## Restrict to Baltimore City
baltimoreCity <- NEI[NEI$fips == "24510",]

# Sum by year
library(plyr)
df <- ddply(.data=data.frame(baltimoreCity$Emissions),
            .variables=.(baltimoreCity$year), colwise(sum))
names(df) <- c("year", "emissions")

# Plot and save
plot(df$year, df$emissions, type="b",
     main="Total PM2.5 emissions in Baltimore City",
     xlab="Year",
     ylab="Total emissions (tons)")

dev.copy(png, file="plot2.png")
dev.off()
