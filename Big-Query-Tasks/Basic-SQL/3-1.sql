SELECT
sales_detail.SalesOrderID,
sales_detail.OrderQty,
sales_detail.UnitPrice,
sales_detail.LineTotal,
sales_detail.ProductID,
sales_detail.SpecialOfferID,
spec_offer_product.rowguid,
spec_offer_product.ModifiedDate,
spec_offer.Category,
spec_offer.Description
FROM `tc-da-1.adwentureworks_db.salesorderdetail` AS sales_detail
LEFT JOIN `tc-da-1.adwentureworks_db.specialofferproduct` AS spec_offer_product
ON sales_detail.ProductID = spec_offer_product.ProductID AND sales_detail.SpecialOfferID = spec_offer_product.SpecialOfferID
/*spec_offer_product table has a combined primary key of ProductID AND SpecialOfferID, you have to join on both of them*/
/*otherwise, the rows would duplicate in some cases*/
LEFT JOIN `tc-da-1.adwentureworks_db.specialoffer` AS spec_offer
ON spec_offer_product.SpecialOfferID = spec_offer.SpecialOfferID

WHERE spec_offer.Category != 'No Discount'
ORDER BY LineTotal DESC;
