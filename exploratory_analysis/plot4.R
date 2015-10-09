filePath <- "./power/"
fileName <- "household_power_consumption.txt"
power <- read.table(paste0(filePath, fileName), 
                    sep = ";", header = TRUE, na.strings = "?", 
                    stringsAsFactors = FALSE)
power <- transform(power, Date = as.Date(strptime(Date, "%d/%m/%Y")))
powerInFebruary <- subset(power, subset = Date >= "2007-02-01" & Date <= "2007-02-02")
dateTime <- as.POSIXlt(paste(powerInFebruary$Date, powerInFebruary$Time), 
                       format = "%Y-%m-%d %H:%M:%S",
                       tz = "GMT")
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

with(powerInFebruary, plot(dateTime, Global_active_power, 
                           ylab = "Global Active Power",
                           xlab = "",
                           type = "l"))

with(powerInFebruary, plot(dateTime, Voltage, 
                           ylab = "Voltage",
                           xlab = "datatime",
                           type = "l"))

with(powerInFebruary, plot(dateTime, Sub_metering_1,
                           cel = "black",
                           ylab = "Global Active Power",
                           xlab = "",
                           type = "l"))
with(powerInFebruary, lines(dateTime, Sub_metering_2, col = "red"))
with(powerInFebruary, lines(dateTime, Sub_metering_3, col = "blue"))
legend("topright", legend = names(powerInFebruary[7:9]), lty = c(1, 1, 1), 
       col = c("black", "red", "blue"), bty = "n", 
       pt.cex = 1, cex = 0.6, xjust = 1, yjust = 1)

with(powerInFebruary, plot(dateTime, Global_reactive_power, 
                           xlab = "datatime",
                           type = "l"))
dev.off()
par(mfrow = c(1, 1))
