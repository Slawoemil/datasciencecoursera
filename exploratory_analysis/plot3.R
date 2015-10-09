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
png(filename = "plot3.png", width = 480, height = 480)
with(powerInFebruary, plot(dateTime, Sub_metering_1,
                           cel = "black",
                           ylab = "Global Active Power",
                           xlab = "",
                           type = "l"))
with(powerInFebruary, lines(dateTime, Sub_metering_2, col = "red"))
with(powerInFebruary, lines(dateTime, Sub_metering_3, col = "blue"))
legend("topright", legend = names(powerInFebruary[7:9]), lty = c(1, 1, 1), lwd = 2, col = c("black", "red", "blue"))
dev.off()
