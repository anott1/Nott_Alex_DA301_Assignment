## LSE Data Analytics Online Career Accelerator 

# DA301:  Advanced Analytics for Organisational Impact

###############################################################################

# Assignment template

## Scenario
## You are a data analyst working for Turtle Games, a game manufacturer and 
## retailer. They manufacture and sell their own products, along with sourcing
## and selling products manufactured by other companies. Their product range 
## includes books, board games, video games and toys. They have a global 
## customer base and have a business objective of improving overall sales 
## performance by utilising customer trends. 

## In particular, Turtle Games wants to understand:
## - how customers accumulate loyalty points (Week 1)
## - how useful are remuneration and spending scores data (Week 2)
## - can social data (e.g. customer reviews) be used in marketing 
##     campaigns (Week 3)
## - what is the impact on sales per product (Week 4)
## - the reliability of the data (e.g. normal distribution, Skewness, Kurtosis)
##     (Week 5)
## - if there is any possible relationship(s) in sales between North America,
##     Europe, and global sales (Week 6).

################################################################################

# Week 4 assignment: EDA using R

## The sales department of Turtle games prefers R to Python. As you can perform
## data analysis in R, you will explore and prepare the data set for analysis by
## utilising basic statistics and plots. Note that you will use this data set 
## in future modules as well and it is, therefore, strongly encouraged to first
## clean the data as per provided guidelines and then save a copy of the clean 
## data for future use.

# Instructions
# 1. Load and explore the data.
##  - Remove redundant columns (Ranking, year, Genre, Publisher) by creating 
##      a subset of the data frame.
##  - Create a summary of the new data frame.
# 2. Create plots to review and determine insights into data set.
##  - Create scatterplots, histograms and boxplots to gain insights into
##      the Sales data.
##  - Note your observations and diagrams that could be used to provide
##      insights to the business.
# 3. Include your insights and observations.

###############################################################################

# 1. Load and explore the data

# Install and import Tidyverse.
library(tidyverse)

# Set working directory
setwd(dir='C:/Users/alex_/OneDrive/Documents/LSE Course 3/Assignment')

# Import the data set.
t_sales <- read.csv('turtle_sales.csv', header=TRUE)

# change all column names to lower case (to avoid column name case issues)
colnames(t_sales) <- tolower(colnames(t_sales))

# add in other_sales column Global minus (NA+EU)
library(dplyr)
t_sales <- t_sales %>% mutate(other_sales = global_sales - 
                                  (na_sales + eu_sales))
# round new other_sales column to 2 decimal places
t_sales <- t_sales %>%
  mutate(other_sales = round(other_sales, 2))

# view and explore new data frame
View(t_sales)
summary(t_sales)
head(t_sales)
dim(t_sales)
str(t_sales)

# Count unique Platforms
num_unique_items <- t_sales %>% 
  distinct(platform) %>% 
  n_distinct()

print(num_unique_items)
# 22 unique platforms

# Count unique Products
num_unique_products <- t_sales %>% 
  distinct(product) %>% 
  n_distinct()

print(num_unique_products)
# 175 unique products


# Print the data frame.
print(t_sales)

###-----------
# Observations: 
# Ranking has a huge range beyond the top 352
# Product should be converted to characters (it's not numerical)
# Year - if using year column remove 2 blank years. 
# Year range is 1982-2016
# NA and EU sales columns have a 0 as minimum. 
# Na_sales mean higher than eu_sales. 
# other_sales average mean is below eu_sales
# Wide range of 175 products and 22 platforms

###-----------


# Create a new data frame from a subset of the sales data frame.
# Remove unnecessary columns. 
t_sales2 <- select(t_sales, -ranking, -year, -genre, -publisher)

# View the data frame.
View(t_sales2)

# View the descriptive statistics.
summary(t_sales2)
dim(t_sales2)
str(t_sales2)

# Clean the data - change product to character data type
t_sales2 <- t_sales2 %>% mutate(product = as.character(product))


################################################################################

# 2. Review plots to determine insights into the data set.

## 2a) Scatterplots
# Create scatterplots.
# Which platform drives global sales?
ggplot(t_sales2, aes(global_sales, platform)) +
  geom_point(color = 'green',
             alpha = 1, size = 1.5) +
  geom_smooth(method = 'lm') +
  labs(title = 'Which platform drives global sales?')

# Which platform drives NA sales?
ggplot(t_sales2, aes(na_sales, platform)) +
  geom_point(color = 'darkorchid1',
             alpha = 1, size = 1.5) +
  geom_smooth(method = 'lm') +
  labs(title = 'Which platform drives NA Sales?')

