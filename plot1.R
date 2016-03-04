library(ggplot2)
library(dplyr)

options(scipen=5)

sourceRDS<-readRDS(file="C:/Users/mila_/Documents/Coursera/Source_Classification_Code.rds")
summaryRDS<-readRDS(file="C:/Users/mila_/Documents/Coursera/summarySCC_PM25.rds")
summaryRDS$Pollutant<-as.factor(summaryRDS$Pollutant)
summaryRDS$type<-as.factor(summaryRDS$type)

totals <- summaryRDS %>% group_by(year) %>% summarize(Total_Emissions=sum(Emissions))


png(filename="plot1.png",width=480, height=480)
barplot(totals$Total_Emissions/1000,names.arg=totals$year,main="Thousands of Tons Emitted")
dev.off()
