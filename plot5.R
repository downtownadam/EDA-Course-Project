library(ggplot2)
library(dplyr)

options(scipen=5)

sourceRDS<-readRDS(file="C:/Users/mila_/Documents/Coursera/Source_Classification_Code.rds")
summaryRDS<-readRDS(file="C:/Users/mila_/Documents/Coursera/summarySCC_PM25.rds")

summaryRDS$Pollutant<-as.factor(summaryRDS$Pollutant)
summaryRDS$type<-as.factor(summaryRDS$type)
summaryRDS$year<-as.factor(summaryRDS$year)

veh_codes <- sourceRDS[grepl(pattern="vehicle",sourceRDS$SCC.Level.Two,ignore.case = T),]


totals <- summaryRDS %>% filter(SCC %in% veh_codes$SCC,fips=="24510") %>% group_by(year) %>% summarize(Total_Emissions=sum(Emissions))

modelL <- lm(totals$Total_Emissions~as.numeric(totals$year))
totals$trend <- modelL$fitted.values

png(filename="plot5.png",width=480, height=480)
bars <- barplot(totals$Total_Emissions,names.arg=totals$year,main="Baltimore City, Marylyand\nVehicle Related Emissions with Trendline",ylab="PM25 Emissions in Tons")
points(x=bars,y=totals$trend,type="b")
dev.off()