# Which platform drives EU sales?
ggplot(t_sales2, aes(eu_sales, platform)) +
  geom_point(color = 'navy',
             alpha = 1, size = 1.5) +
  geom_smooth(method = 'lm') +
  labs(title = 'Which platform drives EU Sales?')

# Which platform drives other sales?
ggplot(t_sales2, aes(other_sales, platform)) +
  geom_point(color = 'orange',
             alpha = 1, size = 1.5) +
  geom_smooth(method = 'lm') +
  labs(title = 'Which platform drives other market Sales?')

## Observations: 
# global Sales: driven by Wii, NES, GB
# NA Sales by Wii, NES, GB, X360
# EU Sales by Wii, DS, PS3
# Other sales by Wii, PS2 GB


## 2b) Histograms
# Create histograms.

# global_sales histogram
ggplot(t_sales2, aes(global_sales)) +
  geom_histogram(fill = 'green') +
  labs(title = 'Global sales')

# na_sales histogram
ggplot(t_sales2, aes(na_sales)) +
  geom_histogram() +
  labs(title = 'NA Sales')

# eu_sales histogram
ggplot(t_sales2, aes(eu_sales)) +
  geom_histogram() +
  labs(title = 'EU Sales')

# other_sales histogram
ggplot(t_sales2, aes(other_sales)) +
  geom_histogram() +
  labs(title = 'Other Sales')


# Observations
# All sales columns have right skew (positive)
#  global sales has 2 clear peaks over 50
# NA sales has 1 clear peak
# Other has 1 clear peak
# global and EU sales have one clear outlier. 
# NA and other have several outliers
# Other has a gentler tail (indicating more diverse spread)


## 2c) Boxplots
# Create boxplots.
# global sales by platform
ggplot(t_sales2, aes(x = platform, y = global_sales)) +
  geom_boxplot(fill = 'green', 
               notch = FALSE, 
               outlier.color = 'deeppink') +
  labs(title = 'Global Sales by Platform')


# NA sales by platform
ggplot(t_sales2, aes(x = platform, y = na_sales)) +
  geom_boxplot() +
  labs(title = 'NA Sales by Platform')

# EU sales by platform
ggplot(t_sales2, aes(x = platform, y = eu_sales)) +
  geom_boxplot() +
  labs(title = 'EU Sales by Platform')

# Other sales by platform
ggplot(t_sales2, aes(x = platform, y = other_sales)) +
  geom_boxplot()  +
  labs(title = 'Other Sales by Platform')

# Observations:
# Global:  wii has several outliers, and one outlier over 60 but the 
# wii median is less than some other platforms eg SNES
# NA: wii outlier, but much longer NES upper tail NES has higher median 
# than wii
# EU: wii outlier but highest median is PS4 and huge difference in NES from 
# EU and Global
# Other: wii outlier but also has GB and PS2 outliers. Highest median is NES


## Additional visualisations

# Based on platform
ggplot(t_sales2, aes(x = platform)) +
  geom_bar(fill = 'green') +
  labs(title = 'Count of Platform')

# Observations: you would expect to see wii as the highest count based on 
# sales but actually X360, PS3 and PC are much higher. 
# Should the business concentrate on platforms that perform eg as 
# bestsellers or best median sellers?

# Based on year
ggplot(t_sales, aes(x = year)) +
  geom_bar(fill = 'green') +
  labs(title = 'Year')


# Observations: 2006 was a record year for releases. 
# Since that point releases have dropped
# Suspect the final year of data (2016) is not complete or hefty 
# reduction in releases

# Create new df for year
# Remove blank year rows
t_sales_y <- subset(t_sales, !is.na(year))
# check summary and number of rows
summary(t_sales_y)
str(t_sales_y)

# aggregate sales by year
t_sales_year <- aggregate(cbind(global_sales, na_sales, eu_sales, other_sales) ~ 
                                        year, 
                                      data = t_sales_y, FUN = sum)

# View aggregate by year
summary(t_sales_year)
str(t_sales_year)

# Change year to a date
# install lubridate
library(lubridate)

# Add new column for date (Jan 1 for each year)
t_sales_year$date <- as.Date(paste(t_sales_year$year, 1, 1, sep = '-'))

View(t_sales_year)

# view by year with global_sales
plot_gl <- ggplot(t_sales_year, aes(x = date, y = global_sales)) +
  geom_point(color = 'green',
             alpha = 1, size = 1.5) +
  geom_smooth(method = 'lm') +
  labs(title = 'Does year impact global sales?')
