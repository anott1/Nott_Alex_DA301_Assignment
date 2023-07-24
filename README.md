# Course 3 Assignment for LSE Data Analytics Course (Turtle Games)
July 2023
Alex Nott
# Summary
Data Analysis for Turtle Games Sales and Marketing

# Description
Data analysis prepared for Sales & Marketing teams at Turtle Games July 2023. 
Analysis looks at:
Two data files supplied (product id appears in both, but not clear if it's the same time period so files are not joined.
Data period covers games released 1982-2016
- Reviews - includes review data, age, remuneration, loyalty_points and spending_score
- Sales - includes North America, EU and global sales, along with product, year of release and platform. Other_sales column created by the difference between global sales and EU + NA sales.

# Repository includes 
- R script for sales analysis (Sales data)
- Python scripts in Jupyter notebook format for marketing analysis (review data)
- technical report
- link to video presentation for Turtle Games assignment
- powerpoint version of presentation
- summary of weekly insights and observations in README (below)

# Installation
Rstudio for R script and Jupyter Notebook for Python

# Presentation video
https://www.youtube.com/watch?v=oe_T7y8bdxM 

# Week 1 Insights & Observations
There is no missing data
The age range is 17-72 (reviews from kids are not included, but it seems products are bought for kids). Average age is 39.5. We will explore age as a factor in loyalty points.
Spending score range is 1-99, with the mean at 50. Based on metadata spending score is based on spend (as are loyalty points). Spending points are not an independent variable to use to predict loyalty points.
Loyalty points range from 25 (very low, but might be new customers) to 6847 - it’s a very wide range. Average is 1578. Quite a low average indicating there are only a few high outliers.
Remuneration ranges from £12-112k, with mean at £48k.

Spending score and remuneration plotted with loyalty points as dependent variable both show heteroscedasticity.

For every £1k increase in remuneration there is a 34 unit increase in loyalty points
For every 1 unit increase in spending score there is a 33 unit increase in loyalty points.
For every 1 year increase in age there is a -4.2 reduction in loyalty points. Older market is less loyal.

Education and gender (converted to numerical variables) show less impact on loyalty points than other factors. VIF shows no multicollinarity.
Multiple linear regression based on age and remuneration show 38% of variation in loyalty points can be explained by age and remuneration.

# Week 2 Insights & Observations
Based on remuneration impact on loyalty points used elbow, silhouette and dendrogram methods to work out the best cluster (indicated 3-5 clusters). 

Three clusters chosen as it splits the data into the most even groups, and there’s enough clarity between groups.

Range of remuneration for group 1 remuneration (optimal group for loyalty points) is £56-£112k. Note this is above the mean for remuneration, but assumed this is acceptable as we want to target a subset of customers for optimal marketing returns in loyalty.


# Week 3 Insights & Observations
Reviewed frequency distribution of words and sentiment and subjectivity for reviews and summary separately and together (for comparisons), as well as for a subset for the selected remuneration group.
Merged summary and review gives more data and a benchmark of 0.22 sentiment and 0.45 subjectivity.
Subset shows 0.24 sentiment (target customers are happier with product than whole group).

Frequency distribution of words shows ‘game’ above ‘book’ - indicating product preferences. (This might also indicate a bias in the data eg more gamers reviewing than book buyers).

Future exploration could include subsetting by age or gender, and using reviews by product to review sentiment towards particular products.

# Week 4 Insights & Observations
There are 175 unique products across 22 unique platforms - very wide range of products and platforms. Assume there is a cost to support a wide range and therefore profits could be increased by focusing support for key products in certain markets.

Sales data ranges from 1982-2016, however 2016 data is low and indicates incomplete data.

There are 2 blank years (remove these when using year based analysis).

NA_sales has a higher mean than EU_sales and other_sales.

By platform wii drives the most sales, but there are less wii products than other platforms. Wii has a lower median sale than other platforms eg SNES.

All sales markets have a positive skew with outliers, and heavy kurtosis.

2006 was a record year for sales, and since that point it has been dropping steadily (note this might be skewed by the Year representing Year of Release not year of sale).


# Week 5 Insights & Observations
Product scatterplot shows 3 outlier products generating over £30m sales, one of which (product 107) generates over £60m sales.

When we reduce products to just the top 20 we can see outside product 107 (the outlier) different products sell better in different markets.

When each markets sales plotted as a percentage of global_sales we see different products sales by market eg
 EU generally lower than NA except for product 399
NA generally higher percentage of total (Global) sales 3 outstanding are  326, 123, 254,
Other markets 249 and 518 are forming majority of the sales.

The data sets are not normal distribution Global sales is skew 3.07, kurtosis 17.79.

NA, EU and other sales all correlate closely with global_sales (as expected as they are not independent variables). NA has the highest correlation (and makes up the biggest percentage of global_sales.


# Week 6 Insights & Observations
Using Year as the only independent variable a simple linear regression model forecasts an increase of £3.63m per year, and Year explains 57.4% of variability in global_sales.  Residuals have no pattern (so linear regression can be used).

Based on this we can predict sales in 2026 at £156.21m. Note this doesn’t take into account pandemic and is purely forecasted based on year of release, so if expected number of products not released than forecast would be affected.

Multiple linear regression based on year with NA_sales is found to be most accurate model using test and train data (split using data from the provided dataset). Based on this the sales forecast for 2020 is £72.17 million (still on downward slope from 2006 sales).


# Credits
Included additional games industry data from:
GWI report: https://www.gwi.com/reports/the-gaming-playbook
Mordor: https://www.mordorintelligence.com/industry-reports/global-gaming-market

# Feedback
All feedback and questions welcome:
https://forms.gle/k79xgdk77GYDCrNp7

# Contact
alexnott@gmail.com

# Licenses
Copyright (c) [2023] [Alex Nott]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
