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
     #if (i == 2) {
     #     fsub[,i] <- as.
     #}
     if (i >= 3) {
          fsub[,i] <- as.numeric(fsub[,i])
     }
}

# Plot
hist(as.numeric(as.character(fsub$Global_active_power)), main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col="red")

# Copy to PNG
dev.copy(png, file = "plot1.png")
dev.off()