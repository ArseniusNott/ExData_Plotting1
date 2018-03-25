#plot4
#read the text file
hpc <- read.table("./household_power_consumption.txt", sep = ";", 
                  header = TRUE, stringsAsFactors = FALSE, na.strings = "?")
#tansform character dates and times into Date and POSIXct formats respectively
hpc <- transform(hpc, Date = as.Date(hpc$Date, "%d/%m/%Y"), 
                 Time = as.POSIXct(hpc$Time,format="%H:%M:%S"))
#subset observations to the required date interval
hpc_subset <- subset(hpc, Date >= as.Date("2007-2-1") 
                            & Date <= as.Date("2007-2-2"))

#initiate png graphics device
png("plot4.png", width=480, height=480)
#set the canvas to be a two-by-two grid of charts with margins different 
#from defaults
par(mfrow = c(2, 2), mar = c(4, 4, 1, 1))

#concatenate dates and times into one POSIXlt component. 
#This will be used as one of the required variables in bivariate plot below
hpc_subset$datetime <- strptime(paste(as.character(hpc_subset$Date, 
                                "%Y-%m-%d"), as.character(hpc_subset$Time, 
                                "%H:%M:%S")), format = "%Y-%m-%d %H:%M:%S")
with(hpc_subset, {
        #Chart 1_1
        plot(datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power")
        #Chart 1_2
        plot(datetime, Voltage, type="l", xlab="datetime", ylab="Voltage")
        #Chart 2_1
        plot(datetime, Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
        lines(datetime, Sub_metering_2, type="l", col="red")
        lines(datetime, Sub_metering_3, type="l", col="blue")
        legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
        #Chart 2_2
        plot(datetime, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
})
#close the graphics device
dev.off()