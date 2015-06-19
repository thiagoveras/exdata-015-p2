# Question 3:
# Of the four types of sources indicated by the type (point, nonpoint, onroad, 
# nonroad) variable, which of these four sources have seen decreases in emissions 
# from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008?
plot3 <- function() 
{ 

# Using ggplot2 library
library(ggplot2)    

# Read data files 
message("Reading NEI Data")    
NEI <- readRDS("nei-data/summarySCC_PM25.rds")
message("Reading SCC Data")
SCC <- readRDS("nei-data/Source_Classification_Code.rds")

# Filtering the data to Baltimore City, Maryland (fips == "24510")
baltimore.emissions <- NEI[NEI$fips=="24510",]
# Aggregating the emissions by year to analize the data and answer the question
baltimore.emissions.aggr <- aggregate(Emissions ~ year + type,
                                  data=baltimore.emissions,
                                  FUN=sum)

# Ploting the graph
# Ploting the graph and saving the PNG file (plot3.png)
message("Ploting the graph")
ggplot(baltimore.emissions.aggr, aes(x=factor(year), y=Emissions, fill=type)) +
    geom_bar(stat="identity") +
    facet_grid(. ~ type) +
    xlab("year") +
    ylab(expression("total PM"[2.5]*" emission")) +
    ggtitle(expression("PM"[2.5]*paste(" emissions in Baltimore ",
                                       "City by various source types", sep="")))

message("Saving the PNG file (plot3.png)")
ggsave(filename="plot3.png", width=9, height=5)

}