# View plot
print(plot_gl)

# view by year with na_sales
plot_na <- ggplot(t_sales_year, aes(x = date, y = na_sales)) +
  geom_point(color = 'darkorchid1',
             alpha = 1, size = 1.5) +
  geom_smooth(method = 'lm') +
  labs(title = 'Does year impact NA Sales?')
# View plot
print(plot_na)

  
# view by year with eu_sales
plot_eu <- ggplot(t_sales_year, aes(x = date, y = eu_sales)) +
  geom_point(color = 'navy',
             alpha = 1, size = 1.5) +
  geom_smooth(method = 'lm') +
  labs(title = 'Does year impact EU Sales?')
# View plot
print(plot_eu)

# view by year with other_sales
plot_other <- ggplot(t_sales_year, aes(x = date, y = other_sales)) +
  geom_point(color = 'orange',
             alpha = 1, size = 1.5) +
  geom_smooth(method = 'lm') +
  labs(title = 'Does year impact Other Sales?')
# View plot
print(plot_other)

# View graphs together
install.packages('gridExtra')
library(gridExtra)

# arrange plots on top of each other
grid.arrange(plot_gl, plot_na, plot_eu, plot_other, nrow = 2)
# Observations: better to see all 4 together, but hard to compare lines
# Last 2 years in all areas show sales dropping

# show all sales types on one graph by year
ggplot(t_sales_year, aes(x = date)) +
  geom_point(aes(y = `global_sales`, color = 'global_sales')) +
  geom_point(aes(y = na_sales, color = 'na_sales')) +
  geom_point(aes(y = eu_sales, color = 'eu_sales')) +
  geom_point(aes(y = `other_sales`, color = 'other_sales')) +
  geom_smooth(aes(y = `global_sales`, color = 'global_sales'), 
              method = 'lm', se = FALSE) +
  geom_smooth(aes(y = na_sales, color = 'na_sales'), 
              method = 'lm', se = FALSE) +
  geom_smooth(aes(y = eu_sales, color = 'eu_sales'), 
              method = 'lm', se = FALSE) +
  geom_smooth(aes(y = other_sales, color = 'other_sales'), 
              method = 'lm', se = FALSE) +
  labs(x = 'Date', y = 'Sales', color = 'Sales Type') +
  scale_color_manual(values = c('global_sales' = 'green', 
                                'na_sales' = 'darkorchid1', 
                                'eu_sales' = 'navy',
                                'other_sales' = 'orange')) +
  labs(title = 'Sales by year')


# show all sales types on one graph by year without smooth lines
ggplot(t_sales_year, aes(x = date)) +
  geom_point(aes(y = global_sales, color = 'global_sales')) +
  geom_point(aes(y = na_sales, color = 'na_sales')) +
  geom_point(aes(y = eu_sales, color = 'eu_sales')) +
  geom_point(aes(y = other_sales, color = 'other_sales')) +
  geom_line(aes(y = global_sales, color = 'global_sales')) +
  geom_line(aes(y = na_sales, color = 'na_sales')) +
  geom_line(aes(y = eu_sales, color = 'eu_sales')) +
  geom_line(aes(y = other_sales, color = 'other_sales')) +
  labs(x = 'Year', y = 'Sales', color = 'Sales Type') +
  scale_color_manual(values = c('global_sales' = 'green', 
                                'na_sales' = 'darkorchid1', 
                                'eu_sales' = 'navy',
                                'other_sales' = 'orange')) +
  labs(title = 'Sales by year') +
  scale_x_date(date_breaks = '3 years', date_labels = '%Y')


###############################################################################

# 3. Observations and insights

## Your observations and insights here ......
# Global sales are increasing y on year.
# NA sales are showing a slower linear regression line
# EU continuing to grow but slower than global
# indicates there are other faster growing markets to explore




###############################################################################
###############################################################################


# Week 5 assignment: Cleaning and manipulating data using R

## Utilising R, you will explore, prepare and explain the normality of the data
## set based on plots, Skewness, Kurtosis, and a Shapiro-Wilk test. Note that
## you will use this data set in future modules as well and it is, therefore, 
## strongly encouraged to first clean the data as per provided guidelines and 
## then save a copy of the clean data for future use.

