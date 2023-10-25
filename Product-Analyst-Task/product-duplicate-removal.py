#removes duplicating events in less than 0.5 s from dataset
import pandas as pd

df = pd.read_csv('abp_page_titles.csv')
index_list = []
for row in range(df.shape[0]-1):
  if (df.iloc[row]['event_name'] == df.iloc[row+1]['event_name']) & (df.iloc[row]['sec_spent_in_event'] == 0):
    index_list.append(row)
df.drop(index=index_list, inplace=True)
df.to_csv('abp_page_titles_cleaned.csv', index=False)
