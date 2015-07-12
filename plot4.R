file<-"household_power_consumption.txt"
dat <- read.table(file, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
dat$Date <- as.Date(dat$Date, format="%d/%m/%Y")
sub_dat <- subset(dat,dat$Date=="2007-02-01" | dat$Date=="2007-02-02")
sub_dat$Global_active_power <- as.numeric(as.character(sub_dat$Global_active_power))
sub_dat$Global_reactive_power <- as.numeric(as.character(sub_dat$Global_reactive_power))
sub_dat$Voltage <- as.numeric(as.character(sub_dat$Voltage))
sub_dat$Sub_metering_1 <- as.numeric(as.character(sub_dat$Sub_metering_1))
sub_dat$Sub_metering_2 <- as.numeric(as.character(sub_dat$Sub_metering_2))
sub_dat$Sub_metering_3 <- as.numeric(as.character(sub_dat$Sub_metering_3))
sub_dat <- transform(sub_dat, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

par(mfrow=c(2,2))

##PLOT 1
plot(sub_dat$timestamp,sub_dat$Global_active_power, type="l", xlab="", ylab="Global Active Power")
##PLOT 2
plot(sub_dat$timestamp,sub_dat$Voltage, type="l", xlab="datetime", ylab="Voltage")

##PLOT 3
plot(sub_dat$timestamp,sub_dat$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(sub_dat$timestamp,sub_dat$Sub_metering_2,col="red")
lines(sub_dat$timestamp,sub_dat$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"),
       c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),
       lty=c(1,1), bty="n", cex=.5)

#PLOT 4
plot(sub_dat$timestamp,sub_dat$Global_reactive_power, type="l", xlab="datetime",
     ylab="Global_reactive_power")

#OUTPUT
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()
