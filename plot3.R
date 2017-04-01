## Exploratory Data Analysis Course Project 1
## Programming Assignement

# PLOT 2

# Loading libraries
library("dplyr")
library("lubridate")

# Downloading and extracting data
dataURL = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
datadest = "./data/data.zip"
if (!file.exists(datadest)) {download.file(dataURL, datadest)}
unzip(zipfile = datadest, exdir = "./data") 
# list.files("./data")

# Importing and filtering data
data <- read.table(file = "./data/household_power_consumption.txt", skip = 0, sep = ";", header = TRUE, na.strings = "?")
data <- cbind(Date_Time = dmy_hms(paste(data$Date, data$Time,sep = " ")), data[ , 3:ncol(data)])
data <- tbl_df(data)
data <- data %>%
  filter(date(Date_Time) == ymd("2007-02-01") | date(Date_Time) == ymd("2007-02-02"))

# Setting local environment to english to have proper x-axis label
Sys.setenv("LANGUAGE"="En")
Sys.setlocale("LC_ALL", "English")

# Plotting - Plot 3
windows(width = 480, height = 480)
with(data, plot(x = Date_Time,
                y = Sub_metering_1,
                type = "l",
                col = "black", 
                main = "", 
                xlab = "",
                ylab = "Energy submetering"))
with(data, lines(x = Date_Time,
                 y = Sub_metering_2, 
                 col = "red"))
with(data, lines(x = Date_Time,
                 y = Sub_metering_3, 
                 col = "blue"))
legend("topright", 
       lty = c(1,1,1),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black", "red", "blue"),
       y.intersp = .5)

# Copying to PNG
dev.copy(device = png, file = "plot3.png", width = 480, height = 480, units = "px")
dev.off()