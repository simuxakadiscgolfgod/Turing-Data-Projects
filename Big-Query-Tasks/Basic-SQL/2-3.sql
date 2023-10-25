SELECT
wor.WorkOrderID,
SUM(wor.ActualCost) AS Total_Actual_Cost
FROM `tc-da-1.adwentureworks_db.workorderrouting` AS wor
WHERE DATE_TRUNC(EXTRACT(DATE FROM wor.ActualStartDate), MONTH) = '2004-01-01'
GROUP BY wor.WorkOrderID
HAVING Total_Actual_Cost > 300;
