## "household_power_consumption.txt" must be in working directory.

## Reading file
file <- file("household_power_consumption.txt")
f <- read.csv2(file, na.strings = "?")

## Subsetting
fsub <- f[f$Date == "1/2/2007" | f$Date == "2/2/2007",1:9]

## Transforming to tidy data
for (i in 1:9) {
     fsub[,i] <- as.character(fsub[,i])
     if (i == 1) {
          fsub[,i] <- as.Date(fsub[,i], format = "%d/%m/%Y")
     }
     if (i >= 3) {
          fsub[,i] <- as.numeric(fsub[,i])
     }
}

## 2x2 plot grid
par(mfrow = c(2, 2), mar = c(2, 0, 2, 0), oma = c(2, 0, 2, 0))

## Plot 1
plot(fsub$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab="", xaxt='n')
axis(1, at = c(1, 1441, 2880), labels = c("Thu", "Fri", "Sat"))

## Plot 2
plot(fsub$Voltage, type = "l", ylab = "Voltage", xaxt='n', xlab = "datetime")
axis(1, at = c(1, 1441, 2880), labels = c("Thu", "Fri", "Sat"))

## Plot 3
plot(fsub$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab="", xaxt='n')
lines(fsub$Sub_metering_2, type="l", col = "red")
lines(fsub$Sub_metering_3, type="l", col = "blue")
axis(1, at = c(1, 1441, 2880), labels = c("Thu", "Fri", "Sat"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1,1,1), lwd = 2)

## Plot 4
plot(fsub$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xaxt='n', xlab = "datetime")
axis(1, at = c(1, 1441, 2880), labels = c("Thu", "Fri", "Sat"))

# Copy to PNG
dev.copy(png, file = "plot4.png")
dev.off()