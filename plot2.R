file<-"household_power_consumption.txt"
dat <- read.table(file, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
dat$Date <- as.Date(dat$Date, format="%d/%m/%Y")
sub_dat <- subset(dat,dat$Date=="2007-02-01" | dat$Date=="2007-02-02")
sub_dat$Global_active_power <- as.numeric(as.character(sub_dat$Global_active_power))
sub_dat <- transform(sub_dat, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
plot(sub_dat$timestamp,sub_dat$Global_active_power, type="l", xlab="",
     ylab="Global Active Power (kilowatts)")
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()
