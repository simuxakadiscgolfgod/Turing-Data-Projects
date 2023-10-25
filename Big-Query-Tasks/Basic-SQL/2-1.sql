SELECT																									
LocationID,																									
COUNT(DISTINCT WorkOrderID) AS Num_Work_Orders,																									
COUNT(DISTINCT ProductID) AS Num_Unique_Products,																									
SUM(ActualCost) AS Total_Actual_Cost																									
FROM `tc-da-1.adwentureworks_db.workorderrouting`																									
WHERE DATE_TRUNC(EXTRACT(DATE FROM ActualStartDate), MONTH) = '2004-01-01'																									
GROUP BY LocationID																									
ORDER BY Total_Actual_Cost DESC;
