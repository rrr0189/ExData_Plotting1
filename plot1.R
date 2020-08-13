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
# plot1 #
#########
png(filename = "plot1.png", width = 480, height = 480)
with(DT, hist(Global_active_power, col = "red",
                     main = "Global Active Power",
                     xlab = "Global Active Power (kilowatts)"))
dev.off()
