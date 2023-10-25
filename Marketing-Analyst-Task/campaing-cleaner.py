#gets the most frequent occurring non-null campaign tag in the session
#ended up not using it as the first occurring non-null campaign tag represents the most contributing reason better of why the visitor came into our website in the first place

import pandas as pd
import numpy as np

df = pd.read_json('campaign_data.json', lines=True)

for row in range(df.shape[0]):
  if 'value' not in str(df.iloc[row]['campaign']):
    df.at[row, 'campaign'] = np.nan
  elif len(df.iloc[row]['campaign']) == 1:
    df.at[row, 'campaign'] = df.iloc[row]['campaign'][0].get('value')
  else:
    value_nr = [s for s in df.iloc[row]['campaign'] if "value" in s]
    if len(value_nr) == 1:
      df.at[row, 'campaign'] = value_nr[0].get('value')
    else:
      if int(df.iloc[row]['campaign'][0].get('count')) >= int(df.iloc[row]['campaign'][1].get('count')):
        df.at[row, 'campaign'] = df.iloc[row]['campaign'][0].get('value')
      else:
        df.at[row, 'campaign'] = df.iloc[row]['campaign'][1].get('value')

df.to_csv('session_data_cleaned.csv', index=False)
