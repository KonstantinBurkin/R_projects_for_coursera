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

par(mfrow=c(2,2), mar=c(4,4,2,1))

names(dt)

with(dt, plot(Global_active_power~as.POSIXct(Time), type="l"
             , ylab="Global Active Power (kilowatts)", xlab=""))

with(dt, plot(Voltage~as.POSIXct(Time), type="l"
             , ylab="Voltage (volt)", xlab=""))

with(dt, 
     {plot(Sub_metering_1~as.POSIXct(Time), type="l", ylab="Global Active Power (kilowatts)", xlab="")
lines(Sub_metering_2~as.POSIXct(Time),col='Red')
lines(Sub_metering_3~as.POSIXct(Time),col='Blue')
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") 
       )})

with(dt, plot(Global_reactive_power~as.POSIXct(Time), type="l"
              , ylab="Global reactive power (kilowatts)", xlab=""))

dev.copy(png,"plot4.png", width=480, height=480)
dev.off()
