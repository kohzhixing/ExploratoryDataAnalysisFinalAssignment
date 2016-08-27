## Plot 5 
## How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

#Read the PM2.5 dataset and the source classification code dataset into R
nei<-readRDS("summarySCC_PM25.rds")
scc<-readRDS("Source_Classification_Code.rds")
# use the "Onroad" category to select rows corresponding to motor vehice sources
scc$SCC[scc$Data.Category=="Onroad"]->motorcode1
# use the fips variable to filter out rows corresponding to motor vehicle sources in Baltimore City
subset(nei, SCC %in% motorcode1 & fips=="24510")->motorcode2
# using the aggregate function, sum emissions by year for Baltimore city
aggregatedbyyearbaltimore<-aggregate(Emissions~year,data=motorcode2,sum)
# open a connection to png graphics device
png("plot5.png", width=600, height=600)
par(mfrow=c(1,1))
# plot a scatter plot and connect the dots using line through the base plotting system
plot(aggregatedbyyearbaltimore$year,aggregatedbyyearbaltimore$Emissions, ylab="Emissions in Tons", xlab="Year", main="Motor Vehicle PM2.5 Emissions in Baltimore City, Maryland, United States by Year", ylim=c(0,400),pch=20)
lines(aggregatedbyyearbaltimore$year,aggregatedbyyearbaltimore$Emissions, col="red")
# close off connection to png graphics device.
dev.off()

