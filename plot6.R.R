## Plot 6
## Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California.

#Read the PM2.5 dataset and the source classification code dataset into R
nei<-readRDS("summarySCC_PM25.rds")
scc<-readRDS("Source_Classification_Code.rds")
#select obsrevation rows corresponding to motor vehicle sources using the "Onroad" data category
scc$SCC[scc$Data.Category=="Onroad"]->motorcode1
#subset the PM2.5 emissions dataset based on classifcation code corresponding to motor vehicle sources.
subset(nei, SCC %in% motorcode1)->motor
#load dplyr package
library(dplyr)
by_yearfips<-group_by(motor,fips,year)
#using dplyr's summarize function, sum emissions by both fips(county) and by year
emissions_by_yearfips=summarize(by_yearfips, sum(Emissions))
names(emissions_by_yearfips)<-c("fips","year", "emissions")
#filter out the total emissions by year based on county code for Baltimore City and Los Angeles County, California
subset(emissions_by_yearfips, fips=="24510")->baltimore
subset(emissions_by_yearfips,fips=="06037")->lacounty
#append the rows for both Baltimore City and Los Angeles County
compare<-rbind(baltimore,lacounty)
# provide a description by converting the fips code to the county name under the fips variable
compare$fips[compare$fips=="24510"]<-"Baltimore City"
compare$fips[compare$fips=="06037"]<-"Los Angeles County"
compare<-rename(compare, county=fips)
library(ggplot2)
#open a connection to the png graphics device
png("plot6.png", width=800, height=600)
par(mfrow=c(1,1))
compare$year<-as.character(compare$year)
#using the ggplot2 plotting system, plot two separate barplots, one for each county, which shows the amount of PM2.5 emissions by year
g<-ggplot(data=compare, aes(year,emissions,fill=county))
g<-g+geom_bar(stat="identity")+xlab("Year")+ylab("Total PM2.5 Emissions")
g<-g+ ggtitle("Motor Vehicle PM2.5 Emissions in Baltimore City and LA County by Year")+facet_grid(.~county)
print(g)
#close off connection to png graphics device
dev.off()
