WITH months AS
(SELECT DATE_TRUNC(soh.OrderDate, month) AS OrderMonth,
state_prov.CountryRegionCode,
sales_terr.Name AS Region,
COUNT(*) AS number_orders,
COUNT(DISTINCT soh.CustomerID) AS number_customers,
COUNT(DISTINCT soh.SalesPersonID) AS number_sales_persons,
ROUND(SUM(soh.TotalDue), 2) AS total_w_tax
FROM `adwentureworks_db.salesorderheader` AS soh
LEFT JOIN `adwentureworks_db.address` as address
ON soh.BillToAddressID = address.AddressID
LEFT JOIN `adwentureworks_db.stateprovince` AS state_prov
ON address.StateProvinceID = state_prov.StateProvinceID
LEFT JOIN `adwentureworks_db.salesterritory` AS sales_terr
ON state_prov.TerritoryID = sales_terr.TerritoryID
GROUP BY 1, 2, 3)

SELECT *,
ROUND(SUM(months.total_w_tax) OVER (PARTITION BY months.CountryRegionCode, months.Region ORDER BY months.OrderMonth), 2) AS cumulative_sum
FROM months;
