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
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(data.sub$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()



