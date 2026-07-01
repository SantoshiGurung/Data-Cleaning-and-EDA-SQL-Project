# Data-Cleaning-and-EDA-SQL-Project
Data Cleaning and Exploratory Data Analysis (EDA) using SQL.
Data Cleaning and Exploratory Data Analysis Project

Project Overview
This project was all about handling the messy, real-world side of data. I took a raw, unformatted dataset and walked it through a complete transformation pipeline—first cleaning up the structural inconsistencies, and then running an exploratory analysis to see what insights were actually hiding inside the data. 

Tech Stack and Key Techniques
- SQL Functions: Common Table Expressions (CTEs), Window Functions (ROW_NUMBER), String Manipulation (SUBSTRING, PARSENAME), and Conditional Logic (CASE WHEN).
- Aggregations: GROUP BY, Joins, and Subqueries.

Part 1: The Data Cleaning Process
Real data is rarely clean, so I focused on fixing the main issues that would break an analysis:
1. Fixing Dates: Converted inconsistent date strings into a standardized format so they can actually be used for time-series analysis.
2. Filling Blank Fields: Used self-joins to look up and populate missing property addresses using matching reference IDs.
3. Splitting Columns: Broke down monolithic address fields into separate columns for Address, City, and State to allow for better filtering later on.
4. Removing Duplicates: Used a CTE combined with row numbers to find and safely eliminate duplicate entries without damaging the rest of the dataset.
5. Streamlining the Schema: Dropped the original, unformatted columns that were no longer needed to keep the database organized.

Part 2: Exploratory Data Analysis (EDA)
Once the data was clean, I wrote queries to explore the dataset and find patterns. I focused on answering questions like:
- What are the overall trends and peaks in the data over time?
- Which industries, locations, or companies saw the highest activity or impact?
- How do different subsets of the data compare when grouped by specific metrics?
