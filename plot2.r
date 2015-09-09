plot2 <- function() {
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
    
    # convert Global_active_power to numeric
    powerdf$Global_active_power <- as.numeric(powerdf$Global_active_power)
    
    # create date time column and convert to datetime
    powerdf$DateAndTime <- paste(powerdf$Date, powerdf$Time)
    powerdf$DateAndTime <- strptime(powerdf$DateAndTime, format = "%Y-%m-%d %H:%M:%S")
    
    # create plot - no need to mention sizes as 480x480px is default
    png(filename = "plot2.png")
    plot(powerdf$DateAndTime, powerdf$Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = "", type = "l")
    dev.off()
    
}