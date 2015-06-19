# Question 5:
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
plot5 <- function() 
{ 

# Using ggplot2 library
library(ggplot2)    

# Read data files 
message("Reading NEI Data")    
NEI <- readRDS("nei-data/summarySCC_PM25.rds")
message("Reading SCC Data")
SCC <- readRDS("nei-data/Source_Classification_Code.rds")

# Filtering the data by Baltimore City and Motor Vehicles
baltimore.emissions <- NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]
baltimore.emissions.aggr <- aggregate(Emissions ~ year, data=baltimore.emissions, FUN=sum)

# Ploting the graph
message("Ploting the graph")
ggplot(baltimore.emissions.aggr, aes(x=factor(year), y=Emissions)) +
    geom_bar(stat="identity") +
    xlab("year") +
    ylab(expression("total PM"[2.5]*" emissions")) +
    ggtitle("Emissions from motor vehicle sources in Baltimore City")

message("Saving the PNG file (plot5.png)")
ggsave(filename="plot5.png", width=7, height=5)

}