## Instructions
# 1. Load and explore the data.
##  - Continue to use the data frame that you prepared in the Week 4 assignment. 
##  - View the data frame to sense-check the data set.
##  - Determine the `min`, `max` and `mean` values of all the sales data.
##  - Create a summary of the data frame.
# 2. Determine the impact on sales per product_id.
##  - Use the group_by and aggregate functions to sum the values grouped by
##      product.
##  - Create a summary of the new data frame.
# 3. Create plots to review and determine insights into the data set.
##  - Create scatterplots, histograms, and boxplots to gain insights into 
##     the Sales data.
##  - Note your observations and diagrams that could be used to provide 
##     insights to the business.
# 4. Determine the normality of the data set.
##  - Create and explore Q-Q plots for all sales data.
##  - Perform a Shapiro-Wilk test on all the sales data.
##  - Determine the Skewness and Kurtosis of all the sales data.
##  - Determine if there is any correlation between the sales data columns.
# 5. Create plots to gain insights into the sales data.
##  - Compare all the sales data (columns) for any correlation(s).
##  - Add a trend line to the plots for ease of interpretation.
# 6. Include your insights and observations.

################################################################################

# 1. Load and explore the data

# View data frame created in Week 4
View(t_sales2)

# Check output: Determine the min, max, and mean values.
head(t_sales2)

# View the descriptive statistics.
summary(t_sales2)


###############################################################################

# 2. Determine the impact on sales per product_id.

## 2a) Use the group_by and aggregate functions.

# Group data based on product and determine the sum per product.

t_sales3 <- aggregate(cbind(global_sales, na_sales, eu_sales, other_sales) ~ 
                        product, 
                      data = t_sales2, FUN = sum)

# View the data frame.
head(t_sales3)
View(t_sales3)

# Explore the data frame.
summary(t_sales3)

## 2b) Determine which plot is the best to compare game sales.
# Create scatterplot.
ggplot (data = t_sales3, 
        aes(x = product, y = global_sales)) +
  geom_point(color = 'green',
             alpha = 0.5,  
             size = 1.5) +
  labs(title = 'How does Product contribute to Global Sales?')
# Observations:
# Scatterplots show 3 outliers generating over £30m each
# one outlier over £60m

# Create a subset to reduce the number of products to top 20 for sales
# Import dplyr library
library(dplyr)

# arrange data into descending products by global_sales and create subset
t_sales3_top20 <- t_sales3 %>%
  arrange(desc(global_sales)) %>%  
  head(20)

# print subset
print(t_sales3_top20)

# create scatterplot based on top 20 subset
plot1 <- ggplot(t_sales3_top20, aes(x = product, y = global_sales)) +
  geom_point(color = 'green',
             alpha = 0.5,  
             size = 1.5) +
  labs(x = 'Global Sales', y = 'Product',
       title = 'Top 20 Products by Global Sales')
# View plot
print(plot1)

# create scatterplot based on top 20 subset for NA sales
plot2 <- ggplot(t_sales3_top20, aes(x = product, y = na_sales)) +
  geom_point(color = 'darkorchid1',
             alpha = 0.5,  
             size = 1.5) +
  labs(x = 'NA Sales', y = 'Product',
       title = 'Top 20 Products by NA Sales')
# View plot
print(plot2)

# create scatterplot based on top 20 subset for EU sales
plot3 <- ggplot(t_sales3_top20, aes(x = product, y = eu_sales)) +
  geom_point(color = 'navy',
             alpha = 0.5,  
             size = 1.5) +
  labs(x = 'EU Sales', y = 'Product',
       title = 'Top 20 Products by EU Sales')
# View plot
print(plot3)

# create scatterplot based on top 20 subset for Other sales
plot4 <- ggplot(t_sales3_top20, aes(x = product, y = other_sales)) +
  geom_point(color = 'orange',
             alpha = 0.5,  
             size = 1.5) +
  labs(x = 'Other Sales', y = 'Product',
       title = 'Top 20 Products by Other Sales')
# View plot
print(plot4)


# Create scatterplot for EU, NA, other and Global based on top 20 global products
ggplot(t_sales3_top20, aes(x = product)) +
  geom_point(aes(y = `global_sales`, color = 'global_sales')) +
  geom_point(aes(y = na_sales, color = 'na_sales')) +
  geom_point(aes(y = eu_sales, color = 'eu_sales')) +
  geom_point(aes(y = other_sales, color = 'other_sales')) +
  geom_smooth(aes(y = `global_sales`, color = 'global_sales'), 
              method = 'lm', se = FALSE) +
  geom_smooth(aes(y = na_sales, color = 'na_sales'), 
              method = 'lm', se = FALSE) +
  geom_smooth(aes(y = eu_sales, color = 'eu_sales'), 
              method = 'lm', se = FALSE) +
  geom_smooth(aes(y = other_sales, color = 'other_sales'), 
              method = 'lm', se = FALSE) +
  labs(x = 'Product', y = 'Sales', color = 'Sales Type') +
  scale_color_manual(values = c('global_sales' = 'green', 
                                'na_sales' = 'darkorchid1', 
                                'eu_sales' = 'navy',
                                'other_sales' = 'orange')) +
  labs(title = 'Top 20 Products by sales')


