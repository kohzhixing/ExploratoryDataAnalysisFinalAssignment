
## Plot4
## Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

#Read the PM2.5 dataset and the source classification code dataset into R
nei<-readRDS("summarySCC_PM25.rds")
scc<-readRDS("Source_Classification_Code.rds")

#select rows with the whole words "coal " and "comb" (both uppercase and lowercase) in the source classification code dataset "Short.Name" variable
coalsource<-intersect(grep("\\bcoal\\b",tolower(scc$Short.Name)),grep("\\bcomb\\b",tolower(scc$Short.Name)))
scc$SCC<-as.character(scc$SCC)
# select source classification code corresponding to coal combustion-related sources 
coalcode<-scc$SCC[coalsource]
# subset the PM2.5 emissions dataset by source classifcation code corresponding to coal combustion-related sources
coal_data<-subset(nei, SCC %in% coalcode)
# using the tapply function, sum emissions by year for coal combustion-related sources
coal_data_year<-with(coal_data,tapply(Emissions,year,sum,na.rm=TRUE))
#open a connection to the png graphics device
png("plot4.png", width=600, height=600)
par(mfrow=c(1,1))
year<-unique(nei$year)
#using the base plotting system, plot a scatter plot with lines connecting the plots
plot(year,coal_data_year, xlab="Year",ylab="PM2.5 Emission Levels", main="Emissions from Coal Combustion-Related Sources in the United States")
lines(year, coal_data_year, type="l", col="red")
#close off connection to the png graphics device.
dev.off()