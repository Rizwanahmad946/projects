#------------------------------------------------------🧠 SQL Analysis Questions for MY Project @--------------------------------------------------------------------------------

#----------------------------------------------------------creating database and use it----------------------------------------------------------------------------------------------------------------
create database jammu_and_kashmir_tourism;
use jammu_and_kashmir_tourism;

#---------------------------------------------------------create table----------------------------------------------------------------------------------------------------------
create table jammu_and_kashmir(Year int, Month varchar(40),Jammu_Domestic float, Jammu_Foreign float,
Jammu_Total int,Kashmir_Domestic int, Kashmir_Foreign int, Kashmir_Total int,Total_Tourists_in_JK int);
SELECT * FROM jammu_and_kashmir;

#-----------------------------------------------------------------analyzing the data--------------------------------------------------------------------------------------------
#What is the total number of tourists visiting Jammu & Kashmir each month?
select sum(Total_Tourists_in_JK) as total_tourest,Month from jammu_and_kashmir group by Month order by  total_tourest;  

#For each month, what percentage of the total tourists visited Jammu and what percentage visited Kashmir?
SELECT 
  SUM(Jammu_Total) AS Total_Tourists_Jammu,
  SUM(Kashmir_Total) AS Total_Tourists_Kashmir,
  ROUND(SUM(Jammu_Total) * 100.0 / SUM(Jammu_Total + Kashmir_Total), 2) AS Jammu_Percentage,
  ROUND(SUM(Kashmir_Total) * 100.0 / SUM(Jammu_Total + Kashmir_Total), 2) AS Kashmir_Percentage
FROM 
  jammu_and_kashmir;
#What is the total number and percentage of foreign vs domestic tourists for the full year?
select sum(Jammu_Foreign) as total_foreign,sum(Kashmir_Foreign) as total_foreign_k,
  ROUND(SUM(Jammu_Foreign) * 100.0 / SUM(Jammu_Foreign + Kashmir_Foreign), 2) AS Jammu_Percentage,
  ROUND(SUM(Kashmir_Foreign) * 100.0 / SUM(Jammu_Foreign + Kashmir_Foreign), 2) AS Kashmir_Percentage
FROM 
  jammu_and_kashmir;

#🔹 3. Year-wise Total Tourists in J&K

SELECT 
  Year,
  SUM(Total_Tourists_in_JK) AS Yearly_Total
FROM 
  jammu_and_kashmir
GROUP BY 
  Year
ORDER BY 
  Year;

#🔹 4. Foreign Tourist Share (Jammu vs Kashmir)

SELECT 
  ROUND(SUM(Jammu_Foreign) * 100.0 / SUM(Jammu_Total), 2) AS Jammu_Foreign_Percent,
  ROUND(SUM(Kashmir_Foreign) * 100.0 / SUM(Kashmir_Total), 2) AS Kashmir_Foreign_Percent
FROM 
  jammu_and_kashmir;

#🔹 5. Month with the Highest Tourism in Each Year
SELECT 
  Year, 
  Month, 
  Total_Tourists_in_JK
FROM 
  jammu_and_kashmir jt
WHERE 
  Total_Tourists_in_JK = (
    SELECT MAX(Total_Tourists_in_JK)
    FROM jammu_and_kashmir jt2
    WHERE jt2.Year = jt.Year
  );