-- DATA CLEANING & EXPLORATORY DATA ANALYSIS (EDA) PROJECT
-- Tool Used: MySQL Workbench
-- ------------------------------------------------------------------------------------------
-- PART 1: DATA CLEANING
-- ------------------------------------------------------------------------------------------

-- Step 1: Create a staging table to work on (keeps the raw data safe)
CREATE TABLE layoffs_staging 
LIKE layoffs;

INSERT INTO layoffs_staging
SELECT * FROM layoffs;


-- Step 2: Identify and Remove Duplicates
WITH duplicate_cte AS (
    SELECT *,
    ROW_NUMBER() OVER(
        PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions
    ) AS row_num
    FROM layoffs_staging
)
SELECT * FROM duplicate_cte 
WHERE row_num > 1;


-- Step 3: Standardizing Data (Fixing text inconsistencies and blank spaces)
UPDATE layoffs_staging
SET company = TRIM(company);

UPDATE layoffs_staging
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';


-- Step 4: Fixing Date Formats (Converting string format to standard YYYY-MM-DD)
UPDATE layoffs_staging
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging
MODIFY COLUMN `date` DATE;


-- Step 5: Handling Null and Blank Values
UPDATE layoffs_staging
SET industry = NULL
WHERE industry = '';


-- Step 6: Dropping Unnecessary Columns and Rows
DELETE FROM layoffs_staging
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL;

-- ------------------------------------------------------------------------------------------
-- PART 2: EXPLORATORY DATA ANALYSIS (EDA)
-- ------------------------------------------------------------------------------------------

-- Query 1: Finding the maximum layoffs and percentage in a single day
SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging;


-- Query 2: Companies with the absolute highest total layoffs, ordered descending
SELECT company, SUM(total_laid_off)
FROM layoffs_staging
GROUP BY company
ORDER BY 2 DESC;


-- Query 3: Total layoffs grouped by Industry to see which sectors were hit hardest
SELECT industry, SUM(total_laid_off)
FROM layoffs_staging
GROUP BY industry
ORDER BY 2 DESC;


-- Query 4: Progression of layoffs over time (Rolling Total by Month)
WITH Rolling_Total_CTE AS (
    SELECT SUBSTRING(`date`, 1, 7) AS `MONTH`, SUM(total_laid_off) AS total_off
    FROM layoffs_staging
    WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
    GROUP BY `MONTH`
    ORDER BY 1 ASC
)
SELECT `MONTH`, total_off,
SUM(total_off) OVER(ORDER BY `MONTH`) AS rolling_total
FROM Rolling_Total_CTE;
