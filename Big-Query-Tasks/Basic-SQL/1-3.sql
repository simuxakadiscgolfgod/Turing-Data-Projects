SELECT
P.ProductID,
P.Name,
P.ProductNumber,
P.Size,
P.Color,
P.ListPrice,
P.ProductSubcategoryID,
PSub.Name AS SubCategory,
PCat.Name AS Category
FROM `tc-da-1.adwentureworks_db.product` AS P
JOIN `tc-da-1.adwentureworks_db.productsubcategory` AS PSub
ON P.ProductSubcategoryID = PSub.ProductSubcategoryID
LEFT JOIN `tc-da-1.adwentureworks_db.productcategory` AS PCat
ON PSub.ProductCategoryID = PCat.ProductCategoryID
WHERE PCat.Name = 'Bikes' AND P.ListPrice > 2000 AND P.SellEndDate IS NULL
ORDER BY P.ListPrice DESC;
