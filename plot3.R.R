## Plot 3
## Of the four types of sources (point, nonpoint, onroad, nonroad), which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases in emissions from 1999-2008?
## Use the ggplot2 plotting system to make a plot answer this question.

#Read the PM2.5 dataset and the source classification code dataset into R
nei<-readRDS("summarySCC_PM25.rds")
scc<-readRDS("Source_Classification_Code.rds")

#open a connection to the png graphics device
png("plot3.png", width=600, height=600)
par(mfrow=c(1,4))
#filter out rows that are relevant to Baltimore City
baltimore<-subset(nei, fips=="24510")
#load the dplyr package for data manipulation
library(dplyr)
by_typeyear<-group_by(baltimore, type, year)
#sum emissions by type and by year using summarize function in the dplyr package
emissions_baltimore_typeyear<-summarize(by_typeyear, sum(Emissions))
names(emissions_baltimore_typeyear)<-c("Type","Year", "Total.Emissions")

#load and plot line graph using the ggplot2 plotting system
library(ggplot2)
g<-ggplot(data=emissions_baltimore_typeyear, aes(Year,Total.Emissions,color=Type))
g<-g+geom_line()+xlab("Year")+ylab("Total PM2.5 Emissions") + ggtitle("Total Emissions in Baltimore City, Maryland by Source Type")
print(g)
#close off connection to the png graphics device
dev.off()