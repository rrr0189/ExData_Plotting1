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
# plot3 #
#########
t <- DT$datetime
png(filename = "plot3.png", width = 480, height = 480)
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
       cex = 0.80)
dev.off()