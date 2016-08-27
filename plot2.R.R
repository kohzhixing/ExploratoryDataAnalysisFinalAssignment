## Plot 2 
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (???????? == "??????????") from 1999 to 2008? 
## Use the base plotting system to make a plot answering this question.

#Read the PM2.5 dataset and the source classification code dataset into R
nei<-readRDS("summarySCC_PM25.rds")
scc<-readRDS("Source_Classification_Code.rds")
# filter and select the PM2.5 emissions for Baltimore City
baltimore<-subset(nei, fips=="24510")
# using the tapply function, sum PM2.5 emissions by year for Baltimore City
pm_by_year_baltimore<-with(baltimore,tapply(Emissions, as.factor(year),sum,na.rm=TRUE))
#open a connection to the png graphics device.
png("plot2.png", width=600, height=600)
par(mfrow=c(1,1))
year<-unique(nei$year)
#plot years in the x-axis and the total PM2.5 emissions on the y-axis using a barplot
barplot(names.arg=year,height=pm_by_year_baltimore, xlab="Year",ylab="Total PM2.5 Emissions in Tons", main="PM2.5 Emissions in Baltimore City, Maryland, United States",ylim=c(0,3500))
#close off the connection to the png graphics device
dev.off()