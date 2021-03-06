# Created by Lon Lieberman
# For Coursera, Course Project 2, Week 4, Exploratory Data Analysis
# Created on September 8th, 2016
# Created on a MAC OS 10.11.16 | RStudio v 0.99.902
# File name = **plot6.R**
###############################################################################
# INSTRUCTIONS (Skip to line 37 for code)
# The overall goal of this assignment is to explore the National Emissions 
# Inventory database and see what it say about fine particulate matter 
# pollution in the United states over the 10-year period 1999–2008. 
# You may use any R package you want to support your analysis.
# 
# Questions
# 
# You must address the following questions and tasks in your 
# exploratory analysis. 
#
# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, 
# California (𝚏𝚒𝚙𝚜 == "𝟶𝟼𝟶𝟹𝟽"). Which city has seen greater changes 
# over time in motor vehicle emissions?
#
# Making and Submitting Plots: 
#       For each plot you should:
# 
# 1) Construct the plot and save it to a PNG file.
# 2) Create a separate R code file (plot6.R)
#       that constructs the corresponding plot, 
#       i.e. code in plot1.R constructs the plot1.png plot. 
#       Collate By Look Outside Net-Net 'Y' Label
# 3) Your code file should include code for reading the data so that the plot 
#       can be fully reproduced. 
# 4) You must also include the code that creates the PNG file. 
#       Only include the code for a single plot 
# 5) Upload the PNG file on the Assignment submission page
# 6) Copy and paste the R code from the corresponding R file into the 
#       text box at the appropriate point in the peer assessment.
###############################################################################
# Library
library(dplyr)

# Set wolibrary(lattice)
rking directory
setwd(dir = "Documents/R/Assignments/Data_Cleaning_Coursera/Week 4/
      Course Project 2/exdata-data-NEI_data/")

# Get files
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

# Create easier data to look at
SCC_df  <-tbl_df(SCC)
NEI_df <- tbl_df(NEI)

NEI_df
# Combine SUMSSC_df & SCC_df using dplyr to create new data set
CombinedSet<- full_join(NEI_df, SCC_df, by = "SCC")
CombinedSet_df <- tbl_df(CombinedSet)

View(CombinedSet_df)
# Use dplyr to isolate emissions from coal combustion-related sources
BaltimoreVsLaEmissions <- CombinedSet_df %>% 
        group_by(EI.Sector) %>%
        filter(fips == c('24510','06037')) %>%
        filter(grepl('Mobile', EI.Sector))

View(BaltimoreVsLaEmissions)

# Use dplyr to sum each year
BaltimoreEmissions_byCity <- BaltimoreVsLaEmissions %>% 
        group_by(EI.Sector, fips) %>% 
        summarize(annualEmissions = (sum(Emissions)))

View(BaltimoreEmissions_byCity)
# Launch png and create file
png(filename = "plot6.png",
    height = 480,
    width = 600)

xyplot(annualEmissions ~ EI.Sector | fips,
       data = BaltimoreEmissions_byCity,
       layout = c(2, 1))

# Shut graphics device off
dev.off()
