plot4 <- function() {
    library(grDevices)
    
    # read entire data into data frame
    df <- read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors = FALSE)
    
    # convert Date column to date with correct format
    df$Date <- as.Date(df$Date, format="%d/%m/%Y")
    
    # subset data frame by extracting the dates required
    date1 <- as.Date("2007-02-01")
    date2 <- as.Date("2007-02-02")
    powerdf <- df[(df$Date == date1 | df$Date == date2), ]
    
    # clean up unused objects
    rm(list = c("df"))
    
    # convert y-axis columns to numeric
    powerdf$Sub_metering_1 <- as.numeric(powerdf$Sub_metering_1)
    powerdf$Sub_metering_2 <- as.numeric(powerdf$Sub_metering_2)
    powerdf$Sub_metering_3 <- as.numeric(powerdf$Sub_metering_3)
    powerdf$Global_active_power <- as.numeric(powerdf$Global_active_power)
    powerdf$Global_reactive_power <- as.numeric(powerdf$Global_reactive_power)
    powerdf$Voltage <- as.numeric(powerdf$Voltage)
    
    
    # create date time column and convert to datetime
    powerdf$DateAndTime <- paste(powerdf$Date, powerdf$Time)
    powerdf$DateAndTime <- strptime(powerdf$DateAndTime, format = "%Y-%m-%d %H:%M:%S")
    
    # create plot - no need to mention sizes as 480x480px is default
    png(filename = "plot4.png")
    par(mfrow=c(2,2))
    
    #plot top left
    plot(powerdf$DateAndTime, powerdf$Global_active_power, ylab = "Global Active Power", xlab = "", type = "l")
    
    #plot top right
    plot(powerdf$DateAndTime, powerdf$Voltage, ylab = "Voltage", xlab = "datetime", type = "l")
    
    #plot bottom left
    plot(powerdf$DateAndTime, powerdf$Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "l", col = "black")
    lines(powerdf$DateAndTime, powerdf$Sub_metering_2, type = "l", col = "red")
    lines(powerdf$DateAndTime, powerdf$Sub_metering_3, type = "l", col = "blue")
    legend(x="topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n", lty = c(1,1, 1), lwd = c(1, 1, 1) , col = c("black", "red", "blue"))
    
    #plot bottom right
    plot(powerdf$DateAndTime, powerdf$Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime", type = "l")
    
    dev.off()
    
}