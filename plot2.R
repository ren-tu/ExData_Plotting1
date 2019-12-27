## Read household power dataset from txt file in working directory
df_full <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

## Subset data to 2007-02-01 and 2007-02-02 dates only
df_subset <- df_full[(df_full$Date=="1/2/2007" | df_full$Date=="2/2/2007"), ]

## Create new column combining Date and Time using lubridate
library(lubridate)
df_subset$Datetime <- paste(df_subset$Date, df_subset$Time, sep=" ")
df_subset$Datetime <- dmy_hms(df_subset$Datetime)

## Create Plot 2 by converting Global Active Power column to numeric, then plot line graph
df_subset$Global_active_power <- as.numeric(as.character(df_subset$Global_active_power))
df_plot2 <- df_subset[, c("Datetime", "Global_active_power")]
plot(x=df_plot2$Datetime, y=df_plot2$Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)")

## Save Plot 2 as PNG file
dev.copy(png, filename="plot2.png", width=480, height=480)
dev.off()
