NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Across the United States, how have emissions from coal combustion-related
## sources changed from 1999–2008?

# convert scc levels to lower case so that I have not matching issues on case
sl1 <- tolower(SCC$SCC.Level.One)
sl3 <- tolower(SCC$SCC.Level.Three)

## An emission is coal-related if its SCC.Level.Three contains the token "coal"
## An emission is combustion-related if its SCC.Level.One contains the token "coal"
## An emission is coal combustion-related if it is coal-related and combustion-related
coalCombustion <- SCC[grepl("combustion", sl1)&grepl("coal", sl3),]

## Merge with NEI and sum by year
library(plyr)
df <- merge(NEI, coalCombustion)
df <- ddply(.data=data.frame(df$Emissions),
            .variables=.(df$year), colwise(sum))
names(df) <- c("year", "emissions")

## Plot and save
library(ggplot2)
ggplot(df, aes(x=year, y=emissions)) +
    geom_line() +
    geom_point() +
    ggtitle("PM2.5 emissions in the United States from coal combustion-related sources") +
    xlab("Year") +
    ylab("Emissions (tons)")
ggsave(filename="plot4.png", width=8, height=8)