#plot3
#read the text file
hpc <- read.table("./household_power_consumption.txt", sep = ";", 
                  header = TRUE, stringsAsFactors = FALSE, na.strings = "?")
#tansform character dates and times into Date and POSIXct formats respectively
hpc <- transform(hpc, Date = as.Date(hpc$Date, "%d/%m/%Y"), 
                 Time = as.POSIXct(hpc$Time,format="%H:%M:%S"))
#subset observations to the required date interval
hpc_subset <- subset(hpc, Date >= as.Date("2007-2-1") 
                            & Date <= as.Date("2007-2-2"))

#concatenate dates and times into one POSIXlt component. 
#This will be used as one of the required variables in bivariate plot below
hpc_subset$datetime <- strptime(paste(
                        as.character(hpc_subset$Date, "%Y-%m-%d"), 
                        as.character(hpc_subset$Time, "%H:%M:%S")), 
                        format = "%Y-%m-%d %H:%M:%S")
#initiate png graphics device
png("plot3.png", width=480, height=480)
#draw the comparison between the datetime made above vs the Sub_metering_1
plot(hpc_subset$datetime, hpc_subset$Sub_metering_1, type="l", 
                            ylab="Energy sub metering", xlab="")
#add dimension to the plot between the datetime made above vs the Sub_metering_2
#use a different color
lines(hpc_subset$datetime, hpc_subset$Sub_metering_2, type="l", col="red")
#add another dimension to the plot between the datetime made above vs the Sub_metering_3
#use a different color
lines(hpc_subset$datetime, hpc_subset$Sub_metering_3, type="l", col="blue")
#put legend on the topright corner of the chart visualizing what the different 
#lines mean
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
#close the graphics device
dev.off()