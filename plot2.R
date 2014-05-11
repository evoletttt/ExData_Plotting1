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
plot(fsub$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab="", xaxt='n')
axis(1, at = c(1, 1441, 2880), labels = c("Thu", "Fri", "Sat"))

# Copy to PNG
dev.copy(png, file = "plot2.png")
dev.off()