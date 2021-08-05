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

#Filter by Los Angeles and Baltimore
LA <- subset(NEI,NEI$fips == '06037')
BMORE <- subset(NEI,NEI$fips == '24510')

#Summarizing by year
totalLA <- tapply(LA$Emissions,LA$year,sum)
yearsLA <- names(totalLA)
tableLA <- data.frame(years = yearsLA, total = totalLA)
totalBMORE <- tapply(BMORE$Emissions,BMORE$year,sum)
yearsBMORE <- names(totalBMORE)
tableBMORE <- data.frame(years = yearsBMORE, total = totalBMORE)


#Plotting graph
png('plot6.png')
par(mfrow=c(1,2),mar=c(4,4,4,1),cex.main=0.8)
plot(tableBMORE$years,tableBMORE$total,type='l', main='Total Motor Vehicle Related PM2.5 
     Emissions by Year in Baltimore', xlab='Year',ylab='Total Emissions (tons)',
     ylim = c(0,max(tableBMORE$total)*1.05))
plot(tableLA$years,tableLA$total,type='l', main='Total Motor Vehicle Related PM2.5 
     Emissions by Year in Los Angeles', xlab='Year',ylab='Total Emissions (tons)',
     ylim = c(0,max(tableLA$total)*1.05))
dev.off()


