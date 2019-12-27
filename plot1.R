## Read household power dataset from txt file in working directory
df_full <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

## Subset data to 2007-02-01 and 2007-02-02 dates only
df_subset <- df_full[(df_full$Date=="1/2/2007" | df_full$Date=="2/2/2007"), ]

## Create new column combining Date and Time using lubridate
library(lubridate)
df_subset$Datetime <- paste(df_subset$Date, df_subset$Time, sep=" ")
df_subset$Datetime <- dmy_hms(df_subset$Datetime)

## Create Plot 1 by converting Global Active Power column to numeric and plotting histogram
df_plot1 <- as.numeric(as.character(df_subset$Global_active_power))
hist(df_plot1, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col="red")

## Save Plot 1 as PNG file
dev.copy(png, filename="plot1.png", width=480, height=480)
dev.off()
