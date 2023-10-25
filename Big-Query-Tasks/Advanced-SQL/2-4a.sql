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
GROUP BY 1, 2, 3),

/*CTE with taxrates per country*/
tax_rates AS
(SELECT CountryRegionCode, ROUND(AVG(TaxRate), 1) AS mean_tax_rate
FROM `adwentureworks_db.salestaxrate` AS sales_tax
LEFT JOIN `adwentureworks_db.stateprovince` AS state_prov
ON state_prov.StateProvinceID = sales_tax.StateProvinceID
GROUP BY 1),

/*CTE with total number of regions per country*/
num_regions AS
(SELECT CountryRegionCode, COUNT(*) AS total_num_regions
FROM `adwentureworks_db.stateprovince` AS state_prov
LEFT JOIN `adwentureworks_db.salestaxrate` AS sales_tax
ON state_prov.StateProvinceID = sales_tax.StateProvinceID
GROUP BY 1),

/*CTE with number of regions with no tax info per country*/
num_regions_no AS
(SELECT CountryRegionCode, COUNT(*) AS num_tax_no
FROM `adwentureworks_db.stateprovince` AS state_prov
LEFT JOIN `adwentureworks_db.salestaxrate` AS sales_tax
ON state_prov.StateProvinceID = sales_tax.StateProvinceID
WHERE sales_tax.TaxRate IS NULL
GROUP BY 1),

/*CTE with percentage of provinces with tax rate info per country*/
perc_provinces AS
(SELECT num_regions.CountryRegionCode, num_regions.total_num_regions, COALESCE(num_regions_no.num_tax_no, 0) AS num_tax_no,
num_regions.total_num_regions - COALESCE(num_regions_no.num_tax_no, 0) AS num_tax_yes,
ROUND((num_regions.total_num_regions - COALESCE(num_regions_no.num_tax_no, 0)) / num_regions.total_num_regions, 2) AS perc_provinces_w_tax
FROM num_regions
LEFT JOIN num_regions_no
ON num_regions.CountryRegionCode = num_regions_no.CountryRegionCode)

SELECT months.*,
DENSE_RANK() OVER (PARTITION BY months.CountryRegionCode, months.Region ORDER BY months.total_w_tax DESC) AS country_sales_rank,
ROUND(SUM(months.total_w_tax) OVER (PARTITION BY months.CountryRegionCode, months.Region ORDER BY months.OrderMonth), 2) AS cumulative_sum,
tax_rates.mean_tax_rate,
perc_provinces.perc_provinces_w_tax
FROM months
LEFT JOIN tax_rates
ON tax_rates.CountryRegionCode = months.CountryRegionCode
LEFT JOIN perc_provinces
ON perc_provinces.CountryRegionCode = months.CountryRegionCode
ORDER BY months.Region, country_sales_rank;
