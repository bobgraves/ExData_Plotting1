# Bob Graves
# February 8, 2015

# file names for source data and plot output (PNG)
dataFileName<-"household_power_consumption.txt"
plotFileName<-"plot3.png"

# date ranges for analysis 
# endDate is exclusive, since there are HH:MM:SS in the date
beginDate<-as.POSIXlt("2007-02-01 00:00:00")
endDate<-as.POSIXlt("2007-02-03 00:00:00")
#dataFileName<-"household_test.txt"
#beginDate<-as.POSIXlt("2006-12-16 00:00:00")
#endDate<-as.POSIXlt("2006-12-22 00:00:00")

# load data 
p <-read.csv(dataFileName,sep = ";",
             na.strings="?",colClasses=c('character','character',rep('numeric',7)))
dim(p)

# fix character-based date/time in separate fields to be a true Date (POSIXlt) type
# Note: The Time column becomes a don't-care column
p$Date<-strptime(paste(p$Date,p$Time),format="%d/%m/%Y %T")

# select only good records within the date range (stripping NA's)
plotRows<-complete.cases(p[,3:9]) & (p$Date >=beginDate & p$Date < endDate)
plotData<-p[plotRows,]
dim(plotData)


png(plotFileName,width = 480, height=480)
plot(plotData$Date,plotData$Sub_metering_1,type="n",ylab="Energy sub metering",xlab="")
lines(plotData$Date,plotData$Sub_metering_1,col="black")
lines(plotData$Date,plotData$Sub_metering_2,col="red")
lines(plotData$Date,plotData$Sub_metering_3,col="blue")
legend("topright",colnames(plotData)[7:9],col=c("black","red","blue"),lty=rep(1,3))
dev.off()
getwd()

