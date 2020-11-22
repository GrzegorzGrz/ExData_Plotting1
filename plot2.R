library(dplyr)
#Reading and cleaning data

unzip(zipfile = "exdata_data_household_power_consumption.zip")
my_data <- read.delim("household_power_consumption.txt", header = TRUE, sep = ";")
file.remove("household_power_consumption.txt")
my_data <- as_tibble(my_data)


my_data$Date <- paste(my_data$Date, my_data$Time, sep = " ")
my_data$Date <- as.POSIXct(strptime(my_data$Date, "%d/%m/%Y %H:%M:%S"))
my_data <- subset(my_data, select = -2)   
my_data <- my_data %>% filter(Date >= "2007-02-01") %>% filter(Date <= "2007-02-02 23:59:59") 

my_data$Global_active_power <- as.numeric(my_data$Global_active_power)
my_data$Sub_metering_1 <- as.numeric(my_data$Sub_metering_1)
my_data$Sub_metering_2 <- as.numeric(my_data$Sub_metering_2)
my_data$Sub_metering_3 <- as.numeric(my_data$Sub_metering_3)


#creating plot
plot(my_data$Date, my_data$Global_active_power, type = "S", ylab = "Global Active Power (kilowatts)", xlab = "")


#printing and saving plots
dev.copy(png, "plot2.png")
dev.off()
