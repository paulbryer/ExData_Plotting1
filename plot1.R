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

##Plot 1
#histograms require numerical class data. 
graphdata$Global_active_power <-  as.numeric(as.character(graphdata$Global_active_power))

#draw histogram and save to png
png("plot1.png")
hist(graphdata$Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "Red")
dev.off()