# Observations: for the top 20 products shows difference between 
# Global, NA and EU sales
# Product 399 is more popular in EU than NA, 515 is nearly equal
# Might better as comparison bar
# Outlier for highest sales is Product 107, then 515 and 123.

# Create bar chart to compare sales by top 20 products
# 1. Convert the data to long format
t_sales3_top20_long <- t_sales3_top20 %>%
  pivot_longer(cols = c(global_sales, eu_sales, na_sales, other_sales), 
               names_to = 'Sales_Type', values_to = 'Sales')

# 2. Create a vector of colors for each sales type
sales_colors <-  c('global_sales' = 'green', 
                   'na_sales' = 'darkorchid1', 
                   'eu_sales' = 'navy',
                   'other_sales' = 'orange')


# 3. Create the comparison bar chart
ggplot(t_sales3_top20_long, aes(x = product, y = Sales, fill = Sales_Type)) +
  geom_bar(stat = 'identity', position = position_dodge(width = 0.8)) +
  labs(x = 'Product', y = 'Sales',
       title = 'Comparison of Global, EU, NA & Other Sales by Product') +
  scale_fill_manual(values = sales_colors) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) 

# Observations:
# 107 and 515 are highest sales producers
# There is a difference between products for sales from each market
# Review as a % of global to see how the markets contribute to each product


# Show NA, EU and Other as a percentage of Global
# 1. Create new columns for NA, EU and Other as a % of Global
t_sales3_top20_pc <- t_sales3_top20 %>%
  mutate(na_sales_percentage = (na_sales / global_sales) * 100,
         eu_sales_percentage = (eu_sales / global_sales) * 100,
         other_sales_percentage = (other_sales / global_sales) * 100)

# change column names to lower
colnames(t_sales3_top20_pc) <- tolower(colnames(t_sales3_top20_pc))

# View new percentages df
View(t_sales3_top20_pc)

# 1. Convert the data to long format
t_sales3_top20_pc_long <- t_sales3_top20_pc %>%
  pivot_longer(cols = c(eu_sales_percentage, 
                        na_sales_percentage, 
                        other_sales_percentage), 
               names_to = 'sales_type', values_to = 'percent')

# 2. Create a vector of colors for each sales type
sales_colors <- c('na_sales_percentage' = 'darkorchid1', 
                  'eu_sales_percentage' = 'navy',
                  'other_sales_percentage' = 'orange')

# 3. Create the comparison bar chart
ggplot(t_sales3_top20_pc_long, aes(x = product, 
                                   y = percent, 
                                   fill = sales_type)) +
  geom_bar(stat = 'identity', 
           position = position_dodge(width = 0.8)) +
  labs(x = 'Product', y = 'Percent',
       title = 'Percentage of EU, NA and Other Sales by Product') +
  scale_fill_manual(values = sales_colors) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  

# Observations
# EU generally lower than NA except for product 399
# NA generally higher % of total (Global) sales 3 outstanding are 
# 326, 123, 254,
# Other markets 249 and 518

# Bar plots are the best to display product - by sales, market and 
# percentage of total sales.
# As the product range is wide easier to reduce to top 20 for insights.


###############################################################################


# 3. Determine the normality of the data set.

## 3a) Create Q-Q Plots
# Create Q-Q Plots.
# global sales
qqnorm(t_sales3$global_sales)
qqline(t_sales3$global_sales)

# qqplot for na_sales
qqnorm(t_sales3$na_sales)
qqline(t_sales3$na_sales)

# qqplot for eu_sales
qqnorm(t_sales3$eu_sales)
qqline(t_sales3$eu_sales)

# qqplot for other_sales
qqnorm(t_sales3$other_sales)
qqline(t_sales3$other_sales)

# Observations
# Global: there is a long tail under the expected normal line, the centre 
#  data points are on the line but the top and bottom measurements are high 
# above the line. There are outliers skewing the data
# If we remove all outliers there's not much data left to use.

