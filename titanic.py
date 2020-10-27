import pandas as pd

train = pd.read_csv("train_clean.csv")
test = pd.read_csv("test_clean.csv")
#train.head()
#train["Survived"].describe()
#train.dtypes
train["Sex"]=train["Sex"].astype("category")

