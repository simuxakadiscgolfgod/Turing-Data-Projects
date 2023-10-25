# Basic querying tasks that were completed in BigQuery environment.  
## Task 1.1
You’ve been asked to extract the data on products from the Product table where there exists a product subcategory. And also include the name of the ProductSubcategory.  
Columns needed: ProductId, Name, ProductNumber, size, color, ProductSubcategoryId, Subcategory name.  
Order results by SubCategory name.  
https://github.com/simuxakadiscgolfgod/Turing-Data-Projects/blob/b7463678f18a7a9e097f7159d01896c691e68c05/Big-Query-Tasks/Basic-SQL/1-1.sql#L1-L12  
## Task 1.2
In 1.1 query you have a product subcategory but see that you could use the category name.  
Find and add the product category name.  
Afterwards order the results by Category name.  
https://github.com/simuxakadiscgolfgod/Turing-Data-Projects/blob/211755dbdb85cf68ffcf0d17135c643348101392/Big-Query-Tasks/Basic-SQL/1-2.sql#L1-L15
## Task 1.3  
Use the established query to select the most expensive (price listed over 2000) bikes that are still actively sold (does not have a sales end date).
Order the results from most to least expensive bike.
https://github.com/simuxakadiscgolfgod/Turing-Data-Projects/blob/211755dbdb85cf68ffcf0d17135c643348101392/Big-Query-Tasks/Basic-SQL/1-3.sql#L1-L17
## Task 2.1
Create an aggregated query to selec the:
Number of unique work orders.
Number of unique products.
Total actual cost.
For each location Id from the 'workoderrouting' table for orders in January 2004.
https://github.com/simuxakadiscgolfgod/Turing-Data-Projects/blob/211755dbdb85cf68ffcf0d17135c643348101392/Big-Query-Tasks/Basic-SQL/2-1.sql#L1-L9
## Task 2.2
Update your 2.1 query by adding the name of the location and also add the average days amount between actual start date and actual end date per each location.
https://github.com/simuxakadiscgolfgod/Turing-Data-Projects/blob/211755dbdb85cf68ffcf0d17135c643348101392/Big-Query-Tasks/Basic-SQL/2-2.sql#L1-L13
## Task 2.3
Select all the expensive work Orders (above 300 actual cost) that happened throught January 2004.
https://github.com/simuxakadiscgolfgod/Turing-Data-Projects/blob/211755dbdb85cf68ffcf0d17135c643348101392/Big-Query-Tasks/Basic-SQL/2-3.sql#L1-L7
## Task 3.1
Your colleague has written a query to find the highest sales connected to special offers. The query works fine but the numbers are off, investigate where the potential issue lies.
https://github.com/simuxakadiscgolfgod/Turing-Data-Projects/blob/211755dbdb85cf68ffcf0d17135c643348101392/Big-Query-Tasks/Basic-SQL/3-1.sql#L1-L21
## Task 3.2
Your colleague has written this query to collect basic Vendor information. The query does not work, look into the query and find ways to fix it. Can you provide any feedback on how to make this query be easier to debug/read?
https://github.com/simuxakadiscgolfgod/Turing-Data-Projects/blob/211755dbdb85cf68ffcf0d17135c643348101392/Big-Query-Tasks/Basic-SQL/3-2.sql#L1-L27
