#bash commands used to explore data file beforehand:
#sed -n 1,10p ../household_power_consumption.txt
#grep -n -A2 -B2 -m3 "1/2/2007" ../household_power_consumption.txt
#grep -n -A2 -B2 "^2/2/2007" ../household_power_consumption.txt | tail -5

#import data
png(filename="plot3.png",height=480,width=480,units="px")
filename<-"../household_power_consumption.txt"
con <- file(filename, open="r")
colnames <- strsplit(readLines(con=con,n=1),";")
close(con)
data<-read.table(filename, header=FALSE,sep=";",skip="66637", nrows=2880,col.names=colnames[[1]])
datetime<-as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
#make the plot
plot(datetime,data[,'Sub_metering_1'],col="black",type="l",ylab="Energy sub metering",xlab="")
lines(datetime,data[,'Sub_metering_2'],col="red")
lines(datetime,data[,'Sub_metering_3'],col="blue")
legend("topright",c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),lty=c(1,1,1),col=c("black","red","blue"))
#save the plot
#dev.copy(png,'plot1.png')
dev.off()
