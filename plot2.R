library(lubridate)

# the data file is expected to be in your working directory; you may set it here
#setwd("")
alldata <- read.table(file="household_power_consumption.txt", 
                      header=TRUE, 
                      sep=";", 
                      dec=".", 
                      fill=TRUE, 
                      stringsAsFactors=FALSE, 
                      na.strings="?")
# select only data from Febr 1st 2007 and Febr 2nd 2007
data <- subset(alldata, Date=="1/2/2007" | Date == "2/2/2007")
rm(alldata)
# combine the date and time parts
data$datetime <- dmy(data$Date) + hms(data$Time)
# we no longer need the Date and Time columns
data <- subset(data, select=-c(Date,Time))

# make sure the day of week labels appear in English
Sys.setlocale(category="LC_TIME", locale="en_US.UTF-8")
png(filename="plot2.png", width=480, height=480, units="px", bg="white")
with(data, plot(datetime, 
                Global_active_power, 
                type="l", 
                xlab="", 
                ylab="Global Active Power (kilowatts)"))
dev.off()
