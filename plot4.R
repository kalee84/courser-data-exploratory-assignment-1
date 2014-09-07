# this will download the data directly from the source. Please make sure you have an internet connetion active. 
temp <- tempfile()
download.file("http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), sep = ";")
unlink(temp)

# Alternatively you can read the downloaded data in using the following code. Change the working directory to wherever you have the downloaded data
setwd("/Users/kalee/Desktop/coursera notes/data exploratory/week 1/assignment/data/") ## Change the working directory for your computer
#data <- read.table("household_power_consumption.txt", header = TRUE)

# get an idea about the data
str(data)

# tell R to read the date/ime as a date/time and not a factor and global active power is numeric
data$date <- as.Date(data$Date, "%d/%m/%Y")
data$active.power <- as.numeric(as.character(data$Global_active_power))
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))
data$Voltage <- as.numeric(as.character(data$Voltage))
data$Global_reactive_power <- as.numeric(as.character(data$Global_reactive_power))
data$date.time <- as.POSIXct(paste(as.character(data$Date), as.character(data$Time)), format="%d/%m/%Y %H:%M:%S")

#subset the two days of interest

data.sub <- subset(data, date == "2007-02-01" | date == "2007-02-02")

par(mfrow = c(2, 2), mar = c(5, 5, 2, 2), oma = c(0, 0, 2, 0))

with(data.sub, {
# plot 1
plot(date.time, active.power, type = "l", xlab = "", ylab = "Global Active Power")

#plot 2
plot(date.time, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

## plot 3
plot(date.time, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(date.time, Sub_metering_2, col = "black")
lines(date.time, Sub_metering_2, col = "red")
lines(date.time, Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black","blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")

## plot 4
plot(date.time, Global_reactive_power, type = "l", xlab = "datetime")

})

dev.copy(png, file = "plot4.png")
dev.off()