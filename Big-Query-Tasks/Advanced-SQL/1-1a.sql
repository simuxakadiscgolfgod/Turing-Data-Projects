SELECT ind.CustomerID, con.Firstname, con.LastName,
CONCAT(con.Firstname, ' ', con.LastName) AS FullName,
CASE WHEN con.Title IS NULL THEN CONCAT('Dear ', con.Lastname) ELSE CONCAT(con.Title, ' ', con.Lastname) END AS AddressingTitle,
con.EmailAddress, con.Phone, cus.AccountNumber, cus.CustomerType,
address.City, address.AddressLine1, address.AddressLine2,
state_prov.name AS State,
country.name AS Country,
COUNT(*) AS number_orders,
ROUND(SUM(soh.TotalDue), 3) AS total_amount,
MAX(soh.OrderDate) AS date_last_order
FROM `adwentureworks_db.individual` AS ind
LEFT JOIN `adwentureworks_db.customer` AS cus
ON ind.CustomerID = cus.CustomerID
AND cus.CustomerType = 'I'
LEFT JOIN `adwentureworks_db.contact` AS con
ON ind.ContactID = con.ContactId
LEFT JOIN `adwentureworks_db.salesorderheader` AS soh
ON cus.CustomerID = soh.CustomerID
LEFT JOIN `adwentureworks_db.address` AS address
ON address.AddressID = soh.BillToAddressID
LEFT JOIN `adwentureworks_db.stateprovince` AS state_prov
ON address.StateProvinceID = state_prov.StateProvinceID
LEFT JOIN `adwentureworks_db.countryregion` AS country
ON state_prov.CountryRegionCode = country.CountryRegionCode
GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14
ORDER BY 16 DESC
LIMIT 200;
