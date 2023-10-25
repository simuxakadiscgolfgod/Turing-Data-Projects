# Advanced querying tasks that were completed in BigQuery environment.
## Task 1.1
You’ve been tasked to create a detailed overview of all individual customers (these are defined by customerType = ‘I’ and/or stored in an individual table). Write a query that provides:  
Identity information : CustomerId, Firstname, Last Name, FullName (First Name & Last Name).  
An Extra column called addressing_title i.e. (Mr. Achong), if the title is missing - Dear Achong.  
Contact information : Email, phone, account number, CustomerType.  
Location information : City, State & Country, address.  
Sales: number of orders, total amount (with Tax), date of the last order.  
Copy only the top 200 rows from your written select ordered by total amount (with tax).  
https://github.com/simuxakadiscgolfgod/Turing-Data-Projects/blob/3873f257311ad4a6e02f1094eb89b592da0628f3/Big-Query-Tasks/Advanced-SQL/1-1a.sql#L1-L27
## Task 1.2
Business finds the original query valuable to analyze customers and now want to get the data from the first query for the top 200 customers with the highest total amount (with tax) who have not ordered for the last 365 days. How would you identify this segment?  
https://github.com/simuxakadiscgolfgod/Turing-Data-Projects/blob/3873f257311ad4a6e02f1094eb89b592da0628f3/Big-Query-Tasks/Advanced-SQL/1-2a.sql#L1-L32
## Task 1.3
Enrich your original 1.1 SELECT by creating a new column in the view that marks active & inactive customers based on whether they have ordered anything during the last 365 days.
https://github.com/simuxakadiscgolfgod/Turing-Data-Projects/blob/3873f257311ad4a6e02f1094eb89b592da0628f3/Big-Query-Tasks/Advanced-SQL/1-3a.sql#L1-L34
## Task 1.4
Business would like to extract data on all active customers from North America. Only customers that have either ordered 2500 in total amount (with Tax) or ordered 5 + times should be presented.
Order the output by country, state and date_last_order.
https://github.com/simuxakadiscgolfgod/Turing-Data-Projects/blob/3873f257311ad4a6e02f1094eb89b592da0628f3/Big-Query-Tasks/Advanced-SQL/1-4a.sql#L1-L37
## Task 2.1
Create a query of monthly sales numbers in each Country & region. Include in the query a number of orders, customers and sales persons in each month with a total amount with tax earned. Sales numbers from all types of customers are required.
https://github.com/simuxakadiscgolfgod/Turing-Data-Projects/blob/3873f257311ad4a6e02f1094eb89b592da0628f3/Big-Query-Tasks/Advanced-SQL/2-1a.sql#L1-L15
## Task 2.2
Enrich 2.1 query with the cumulative_sum of the total amount with tax earned per country & region.
https://github.com/simuxakadiscgolfgod/Turing-Data-Projects/blob/3873f257311ad4a6e02f1094eb89b592da0628f3/Big-Query-Tasks/Advanced-SQL/2-2a.sql#L1-L20
## Task 2.3
Enrich 2.2 query by adding ‘sales_rank’ column that ranks rows from best to worst for each country based on total amount with tax earned each month. I.e. the month where the (US, Southwest) region made the highest total amount with tax earned will be ranked 1 for that region and vice versa.
https://github.com/simuxakadiscgolfgod/Turing-Data-Projects/blob/3873f257311ad4a6e02f1094eb89b592da0628f3/Big-Query-Tasks/Advanced-SQL/2-3a.sql#L1-L22
## Task 2.4
Enrich 2.3 query by adding taxes on a country level:
As taxes can vary in country based on province, the needed column is ‘mean_tax_rate’ -> average tax rate in a country.
Also, as not all regions have data on taxes, you also want to be transparent and show the ‘perc_provinces_w_tax’ -> a column representing the percentage of provinces with available tax rates for each country (i.e. If US has 53 provinces, and 10 of them have tax rates, then for US it should show 0,19).
https://github.com/simuxakadiscgolfgod/Turing-Data-Projects/blob/3873f257311ad4a6e02f1094eb89b592da0628f3/Big-Query-Tasks/Advanced-SQL/2-4a.sql#L1-L62
