use sustainable_fashion_db;
show tables;


#Exploratory Data Analysis (EDA) & SQL Queries for Sustainable Fashion Dataset
# Step 1: Understand the Dataset Structure
#1.Checking table schema
desc sustainable_fashion;

#2.View sample data
select * from sustainable_fashion limit 5;

#3.Check the number of rows
select count(*) from sustainable_fashion;

desc sustainable_fashion;
#Step 2. HANDLING MISSING VALUES
select count(*) as missing_values 
from sustainable_fashion where Brand_ID is null;
select count(*) as missing_values 
from sustainable_fashion where Brand_Name is null;
select count(*) as missing_values 
from sustainable_fashion where Country is null;
select count(*) as missing_values 
from sustainable_fashion where Year is null;
select count(*) as missing_values 
from sustainable_fashion where Sustainability_Rating is null;
select count(*) as missing_values 
from sustainable_fashion where Material_Type is null;
select count(*) as missing_values 
from sustainable_fashion where Eco_Friendly_Manufacturing is null;
select count(*) as missing_values 
from sustainable_fashion where Carbon_Footprint_MT is null;

SELECT 
    SUM(CASE WHEN Brand_ID IS NULL THEN 1 ELSE 0 END) AS Brand_ID_Missing,
    SUM(CASE WHEN Brand_Name IS NULL THEN 1 ELSE 0 END) AS Brand_Name_Missing,
    SUM(CASE WHEN Country IS NULL THEN 1 ELSE 0 END) AS Country_Missing
FROM sustainable_fashion;


#Step 4: SUMMARY STATISTICS
#Min,Max,Aveage Carbon Footprint
SELECT 
    MIN(Carbon_Footprint_MT) AS Min_Carbon,
    MAX(Carbon_Footprint_MT) AS Max_Carbon,
    AVG(Carbon_Footprint_MT) AS Avg_Carbon
FROM sustainable_fashion;

#Distribution of Sustainability Ratings
select Sustainability_Rating, count(*)
from sustainable_fashion
group by Sustainability_Rating
order by count(*) desc;

#Most common material types
select Material_Type,count(*)
from sustainable_fashion
group by Material_Type
order by count(*) desc
limit 5;

#Step 5: ADVANCE ANALYSIS
#top 5  countries by Average price
SELECT Country, AVG(Average_Price_USD) AS Avg_Price
FROM sustainable_fashion
GROUP BY Country
ORDER BY Avg_Price DESC
LIMIT 5;

#Yearly trend in Carbon Footprint
select Year, avg(Carbon_Footprint_MT) as Avg_Carbon_Footprint
from sustainable_fashion
group by Year
order by Year;

#Brands with Highest Sustainability Ratings
SELECT Brand_Name, Sustainability_Rating, Carbon_Footprint_MT 
FROM sustainable_fashion
WHERE Sustainability_Rating = 'A'
ORDER BY Carbon_Footprint_MT ASC
LIMIT 10;

#Percentage of Brands Using Recycling Programs
select
(sum(case when Recycling_Programs= 'Yes' then 1 else 0 end)*100.0)/
count(*) as Recycling_Percentage
from sustainable_fashion;

#Which material has the lowest carbon footprint
SELECT Material_Type, AVG(Carbon_Footprint_MT) AS Avg_Carbon
FROM sustainable_fashion
GROUP BY Material_Type
ORDER BY Avg_Carbon ASC
LIMIT 1;

#Step 6 TREND ANALYSIS
#Growth of Eco-Friendly Manufacturing over the years
select Year, count(*) as Eco_Friendly_Brands
from sustainable_fashion
where Eco_Friendly_Manufacturing = 'Yes'
group by Year
order by Year;


#Market Trend Distribution
select Market_Trend,count(*)
from sustainable_fashion
group by Market_Trend;

#Certifications Analysis
select Certifications, count(*)
from sustainable_fashion
group by Certifications
order by count(*) desc
limit 5;


#Identifying the Most Sustainable Brands (Top Ratings & Low Carbon Footprint)
SELECT Brand_Name, Country, Sustainability_Rating, Carbon_Footprint_MT
FROM sustainable_fashion
WHERE Sustainability_Rating = 'A'
ORDER BY Carbon_Footprint_MT ASC
LIMIT 10;

 #Trend Analysis: Average Carbon Footprint Over the Years
 SELECT Year, 
       AVG(Carbon_Footprint_MT) AS Avg_Carbon_Footprint
FROM sustainable_fashion
GROUP BY Year
ORDER BY Year ASC;


#Which Material Types Are Most Common
SELECT Material_Type, COUNT(*) AS Material_Count
FROM sustainable_fashion
GROUP BY Material_Type
ORDER BY Material_Count DESC
LIMIT 5;

#Top 5 Countries by Sustainability Rating (Proportion of "A" Rated Brands)
SELECT Country, 
       COUNT(*) AS Total_Brands,
       SUM(CASE WHEN Sustainability_Rating = 'A' THEN 1 ELSE 0 END) AS A_Rated_Brands,
       (SUM(CASE WHEN Sustainability_Rating = 'A' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS A_Rating_Percentage
FROM sustainable_fashion
GROUP BY Country
HAVING COUNT(*) > 10  -- Ensures we only analyze countries with a significant number of brands
ORDER BY A_Rating_Percentage DESC
LIMIT 5;

 #Does Higher Product Diversity (More Product Lines) Lead to More Waste?
SELECT 
    CASE 
        WHEN Product_Lines <= 5 THEN 'Low (0-5)'
        WHEN Product_Lines BETWEEN 6 AND 15 THEN 'Medium (6-15)'
        ELSE 'High (16+)' 
    END AS Product_Line_Category,
    AVG(Waste_Production_KG) AS Avg_Waste_Production
FROM sustainable_fashion
GROUP BY Product_Line_Category
ORDER BY Avg_Waste_Production DESC;

#Comparing Sustainability Between the USA and Europe

SELECT 
    CASE 
        WHEN Country IN ('USA', 'United States', 'Canada') THEN 'North America'
        WHEN Country IN ('UK', 'Germany', 'France', 'Italy', 'Spain', 'Netherlands', 'Sweden', 'Denmark', 'Norway') THEN 'Europe'
        ELSE 'Other' 
    END AS Region,
    COUNT(*) AS Total_Brands,
    AVG(CASE 
            WHEN Sustainability_Rating = 'A' THEN 4
            WHEN Sustainability_Rating = 'B' THEN 3
            WHEN Sustainability_Rating = 'C' THEN 2
            WHEN Sustainability_Rating = 'D' THEN 1
        END) AS Avg_Sustainability_Score,
    AVG(Carbon_Footprint_MT) AS Avg_Carbon_Footprint,
    (SUM(CASE WHEN Recycling_Programs = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS Recycling_Adoption_Rate
FROM sustainable_fashion
WHERE Country IN ('USA', 'United States', 'Canada', 'UK', 'Germany', 'France', 'Italy', 'Spain', 'Netherlands', 'Sweden', 'Denmark', 'Norway')
GROUP BY Region;
















