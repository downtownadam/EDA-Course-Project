library(ggplot2)
library(dplyr)

options(scipen=5)

sourceRDS<-readRDS(file="C:/Users/mila_/Documents/Coursera/Source_Classification_Code.rds")
summaryRDS<-readRDS(file="C:/Users/mila_/Documents/Coursera/summarySCC_PM25.rds")

summaryRDS$Pollutant<-as.factor(summaryRDS$Pollutant)
summaryRDS$type<-as.factor(summaryRDS$type)
summaryRDS$year<-as.factor(summaryRDS$year)

coal_codes <- sourceRDS[grepl(pattern="coal",sourceRDS$EI.Sector,ignore.case = T),]


totals <- summaryRDS %>% filter(SCC %in% coal_codes$SCC) %>% group_by(year) %>% summarize(Total_Emissions=sum(Emissions))

modelL <- lm(totals$Total_Emissions~as.numeric(totals$year))
totals$trend <- modelL$fitted.values

png(filename="plot4.png",width=480, height=480)
bars <- barplot(totals$Total_Emissions/1000,names.arg=totals$year,main="Coal Related Emissions in Thousands of Tons\nwith Trendline",ylim=c(0,610))
points(x=bars,y=totals$trend/1000,type="b")
dev.off()