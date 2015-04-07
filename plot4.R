rm(list = ls())

if(!file.exists("data/household_power_consumption.txt"))
    error("Data file not found.")

message("Reading data...")
data <- read.csv("data/household_power_consumption.txt", header = T, sep = ";", stringsAsFactors = F)

message("Formating and subsetting data...")
idxs <- which(data$Date == "1/2/2007" | data$Date == "2/2/2007")

data.sub <- data.frame(
    Time = strptime(paste(data$Date[idxs], data$Time[idxs]), format = "%d/%m/%Y %H:%M:%S"),
    Global_active_power = as.numeric(data$Global_active_power[idxs]),
    Global_reactive_power = as.numeric(data$Global_reactive_power[idxs]),
    Voltage = as.numeric(data$Voltage[idxs]),
    Global_intensity = as.numeric(data$Global_intensity[idxs]),
    Sub_metering_1 = as.numeric(data$Sub_metering_1[idxs]),
    Sub_metering_2 = as.numeric(data$Sub_metering_2[idxs]),
    Sub_metering_3 = as.numeric(data$Sub_metering_3[idxs])
)

rm("data")

message("Plotting...")
png(filename = "plot4.png", width = 480, height = 480, units = "px")

par(mfrow = c(2, 2))

## Plot 1
plot(x = data.sub$Time,
     y = data.sub$Global_active_power, 
     type = "l", 
     ylab = "Global Active Power",
     xlab = "")

## Plot 2
plot(x = data.sub$Time,
     y = data.sub$Voltage, 
     type = "l", 
     ylab = "Voltage",
     xlab = "datetime")

## Plot 3
plot(x = data.sub$Time,
     y = data.sub$Sub_metering_1, 
     type = "n", 
     ylab = "Energy sub metering",
     xlab = "")
points(x = data.sub$Time,
       y = data.sub$Sub_metering_1,
       type = "l",
       col = "black")
points(x = data.sub$Time,
       y = data.sub$Sub_metering_2,
       type = "l",
       col = "red")
points(x = data.sub$Time,
       y = data.sub$Sub_metering_3,
       type = "l",
       col = "blue")
legend(x = "topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"),
       lty = 1)


## Plot 4
plot(x = data.sub$Time,
     y = data.sub$Global_reactive_power, 
     type = "l", 
     ylab = "Global_reactive_power",
     xlab = "datetime")

dev.off()



