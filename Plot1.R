# Created by Lon Lieberman
# For Coursera, Course Project 2, Week 4, Exploratory Data Analysis
# Created on September 8th, 2016
# Created on a MAC OS 10.11.16 | RStudio v 0.99.902
# File name = **Plot1.R**
###############################################################################
# INSTRUCTIONS (Skip to line 41 for code)
# The overall goal of this assignment is to explore the National Emissions 
# Inventory database and see what it say about fine particulate matter 
# pollution in the United states over the 10-year period 1999–2008. 
# You may use any R package you want to support your analysis.
# 
# Questions
# 
# You must address the following questions and tasks in your 
# exploratory analysis. 
# For each question/task you will need to make a single plot. 
# Unless specified, you can use any plotting system in R to make your plot.
# 
# Have total emissions from PM2.5 decreased in the United States from 
# 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 
# emission from all sources for each of the years 1999, 2002, 2005, and 2008.
#
# Making and Submitting Plots: 
# For each plot you should:
# 
# 1) Construct the plot and save it to a PNG file.
# 2) Create a separate R code file (plot1.r)
#       that constructs the corresponding plot, 
#       i.e. code in plot1.R constructs the plot1.png plot. 
# 3) Your code file should include code for reading the data so that the plot 
#       can be fully reproduced. 
# 4) You must also include the code that creates the PNG file. 
#       Only include the code for a single plot 
#       (i.e. 𝚙𝚕𝚘𝚝𝟷.𝚁 should only include code for producing 𝚙𝚕𝚘𝚝𝟷.𝚙𝚗𝚐)
# 5) Upload the PNG file on the Assignment submission page
# 6) Copy and paste the R code from the corresponding R file into the 
#       text box at the appropriate point in the peer assessment.
###############################################################################
# Library
library(dplyr)

# Set working directory
setwd(dir = "Documents/R/Assignments/Data_Cleaning_Coursera/Week 4/
      Course Project 2/exdata-data-NEI_data/")

# Get file
NEI <- readRDS("summarySCC_pm25.rds")

# Create easier data to look at
NEI_df <- tbl_df(NEI)

# Use dplyr to sum data
emissionsSum <- NEI_df %>% 
        group_by(year) %>% 
        summarize(annualEmissions = sum(Emissions))

# Launch png and create file
png(filename = "plot1.png",
    height = 480,
    width = 480)

# Plot data
plot(emissionsSum$year, emissionsSum$annualEmissions, 
     xlab = "YEAR", 
     ylab = "Total PM 2.5 Emissions")

# Shuty graphics device off
dev.off()
