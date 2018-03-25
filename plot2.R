#plot2
#read the text file
hpc <- read.table("./household_power_consumption.txt", sep = ";", 
                  header = TRUE, stringsAsFactors = FALSE, na.strings = "?")
#tansform character dates and times into Date and POSIXct formats respectively
hpc <- transform(hpc, Date = as.Date(hpc$Date, "%d/%m/%Y"), 
                 Time = as.POSIXct(hpc$Time,format="%H:%M:%S"))
#subset observations to the required date interval
hpc_subset <- subset(hpc, Date >= as.Date("2007-2-1") & 
						  Date <= as.Date("2007-2-2"))
#concatenate dates and times into one POSIXlt component. 
#This will be used as one of the required variables in bivariate plot below
hpc_subset$datetime <- strptime(
						paste(as.character(hpc_subset$Date, "%Y-%m-%d"), 
						as.character(hpc_subset$Time, "%H:%M:%S")), 
						format = "%Y-%m-%d %H:%M:%S")
#initiate png graphics device
png("plot2.png", width=480, height=480)
#draw the chart as per the requirement
plot(hpc_subset$datetime, hpc_subset$Global_active_power, type="l", xlab="", 
						ylab="Global Active Power (kilowatts)")
#close the graphics device
dev.off()