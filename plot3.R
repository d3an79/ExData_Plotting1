### initial reading and preparing of data ###

# read in table to data
data <- read.table("./exdata-data-household_power_consumption/household_power_consumption.txt", h=T, sep=";")

# Store only the data for 1/2/07 & 2/2/07
data <- data[data[,1]== "1/2/2007" | data[,1]=="2/2/2007",]

# create datetime field using strptime()
data[,"datetime"] <- as.data.frame(strptime(paste(data[,1], data[,2]), format="%d/%m/%Y %H:%M:%S"))

# Convert facter variables to nums
data[,3]<- as.numeric(levels(data[,3]))[data[,3]]
data[,4]<- as.numeric(levels(data[,4]))[data[,4]]
data[,5]<- as.numeric(levels(data[,5]))[data[,5]]
data[,6]<- as.numeric(levels(data[,6]))[data[,6]]
data[,7]<- as.numeric(levels(data[,7]))[data[,7]]
data[,8]<- as.numeric(levels(data[,8]))[data[,8]]
# this could prob be done with sapply or something like that.


### Creating the plot ###

# set ylabel
ylabel <- "Energy sub metering"

# set labels for legend
legs <- c("sub_metering_1","sub_metering_2","sub_metering_3")

# Open png device to save the plot to
png(file="plot3.png", width=480, height=480)

# Change global margin settings
par(mar=c(2,4,2,2))

# plot empty graph with correct annotation
with(data, plot(datetime, Sub_metering_1, type="n", ylab=ylabel))

# plot lines for sub_metering_1
with(data, lines(datetime, Sub_metering_1))

# plot lines for sub_metering_2
with(data, lines(datetime, Sub_metering_2, col="red"))

# plot lines for sub_metering_3
with(data, lines(datetime, Sub_metering_3, col="blue"))

# plot the legend
legend("topright", col=c("black","red","blue"),legend=legs, lty=c(1,1,1))

#close the png device
dev.off()