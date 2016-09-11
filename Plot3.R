# Created by Lon Lieberman
# For Coursera, Course Project 2, Week 4, Exploratory Data Analysis
# Created on September 8th, 2016
# Created on a MAC OS 10.11.16 | RStudio v 0.99.902
# File name = **Plot3.R**
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
#
# Of the four types of sources indicated by 
# the 𝚝𝚢𝚙𝚎 (point, nonpoint, onroad, nonroad) variable, which of these 
# four sources have seen decreases in emissions from 1999–2008 
# for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
#
# Use the ggplot2 plotting system to make a plot answer this question.
#
# Making and Submitting Plots: 
# For each plot you should:
# 
# 1) Construct the plot and save it to a PNG file.
# 2) Create a separate R code file (plot3.r)
#       that constructs the corresponding plot, 
#       i.e. code in plot1.R constructs the plot1.png plot. 
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
library(ggplot2)

# Set working directory
setwd(dir = "Documents/R/Assignments/Data_Cleaning_Coursera/Week 4/
      Course Project 2/exdata-data-NEI_data/")

# Get files
SUMSCC <- readRDS("summarySCC_PM25.rds")

# Create easier data to look at
SUMSCC_df  <-tbl_df(SUMSCC)

# Use dplyr to isolate Baltimore City
baltimoreCity<- SUMSCC_df %>% 
        group_by("fips") %>% 
        filter(fips == 24510)

# Use dplyr to sum each year by typr
baltimorePoints <- baltimoreCity %>% 
        group_by(type,year) %>% 
        summarize(annualEmissions = sum(Emissions))

# Launch png and create file
png(filename = "plot3.png",
    height = 480,
    width = 480)

# Plot data
ggplot(baltimorePoints, aes(year, annualEmissions)) +
        geom_point(aes(x = year, y = annualEmissions, color = type)) + 
        geom_smooth(method = lm) +
        labs(title = "Emissions by Type 1999 - 2008, Baltimore City, Maryland",
             x = "Years",
             y = "Types")
        
# Shut graphics device off
dev.off()
