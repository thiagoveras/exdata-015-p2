# Question 4:
# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?
plot4 <- function() 
{ 

# Using ggplot2 library
library(ggplot2)    

# Read data files 
message("Reading NEI Data")    
NEI <- readRDS("nei-data/summarySCC_PM25.rds")
message("Reading SCC Data")
SCC <- readRDS("nei-data/Source_Classification_Code.rds")

# Finding coal combustion-related sources
is.combustion.coal <- grepl("Fuel Comb.*Coal", SCC$EI.Sector)
combustion.coal.sources <- SCC[is.combustion.coal,]

# Finding emissions from coal combustion-related sources
emissions <- NEI[(NEI$SCC %in% combustion.coal.sources$SCC), ]

# Aggregating the emissions by year to analize the data and answer the question
emissions.by.year <- aggregate(Emissions ~ year, data=emissions, FUN=sum)

# Ploting the graph and saving the PNG file (plot4.png)
message("Ploting the graph")
ggplot(emissions.by.year, aes(x=factor(year), y=Emissions)) +
    geom_bar(stat="identity") +
    xlab("year") +
    ylab(expression("total PM"[2.5]*" emissions")) +
    ggtitle("Emissions from coal combustion-related sources")

message("Saving the PNG file (plot4.png)")
ggsave(filename="plot4.png", width=6, height=5)

}