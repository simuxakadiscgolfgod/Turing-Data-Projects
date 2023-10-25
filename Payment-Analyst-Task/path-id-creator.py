#creates path ID table required for the map
#ended up not using in the dashboard as it didn't bring useful insights

import pandas as pd

df = pd.read_csv('payment_order_data.csv')
path_df = pd.DataFrame(columns=["order_id", "order_of_points" , "state"])
for row in range(df.shape[0]):
  seller_states = df.iloc[row]['seller_state'].split(', ')
  for state in seller_states:
    seller_data = [df.iloc[row]['order_id'], 1, state]
    path_df = path_df.append(pd.Series(seller_data, index=["order_id", "order_of_points" , "state"]), ignore_index=True)
  customer_data = [df.iloc[row]['order_id'], 2, df.iloc[row]['deliver_state']]
  path_df = path_df.append(pd.Series(customer_data, index=["order_id", "order_of_points" , "state"]), ignore_index=True)
path_df.to_csv('path_data.csv', index=False)
