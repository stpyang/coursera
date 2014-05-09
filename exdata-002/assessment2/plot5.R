NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## How have emissions from motor vehicle sources changed from 1999–2008 in
## Baltimore City?

## Restrict to Baltimore City
baltimoreCity <- NEI[NEI$fips == "24510",]

## convert scc levels to lower case so that I have not matching issues on case
sl2 <- tolower(SCC$SCC.Level.Two)

## An emission is motor vehicle related if its SCC.Level.Two contains the token "vehicle"
motorVehicle <- SCC[grepl("vehicle", sl2),]

## Merge with Baltimore City and sum by year
library(plyr)
df <- merge(baltimoreCity, motorVehicle)
df <- ddply(.data=data.frame(df$Emissions),
            .variables=.(df$year), colwise(sum))
names(df) <- c("year", "emissions")

## Plot and save
library(ggplot2)
ggplot(df, aes(x=year, y=emissions)) +
    geom_line() +
    geom_point() +
    ggtitle("PM2.5 emissions in Baltimore City from coal combustion-related sources") +
    xlab("Year") +
    ylab("Emissions (tons)")
ggsave(filename="plot5.png", width=8, height=8)

