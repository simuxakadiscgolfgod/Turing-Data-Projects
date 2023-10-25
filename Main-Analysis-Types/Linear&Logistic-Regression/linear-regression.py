import numpy as np
import pandas as pd
from patsy import dmatrices
import scipy.stats as st
from matplotlib import pyplot as plt
from statsmodels.stats.outliers_influence import variance_inflation_factor
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error, mean_absolute_error

df = pd.read_csv('Hands on data - Melbourne_housing_data.csv')

'''
observe data and choose features to proceed based on corr, missing data, graphs.
print(df.isnull().sum()*100/df.shape[0])
print(df.corr(method='spearman', numeric_only=True)['Price'])
plt.scatter(df['Rooms'], df['Price'])
plt.show()
'''

'''chose type, rooms, yearbuilt, bedroom2 - dropping everything else'''
df = df.drop(columns=['Suburb', 'Bedroom2', 'Address', 'Method', 'SellerG', 'Date', 'Distance', 'Postcode', 'Bathroom', 'Car', 'Landsize', 'BuildingArea', 'CouncilArea', 'Lattitude', 'Longtitude', 'Regionname', 'Propertycount'])

'''drop non existing values and houses built pre 1800yr'''
df.dropna(inplace=True)
df = df.drop(df[df.YearBuilt < 1800].index)

'''get dummies for type'''
df = pd.get_dummies(df, columns=['Type'], dtype=int, drop_first=True)

'''remove outliers that are > 6 stds'''
df = df[(np.abs(st.zscore(df)) < 6).all(axis=1)]

'''
check removed outliers in scatter
plt.scatter(df['Rooms'], df['Price'])
plt.show()
'''
'''
check for multicollinearity - dropped bedroom2, because of collinearity with rooms
y, x = dmatrices('Price ~ Rooms + Bedroom2 + YearBuilt + Type_t + Type_u', data=df, return_type='dataframe')

#create DataFrame to hold VIF values
vif_df = pd.DataFrame()
vif_df['variable'] = x.columns 

#calculate VIF for each predictor variable 
vif_df['VIF'] = [variance_inflation_factor(x.values, i) for i in range(x.shape[1])]

#view VIF for each predictor variable 
print(vif_df)
'''
'''to numpy for feeding to sklearn'''
df_np = df.to_numpy()

'''separating features from price'''
x, y = df_np[:, [0, 2, 3, 4]], df_np[:, [1]]

'''.8 data to train and .2 data to test'''
x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2, random_state=101)

model = LinearRegression()
model.fit(x_train, y_train)

predictions = model.predict(x_test)

print(
  'mean_squared_error: ', mean_squared_error(y_test, predictions))
print(
  'mean_absolute_error: ', mean_absolute_error(y_test, predictions))

predictions_df = pd.DataFrame({'Rooms': x_test[:, 0],
                               'YearBuilt': x_test[:, 1],
                               'Type_t': x_test[:, 2],
                               'Type_h': x_test[:, 3],
                               'Price': y_test[:, 0],
                               'Predicted Price': predictions[:, 0]})
print(predictions_df)
