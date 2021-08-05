#Load the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Creating table with total values from 1999,2002,2005 and 2008 for motor
#vehicle related sources
#Comparing to the EI.Sector column using the SCC code
sector <- data.frame(SCC = SCC$SCC,sector=SCC$EI.Sector)
motor <- sector[grep('[Vv]ehicle',sector$sector),]

#Filter by columns that contain the word coal
NEI <- subset(NEI,NEI$SCC %in% motor$SCC)

#Filter by Baltimore
NEI <- subset(NEI,NEI$fips == '24510')

#Summarizing by year
total <- tapply(NEI$Emissions,NEI$year,sum)
years <- names(total)
table <- data.frame(years = years, total = total)

#Plotting graph
png('plot5.png')
plot(table$years,table$total,type='l', main='Total Motor Vehicle Related PM2.5 
     Emissions by Year in Baltimore', xlab='Year',ylab='Total Emissions (tons)')
dev.off()


