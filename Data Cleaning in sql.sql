CREATE DATABASE TEST;
USE TEST;
CREATE TABLE IF NOT EXISTS unemployment_rate_women (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Year YEAR,
    Country VARCHAR(100),
    UnemploymentRate DECIMAL(5,2),
    AgeGroup VARCHAR(50)
);
SELECT * FROM unemployment_rate_women;
#Data cleaning_Remove duplicates
DELETE u1 FROM unemployment_rate_women u1
INNER JOIN (
    SELECT MIN(id) as id, Year, Country, AgeGroup
    FROM unemployment_rate_women
    GROUP BY Year, Country, AgeGroup
    HAVING COUNT(*) > 1
) u2 ON u1.Year = u2.Year AND u1.Country = u2.Country AND u1.AgeGroup = u2.AgeGroup AND u1.id > u2.id;

#Data cleaning_Handling Missing Values
UPDATE unemployment_rate_women
SET UnemploymentRate = 0
WHERE UnemploymentRate IS NULL;

#Data cleaning_Remove missing 'UnemploymentRate' values
DELETE FROM unemployment_rate_women
WHERE UnemploymentRate IS NULL;

#Data cleaning_Correct data formats
#To convert UnemploymentRate to a proper decimal format if it wasn't already:
ALTER TABLE unemployment_rate_women
MODIFY UnemploymentRate DECIMAL(5,2);

#If Year was mistakenly imported as a string and you want to convert it to a year format:
ALTER TABLE unemployment_rate_women
MODIFY Year YEAR;

#Data cleaning_Trimming Whitespace
UPDATE unemployment_rate_women
SET Country = TRIM(Country),
    AgeGroup = TRIM(AgeGroup);
    
UPDATE unemployment_rate_women
SET Country = UPPER(Country);



