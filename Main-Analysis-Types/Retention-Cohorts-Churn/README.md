# Retention, Cohorts & Churn
## Task Description
You got a follow up task from your product manager to give stats on how subscriptions churn looks like from a weekly retention standpoint. Your PM argues that to view retention numbers on a monthly basis takes too long and important insights from data might be missed out.

You remember learning previously that cohorts analysis can be really helpful in such cases. You should provide weekly subscriptions data that shows how many subscribers started their subscription in a particular week and how many remain active in the following 6 weeks. Your end result should show weekly retention cohorts for each week of data available in the dataset and their retention from week 0 to week 6. Assume that you are doing this analysis on 2021-02-07.

You should use turing_data_analytics.subscriptions table to answer this question. Please write a SQL that would extract data from the BigQuery, make a visualisation using Google spreadsheets and briefly comment your findings.

## Results, Conclusions & Comments
retention-data-pull.sql was used to pull out required information. Google Slides were used for visualization. Retention rates were investigated by week cohorts and then split by device type.

Retention rate by week cohorts-
![alt_text](https://github.com/simuxakadiscgolfgod/Turing-Data-Projects/blob/22ceae5df360dba90f9f42479870baf994fa749e/Main-Analysis-Types/Retention-Cohorts-Churn/retention_cohorts.png)

Retention rate by week cohorts split by device-
![alt_text](https://github.com/simuxakadiscgolfgod/Turing-Data-Projects/blob/28f4a42c5f60707e3d02f582890e917794183c6f/Main-Analysis-Types/Retention-Cohorts-Churn/retention_device.png)

