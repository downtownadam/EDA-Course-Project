library(ggplot2)
library(dplyr)

options(scipen=5)

sourceRDS<-readRDS(file="C:/Users/mila_/Documents/Coursera/Source_Classification_Code.rds")
summaryRDS<-readRDS(file="C:/Users/mila_/Documents/Coursera/summarySCC_PM25.rds")

summaryRDS$Pollutant<-as.factor(summaryRDS$Pollutant)
summaryRDS$type<-as.factor(summaryRDS$type)
summaryRDS$year<-as.factor(summaryRDS$year)
totals <- summaryRDS %>% filter(fips=="24510") %>% group_by(type,year) %>% summarize(Total_Emissions=sum(Emissions))

png(filename="plot3.png",width=640, height=480)
fancygraph <- ggplot(totals,aes(year,Total_Emissions,fill=type)) +
    facet_grid(.~type,scales="free", space="free") + geom_bar(stat="identity") + 
    theme_dark() + ylim(0,2500) + theme(legend.position="none") + labs(x="Year",y="Total Emissions in Tons",title="Baltimore City, Maryland\nTotal Emissions in Tons by Type of Source")
print(fancygraph)
dev.off()