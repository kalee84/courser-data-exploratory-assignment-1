# this will download the data directly from the source. Please make sure you have an internet connetion active. 
temp <- tempfile()
download.file("http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), sep = ";")
unlink(temp)

# Alternatively you can read the data in using the following code. Change the working directory to your local computer
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
data$date.time <- as.POSIXct(paste(as.character(data$Date), as.character(data$Time)), format="%d/%m/%Y %H:%M:%S")

#subset the two days of interest

data.sub <- subset(data, date == "2007-02-01" | date == "2007-02-02")

with(data.sub, plot(date.time, active.power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

dev.copy(png, file = "plot2.png")
dev.off()