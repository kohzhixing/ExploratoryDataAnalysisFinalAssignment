## Plot 1
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
##Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.


#Read the PM2.5 dataset and the source classification code dataset into R
nei<-readRDS("summarySCC_PM25.rds")
scc<-readRDS("Source_Classification_Code.rds")

#using the tapply function to sum total PM2.5 emissions by year
pm_by_year<-with(nei, tapply(Emissions,year,sum,na.rm=TRUE))

#open a connection to the png graphics device
png("plot1.png", width=600, height=600)
par(mfrow=c(1,1))
year<-unique(nei$year)
#plot a barplot with year on the x-axis and the sum of total PM2.5 emissions on the y-axis
barplot(height=pm_by_year, names.arg=year, xlab="years", ylab="Total PM2.5 Emissions in Tons",main="PM2.5 Emissions in the United States",ylim=c(0,8000000))
#close off the connection to the png graphics device.
dev.off()


