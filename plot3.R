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

## Plot
plot(fsub$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab="", xaxt='n')
lines(fsub$Sub_metering_2, type="l", col = "red")
lines(fsub$Sub_metering_3, type="l", col = "blue")
axis(1, at = c(1, 1441, 2880), labels = c("Thu", "Fri", "Sat"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1,1,1), lwd = 2)

## Copy to PNG
dev.copy(png, file = "plot3.png")
dev.off()