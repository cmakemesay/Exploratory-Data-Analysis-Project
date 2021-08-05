#Load the files
NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

#Creating table with total values from 1999,2002,2005 and 2008
total <- tapply(NEI$Emissions,NEI$year,sum)
years <- names(total)
table <- data.frame(years = years, total = total)

#Plotting graph
png('plot1.png')
plot(table$years,table$total,type='l', main='Total PM2.5 Emissions by Year in the
     USA', xlab='Year',ylab='Total Emissions (tons)')
dev.off()