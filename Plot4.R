# Created by Lon Lieberman
# For Coursera, Course Project 2, Week 4, Exploratory Data Analysis
# Created on September 8th, 2016
# Created on a MAC OS 10.11.16 | RStudio v 0.99.902
# File name = **Plot4.R**
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
# Across the United States, how have emissions from coal 
# combustion-related sources changed from 1999–2008?
#
# Making and Submitting Plots: 
# For each plot you should:
# 
# 1) Construct the plot and save it to a PNG file.
# 2) Create a separate R code file (Plot4.R)
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
SUMSCC <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Create easier data to look at
SUMSCC_df  <-tbl_df(SUMSCC)
SCC_df <- tbl_df(SCC)

# Combine SUMSSC_df & SCC_df using dplyr to create new data set
CombinedSet<- full_join(SUMSCC_df, SCC_df, by = "SCC")
CombinedSet_df <- tbl_df(CombinedSet)

# Use dplyr to isolate emissions from coal combustion-related sources
CombustionByCoal <- CombinedSet_df %>% select(SCC.Level.One, 
                                                     SCC.Level.Three,
                                                     year,
                                                     Emissions) %>%
                                filter(grepl('Combustion', SCC.Level.One)) %>%
                                filter(grepl('Coal', SCC.Level.Three))

# Use dplyr to sum each year
CoalCombustionByYear <- CombustionByCoal %>% 
        group_by(year) %>% 
        summarize(annualEmissions = sum(Emissions))

# Launch png and create file
png(filename = "plot4.png",
    height = 480,
    width = 480)

# Plot data using base plot
plot(CoalCombustionByYear$year, CoalCombustionByYear$annualEmissions, 
     xlab = "YEAR", 
     ylab = "Total Coal Emissions")

# Shut graphics device off
dev.off()
