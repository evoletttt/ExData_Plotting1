power <- read.csv2("household_power_consumption.txt")
power[,1] <- as.Date(as.character(power[,1]), format = "%d/%m/%Y")
power[,2] <- as.character(power[,2])
for (i in 3:9)
{
     power[,i] <- as.numeric(as.character(power[,i]))
}

tempsub <- power[power$Date == "2007-02-01" | power$Date == "2007-02-02",]

temp <- as.character(paste(tempsub[,1], tempsub[,2]))
temp <- strptime(temp, format = "%Y-%m-%d %H:%M:%S")
sub <- cbind(tempsub[,1],temp,tempsub[,3:9])

par(mar = c(5,5,1,1))
par(mfrow = c(2,2))

# Plot 1
plot(sub$temp, sub$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# Plot 2
plot(sub$temp, sub$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")

# Plot 3
plot(sub$temp, sub$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
lines(sub$temp, sub$Sub_metering_2, col = "red")
lines(sub$temp, sub$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Plot 4
plot(sub$temp, sub$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l")

# Save to PNG
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()
