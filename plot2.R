library(ggplot2)
library(dplyr)

options(scipen=5)

sourceRDS<-readRDS(file="C:/Users/mila_/Documents/Coursera/Source_Classification_Code.rds")
summaryRDS<-readRDS(file="C:/Users/mila_/Documents/Coursera/summarySCC_PM25.rds")

summaryRDS$Pollutant<-as.factor(summaryRDS$Pollutant)
summaryRDS$type<-as.factor(summaryRDS$type)

totals <- summaryRDS %>% filter(fips=="24510") %>% group_by(year) %>% summarize(Total_Emissions=sum(Emissions))

modelL <- lm(totals$Total_Emissions~totals$year)
totals$trend <- modelL$fitted.values

png(filename="plot2.png",width=480, height=480)
bars <- barplot(totals$Total_Emissions/1000,names.arg=totals$year,main="Baltimore City, Maryland\nThousands of Tons Emitted with Trendline",ylim=c(0,3.5))
points(x=bars,y=totals$trend/1000,type="b")
dev.off()