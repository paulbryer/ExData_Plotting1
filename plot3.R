#read in data from text file
fulldata <- read.table(file="household_power_consumption.txt", sep = ";",header=TRUE)

#coerce class of Date column to date class
fulldata$Date <- fulldata$Date<- strptime(fulldata$Date, format="%d/%m/%Y")

#Subset full dataset on desired dates
graphdata <- fulldata[fulldata$Date == "2007-02-01"|fulldata$Date == "2007-02-02",]
#Create new column for consolidated date and time variable of class POSIXct
graphdata$Time2 <- strptime(graphdata$Time, format="%H:%M:%S")
graphdata$DateAndTime <- as.POSIXct(paste(graphdata$Date, graphdata$Time), format="%Y-%m-%d%H:%M:%S")
class(graphdata$DateAndTime)

#Plot 3

graphdata$Sub_metering_1 <-  as.numeric(as.character(graphdata$Sub_metering_1))
graphdata$Sub_metering_2 <-  as.numeric(as.character(graphdata$Sub_metering_2))
graphdata$Sub_metering_3 <-  as.numeric(as.character(graphdata$Sub_metering_3))

png("plot3.png")
plot(graphdata$DateAndTime, graphdata$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
legend("topright", lty =c(1,1,1), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col =c("black","red","blue"))
lines(graphdata$DateAndTime, graphdata$Sub_metering_1, col = "black", type = "l")
lines(graphdata$DateAndTime, graphdata$Sub_metering_2, col = "red", type = "l")
lines(graphdata$DateAndTime, graphdata$Sub_metering_3, col = "blue", type = "l")
dev.off()