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

#Plot 2
graphdata$Global_active_power <-  as.numeric(as.character(graphdata$Global_active_power))
png("plot2.png")
plot(graphdata$DateAndTime, graphdata$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()