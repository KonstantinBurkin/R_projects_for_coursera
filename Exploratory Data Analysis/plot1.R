# 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5 emission 
# from all sources for each of the years 1999, 2002, 2005, and 2008.

# Read the data
NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

# Make plot
total_emmisions <- tapply(NEI$Emissions, NEI$year, sum)
total_emmisions
plot(x = unique(NEI$year), y = total_emmisions,
     ylab = "Total emissions in year, tons",
     xlab = "Year",
     pch=19,
     col="#005C53",
     cex=1
     )
lines(unique(NEI$year), total_emmisions, col="#005C53")
title(main = expression("Total PM"[2.5]*" emissions in the United States"))

# Save plot
dev.copy(png, "plot1.png", width=480, height=480)
dev.off()