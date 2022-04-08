# Loading the data

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

hist(dt$Global_active_power, main = "Global active power", 
     col="red", xlab = "Global active power, (kilowatts)")
dev.copy(png, "plot1.png", width=480, height=480)
dev.off()

