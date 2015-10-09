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
png(filename = "plot2.png", width = 480, height = 480)
with(powerInFebruary, plot(dateTime, Global_active_power, 
                           ylab = "Global Active Power",
                           xlab = "",
                           type = "l"))
dev.off()
