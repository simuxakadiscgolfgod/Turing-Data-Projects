# Customer Lifetime Value Calculation
## Task Requirements
1. As the first step you should write 1 or 2 queries to pull data of weekly revenue divided by registrations. Since in this particular site there is no concept of registration, we will simply use the first visit to our website as registration date (registration cohort). Do not forget to use user_pseudo_id to distinguish between users. Then divide revenue in consequent weeks by the number of weekly registration numbers.
2. Next you will produce the same chart, but the revenue / registrations for a particular week cohort will be expressed as a cumulative sum. Down below you will calculate averages for all week numbers (weeks since registration). Down below that you will calculate percentage growth, which will be based on those average numbers.
3. Next, you will focus on the future and try to predict the missing data. In this case missing data is the revenue we should expect from later acquired user cohorts.

## Results & Conclusions
The average purchase per customer is decreasing throughout almost each sequential week. The average purchase decreases more than 40 times throughout 12 weeks. Meaning that the more time passes, the less revenue we can expect from each cohort. Also there is a noticable decrease in spending around Christmas/NewYear period.
![alt-text](https://github.com/simuxakadiscgolfgod/Turing-Data-Projects/blob/6f8780df1fe449e2b0c4bafb9ab7ddd274969bbe/Main-Analysis-Types/Customer-Lifetime-Value/clv_1.png)

The cumulative growth also suggests that the biggest increase in revenue happens in the first weeks after customer's "registration".
![alt-text](https://github.com/simuxakadiscgolfgod/Turing-Data-Projects/blob/6f8780df1fe449e2b0c4bafb9ab7ddd274969bbe/Main-Analysis-Types/Customer-Lifetime-Value/clv_2.png)

The estitmated customer's lifetime (in this scenario its 12 weeks) value is $1.4708. This puts all customers into equation, even those who did not make any purchases. This gives a much more realistic metric than, for example accounting for customers, who only made purchases. If, for example, the CAC is $1, then we could estimate that we would make around $0.50 of profit per customer in 12 week period.
![alt-text](https://github.com/simuxakadiscgolfgod/Turing-Data-Projects/blob/6f8780df1fe449e2b0c4bafb9ab7ddd274969bbe/Main-Analysis-Types/Customer-Lifetime-Value/clv_3.png)


