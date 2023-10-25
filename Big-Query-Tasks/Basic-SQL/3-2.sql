SELECT
ven.VendorID,
ven.Name,
ven.CreditRating,
ven.ActiveFlag,
ven_con.ContactID,
ven_con.ContactTypeID,
ven_add.AddressID,
address.City

FROM `tc-da-1.adwentureworks_db.vendor` AS ven

LEFT JOIN `tc-da-1.adwentureworks_db.vendorcontact` AS ven_con
ON ven.VendorID = ven_con.VendorID

LEFT JOIN `tc-da-1.adwentureworks_db.vendoraddress` AS ven_add
ON ven.VendorID = ven_add.VendorId

LEFT JOIN `tc-da-1.adwentureworks_db.address` AS address
ON ven_add.AddressID = address.AddressID

/*Write code more clearly by writing SQL functions in CAPITAL*/
/*Aliasing is off and table refferences are incorrect*/
/*Try to stick to the same naming logic*/
/*Separate little bits of query by /n to bring some clarity into it*/
/*SELECT all columns you want from one table and only then move to the next one -> more clarity*/
/*Joining tables on incorrect key pairs*/
