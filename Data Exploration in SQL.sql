#Step 1: Create a Database

CREATE DATABASE IF NOT EXISTS EmploymentData;

#Step 2: Select the Database
USE EmploymentData;

#Step 3: Create a Table
CREATE TABLE IF NOT EXISTS WomenUnemployment (
    Year INT,
    Country VARCHAR(255),
    UnemploymentRate DECIMAL(5, 2)
);

#Step 5: Query the Data
-- Get the average unemployment rate for each country
SELECT Country, AVG(UnemploymentRate) AS AverageRate
FROM WomenUnemployment
GROUP BY Country;

-- Get the total number of records per year
SELECT Year, COUNT(*) AS TotalRecords
FROM WomenUnemployment
GROUP BY Year;

-- Get the highest unemployment rate and the corresponding country for each year
SELECT 
    wu.Year, 
    wu.Country, 
    wu.UnemploymentRate AS HighestRate
FROM 
    WomenUnemployment wu
INNER JOIN (
    SELECT 
        Year, 
        MAX(UnemploymentRate) AS MaxRate
    FROM 
        WomenUnemployment
    GROUP BY 
        Year
) AS max_rates ON wu.Year = max_rates.Year AND wu.UnemploymentRate = max_rates.MaxRate;

#Step 6: Verify Table and Data
-- Check the first few rows of the table
SELECT * FROM WomenUnemployment
LIMIT 5;

