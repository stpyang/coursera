NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")

## Of the four types of sources indicated by the type (point, nonpoint, onroad,
## nonroad) variable, which of these four sources have seen decreases in
## emissions from 1999–2008 for Baltimore City? Which have seen increases in
## emissions from 1999–2008? Use the ggplot2 plotting system to make a plot
## answer this question.

## Restrict to Baltimore City
baltimoreCity <- NEI[NEI$fips == "24510",]

## Sum by year and type
library(plyr)
df <- ddply(.data=data.frame(baltimoreCity$Emissions),
            .variables=.(baltimoreCity$year, baltimoreCity$type), colwise(sum))
names(df) <- c("year", "type", "emissions")
df$type<-factor(df$type)

## Plot and save
library(ggplot2)
ggplot(df, aes(x=year, y=emissions, color=type)) +
    geom_line() +
    geom_point() +
    ggtitle("PM2.5 emissions in Baltimore City by type of source") +
    xlab("Year") +
    ylab("Emissions (tons)") +
    scale_x_continuous(breaks=seq(1999,2008,3))
ggsave(filename="plot3.png", width=8, height=8)