# Other: least normality - the top of the plot is curving away from the line


## 3b) Perform Shapiro-Wilk test
# Install and import Moments.
install.packages('moments')
library(moments)

install.packages('BSDA')
library(BSDA)

# Perform Shapiro-Wilk test.
shapiro.test(t_sales3$global_sales)
shapiro.test(t_sales3$na_sales)
shapiro.test(t_sales3$eu_sales)
shapiro.test(t_sales3$other_sales)


# Observations
# All 4 tests have values under 0.05
# Indicates not normal distribution
# Other is the least normal distribution


## 3c) Determine Skewness and Kurtosis
# Skewness and Kurtosis.
skewness(t_sales3$global_sales)
kurtosis(t_sales3$global_sales)

skewness(t_sales3$na_sales)
kurtosis(t_sales3$na_sales)

skewness(t_sales3$eu_sales)
kurtosis(t_sales3$eu_sales)

skewness(t_sales3$other_sales)
kurtosis(t_sales3$other_sales)

# Observations:
# All have high positive skew - especially other
# All have heavy kurtosis (normal is 3) indicating heavy tails
# a long way from the expected value
# Global sales is skew 3.07, kurtosis 17.79


## 3d) Determine correlation
# Determine correlation.
cor(t_sales3$global_sales, t_sales3$eu_sales)
cor(t_sales3$global_sales, t_sales3$na_sales)
cor(t_sales3$global_sales, t_sales3$other_sales)
# Observation: Strongest correlation to Global sales is NA

# Correlate the whole dataframe
# 1. remove product column
t_sales_cor <- subset(t_sales3, select = -c(product))
head(t_sales_cor)

# correlate
cor(t_sales_cor)

# Observations: 
# NA (91.6), EU (84.9) and Other sales (72.7) are closely correlated to 
# Global sales

###############################################################################

# 4. Plot the data
# Create plots to gain insights into data.
# Choose the type of plot you think best suits the data set and what you want 
# to investigate. Explain your answer in your report.

# install psych package and library to plot correlations
install.packages('psych')
library(psych)

# View correlation plot
corPlot(t_sales_cor, cex = -1)


###############################################################################

# 5. Observations and insights
# Your observations and insights here...
# Observation: all the variables are positive but NA_sales correlates
# highest with global_sales (0.92). 
# So we can use NA sales to forecast Global sales


###############################################################################
###############################################################################

# Week 6 assignment: Making recommendations to the business using R

## The sales department wants to better understand if there is any relationship
## between North America, Europe, and global sales. Therefore, you need to
## investigate any possible relationship(s) in the sales data by creating a 
## simple and multiple linear regression model. Based on the models and your
## previous analysis (Weeks 1-5), you will then provide recommendations to 
## Turtle Games based on:
##   - Do you have confidence in the models based on goodness of fit and
##        accuracy of predictions?
##   - What would your suggestions and recommendations be to the business?
##   - If needed, how would you improve the model(s)?
##   - Explain your answers.

# Instructions
# 1. Load and explore the data.
##  - Continue to use the data frame that you prepared in the Week 5 assignment. 
# 2. Create a simple linear regression model.
##  - Determine the correlation between the sales columns.
##  - View the output.
##  - Create plots to view the linear regression.
# 3. Create a multiple linear regression model
##  - Select only the numeric columns.
##  - Determine the correlation between the sales columns.
##  - View the output.
# 4. Predict global sales based on provided values. Compare your prediction to
#      the observed value(s).
##  - na_sales_sum of 34.02 and eu_sales_sum of 23.80.
##  - na_sales_sum of 3.93 and eu_sales_sum of 1.56.
##  - na_sales_sum of 2.73 and eu_sales_sum of 0.65.
##  - na_sales_sum of 2.26 and eu_sales_sum of 0.97.
##  - na_sales_sum of 22.08 and eu_sales_sum of 0.52.
# 5. Include your insights and observations.

###############################################################################

# 1. Load and explore the data
# View data frame created in Week 5.
View(t_sales_cor)

# Determine a summary of the data frame.
summary(t_sales_cor)

###############################################################################

# 2. Create a simple linear regression model
## 2a) Determine the correlation between columns
# Create a linear regression model on the original data.
# 1. Base on original data with a year as number (created above) and remove 
  # extra date column
t_sales_num <- subset(t_sales_year, select = -c(date))

# remove row for 2016 as outlier and possibly incomplete data.
t_sales_num <- subset(t_sales_num, year != 2016)

