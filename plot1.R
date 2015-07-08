allpower <- read.table("household_power_consumption.txt", 
                       header = TRUE, sep = ";", 
                       colClasses = c("character","character", "numeric","numeric",
                                      "numeric","numeric","numeric","numeric","numeric"), 
                       na.strings = "?")

allpower[,1] <- as.Date(allpower[,1], "%d/%m/%Y")

date_1 <- as.Date("2007-02-01", "%Y-%m-%d")
date_2 <- as.Date("2007-02-02", "%Y-%m-%d")
power_sel <- allpower[which(allpower$Date == date_1 | allpower$Date == date_2),]

remove(allpower, date_1, date_2)

power_sel$Date <- paste(power_sel$Date, power_sel$Time)
power_sel$Date <- as.POSIXct(power_sel$Date, "%Y-%m-%d %H:%M:%S", tz = "UTC")
names(power_sel)[1] <- "datetime"

dev.set("png")
png("plot1.png", width = 480, height = 480, units = "px")
hist(power_sel$Global_active_power, col= "red", 
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
