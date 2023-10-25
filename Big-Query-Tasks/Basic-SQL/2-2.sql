SELECT																									
wor.LocationID,																									
loc.Name AS Location,																									
COUNT(DISTINCT wor.WorkOrderID) AS Num_Work_Orders,																									
COUNT(DISTINCT wor.ProductID) AS Num_Unique_Products,																									
SUM(wor.ActualCost) AS Total_Actual_Cost,																									
ROUND(AVG(DATETIME_DIFF(wor.ActualEndDate, wor.ActualStartDate, DAY)), 2) AS Avg_Days_Diff																									
FROM `tc-da-1.adwentureworks_db.workorderrouting` AS wor																									
JOIN `tc-da-1.adwentureworks_db.location` AS loc																									
ON wor.LocationID = loc.LocationID																									
WHERE DATE_TRUNC(EXTRACT(DATE FROM wor.ActualStartDate), MONTH) = '2004-01-01'																									
GROUP BY wor.LocationID, loc.Name																									
ORDER BY Total_Actual_Cost DESC;