# check the data:
head(t_sales_num)
str(t_sales_num)
View(t_sales_num)

# Find correlation
cor(t_sales_num)

# Observations
# EU sales correlates most strongly to year (85%)
# NA and EU correlate closely with global_Sales (97%)
# Year has positive correlation with global sales and is the only true
# independent variable (76%)

## 2b) Create a plot (simple linear regression)
# Basic visualisation.
plot (t_sales_num$year, t_sales_num$global_sales, 
      xlab = 'Year',
      ylab = 'Global Sales',
      main = 'Global Sales by Year')

# Fit linear regression model
model1 <- lm(global_sales~year, data = t_sales_num)

# View model
model1
# Outcome: Each year global sales should increase by £3.63m

# View model summary
summary(model1)
# Outcome:
  # P-value for year is under 0.05, so Year has significant impact 
  # on global_sales
  # R-squared of 57.4% so it explains over 50% of variability in Global Sales.
  # We need to look at other factors to add to Global Sales variability


# check residuals
plot(model1$residuals, main = 'Model 1 Residuals plot')
# Residuals show no pattern so multiple linear 
# can be applied

# Plot model1 with line of best fit
plot (t_sales_num$year, t_sales_num$global_sales, 
      xlab = 'Year',
      ylab = 'Global Sales',
      main = 'Global Sales by Year')
coefficients(model1)
abline(coefficients(model1))
# Observations the line doesn't fit the data points brilliantly. Try
# transforming data to compare models

# Transform the data using log transformation
# 1. drop all columns except year and global_sales
t_sales_gl_only <- subset(t_sales_num, select = -c(eu_sales, 
                                                   na_sales, 
                                                   other_sales))
head(t_sales_gl_only)

# 2. add new column for log_global and transform
t_sales_gl_only <- mutate(t_sales_gl_only, log_global=log(global_sales))

# 3 create new model with log_global
model2 <- lm(log_global~year, data = t_sales_gl_only)

# view summary of model 2
summary(model2)

# plot year and log_global
plot(t_sales_gl_only$year, t_sales_gl_only$log_global, 
     main = 'Log of Global Sales by Year')
abline(coefficients(model2))

# Observation:
# Model2 (log_global) model performs worse than model1.

# Predicting the next 5 and 10 years from the end of the data set
# Create a dataframe for 2016-2026
t_sales_year_forecast <- data.frame(year=2016:2026)
View(t_sales_year_forecast)

# Predict new values
predict(model1, newdata=t_sales_year_forecast)

# add the new values to forecast object
t_sales_year_forecast$global_sales_forecast <- 
  predict(model1, newdata=t_sales_year_forecast)

# View forecast
View(t_sales_year_forecast)


# find the last data point so we can annotate on graph
last_point <- tail(t_sales_year_forecast, n = 1)

# plot 10 year forecast based on year simple linear forecast
ggplot(data = t_sales_year_forecast, aes(x = year, y = global_sales_forecast)) +
  geom_line(color = 'green', size = 1.5) +
  geom_text(data = last_point, 
            aes(label = paste('£', (round(global_sales_forecast, 2)), 'million')),
            hjust = -0.2, 
            vjust = 0, 
            position = position_nudge(x = -2.5)) +  
  labs(title = '10 year Global Sales forecast based on Year', x = 'Year',
       y = 'Global Sales (Million £)')

  
###############################################################################

# 3. Create a multiple linear regression model
# Select only numeric columns from the original data frame.
str(t_sales_num)

# check correlation plot on new dataframe:
corPlot(t_sales_num, cex = -1)


# split the data into 80% for training and 20% for test
# 80% for training
train_t_sales <- t_sales_num[t_sales_num$year >= 1982 & t_sales_num$year <= 2009, ]
test_t_sales <- t_sales_num[t_sales_num$year >= 2010 & t_sales_num$year <= 2015, ]

# Multiple linear regression model.
# create new object with variables to predict global_sales
modela = lm(global_sales~year+na_sales+eu_sales+other_sales, 
            data = train_t_sales)

# View modela summary
summary(modela)
# Outcome: modela shows Adjusted R-squared of 1 - perfect fit / overfitted.

# create new object with year, na and eu variables
modelb = lm(global_sales~year+na_sales+eu_sales, 
            data = train_t_sales)

# View modelb summary
summary(modelb)
# Outcome: modelb shows Adjusted R squared of 0.99 - overfitted.

# create new object with year and NA variables
modelc = lm(global_sales~year+na_sales, 
            data = train_t_sales)

