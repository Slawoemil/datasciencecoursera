filePath <- "./power/"
fileName <- "household_power_consumption.txt"
power <- read.table(paste0(filePath, fileName), 
                    sep = ";", header = TRUE, na.strings = "?", 
                    stringsAsFactors = FALSE)
power <- transform(power, Date = as.Date(strptime(Date, "%d/%m/%Y")))
powerInFebruary <- subset(power, subset = Date >= "2007-02-01" & Date <= "2007-02-02")
png(filename = "plot1.png", width = 480, height = 480)
with(powerInFebruary, hist(Global_active_power, col="red", 
                           xlab = "Global Active Power (kilowatts)", 
                           main = "Global Active Power"))
dev.off()




