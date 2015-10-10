

### ************************************************************************************************** ###

# Reproduce plot4 given in the https://github.com/rdpeng/ExData_Plotting1 using 'Electric power consumption' data





# 1. Download 'Electric power consumption' data

FileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url = FileUrl, destfile = paste0(getwd(), '/data.zip'))
unzip ("data.zip", exdir = "./data")
file.remove(paste0(getwd(), '/data.zip'))
rm(FileUrl)




# 2. Read a subset of data by indexing the Date (or the first) column.

library(data.table)
DateCol <- fread(input = './data/household_power_consumption.txt', sep = ";", header = T, na.strings = "?", select = c(1))


# We want to subset for 2007-02-01 to 2007-02-02
ind  <- which({as.Date(DateCol$Date, "%d/%m/%Y")>='2007-02-01' & as.Date(DateCol$Date, "%d/%m/%Y")<='2007-02-02'})
DATA <- fread(input = './data/household_power_consumption.txt', sep = ";", header = F,
              na.strings = "?", skip = ind[1], nrows = length(ind))

# all.equal(dim(DATA)[1], length(ind))

setnames(DATA, 1:dim(DATA)[2], colnames(fread(input = './data/household_power_consumption.txt', sep = ";", header = T, nrows = 1)))
rm(list = c('ind', 'DateCol'))




# 3. Create plot4 in a png format.

png(file = "plot4.png", width = 480, height = 480, units = "px")

par(mfcol = c(2,2))

plot(DATA$Global_active_power, ylab = 'Global Active Power', type = 'n', xaxt = "n", xlab = '')
lines(DATA$Global_active_power)
axis(1, at = c(0, 1440, 2880), labels=c('Thu', 'Fri', 'Sat'))

plot(DATA$Sub_metering_1, ylab = 'Energy sub metering', type = 'n', xaxt = "n", xlab = '')
lines(DATA$Sub_metering_1)
lines(DATA$Sub_metering_2, col = 'red')
lines(DATA$Sub_metering_3, col = 'blue')
axis(1, at = c(0, 1440, 2880), labels=c('Thu', 'Fri', 'Sat'))
legend('topright', lty = 1, cex = 0.85, bty = 'n', 
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col = c('black', 'red', 'blue'))

plot(DATA$Voltage, ylab = 'Voltage', type = 'n', xaxt = "n", xlab = 'datetime')
lines(DATA$Voltage)
axis(1, at = c(0, 1440, 2880), labels=c('Thu', 'Fri', 'Sat'))

plot(DATA$Global_reactive_power, ylab = 'Global_reactive_power', type = 'n', xaxt = "n", xlab = 'datetime')
lines(DATA$Global_reactive_power)
axis(1, at = c(0, 1440, 2880), labels=c('Thu', 'Fri', 'Sat'))

dev.off()



