# Created by Lon Lieberman
# For Coursera, Course Project 2, Week 4, Exploratory Data Analysis
# Created on September 8th, 2016
# Created on a MAC OS 10.11.16 | RStudio v 0.99.902
# File name = **plot5.R**
###############################################################################
# INSTRUCTIONS (Skip to line 36 for code)
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
# How have emissions from motor vehicle sources changed 
# from 1999–2008 in Baltimore City?
#
# Making and Submitting Plots: 
#       For each plot you should:
# 
# 1) Construct the plot and save it to a PNG file.
# 2) Create a separate R code file (plot5.R)
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

# Set working directory
setwd(dir = "Documents/R/Assignments/Data_Cleaning_Coursera/Week 4/
      Course Project 2/exdata-data-NEI_data/")

# Get files
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

# Create easier data to look at
SCC_df  <-tbl_df(SCC)
NEI_df <- tbl_df(NEI)

# Combine SUMSSC_df & SCC_df using dplyr to create new data set
CombinedSet<- full_join(NEI_df, SCC_df, by = "SCC")
CombinedSet_df <- tbl_df(CombinedSet)

# Use dplyr to isolate emissions from coal combustion-related sources
EmissionsInBaltimore <- CombinedSet_df %>% group_by(Short.Name, EI.Sector) %>%
                        filter(fips == '24510') %>%
                        filter(grepl('Mobile', EI.Sector))
                     
# Use dplyr to sum each year
BaltimoreEmissions_SourceByYear <- EmissionsInBaltimore %>% 
         group_by(EI.Sector, year) %>% 
        summarize(annualEmissions = (sum(Emissions)))

# Launch png and create file
png(filename = "plot5.png",
    height = 600,
    width = 600)

# Plot data using base plot
plot(BaltimoreEmissions_SourceByYear$year,
        BaltimoreEmissions_SourceByYear$annualEmissions,
        col = rep(1:37, each = 10), pch = 19,
        xlab = "Year",
        ylab = "Emissions")
legend("topright", legend = paste("Emmision Type"), col = 1:37,
       pch = 19, bty ="n")

# Shut graphics device off
dev.off()
