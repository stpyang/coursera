NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Compare emissions from motor vehicle sources in Baltimore City with emissions
## from motor vehicle sources in Los Angeles County, California (fips ==
## "06037"). Which city has seen greater changes over time in motor vehicle
## emissions?

## Restrict to Baltimore City or Los Angeles
myCounties <- NEI[NEI$fips == "24510"|NEI$fips == "06037",]

## convert scc levels to lower case so that I have not matching issues on case
sl2 <- tolower(SCC$SCC.Level.Two)

## An emission is motor vehicle related if its SCC.Level.Two contains the token "vehicle"
motorVehicle <- SCC[grepl("vehicle", sl2),]

## Merge with myCounties and sum by year
library(plyr)
df <- merge(myCounties, motorVehicle)
df <- ddply(.data=data.frame(df$Emissions),
            .variables=.(df$year,df$fips), colwise(sum))
names(df) <- c("year", "county", "emissions")
df$county <- ifelse(df$county == 24510, "Baltimore City", "Los Angeles County")
df$county <- factor(df$county)

## Create a graph of absolute emission values
library(ggplot2)
plotAbsolute <- ggplot(df, aes(x=year, y=emissions, color=county)) +
    geom_line() +
    geom_point() +
    ggtitle("Absolute change in motor-vehicle related PM25 emissions (tons)") +
    xlab("Year") +
    ylab("Emissions (tons)")

## Create a graph of relative emissions values, relative to 1999
initialValues <- df[df$year==1999,]
initialValues$year <- NULL
names(initialValues) <- c("county", "initialEmissions")
df <- merge(df, initialValues)
df$relativeEmissions <- 100 * df$emissions / df$initialEmissions
plotRelative <- ggplot(df, aes(x=year, y=relativeEmissions, color=county)) +
    geom_line() +
    geom_point() +
    ggtitle("Percent change (from 1999) in motor-vehicle related PM25 emissions") +
    xlab("Year") +
    ylab("Percent change (from 1999) of emissions")

#Plot and save
library(gridExtra)
png(filename="plot6.png", width=1000, height=800)
grid.arrange(plotAbsolute, plotRelative, nrow = 2)
dev.off()
