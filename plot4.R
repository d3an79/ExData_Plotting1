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

# Open png device to save the plot to
png(file="plot4.png", width=480, height=480)


# set No of plots per image to 2*2 rows
par(mfrow=c(2,2))

# Change global margin settings
par(mar=c(4,4,2,2))

#plot4.1

# set ylabel
ylabel <- "Global Active Power"
# set xlabel
xlabel <- ""

# plot empty graph with correct annotation
with(data, plot(datetime, Global_active_power, type="n", ylab=ylabel, xlab=xlabel))

# plot the lines
with(data, lines(datetime, Global_active_power))


#plot4.2

# set xlabel
xlabel <- "datetime"

with(data, plot(datetime, Voltage, type="n", xlab=xlabel))
# change ticks on y axis?

# plot the lines
with(data, lines(datetime, Voltage))


#plot4.3


# set ylabel
ylabel <- "Energy sub metering"

# set labels for legend
legs <- c("sub_metering_1","sub_metering_2","sub_metering_3")

# plot empty graph with correct annotation
with(data, plot(datetime, Sub_metering_1, type="n", ylab=ylabel, xlab=""))

# plot lines for sub_metering_1
with(data, lines(datetime, Sub_metering_1))

# plot lines for sub_metering_2
with(data, lines(datetime, Sub_metering_2, col="red"))

# plot lines for sub_metering_3
with(data, lines(datetime, Sub_metering_3, col="blue"))

# plot the legend
legend("topright", col=c("black","red","blue"),legend=legs, lty=c(1,1,1), bty="n")


#plot 4.4

# set xlabel
xlabel <- "datetime"

with(data, plot(datetime, Global_reactive_power, type="n", xlab=xlabel))
# change ticks on y axis?

# plot the lines
with(data, lines(datetime, Global_reactive_power))

#close the png device
dev.off()