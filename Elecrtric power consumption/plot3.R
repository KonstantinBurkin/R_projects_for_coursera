# Loading the data

library(lubridate)
unzip(zipfile = "exdata_data_household_power_consumption.zip")
dt <- read.table(file = "household_power_consumption.txt", sep = ";", 
                 header = TRUE, na.strings = "?")
dt$Date <- as.Date(dt$Date, format = "%d/%m/%Y")
dt <- subset(dt, Date == as.Date("01/02/2007", format = "%d/%m/%Y") | 
               Date == as.Date("02/02/2007", format = "%d/%m/%Y"))
dt$Time <- strptime(dt$Time, format = "%H:%M:%S")
date(dt$Time) <- dt$Date 
dt <- dt[names(dt)[2:dim(dt)[2]]]

str(dt)

# Making Plots
as.POSIXct(dt$Time)
names(dt)

with(dt, 
     {plot(Sub_metering_1~as.POSIXct(Time), type="l", ylab="Global Active Power (kilowatts)", xlab="")
       lines(Sub_metering_2~as.POSIXct(Time),col='Red')
       lines(Sub_metering_3~as.POSIXct(Time),col='Blue')
       legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") 
       )})

dev.copy(png,"plot3.png", width=480, height=480)
dev.off()
