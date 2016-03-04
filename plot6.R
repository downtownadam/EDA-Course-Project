library(ggplot2)
library(dplyr)

options(scipen=5)

sourceRDS<-readRDS(file="C:/Users/mila_/Documents/Coursera/Source_Classification_Code.rds")
summaryRDS<-readRDS(file="C:/Users/mila_/Documents/Coursera/summarySCC_PM25.rds")

summaryRDS$Pollutant<-as.factor(summaryRDS$Pollutant)
summaryRDS$type<-as.factor(summaryRDS$type)
summaryRDS$year<-as.factor(summaryRDS$year)

veh_codes <- sourceRDS[grepl(pattern="vehicle",sourceRDS$SCC.Level.Two,ignore.case = T),]
totals <- summaryRDS %>% filter(SCC %in% veh_codes$SCC,fips %in% c("24510","06037")) %>% group_by(fips,year) %>% summarize(Total_Emissions=sum(Emissions))
totals$location <- ifelse(totals$fips=="24510","Baltimore City, MD","Los Angeles County, CA")

png(filename="plot6.png",width=480, height=480)
fancygraph <- ggplot(totals,aes(year,Total_Emissions,fill=location)) +
  facet_grid(.~location,scales="free", space="free") + geom_bar(stat="identity") + 
  theme_dark() + theme(legend.position="none") + labs(x="Year",y="Total Emissions in Tons",title="Comparison of Baltimore City, Maryland and\n Los Angeles County, California")
print(fancygraph)
dev.off()