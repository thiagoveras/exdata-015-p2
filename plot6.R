# Question 6:
# Compare emissions from motor vehicle sources in Baltimore City 
# with emissions from motor vehicle sources in Los Angeles County, 
# California (fips == "06037"). Which city has seen greater changes 
# over time in motor vehicle emissions?
plot6 <- function() 
{ 

# Using ggplot2 library
library(ggplot2)    

# Read data files 
message("Reading NEI Data")    
NEI <- readRDS("nei-data/summarySCC_PM25.rds")
message("Reading SCC Data")
SCC <- readRDS("nei-data/Source_Classification_Code.rds")

# Normalizing...
normalize <- function(x) {(x-min(x)) / (max(x)-min(x))}

# Filtering the data by Baltimore City and Motor Vehicles
baltimore.emissions <- NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]
baltimore.emissions.aggr <- aggregate(Emissions ~ year, data=baltimore.emissions, FUN=sum)

# Filtering the data by Los Angeles and Motor Vehicles
la.emissions <- NEI[(NEI$fips=="06037") & (NEI$type=="ON-ROAD"),]
la.emissions.aggr <- aggregate(Emissions ~ year, data=la.emissions, FUN=sum)


# Creating a new dataset with both filtered data (Baltimore and Los Angeles)
baltimore.emissions.aggr$County <- "Baltimore City, MD"
la.emissions.aggr$County <- "Los Angeles County, CA"
both.emissions <- rbind(baltimore.emissions.aggr, la.emissions.aggr)

# Ploting the graph
message("Ploting the graph")
ggplot(both.emissions, aes(x=factor(year), y=Emissions, fill=County)) +
    geom_bar(stat="identity") + 
    facet_grid(County  ~ ., scales="free") +
    ylab("total emissions (tons)") + 
    xlab("year") +
    ggtitle(expression("Motor vehicle emission variation\nin Baltimore and Los Angeles"))

message("Saving the PNG file (plot6.png)")
ggsave(filename="plot6.png", width=7, height=5)

}
