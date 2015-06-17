# Question 1:
# Have total emissions from PM2.5 decreased in the United States 
# from 1999 to 2008?
plot1 <- function() 
{ 

# Read data files 
message("Reading NEI Data")    
NEI <- readRDS("nei-data/summarySCC_PM25.rds")
message("Reading SCC Data")
SCC <- readRDS("nei-data/Source_Classification_Code.rds")

# Aggregating the emissions by year to analize the data and answer the question
total.emissions <- aggregate(Emissions ~ year, NEI, sum)

# Ploting the graph
message("Ploting the graph")
barplot(height=total.emissions$Emissions, names.arg=total.emissions$year,
        xlab="years", ylab=expression('total PM'[2]*' emission'),
        main=expression('Total PM'[2]*' emissions at various years'))

## Saving it to a PNG file
message("Saving the PNG file (plot1.png)")
dev.copy(png, file="plot1.png", height=480, width=640)
dev.off()

}