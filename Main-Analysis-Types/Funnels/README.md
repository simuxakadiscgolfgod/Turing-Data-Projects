# Funnel Analysis
## Task Description
1. Analyze the data in raw_events table. Spend time querying the table, getting more familiar with data. Identify events captured by users visiting the website.
2. Now that you have your unique events table create a sales funnel chart from events in it. Not all events are relevant, productive to be used in this chart. Identify & collect data that you think could be used.
* Use between 4 to 6 types of events in this analysis.
* Create a funnel chart with a country split. Business is interested in the differences between top 3 countries in the funnel chart.
* Top countries are decided by their overall number of events.
* Provide insights if any found.
* See if you can come up with any other ideas/slices for funnel analysis that could be worth a look.
## Results & Comments
funnel-data-pull.sql was used to pull out required information. Google Slides were used for visualization. Funnels were created for top 3 countries by customer count, devices and campaigns.
Top 3 countries significantly differs only in the number of engaging customers. The percentages of customer drop off throughout the events are more or less the same despite different countries -
![alt-text](https://github.com/simuxakadiscgolfgod/Turing-Data-Projects/blob/80a4442d73c265144368629245f6c51497fa7957/Main-Analysis-Types/Funnels/funnel_countries.png)  
Device usage also significantly differs only in the number of engaging customers. The percentages of customer drop off throughout the events are more or less the same despite different devices -
![alt-text](https://github.com/simuxakadiscgolfgod/Turing-Data-Projects/blob/80a4442d73c265144368629245f6c51497fa7957/Main-Analysis-Types/Funnels/funnel_device.png)  
Top 3 campaign by customer count differ significantly not only in the customer amount, but also by drop off percentages. The biggest cut off stage by customer amount is from page_view to scroll step. We can see that 76% customers who came to the site without campaign did that step. Thats a huge difference from customer groups who came through 'organic' and 'direct' campaigns and did that step to proceed scrolling with 26% and 31% respectively. Only 'referral' campaign has had bigger customer retention percentage in this step with 83%, compared to no campaign with 76%. The difference in this step percentages ultimately led to higher purchase percentage in 'referal' (4.48%) than in no campaign (2.55%), and the smaller purchase percentages in 'organic' (0.36%) and 'direct' (0.68%) -
![alt-text](https://github.com/simuxakadiscgolfgod/Turing-Data-Projects/blob/80a4442d73c265144368629245f6c51497fa7957/Main-Analysis-Types/Funnels/funnel_campaign.png)
## Conclusions
* There are no significant differences in customer drop off percentages between top 3 countries and devices used.
* There are significant differences in customer drop off percentages between campaigns. Customers who came through referrals are almost 2 times more likely to purchase our product.
