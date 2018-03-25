#plot1
#read the text file
hpc <- read.table("./household_power_consumption.txt", sep = ";", 
                  header = TRUE, stringsAsFactors = FALSE, na.strings = "?")
#tansform character dates and times into Date and POSIXct formats respectively
hpc <- transform(hpc, Date = as.Date(hpc$Date, "%d/%m/%Y"), 
                 Time = as.POSIXct(hpc$Time,format="%H:%M:%S"))
#subset observations to the required date interval
hpc_subset <- subset(hpc, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
#initiate png graphics device
png("plot1.png", width=480, height=480)
#draw histogram as per the requirement
hist(hpc_subset$Global_active_power, col="red", main="Global Active Power", 
				xlab="Global Active Power (kilowatts)")
#close the graphics device
dev.off()