# View modelc summary
summary(modelc)
# Outcome: modelc shows Adjusted R squared of 0.97.

# create new object with year and other variables
modeld = lm(global_sales~year+other_sales, 
            data = train_t_sales)

# View modeld summary
summary(modeld)
# Outcome: modeld shows Adjusted R squared of 0.91.
# other_sales shows as highly (***) correlated
# least overfitted model

# create new object with na and eu sales
modele = lm(global_sales~na_sales+eu_sales, 
            data = train_t_sales)

# View modele summary
summary(modele)
# Outcome: modele shows Adjusted R squared of 0.99 - might be overfitted.
# na and eu sales are 3* variables




###############################################################################

# 4. Predictions based on given values
# Compare with observed values for a number of records.

# test using modelc
predictTest = predict(modelc, newdata=test_t_sales, interval='confidence')
# print the forecast sales:
predictTest

# Observations for modelc
# 2010 actual was 143.87, predicted was 155.4
# 2011 actual was 119.48, predicted was 124.45
# 2012 actual was 94.86, predicted was 96.84
# 2013 actual was 101.78, predicted was 102.84
# 2014 actual was 100.36, predicted was 97.47
# 2015 actual was 55.52, predicted was 64.57
# modelc is a better model for forecasting based on test data.
# most actuals are within confidence levels


# use predict with modeld on test data set to predict global_sales
predictTest = predict(modeld, newdata=test_t_sales, interval='confidence')

# print the forecast sales:
predictTest

# Observations for modeld
# 2010 actual was 143.87, predicted was 103.14
# 2011 actual was 119.48, predicted was 82.89
# 2012 actual was 94.86, predicted was 85.1
# 2013 actual was 101.78, predicted was 82.68
# 2014 actual was 100.36, predicted was 87.25
# 2015 actual was 55.52, predicted was 38.48

# use predict with modele on test data set to predict global_sales
predictTest = predict(modele, newdata=test_t_sales, interval='confidence')

# print the forecast sales:
predictTest

# Observations for modele
# 2010 actual was 143.87, predicted was 152.74
# 2011 actual was 119.48, predicted was 131.00
# 2012 actual was 94.86, predicted was 99.18
# 2013 actual was 101.78, predicted was 109.73
# 2014 actual was 100.36, predicted was 107.47
# 2015 actual was 55.52, predicted was 65.29

# modele most actuals are outside lower edge of confidence level

# predict global_sales based on new data using modelc
# load new data in csv
new_t_sales <- read.csv('new_t_sales.csv')
View(new_t_sales)

# test using modelc
predict = predict(modelc, newdata=new_t_sales, interval='confidence')
# print the forecast sales:
predict

# Observations:
# predicted global_sales based on new data are:
# 2016 predicted was 90.26
# 2017 predicted was 34.43
# 2018 predicted was 33.29
# 2019 predicted was 33.52
# 2020 predicted was 72.17

# Create new df for predicted data
predicted_sales <- c(90.26, 34.43, 33.29, 33.53, 72.17)
years <- c(2016, 2017, 2018, 2019, 2020)

predicted_global <- data.frame(year = years, global_sales = predicted_sales)
print(predicted_global)

# Visualise predictions alongside existing data
# Create a new object and remove all columns except global_sales
t_fc2 <- subset(t_sales_num, select = -c(eu_sales, na_sales, other_sales))

# View new object
print(t_fc2)
str(t_fc2)

# Append new predictions on new object
t_sales_fc_global <- rbind(t_fc2, predicted_global)
print(t_sales_fc_global)

# Visualise existing data with forecast
ggplot(t_sales_fc_global, aes(x = year, y = global_sales)) +
  geom_line(aes(linetype = year >= 2016, color = year >= 2016), size = 2) +
  labs(title = 'Global Sales Forecast to 2020',
       x = 'Year',
       y = 'Global Sales (£millions)') +
    scale_color_manual(values = c('TRUE' = 'deeppink', 'FALSE' = 'green')) +
    scale_linetype_manual(values = c('TRUE' = 'dashed', 'FALSE' = 'solid')) +
    scale_x_continuous(breaks = seq(min(t_sales_fc_global$year), 
                                    max(t_sales_fc_global$year), 
                                    by = 3)) + 
    theme(legend.position = 'none')
 

###############################################################################

# 5. Observations and insights
# Your observations and insights here...
# Using NA and Year to predict sales from 2016 onwards shows continued 
# downward trend.
# 2020 forecast to be £72 million (down from 2006 peak)

###############################################################################
###############################################################################



