## Read household power dataset from txt file in working directory
df_full <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

## Subset data to 2007-02-01 and 2007-02-02 dates only
df_subset <- df_full[(df_full$Date=="1/2/2007" | df_full$Date=="2/2/2007"), ]

## Create new column combining Date and Time using lubridate
library(lubridate)
df_subset$Datetime <- paste(df_subset$Date, df_subset$Time, sep=" ")
df_subset$Datetime <- dmy_hms(df_subset$Datetime)

## Convert relevant columns to numeric and filter relevant columns into df_plot4
df_subset$Global_active_power <- as.numeric(as.character(df_subset$Global_active_power))
df_subset$Voltage <- as.numeric(as.character(df_subset$Voltage))
df_subset$Sub_metering_1 <- as.numeric(as.character(df_subset$Sub_metering_1))
df_subset$Sub_metering_2 <- as.numeric(as.character(df_subset$Sub_metering_2))
df_subset$Sub_metering_3 <- as.numeric(as.character(df_subset$Sub_metering_3))
df_subset$Global_reactive_power <- as.numeric(as.character(df_subset$Global_reactive_power))
df_plot4 <- df_subset[, c("Datetime", "Global_active_power", "Voltage", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3", "Global_reactive_power")]

## Set parameters for Plot 4
par(mfrow=c(2,2), mar=c(3.5, 3, 1, 1.5), mgp=c(2,1,0))
cexvalue <- 1.1

## Top left subplot
plot(x=df_plot4$Datetime, y=df_plot4$Global_active_power, type="l", xlab = "", ylab = "Global Active Power", cex.axis=cexvalue, cex.lab=cexvalue)

## Top right subplot
plot(x=df_plot4$Datetime, y=df_plot4$Voltage, type="l", xlab = "datetime", ylab = "Voltage", cex.axis=cexvalue, cex.lab=cexvalue)

## Bottom left subplot
plot(x=df_plot4$Datetime, y=df_plot4$Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering", cex.axis=cexvalue, cex.lab=cexvalue)
lines(x=df_plot4$Datetime, y=df_plot4$Sub_metering_2, col="red")
lines(x=df_plot4$Datetime, y=df_plot4$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"), bty="n", cex=0.7)

## Bottom right subplot
plot(x=df_plot4$Datetime, y=df_plot4$Global_reactive_power, type="l", xlab = "datetime", ylab = "Global_reactive_power", cex.axis=cexvalue, cex.lab=cexvalue)

## Save Plot 4 as PNG file
dev.copy(png, filename="plot4.png", width=480, height=480)
dev.off()
