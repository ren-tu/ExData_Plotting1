## Read household power dataset from txt file in working directory
df_full <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

## Subset data to 2007-02-01 and 2007-02-02 dates only
df_subset <- df_full[(df_full$Date=="1/2/2007" | df_full$Date=="2/2/2007"), ]

## Create new column combining Date and Time using lubridate
library(lubridate)
df_subset$Datetime <- paste(df_subset$Date, df_subset$Time, sep=" ")
df_subset$Datetime <- dmy_hms(df_subset$Datetime)

## Create Plot 3 by converting Sub Metering columns to numeric, then plot line graphs and legend
df_subset$Sub_metering_1 <- as.numeric(as.character(df_subset$Sub_metering_1))
df_subset$Sub_metering_2 <- as.numeric(as.character(df_subset$Sub_metering_2))
df_subset$Sub_metering_3 <- as.numeric(as.character(df_subset$Sub_metering_3))
df_plot3 <- df_subset[, c("Datetime", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")]
plot(x=df_plot3$Datetime, y=df_plot3$Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering")
lines(x=df_plot3$Datetime, y=df_plot3$Sub_metering_2, col="red")
lines(x=df_plot3$Datetime, y=df_plot3$Sub_metering_3, col="blue")
legend("topright", names(df_plot3)[-1], lty=1, col=c("black", "red", "blue"), cex=0.7)

## Save Plot 3 as PNG file
dev.copy(png, filename="plot3.png", width=480, height=480)
dev.off()
