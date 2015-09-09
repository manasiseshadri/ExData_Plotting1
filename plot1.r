plot1 <- function() {
    library(grDevices)
    
    # read entire data into data frame
    df <- read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors = FALSE)
    
    # convert Date column to date with correct format
    df$Date <- as.Date(df$Date, format="%d/%m/%Y")
    
    # subset data frame by extracting the dates required
    powerdf <- df[(df$Date == "2007-02-01" | df$Date == "2007-02-02"), ]
    
    # clean up unused objects
    rm(list = c("df"))
    
    # convert Global_active_power to numeric
    powerdf$Global_active_power <- as.numeric(powerdf$Global_active_power)
    
    histplot <- hist(powerdf$Global_active_power)
    
    # create plot - no need to mention sizes as 480x480px is default
    png(filename = "plot1.png")
    plot(histplot, col = "red", xlab = "Global Active Power (kilowatts)", main="Global Active Power")
    dev.off()
    
}