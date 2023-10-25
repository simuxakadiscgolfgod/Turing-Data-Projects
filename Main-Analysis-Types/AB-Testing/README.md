# A/B testing task
## Task Requirements
You should prepare SQL query which would pull all data needed and similarly as before estimate if different variants of marketing campaigns (V1 vs V2) for both “NewYear” and “BlackFriday” campaigns had significantly better clickthrough rates (estimated as: number of users who clicked on campaign / number of impressions).
For now you can ignore timing of user tracking data, you do not need to check if those sessions were recorded when the marketing campaign was running.
Run the A/B testing on the results from your query.
You can use Binomial A/B test Calculator.
Add visualizations to help illustrate A/B testing results.

## Results & Conclusions
### New Year Campaign
Null hypothesis: There is no significant difference between NewYear_V1 and NewYear_V2 conversion rates.  
Alternative hypothesis: There is a significant difference between NewYear_V1 and NewYear_V2 conversion rates.  
Our calculated p-value <0.01, therefore we can reject the null hypothesis with 99% confidence, which means that out of 100 samples from each distribution only 1 will be a false positive.
![alt-text](https://github.com/simuxakadiscgolfgod/Turing-Data-Projects/blob/dca6f1701ea1fe12dc62aedc1f07913625fd6e4f/Main-Analysis-Types/AB-Testing/newyear_abtest.png)

### Black Friday Campaign
Null hypothesis: There is no significant difference between BlackFriday_V1 and BlackFirday_V2 conversion rates.  
Alternative hypothesis: There is a significant difference between BlackFriday_V1 and BlackFriday_V2 conversion rates.  
Our calculated p-value >0.05, therefore we fail to reject the null hypothesis with 95% confidence, which means that out of 100 samples from each distribution more than 5 will be a false positive.
![alt-text](https://github.com/simuxakadiscgolfgod/Turing-Data-Projects/blob/dca6f1701ea1fe12dc62aedc1f07913625fd6e4f/Main-Analysis-Types/AB-Testing/blackfriday_abtest.png)
