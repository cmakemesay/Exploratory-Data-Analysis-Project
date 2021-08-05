#To run this code, you must have dplyr and ggplot2 installed

#Load the files
NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

#Creating table with total values from 1999,2002,2005 and 2008 from Baltimore
#Group the values according to type and year
library(dplyr)
NEI <- NEI[NEI$fips=='24510',]
table <- NEI %>%
  group_by(type,year) %>%
  summarize(sum(Emissions))
names(table) <- c('type','year','emissions')

#Plotting graph
library(ggplot2)
png('plot3.png')
d <- ggplot(table,aes(year,emissions,color=type))
plot <- d + geom_point() + labs(x='Year',y='Emissions (tons)',
                        title='Emissions in Baltimore by Type') + geom_line()
print(plot)
dev.off()