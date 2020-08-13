library(data.table); library(dplyr); library(lubridate);

### Is this file in your working directory?
fname <- "household_power_consumption.txt"

# Extract all observations from Feb. 1 2007 to Feb. 2 2007
DT <- (fread(fname, na.strings = "?")
       [which(Date == "1/2/2007" |Date == "2/2/2007"),])

# Combine Date and Time columns to be a datetime column.
DT <- DT %>% mutate(datetime = dmy(Date) + hms(Time),
                    .keep = "unused")

#########
# plot4 #
#########
t <- DT$datetime
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(DT, plot(datetime, Global_active_power,
                     type = "l",
                     xlab = "", ylab = "Global Active Power"))
with(DT, plot(datetime, Voltage,
                     type = "l",
                     xlab = "datetime"))
plot(t, DT$Sub_metering_1,
     type = "n",
     xlab = "",
     ylab = "Energy sub metering")
points(t, DT$Sub_metering_1, type = "l", col = "black")
points(t, DT$Sub_metering_2, type = "l", col = "red")
points(t, DT$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = "solid", 
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       cex = 0.80, bty = "n")
with(DT, plot(datetime, Global_reactive_power,
                     type = "l",
                     xlab = "datetime"))

dev.off()