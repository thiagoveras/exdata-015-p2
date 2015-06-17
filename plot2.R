# Question 2:
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
# from 1999 to 2008?
plot2 <- function() 
{ 

# Read data files 
message("Reading NEI Data")    
NEI <- readRDS("nei-data/summarySCC_PM25.rds")
message("Reading SCC Data")
SCC <- readRDS("nei-data/Source_Classification_Code.rds")

# Filtering the data to Baltimore City, Maryland (fips == "24510")
baltimore.emissions <- NEI[NEI$fips=="24510",]
# Aggregating the emissions by year to analize the data and answer the question
baltimore.emissions.by.year <- aggregate(Emissions ~ year, baltimore.emissions, sum)

# Ploting the graph
message("Ploting the graph")
barplot(height=baltimore.emissions.by.year$Emissions, names.arg=baltimore.emissions.by.year$year,
        xlab="years", ylab=expression('total PM'[2]*' emissions'),
        main=expression('Total PM'[2]*' emissions in Baltimore City, '*
                            'Maryland at various years'))

## Saving it to a PNG file
message("Saving the PNG file (plot2.png)")
dev.copy(png, file="plot2.png")
dev.off()

}