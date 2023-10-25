SELECT
P.ProductID,
P.Name,
P.ProductNumber,
P.Size,
P.Color,
P.ProductSubcategoryID,
PSub.Name AS SubCategory
FROM `tc-da-1.adwentureworks_db.product` AS P
JOIN `tc-da-1.adwentureworks_db.productsubcategory` AS PSub
ON P.ProductSubcategoryID = PSub.ProductSubcategoryID
ORDER BY SubCategory;
