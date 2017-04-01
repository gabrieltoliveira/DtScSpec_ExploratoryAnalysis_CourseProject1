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

# Plotting - Plot 2
windows(width = 480, height = 480)
with(data, plot(x = Date_Time,
                y = Global_active_power, 
                type = "l",
                col = "black",
                xlab = "",
                ylab = "Global Active Power (kilowatts)"))

# Copying to PNG
dev.copy(device = png, file = "plot2.png", width = 480, height = 480, units = "px")
dev.off()